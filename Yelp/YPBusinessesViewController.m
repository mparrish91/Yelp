//
//  YPBusinessesViewController.m
//  Yelp
//
//  Created by parry on 10/23/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "YPBusinessesViewController.h"
#import "Yelp-Swift.h"
#import "MBProgressHUD.h"
#import "YPBusinessTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "YPInfiniteScrollActivityView.h"
#import "YPErrorView.h"
#import "YPFilterViewController.h"
#import "YPMapViewController.h"
#import <MapKit/MapKit.h>


@interface YPBusinessesViewController ()

@property(strong,readwrite,nonatomic) NSMutableArray *businesses;
@property (nonatomic,assign) BOOL isMoreDataLoading;

@property(nonatomic,strong) UITableView *businessesTableView;
@property(nonatomic,strong) UIRefreshControl *refreshControl;
@property(nonatomic,strong) UISearchBar *searchBar;

@property(nonatomic,strong) YPErrorView *errorView;

@property (nonatomic, strong) NSMutableArray * filteredBusinesses;
@property (nonatomic, strong) NSMutableDictionary *switchStates;

@property (nonatomic, weak) NSArray * displayedItems;

@property(nonatomic,strong) YPInfiniteScrollActivityView *loadingMoreView;
@property(nonatomic,strong) MKMapView *mapView;
@property (nonatomic,assign) BOOL isMapShowing;


@end

@implementation YPBusinessesViewController


#pragma mark - Initialize

- (instancetype)init
{
    self.businessesTableView = [[UITableView alloc]init];
    self.searchBar = [[UISearchBar alloc] init];
    self.errorView = [[YPErrorView alloc]init];
    self.businesses = [[NSMutableArray alloc] init];
    self.filteredBusinesses = [[NSMutableArray alloc] init];
    self.mapView = [[MKMapView alloc]init];

    if (!(self = [super init]))
        return nil;
    
    return self;
}




#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    
    //tableview
    NSString *cellIdentifier = @"cell";
    [self.businessesTableView registerClass:[YPBusinessTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    self.businessesTableView.delegate = self;
    self.businessesTableView.dataSource = self;
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.businessesTableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    UIEdgeInsets insets = self.businessesTableView.contentInset;
    insets.bottom += YPInfiniteScrollActivityView.defaultHeight;
    self.businessesTableView.contentInset = insets;
    
    self.businessesTableView.rowHeight = UITableViewAutomaticDimension;
    self.businessesTableView.estimatedRowHeight = 120;

    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    UIBarButtonItem *map = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStylePlain target:self action:@selector(presentMap)];
    negativeSpacer.width = -14;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(presentFilterView) forControlEvents:UIControlEventTouchUpInside];

    [button setFrame:CGRectMake(0, 0, 50, 30)];
    [button setImage:[UIImage imageNamed:@"filter.png"] forState:UIControlStateNormal];
  
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
//    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer, leftItem] animated:NO];
    [self.navigationItem setRightBarButtonItem:map];
    

    [leftItem setTarget:self];
    [leftItem setAction:@selector(presentFilterView)];
    
//    leftItem.target = self;
//    leftItem.action = @selector(presentFilterView);

    
    [self setConstraints];
    [self doSearch:@"test"];
    
    [self setupInfiniteScrollView];
    [self addSearchBar];
    [self hideErrorView:self.errorView];
    
    [self populateMapView];
    self.isMapShowing = FALSE;

}

- (void)doSearch: (NSString *) term {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    term = @"thai";
    [Business searchWithTermWithTerm:term completion:^(NSArray *objects, NSError *error)
     {
         
         if (error)
         {
             [self showErrorView:self.errorView];
         }
         
         [self.businesses addObjectsFromArray:objects];
         self.displayedItems = self.businesses;
         
         dispatch_async(dispatch_get_main_queue(), ^{
             self.isMoreDataLoading = false;
             
             if ([[NSThread currentThread] isMainThread]){
                 [self.refreshControl endRefreshing];
                 [self.loadingMoreView stopAnimating];
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 [self.businessesTableView reloadData];
                 
             }
             else{
                 NSLog(@"Not in main thread--completion handler");
             }
             
         });
         
     }];
    
}



