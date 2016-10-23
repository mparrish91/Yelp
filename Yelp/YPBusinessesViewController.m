//
//  YPBusinessesViewController.m
//  Yelp
//
//  Created by parry on 10/23/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "YPBusinessesViewController.h"
#import "Yelp-Swift.h"

//#import "MBProgressHUD.h"
#import "YPBusinessTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "YPInfiniteScrollActivityView.h"
#import "YPErrorView.h"

@interface YPBusinessesViewController ()

@property(strong,readwrite,nonatomic) NSMutableArray *businesses;
@property (nonatomic,assign) BOOL isMoreDataLoading;


@property(nonatomic,strong) UITableView *businessesTableView;
@property(nonatomic,strong) UIRefreshControl *refreshControl;
@property(nonatomic,strong) UISearchBar *searchBar;

@property(nonatomic,strong) YPErrorView *errorView;

@property (nonatomic, strong) NSMutableArray * filteredBusinesses;
@property (nonatomic, weak) NSArray * displayedItems;

@property(nonatomic,strong) YPInfiniteScrollActivityView *loadingMoreView;


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
    
    //    UIEdgeInsets insets = self.businessesTableView.contentInset;
    //    insets.bottom += FLInfiniteScrollActivityView.defaultHeight
    //    self.moviesTableView.contentInset = insets;
    
    self.businessesTableView.estimatedRowHeight = 100;
    self.businessesTableView.rowHeight = UITableViewAutomaticDimension;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter"  style:UIBarButtonItemStylePlain target:self action:@selector(refreshTable)];
    
    [self setConstraints];
    [self doSearch];
    
}


- (void)doSearch {
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //    Business *yelp = [[Business alloc]init];
    [Business searchWithTermWithTerm:@"thai" completion:^(NSArray *objects, NSError *error)
     {
         
         if (error)
         {
             [self showErrorView:self.errorView];
         }
         else
         {
             [self hideErrorView:self.errorView];
             
         }
         [self.businesses  addObjectsFromArray:objects];
         self.displayedItems = self.businesses;
         
         
         dispatch_async(dispatch_get_main_queue(), ^{
             self.isMoreDataLoading = false;
             [self.businessesTableView reloadData];
             
             
             
             if ([[NSThread currentThread] isMainThread]){
                 NSLog(@"In main thread--completion handler");
                 [self.refreshControl endRefreshing];
                 [self.loadingMoreView stopAnimating];
//                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 
                 
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    YPBusinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier   forIndexPath:indexPath] ;
    
    if (cell == nil)
    {
        cell = [[YPBusinessTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    return cell;
}

//This function is where all the magic happens
-(void) tableView:(UITableView *) tableView willDisplayCell:(YPBusinessTableViewCell *) cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    Business *business = [self.displayedItems objectAtIndex:indexPath.row];
    cell.nameLabel.text = [business name];
    cell.addressLabel.text = [business address];
    cell.categoriesLabel.text = [business categories];
    cell.distanceLabel.text = [business distance];;
    cell.reviewsLabel.text = [NSString stringWithFormat:@"%@",[business reviewCount]];
    
    NSURL *photoImageURL = [business imageURL];
    NSURL *ratingImageURL = [business ratingImageURL];

    
    [cell.photoImageView setImageWithURL:photoImageURL placeholderImage:[UIImage imageNamed:@"placeholder-background"]];
    [cell.ratingsImageView setImageWithURL:ratingImageURL placeholderImage:[UIImage imageNamed:@"placeholder-background"]];

//
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
//    Business *business = [self.displayedItems objectAtIndex:indexPath.row];
    
    //    FLMovieDetailViewController *detailVC = [[FLMovieDetailViewController alloc]initWithMovie:movie];
    //    //    FLMovieDetailViewController *detailVC = [[FLMovieDetailViewController alloc]initWithURL:[movie posterPath]];
    //    [self.navigationController pushViewController:detailVC animated:true];
}

- (void)refreshTable {
    [self doSearch];
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
            
            [self doSearch];
            
        }
    }
    
}



- (void)loadView
{
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
    [view addSubview:self.businessesTableView];
    [view addSubview:self.errorView];
    
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
    self.loadingMoreView.backgroundColor = [UIColor yellowColor];
    
    
}

-(void)addSearchBar {
    
    self.searchBar.delegate = self;
    [self.searchBar sizeToFit];
    
    self.navigationItem.titleView = self.searchBar;
    
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self setupInfiniteScrollView];
    [self addSearchBar];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.businessesTableView setContentOffset:CGPointMake(0, 0)];
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.businessesTableView setContentOffset:CGPointMake(0, 0)];
    
}



@end
