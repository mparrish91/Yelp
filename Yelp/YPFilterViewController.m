//
//  YPFilterViewController.m
//  Yelp
//
//  Created by parry on 10/23/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "YPFilterViewController.h"


@interface YPFilterViewController ()
@property(strong,readwrite,nonatomic) NSArray *categories;


@property(nonatomic,strong) UITableView *filtersTableView;

@property (nonatomic, strong) NSMutableArray * filteredBusinesses;
@property (nonatomic, weak) NSArray * displayedItems;



@end

@implementation YPFilterViewController


#pragma mark - Initialize

- (instancetype)init
{
    self.filtersTableView = [[UITableView alloc]init];
    
    self.categories = @[@
    {@@"name" : @"Afghan", @"code": @"afghani"},
        {@"name" : @"African", @"code": @"african"},
        {@"name" : @"American, New", @"code": @"newamerican"},
        {@"name" : "American, Traditional", @"code": "tradamerican"},
        {@"name" : "Arabian", @"code": "arabian"},
        {@"name" : "Argentine", @"code": "argentine"},
        {@"name" : "Armenian", @"code": "armenian"},
        {@"name" : "Asian Fusion", @"code": "asianfusion"},
        {@"name" : "Asturian", @"code": "asturian"},
        {@"name" : "Australian", @"code": "australian"},
        {@"name" : "Austrian", @"code": "austrian"},
        {@"name" : "Baguettes", @"code": "baguettes"},
        {@"name" : "Bangladeshi", @"code": "bangladeshi"},
        {@"name" : "Barbeque", @"code": "bbq"},
        {@"name" : "Basque", @"code": "basque"},
        {@"name" : "Bavarian", @"code": "bavarian"},
        {@"name" : "Beer Garden", @"code": "beergarden"},
        {@"name" : "Beer Hall", @"code": "beerhall"},
        {@"name" : "Beisl", @"code": "beisl"},
        {@"name" : "Belgian", @"code": "belgian"},
        {@"name" : "Bistros", @"code": "bistros"},
        {@"name" : "Black Sea", @"code": "blacksea"},
        {@"name" : "Brasseries", @"code": "brasseries"},
        {@"name" : "Brazilian", @"code": "brazilian"},
        {@"name" : "Breakfast & Brunch", @"code": "breakfast_brunch"},
        {@"name" : "British", @"code": "british"},
        {@"name" : "Buffets", @"code": "buffets"},
        {@"name" : "Bulgarian", @"code": "bulgarian"},
        {@"name" : "Burgers", @"code": "burgers"},
        {@"name" : "Burmese", @"code": "burmese"},
        {@"name" : "Cafes", @"code": "cafes"},
        {@"name" : "Cafeteria", @"code": "cafeteria"},
        {@"name" : "Cajun/Creole", @"code": "cajun"},
        {@"name" : "Cambodian", @"code": "cambodian"},
        {@"name" : "Canadian", @"code": "New)"},
        {@"name" : "Canteen", @"code": "canteen"},
        {@"name" : "Caribbean", @"code": "caribbean"},
        {@"name" : "Catalan", @"code": "catalan"},
        {@"name" : "Chech", @"code": "chech"},
        {@"name" : "Cheesesteaks", @"code": "cheesesteaks"},
        {@"name" : "Chicken Shop", @"code": "chickenshop"},
        {@"name" : "Chicken Wings", @"code": "chicken_wings"},
        {@"name" : "Chilean", @"code": "chilean"},
        {@"name" : "Chinese", @"code": "chinese"},
        {@"name" : "Comfort Food", @"code": "comfortfood"},
        {@"name" : "Corsican", @"code": "corsican"},
        {@"name" : "Creperies", @"code": "creperies"},
        {@"name" : "Cuban", @"code": "cuban"},
        {@"name" : "Curry Sausage", @"code": "currysausage"},
        {@"name" : "Cypriot", @"code": "cypriot"},
        {@"name" : "Czech", @"code": "czech"},
        {@"name" : "Czech/Slovakian", @"code": "czechslovakian"},
        {@"name" : "Danish", @"code": "danish"},
        {@"name" : "Delis", @"code": "delis"},
        {@"name" : "Diners", @"code": "diners"},
        {@"name" : "Dumplings", @"code": "dumplings"},
        {@"name" : "Eastern European", @"code": "eastern_european"},
        {@"name" : "Ethiopian", @"code": "ethiopian"},
        {@"name" : "Fast Food", @"code": "hotdogs"},
        {@"name" : "Filipino", @"code": "filipino"},
        {@"name" : "Fish & Chips", @"code": "fishnchips"},
        {@"name" : "Fondue", @"code": "fondue"},
        {@"name" : "Food Court", @"code": "food_court"},
        {@"name" : "Food Stands", @"code": "foodstands"},
        {@"name" : "French", @"code": "french"},
        {@"name" : "French Southwest", @"code": "sud_ouest"},
        {@"name" : "Galician", @"code": "galician"},
        {@"name" : "Gastropubs", @"code": "gastropubs"},
        {@"name" : "Georgian", @"code": "georgian"},
        {@"name" : "German", @"code": "german"},
        {@"name" : "Giblets", @"code": "giblets"},
        {@"name" : "Gluten-Free", @"code": "gluten_free"},
        {@"name" : "Greek", @"code": "greek"},
        {@"name" : "Halal", @"code": "halal"},
        {@"name" : "Hawaiian", @"code": "hawaiian"},
        {@"name" : "Heuriger", @"code": "heuriger"},
        {@"name" : "Himalayan/Nepalese", @"code": "himalayan"},
        {@"name" : "Hong Kong Style Cafe", @"code": "hkcafe"},
        {@"name" : "Hot Dogs", @"code": "hotdog"},
        {@"name" : "Hot Pot", @"code": "hotpot"},
        {@"name" : "Hungarian", @"code": "hungarian"},
        {@"name" : "Iberian", @"code": "iberian"},
        {@"name" : "Indian", @"code": "indpak"},
        {@"name" : "Indonesian", @"code": "indonesian"},
        {@"name" : "International", @"code": "international"},
        {@"name" : "Irish", @"code": "irish"},
        {@"name" : "Island Pub", @"code": "island_pub"},
        {@"name" : "Israeli", @"code": "israeli"},
        {@"name" : "Italian", @"code": "italian"},
        {@"name" : "Japanese", @"code": "japanese"},
        {@"name" : "Jewish", @"code": "jewish"},
        {@"name" : "Kebab", @"code": "kebab"},
        {@"name" : "Korean", @"code": "korean"},
        {@"name" : "Kosher", @"code": "kosher"},
        {@"name" : "Kurdish", @"code": "kurdish"},
        {@"name" : "Laos", @"code": "laos"},
        {@"name" : "Laotian", @"code": "laotian"},
        {@"name" : "Latin American", @"code": "latin"},
        {@"name" : "Live/Raw Food", @"code": "raw_food"},
        {@"name" : "Lyonnais", @"code": "lyonnais"},
        {@"name" : "Malaysian", @"code": "malaysian"},
        {@"name" : "Meatballs", @"code": "meatballs"},
        {@"name" : "Mediterranean", @"code": "mediterranean"},
        {@"name" : "Mexican", @"code": "mexican"},
        {@"name" : "Middle Eastern", @"code": "mideastern"},
        {@"name" : "Milk Bars", @"code": "milkbars"},
        {@"name" : "Modern Australian", @"code": "modern_australian"},
        {@"name" : "Modern European", @"code": "modern_european"},
        {@"name" : "Mongolian", @"code": "mongolian"},
        {@"name" : "Moroccan", @"code": "moroccan"},
        {@"name" : "New Zealand", @"code": "newzealand"},
        {@"name" : "Night Food", @"code": "nightfood"},
        {@"name" : "Norcinerie", @"code": "norcinerie"},
        {@"name" : "Open Sandwiches", @"code": "opensandwiches"},
        {@"name" : "Oriental", @"code": "oriental"},
        {@"name" : "Pakistani", @"code": "pakistani"},
        {@"name" : "Parent Cafes", @"code": "eltern_cafes"},
        {@"name" : "Parma", @"code": "parma"},
        {@"name" : "Persian/Iranian", @"code": "persian"},
        {@"name" : "Peruvian", @"code": "peruvian"},
        {@"name" : "Pita", @"code": "pita"},
        {@"name" : "Pizza", @"code": "pizza"},
        {@"name" : "Polish", @"code": "polish"},
        {@"name" : "Portuguese", @"code": "portuguese"},
        {@"name" : "Potatoes", @"code": "potatoes"},
        {@"name" : "Poutineries", @"code": "poutineries"},
        {@"name" : "Pub Food", @"code": "pubfood"},
        {@"name" : "Rice", @"code": "riceshop"},
        {@"name" : "Romanian", @"code": "romanian"},
        {@"name" : "Rotisserie Chicken", @"code": "rotisserie_chicken"},
        {@"name" : "Rumanian", @"code": "rumanian"},
        {@"name" : "Russian", @"code": "russian"},
        {@"name" : "Salad", @"code": "salad"},
        {@"name" : "Sandwiches", @"code": "sandwiches"},
        {@"name" : "Scandinavian", @"code": "scandinavian"},
        {@"name" : "Scottish", @"code": "scottish"},
        {@"name" : "Seafood", @"code": "seafood"},
        {@"name" : "Serbo Croatian", @"code": "serbocroatian"},
        {@"name" : "Signature Cuisine", @"code": "signature_cuisine"},
        {@"name" : "Singaporean", @"code": "singaporean"},
        {@"name" : "Slovakian", @"code": "slovakian"},
        {@"name" : "Soul Food", @"code": "soulfood"},
        {@"name" : "Soup", @"code": "soup"},
        {@"name" : "Southern", @"code": "southern"},
        {@"name" : "Spanish", @"code": "spanish"},
        {@"name" : "Steakhouses", @"code": "steak"},
        {@"name" : "Sushi Bars", @"code": "sushi"},
        {@"name" : "Swabian", @"code": "swabian"},
        {@"name" : "Swedish", @"code": "swedish"},
        {@"name" : "Swiss Food", @"code": "swissfood"},
        {@"name" : "Tabernas", @"code": "tabernas"},
        {@"name" : "Taiwanese", @"code": "taiwanese"},
        {@"name" : "Tapas Bars", @"code": "tapas"},
        {@"name" : "Tapas/Small Plates", @"code": "tapasmallplates"},
        {@"name" : "Tex-Mex", @"code": "tex-mex"},
        {@"name" : "Thai", @"code": "thai"},
        {@"name" : "Traditional Norwegian", @"code": "norwegian"},
        {@"name" : "Traditional Swedish", @"code": "traditional_swedish"},
        {@"name" : "Trattorie", @"code": "trattorie"},
        {@"name" : "Turkish", @"code": "turkish"},
        {@"name" : "Ukrainian", @"code": "ukrainian"},
        {@"name" : "Uzbek", @"code": "uzbek"},
        {@"name" : "Vegan", @"code": "vegan"},
        {@"name" : "Vegetarian", @"code": "vegetarian"},
        {@"name" : "Venison", @"code": "venison"},
        {@"name" : "Vietnamese", @"code": "vietnamese"},
        {@"name" : "Wok", @"code": "wok"},
        {@"name" : "Wraps", @"code": "wraps"},
        {@"name" : "Yugoslav", @"code": "yugoslav"}];
    
    
    if (!(self = [super init]))
        return nil;
    
    
    return self;
}




