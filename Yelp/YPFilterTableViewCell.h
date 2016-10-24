//
//  YPFilterTableViewCell.h
//  Yelp
//
//  Created by parry on 10/23/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YPFilterTableViewCellDelegate;


@interface YPFilterTableViewCell : UITableViewCell

@property(strong,readwrite,nonatomic) UILabel *filterLabel;
@property(strong,readwrite,nonatomic) UISwitch *filterSwitch;

@property(weak,nonatomic) id <YPFilterTableViewCellDelegate> delegate;


@end




@protocol YPFilterTableViewCellDelegate <NSObject>
@optional
- (void)ypFilterCellSwitchDidChange:(YPFilterTableViewCell *)cell value: (BOOL)value;

@end