- (void)doSearch: (NSString *) term atPath: (NSNumber *) offset {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    int count = [offset intValue];

    term = @"thai";
    [Business searchWithTermWithTerm:term offset: count completion:^(NSArray *objects, NSError *error)
     {
         
         if (error)
         {
             [self showErrorView:self.errorView];
         }

         [self.businesses addObjectsFromArray:objects];
         self.displayedItems = self.businesses;
         
         dispatch_async(dispatch_get_main_queue(), ^{
             self.isMoreDataLoading = false;
             
             if ([[NSThread currentThread] isMainThread]){
                 [self.refreshControl endRefreshing];
                 [self.loadingMoreView stopAnimating];
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 [self.businessesTableView reloadData];

             }
             else{
                 NSLog(@"Not in main thread--completion handler");
             }
             
         });
         
     }];
    
}


#pragma mark - TableView


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.displayedItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    YPBusinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier   forIndexPath:indexPath] ;
    
    if (cell == nil)
    {
        cell = [[YPBusinessTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Business *business = [self.displayedItems objectAtIndex:indexPath.row];
    cell.nameLabel.text = [business name];
    cell.addressLabel.text = [business address];
    cell.categoriesLabel.text = [business categories];
    cell.distanceLabel.text = [business distance];;
    cell.reviewsLabel.text = [NSString stringWithFormat:@"%@ Reviews",[business reviewCount]];
    
    NSURL *photoImageURL = [business imageURL];
    NSURL *ratingImageURL = [business ratingImageURL];
    
    
    [cell.photoImageView setImageWithURL:photoImageURL placeholderImage:[UIImage imageNamed:@"placeholder-background"]];
    [cell.ratingsImageView setImageWithURL:ratingImageURL placeholderImage:[UIImage imageNamed:@"placeholder-background"]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}


- (void)presentFilterView {
        YPFilterViewController *filterVC = [[YPFilterViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:filterVC];
    if (self.switchStates)
    {
        filterVC.switchStates = self.switchStates;
    }
    nav.navigationBar.titleTextAttributes
    = @{UITextAttributeTextColor : [UIColor whiteColor]};
    
    [self presentViewController:nav animated:true completion:nil];
    filterVC.delegate = self;

}

- (void)presentMap {
    //YPMapViewController *mapVC = [[YPMapViewController alloc]init];
    //UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mapVC];
    //mapVC.businesses = self.businesses;
    //[self presentViewController:nav animated:true completion:nil];
    [self toggleMapView];
}

#pragma mark - delegate methods

- (void)ypFiltersViewControllerDidUpdateFilters:(YPFilterViewController *)filtersViewController filters:(NSDictionary *)filters
{
    NSArray *categories = filters[@"categories"];
    
    self.switchStates = filtersViewController.switchStates;
    
    [Business searchWithCategoriesWithTerm:@"Restaurants" offset:nil categories:categories completion:^(NSArray *objects, NSError *error)
     {
         if (error)
         {
             [self showErrorView:self.errorView];
         }
         [self.businesses removeAllObjects];
         [self.businesses addObjectsFromArray:objects];
         self.displayedItems = self.businesses;

         dispatch_async(dispatch_get_main_queue(), ^{
             self.isMoreDataLoading = false;
             
             if ([[NSThread currentThread] isMainThread]){
                 [self.refreshControl endRefreshing];
                 [self.loadingMoreView stopAnimating];
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 [self.businessesTableView reloadData];
                 
             }
             else{
                 NSLog(@"Not in main thread--completion handler");
             }
             
         });

     }];
    

}





- (void)refreshTable {
    [self doSearch:@"test"];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView; {
    //Do your stuff here
    // You can also track the direction of UIScrollView here.
    
    if (!self.isMoreDataLoading)
    {
        CGFloat scrollViewContentHeight = self.businessesTableView.contentSize.height;
        CGFloat scrollOffsetThreshold = scrollViewContentHeight - self.businessesTableView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.businessesTableView.dragging) {
            self.isMoreDataLoading = true;
            
            CGRect frame = CGRectMake(0, self.businessesTableView.contentSize.height - self.tabBarController.tabBar.frame.size.height, self.businessesTableView.bounds.size.width, YPInfiniteScrollActivityView.defaultHeight);
            self.loadingMoreView.frame = frame;
            [self.loadingMoreView startAnimating];
            NSNumber *count = [NSNumber numberWithInteger:self.businesses.count];
            
            [self doSearch:@"test" atPath:count];
            
        }
    }
    
}



- (void)loadView
{
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
    [view addSubview:self.mapView];
    [view addSubview:self.businessesTableView];
    [view addSubview:self.errorView];

}

-(void)setMapConstraints
{
    UIView *view= self.view;
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    
    self.mapView.translatesAutoresizingMaskIntoConstraints = false;
    [self.mapView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
    [self.mapView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
    [self.mapView.topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
    [self.mapView.bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;

}


-(void)setConstraints
{
    
    UIView *view= self.view;
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    
    
    self.businessesTableView.translatesAutoresizingMaskIntoConstraints = false;
    [self.businessesTableView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
    [self.businessesTableView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
    [self.businessesTableView.topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
    [self.businessesTableView.bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    self.errorView.translatesAutoresizingMaskIntoConstraints = false;
    [self.errorView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
    [self.errorView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
    [self.errorView.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    [self.errorView.heightAnchor constraintEqualToConstant:30].active = YES;
    
}

- (void)hideErrorView:(YPErrorView *)errorView
{
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:0 animations:^{
        
        errorView.hidden = true;
    } completion:^(BOOL finished) {
    }];
    
}

- (void)showErrorView:(YPErrorView *)errorView
{
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:0 animations:^{
        
        errorView.hidden = false;
        
    } completion:^(BOOL finished) {
    }];
    
}

- (void)setupInfiniteScrollView
{
    CGRect frame = CGRectMake(0, self.businessesTableView.contentSize.height - self.tabBarController.tabBar.frame.size.height, self.businessesTableView.bounds.size.width, YPInfiniteScrollActivityView.defaultHeight);
    self.loadingMoreView = [[YPInfiniteScrollActivityView alloc]initWithFrame:frame];
    self.loadingMoreView.hidden = true;
    [self.businessesTableView addSubview:self.loadingMoreView];
    
    
}

-(void)addSearchBar {
    
    self.searchBar.delegate = self;
    [self.searchBar sizeToFit];
    self.searchBar.placeholder = @"Restaurants";
    
    self.navigationItem.titleView = self.searchBar;
    
}


// MARK: SearchBar methods

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar:(UISearchBar *)searchBar
{
    [self.searchBar setShowsCancelButton:true animated:true];
    return true;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [self.searchBar setShowsCancelButton:false animated:true];
    return true;
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"Cancel");
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self handleSearch:searchBar];

}

- (void)handleSearch:(UISearchBar *)searchBar {
    
    //check what was passed as the query String and get rid of the keyboard
    NSLog(@"User searched for %@", searchBar.text);
   NSString *queryString = searchBar.text;
    [searchBar resignFirstResponder];
    
    [Business searchWithTermWithTerm:queryString completion:^(NSArray *objects, NSError *error)
     {
         
         if (error)
         {
             [self showErrorView:self.errorView];
         }

         self.businesses = objects;
         self.displayedItems = self.businesses;
         
         
         dispatch_async(dispatch_get_main_queue(), ^{
             self.isMoreDataLoading = false;
             [self.businessesTableView reloadData];
             
             
             
             if ([[NSThread currentThread] isMainThread]){
                 NSLog(@"In main thread--completion handler");
                 [self.refreshControl endRefreshing];
                 [self.loadingMoreView stopAnimating];
                 
                 
             }
             else{
                 NSLog(@"Not in main thread--completion handler");
             }
             
         });
         
     }];


}


- (void)populateMapView
{
    for (Business *biz in self.businesses) {
        CLLocationCoordinate2D cor = biz.location2D;
        NSString *title = biz.name;
        [self addAnnotationAtCoordinate:cor withTitle:title];
        
    }
    
}

- (void)addAnnotationAtCoordinate:(CLLocationCoordinate2D ) coordinate withTitle:(NSString *)title {
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
    annotation.coordinate = coordinate;
    annotation.title = title;
    [self.mapView addAnnotation:annotation];
}

- (void)toggleMapView
{
    UIView *fromView = [[UIView alloc]init];
    UIView *toView = [[UIView alloc]init];
    
    if (self.isMapShowing)
    {
        fromView = self.mapView;
        toView = self.businessesTableView;
        
    }
    else
    {
        toView = self.mapView;
        fromView = self.businessesTableView;
        
    }
    
    self.isMapShowing = !self.isMapShowing;


    [UIView transitionFromView:fromView toView:toView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        
    }];
    
    


}

- (void)viewDidLayoutSubviews {
    if (self.isMapShowing)
    {
        [self setMapConstraints];
        [self populateMapView];
        
        CLLocation *centerLocation = [[CLLocation alloc]initWithLatitude:37.7833 longitude:-122.4167];
        [self goToLocation:centerLocation];

    }
    else{
        [self setConstraints];
    }
    
}

- (void)goToLocation:(CLLocation *) location {
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
    [self.mapView setRegion:region animated:false];
    
    
}




@end