#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Filter";
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"  style:UIBarButtonItemStylePlain target:self action:@selector(refreshTable)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Search"  style:UIBarButtonItemStylePlain target:self action:@selector(refreshTable)];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    
    //tableview
    NSString *cellIdentifier = @"cell";
    [self.filtersTableView registerClass:[YPBusinessTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    self.filtersTableView.delegate = self;
    self.filtersTableView.dataSource = self;
    
    //    UIEdgeInsets insets = self.filtersTableView.contentInset;
    //    insets.bottom += FLInfiniteScrollActivityView.defaultHeight
    //    self.moviesTableView.contentInset = insets;
    
    self.filtersTableView.estimatedRowHeight = 100;
    self.filtersTableView.rowHeight = UITableViewAutomaticDimension;
    
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
             [self.filtersTableView reloadData];
             
             
             
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
    cell.reviewsLabel.text = [NSString stringWithFormat:@"%@ Reviews",[business reviewCount]];
    
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
        CGFloat scrollViewContentHeight = self.filtersTableView.contentSize.height;
        CGFloat scrollOffsetThreshold = scrollViewContentHeight - self.filtersTableView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.filtersTableView.dragging) {
            self.isMoreDataLoading = true;
            
            CGRect frame = CGRectMake(0, self.filtersTableView.contentSize.height - self.tabBarController.tabBar.frame.size.height, self.filtersTableView.bounds.size.width, YPInfiniteScrollActivityView.defaultHeight);
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
    [view addSubview:self.filtersTableView];
    [view addSubview:self.errorView];
    
}


-(void)setConstraints
{
    
    UIView *view= self.view;
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    
    
    self.filtersTableView.translatesAutoresizingMaskIntoConstraints = false;
    [self.filtersTableView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
    [self.filtersTableView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
    [self.filtersTableView.topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
    [self.filtersTableView.bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
    
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
    CGRect frame = CGRectMake(0, self.filtersTableView.contentSize.height - self.tabBarController.tabBar.frame.size.height, self.filtersTableView.bounds.size.width, YPInfiniteScrollActivityView.defaultHeight);
    self.loadingMoreView = [[YPInfiniteScrollActivityView alloc]initWithFrame:frame];
    self.loadingMoreView.hidden = true;
    [self.filtersTableView addSubview:self.loadingMoreView];
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
    [self.filtersTableView setContentOffset:CGPointMake(0, 0)];
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.filtersTableView setContentOffset:CGPointMake(0, 0)];
    
}


@end
