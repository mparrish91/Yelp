//
//  YPFilterViewController.m
//  Yelp
//
//  Created by parry on 10/23/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "YPFilterViewController.h"
#import "YPFilterTableViewCell.h"


@interface YPFilterViewController ()
@property(strong,readwrite,nonatomic) NSArray *categories;


@property(nonatomic,strong) UITableView *filtersTableView;

@property (nonatomic, strong) NSMutableArray * filteredBusinesses;
@property (nonatomic, strong) NSArray * displayedItems;
@property (nonatomic, strong) NSMutableDictionary * switchStates;
@property (nonatomic, strong) NSArray * filters;
@property (nonatomic, strong) NSArray * distance;
@property (nonatomic, strong) NSArray * sort;



@end

@implementation YPFilterViewController


#pragma mark - Initialize

- (instancetype)init
{
    self.filtersTableView = [[UITableView alloc]init];
    self.switchStates = [[NSMutableDictionary alloc]init];
    self.filters = @[ @"Offering a Deal", @"Sort By",@"Distance", @"Category"];
    self.distance = @[ @"Auto", @"0.3 miles",@"1 mile", @"5 miles", @"20 miles"];
    self.sort = @[ @"Best Match", @"Highest Rated",@"Distance"];

    self.categories = @[@
    {@"name" : @"Afghan", @"code": @"afghani"},
        @{@"name" : @"African", @"code": @"african"},
        @{@"name" : @"American, New", @"code": @"newamerican"},
        @{@"name" : @"American, Traditional", @"code": @"tradamerican"},
        @{@"name" : @"Arabian", @"code": @"arabian"},
        @{@"name" : @"Argentine", @"code": @"argentine"},
        @{@"name" : @"Armenian", @"code": @"armenian"},
        @{@"name" : @"Asian Fusion", @"code": @"asianfusion"},
        @{@"name" : @"Asturian", @"code": @"asturian"},
        @{@"name" : @"Australian", @"code": @"australian"},
        @{@"name" : @"Austrian", @"code": @"austrian"},
        @{@"name" : @"Baguettes", @"code": @"baguettes"},
        @{@"name" : @"Bangladeshi", @"code": @"bangladeshi"},
        @{@"name" : @"Barbeque", @"code": @"bbq"},
        @{@"name" : @"Basque", @"code": @"basque"},
        @{@"name" : @"Bavarian", @"code": @"bavarian"},
        @{@"name" : @"Beer Garden", @"code": @"beergarden"},
        @{@"name" : @"Beer Hall", @"code": @"beerhall"},
        @{@"name" : @"Beisl", @"code": @"beisl"},
        @{@"name" : @"Belgian", @"code": @"belgian"},
        @{@"name" : @"Bistros", @"code": @"bistros"},
        @{@"name" : @"Black Sea", @"code": @"blacksea"},
        @{@"name" : @"Brasseries", @"code": @"brasseries"},
        @{@"name" : @"Brazilian", @"code": @"brazilian"},
        @{@"name" : @"Breakfast & Brunch", @"code": @"breakfast_brunch"},
        @{@"name" : @"British", @"code": @"british"},
        @{@"name" : @"Buffets", @"code": @"buffets"},
        @{@"name" : @"Bulgarian", @"code": @"bulgarian"},
        @{@"name" : @"Burgers", @"code": @"burgers"},
        @{@"name" : @"Burmese", @"code": @"burmese"},
        @{@"name" : @"Cafes", @"code": @"cafes"},
        @{@"name" : @"Cafeteria", @"code": @"cafeteria"},
        @{@"name" : @"Cajun/Creole", @"code": @"cajun"},
        @{@"name" : @"Cambodian", @"code": @"cambodian"},
        @{@"name" : @"Canadian", @"code": @"New)"},
        @{@"name" : @"Canteen", @"code": @"canteen"},
        @{@"name" : @"Caribbean", @"code": @"caribbean"},
        @{@"name" : @"Catalan", @"code": @"catalan"},
        @{@"name" : @"Chech", @"code": @"chech"},
        @{@"name" : @"Cheesesteaks", @"code": @"cheesesteaks"},
        @{@"name" : @"Chicken Shop", @"code": @"chickenshop"},
        @{@"name" : @"Chicken Wings", @"code": @"chicken_wings"},
        @{@"name" : @"Chilean", @"code": @"chilean"},
        @{@"name" : @"Chinese", @"code": @"chinese"},
        @{@"name" : @"Comfort Food", @"code": @"comfortfood"},
        @{@"name" : @"Corsican", @"code": @"corsican"},
        @{@"name" : @"Creperies", @"code": @"creperies"},
        @{@"name" : @"Cuban", @"code": @"cuban"},
        @{@"name" : @"Curry Sausage", @"code": @"currysausage"},
        @{@"name" : @"Cypriot", @"code": @"cypriot"},
        @{@"name" : @"Czech", @"code": @"czech"},
        @{@"name" : @"Czech/Slovakian", @"code": @"czechslovakian"},
        @{@"name" : @"Danish", @"code": @"danish"},
        @{@"name" : @"Delis", @"code": @"delis"},
        @{@"name" : @"Diners", @"code": @"diners"},
        @{@"name" : @"Dumplings", @"code": @"dumplings"},
        @{@"name" : @"Eastern European", @"code": @"eastern_european"},
        @{@"name" : @"Ethiopian", @"code": @"ethiopian"},
        @{@"name" : @"Fast Food", @"code": @"hotdogs"},
        @{@"name" : @"Filipino", @"code": @"filipino"},
        @{@"name" : @"Fish & Chips", @"code": @"fishnchips"},
        @{@"name" : @"Fondue", @"code": @"fondue"},
        @{@"name" : @"Food Court", @"code": @"food_court"},
        @{@"name" : @"Food Stands", @"code": @"foodstands"},
        @{@"name" : @"French", @"code": @"french"},
        @{@"name" : @"French Southwest", @"code": @"sud_ouest"},
        @{@"name" : @"Galician", @"code": @"galician"},
        @{@"name" : @"Gastropubs", @"code": @"gastropubs"},
        @{@"name" : @"Georgian", @"code": @"georgian"},
        @{@"name" : @"German", @"code": @"german"},
        @{@"name" : @"Giblets", @"code": @"giblets"},
        @{@"name" : @"Gluten-Free", @"code": @"gluten_free"},
        @{@"name" : @"Greek", @"code": @"greek"},
        @{@"name" : @"Halal", @"code": @"halal"},
        @{@"name" : @"Hawaiian", @"code": @"hawaiian"},
        @{@"name" : @"Heuriger", @"code": @"heuriger"},
        @{@"name" : @"Himalayan/Nepalese", @"code": @"himalayan"},
        @{@"name" : @"Hong Kong Style Cafe", @"code": @"hkcafe"},
        @{@"name" : @"Hot Dogs", @"code": @"hotdog"},
        @{@"name" : @"Hot Pot", @"code": @"hotpot"},
        @{@"name" : @"Hungarian", @"code": @"hungarian"},
        @{@"name" : @"Iberian", @"code": @"iberian"},
        @{@"name" : @"Indian", @"code": @"indpak"},
        @{@"name" : @"Indonesian", @"code": @"indonesian"},
        @{@"name" : @"International", @"code": @"international"},
        @{@"name" : @"Irish", @"code": @"irish"},
        @{@"name" : @"Island Pub", @"code": @"island_pub"},
        @{@"name" : @"Israeli", @"code": @"israeli"},
        @{@"name" : @"Italian", @"code": @"italian"},
        @{@"name" : @"Japanese", @"code": @"japanese"},
        @{@"name" : @"Jewish", @"code": @"jewish"},
        @{@"name" : @"Kebab", @"code": @"kebab"},
        @{@"name" : @"Korean", @"code": @"korean"},
        @{@"name" : @"Kosher", @"code": @"kosher"},
        @{@"name" : @"Kurdish", @"code": @"kurdish"},
        @{@"name" : @"Laos", @"code": @"laos"},
        @{@"name" : @"Laotian", @"code": @"laotian"},
        @{@"name" : @"Latin American", @"code": @"latin"},
        @{@"name" : @"Live/Raw Food", @"code": @"raw_food"},
        @{@"name" : @"Lyonnais", @"code": @"lyonnais"},
        @{@"name" : @"Malaysian", @"code": @"malaysian"},
        @{@"name" : @"Meatballs", @"code": @"meatballs"},
        @{@"name" : @"Mediterranean", @"code": @"mediterranean"},
        @{@"name" : @"Mexican", @"code": @"mexican"},
        @{@"name" : @"Middle Eastern", @"code": @"mideastern"},
        @{@"name" : @"Milk Bars", @"code": @"milkbars"},
        @{@"name" : @"Modern Australian", @"code": @"modern_australian"},
        @{@"name" : @"Modern European", @"code": @"modern_european"},
        @{@"name" : @"Mongolian", @"code": @"mongolian"},
        @{@"name" : @"Moroccan", @"code": @"moroccan"},
        @{@"name" : @"New Zealand", @"code": @"newzealand"},
        @{@"name" : @"Night Food", @"code": @"nightfood"},
        @{@"name" : @"Norcinerie", @"code": @"norcinerie"},
        @{@"name" : @"Open Sandwiches", @"code": @"opensandwiches"},
        @{@"name" : @"Oriental", @"code": @"oriental"},
        @{@"name" : @"Pakistani", @"code": @"pakistani"},
        @{@"name" : @"Parent Cafes", @"code": @"eltern_cafes"},
        @{@"name" : @"Parma", @"code": @"parma"},
        @{@"name" : @"Persian/Iranian", @"code": @"persian"},
        @{@"name" : @"Peruvian", @"code": @"peruvian"},
        @{@"name" : @"Pita", @"code": @"pita"},
        @{@"name" : @"Pizza", @"code": @"pizza"},
        @{@"name" : @"Polish", @"code": @"polish"},
        @{@"name" : @"Portuguese", @"code": @"portuguese"},
        @{@"name" : @"Potatoes", @"code": @"potatoes"},
        @{@"name" : @"Poutineries", @"code": @"poutineries"},
        @{@"name" : @"Pub Food", @"code": @"pubfood"},
        @{@"name" : @"Rice", @"code": @"riceshop"},
        @{@"name" : @"Romanian", @"code": @"romanian"},
        @{@"name" : @"Rotisserie Chicken", @"code": @"rotisserie_chicken"},
        @{@"name" : @"Rumanian", @"code": @"rumanian"},
        @{@"name" : @"Russian", @"code": @"russian"},
        @{@"name" : @"Salad", @"code": @"salad"},
        @{@"name" : @"Sandwiches", @"code": @"sandwiches"},
        @{@"name" : @"Scandinavian", @"code": @"scandinavian"},
        @{@"name" : @"Scottish", @"code": @"scottish"},
        @{@"name" : @"Seafood", @"code": @"seafood"},
        @{@"name" : @"Serbo Croatian", @"code": @"serbocroatian"},
        @{@"name" : @"Signature Cuisine", @"code": @"signature_cuisine"},
        @{@"name" : @"Singaporean", @"code": @"singaporean"},
        @{@"name" : @"Slovakian", @"code": @"slovakian"},
        @{@"name" : @"Soul Food", @"code": @"soulfood"},
        @{@"name" : @"Soup", @"code": @"soup"},
        @{@"name" : @"Southern", @"code": @"southern"},
        @{@"name" : @"Spanish", @"code": @"spanish"},
        @{@"name" : @"Steakhouses", @"code": @"steak"},
        @{@"name" : @"Sushi Bars", @"code": @"sushi"},
        @{@"name" : @"Swabian", @"code": @"swabian"},
        @{@"name" : @"Swedish", @"code": @"swedish"},
        @{@"name" : @"Swiss Food", @"code": @"swissfood"},
        @{@"name" : @"Tabernas", @"code": @"tabernas"},
        @{@"name" : @"Taiwanese", @"code": @"taiwanese"},
        @{@"name" : @"Tapas Bars", @"code": @"tapas"},
        @{@"name" : @"Tapas/Small Plates", @"code": @"tapasmallplates"},
        @{@"name" : @"Tex-Mex", @"code": @"tex-mex"},
        @{@"name" : @"Thai", @"code": @"thai"},
        @{@"name" : @"Traditional Norwegian", @"code": @"norwegian"},
        @{@"name" : @"Traditional Swedish", @"code": @"traditional_swedish"},
        @{@"name" : @"Trattorie", @"code": @"trattorie"},
        @{@"name" : @"Turkish", @"code": @"turkish"},
        @{@"name" : @"Ukrainian", @"code":@"ukrainian"},
        @{@"name" : @"Uzbek", @"code": @"uzbek"},
        @{@"name" : @"Vegan", @"code": @"vegan"},
        @{@"name" : @"Vegetarian", @"code": @"vegetarian"},
        @{@"name" : @"Venison", @"code": @"venison"},
        @{@"name" : @"Vietnamese", @"code": @"vietnamese"},
        @{@"name" : @"Wok", @"code": @"wok"},
        @{@"name" : @"Wraps", @"code": @"wraps"},
        @{@"name" : @"Yugoslav", @"code": @"yugoslav"}];
    
    
    if (!(self = [super init]))
        return nil;
    
    
    return self;
}




