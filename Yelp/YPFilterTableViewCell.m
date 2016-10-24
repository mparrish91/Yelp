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
    
    [self.filterSwitch addTarget: self action: @selector(onSwitchPressed) forControlEvents: UIControlEventValueChanged];

    
    
    return self;
}

-(void) layoutSubviews {
    [super layoutSubviews];
    
    UILayoutGuide *margins = self.contentView.layoutMarginsGuide;
    
    self.filterLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.filterLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.filterLabel.centerYAnchor constraintEqualToAnchor:margins.centerYAnchor].active = YES;
    self.filterLabel.font = [UIFont fontWithName:@"Avenir-Book" size:11];


    self.filterSwitch.translatesAutoresizingMaskIntoConstraints = false;
    [self.filterSwitch.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.filterSwitch.centerYAnchor constraintEqualToAnchor:margins.centerYAnchor].active = YES;

    

       
}

-(void) onSwitchPressed {
    NSLog(@"switch pressed bro");
    if ([self.delegate respondsToSelector:@selector(ypFilterCellSwitchDidChange:value:)]) {
        [self.delegate ypFilterCellSwitchDidChange:self value:self.filterSwitch.on];
    }

}

@end
