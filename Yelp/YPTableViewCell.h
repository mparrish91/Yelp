//
//  YPTableViewCell.h
//  Yelp
//
//  Created by parry on 10/23/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPTableViewCell : UITableViewCell

@property(strong,readwrite,nonatomic) UILabel *nameLabel;
@property(strong,readwrite,nonatomic) UISwitch *filterSwitch;



@end