#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Filter";
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"  style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButtonTapped)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Search"  style:UIBarButtonItemStylePlain target:self action:@selector(onSearchButtonTapped)];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    
    //tableview
    NSString *cellIdentifier = @"cell";
    [self.filtersTableView registerClass:[YPFilterTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    self.filtersTableView.delegate = self;
    self.filtersTableView.dataSource = self;
    
    [self setConstraints];
    
}



#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.filters.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0)
    {
        return 1;

    }

    if (section == 1)
    {
        return self.distance.count;

    }
    if (section == 2)
    {
        return self.sort.count;
    }
    
    if (section == 3)
    {
        return self.categories.count;
    }
    
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
   
    headerView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    UILabel *categoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 120, 30)];
    categoryLabel.font = [UIFont fontWithName:@"Avenir-Book-Bold" size:15];
    categoryLabel.textColor = [UIColor blackColor];
    
    categoryLabel.text = [self.filters objectAtIndex:section];
    
    [headerView addSubview:categoryLabel];
    
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    YPFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier   forIndexPath:indexPath] ;
    
    if (cell == nil)
    {
        cell = [[YPFilterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    return cell;
}

//This function is where all the magic happens
-(void) tableView:(UITableView *) tableView willDisplayCell:(YPFilterTableViewCell *) cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        cell.filterLabel.text = self.filters[0];
        
    }
    
    if (indexPath.section == 1)
    {
        cell.filterLabel.text = self.distance[indexPath.row];
    }
    if (indexPath.section == 2)
    {
        cell.filterLabel.text = self.sort[indexPath.row];
    }
    
    if (indexPath.section == 3)
    {
        NSDictionary *categoryName = [self.categories objectAtIndex:indexPath.row];
        cell.filterLabel.text = categoryName[@"name"];
    }
    
    
    cell.delegate = self;
    NSString *convertedIndexPath = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    if (self.switchStates[convertedIndexPath] != nil)
    {
        cell.filterSwitch.on = self.switchStates[convertedIndexPath];

    }
    else{
        cell.filterSwitch.on = false;

    }
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    //    Business *business = [self.displayedItems objectAtIndex:indexPath.row];
    
    //    FLMovieDetailViewController *detailVC = [[FLMovieDetailViewController alloc]initWithMovie:movie];
    //    //    FLMovieDetailViewController *detailVC = [[FLMovieDetailViewController alloc]initWithURL:[movie posterPath]];
    //    [self.navigationController pushViewController:detailVC animated:true];
}



