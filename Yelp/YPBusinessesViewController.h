//
//  YPBusinessesViewController.h
//  Yelp
//
//  Created by parry on 10/23/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YPFiltersViewControllerDelegate;

@interface YPBusinessesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UISearchBarDelegate, UISearchResultsUpdating, YPFilterTableViewCellDelegate>

@end


