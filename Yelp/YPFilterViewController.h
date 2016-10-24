//
//  YPFilterViewController.h
//  Yelp
//
//  Created by parry on 10/23/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPFilterTableViewCell.h"
@protocol YPFiltersViewControllerDelegate;


@interface YPFilterViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, YPFilterTableViewCellDelegate>

@property(weak,nonatomic) id <YPFiltersViewControllerDelegate> delegate;

@end



@protocol YPFiltersViewControllerDelegate <NSObject>
@optional
- (void)ypFiltersViewControllerDidUpdateFilters:(YPFilterViewController *)filtersViewController filters:(NSDictionary *)filters;

@end

