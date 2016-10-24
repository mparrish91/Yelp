//
//  YPFilterTableViewCell.m
//  Yelp
//
//  Created by parry on 10/23/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "YPFilterTableViewCell.h"

@implementation YPFilterTableViewCell

#pragma mark - Initialize

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    
    self.filterLabel  = [[UILabel alloc]init];
    self.filterSwitch = [[UISwitch alloc]init];


    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
        return nil;
    
    [[self contentView]addSubview:self.filterLabel];
    [[self contentView]addSubview:self.filterSwitch];
    
    
    return self;
}

-(void) layoutSubviews {
    [super layoutSubviews];
    
    UILayoutGuide *margins = self.contentView.layoutMarginsGuide;
    
    self.filterLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.filterLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.filterLabel.centerYAnchor constraintEqualToAnchor:margins.centerYAnchor].active = YES;

    self.filterSwitch.translatesAutoresizingMaskIntoConstraints = false;
    [self.filterSwitch.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.filterSwitch.centerYAnchor constraintEqualToAnchor:margins.centerYAnchor].active = YES;


    
   
}


@end