- (void)ypFilterCellSwitchDidChange:(YPFilterTableViewCell *)cell value: (BOOL)value;
{
    NSIndexPath *indexPath = [self.filtersTableView indexPathForCell:cell];
    
    NSLog(@"filters got the switch event");
    NSString *convertedIndexPath = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    self.switchStates[convertedIndexPath] = [NSNumber numberWithBool:value];
    NSLog(@"filters got the switch event");

}


- (void)loadView
{
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
    [view addSubview:self.filtersTableView];
    
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
    
    
}


-(void)onCancelButtonTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)onSearchButtonTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSMutableDictionary *filters = [[NSMutableDictionary alloc]init];
    NSMutableArray *selectedCategories = [[NSMutableArray alloc]init];
    
    for (NSString *row in self.switchStates) {
        NSNumber *state = [self.switchStates objectForKey: row];
        if ([state  isEqualToNumber: [NSNumber numberWithInt:1]])
        {
            NSDictionary *category = self.categories[[row integerValue]];
            NSString *code = category[@"code"];
            [selectedCategories addObject:code];
        }
    }
    
    if (selectedCategories.count > 0)
    {
        filters[@"categories"] = selectedCategories;
    }

    if ([self.delegate respondsToSelector:@selector(ypFiltersViewControllerDidUpdateFilters:filters:)]) {
        [self.delegate ypFiltersViewControllerDidUpdateFilters:self filters:filters];
    }
    
}



@end
