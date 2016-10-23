//
//  YPRatingsView.m
//  Yelp
//
//  Created by parry on 10/23/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "YPRatingsView.h"


@interface YPRatingsView ()
@property(strong,readwrite,nonatomic) UIImageView *starImageView;
@property(strong,readwrite,nonatomic) UIImageView *starImageView2;
@property(strong,readwrite,nonatomic) UIImageView *starImageView3;
@property(strong,readwrite,nonatomic) UIImageView *starImageView4;
@property(strong,readwrite,nonatomic) UIImageView *starImageView5;


@end


@implementation YPRatingsView


- (instancetype)initWithFrame:(CGRect)frame
{
    self.starImageView = [[UIImageView alloc]init];
    self.starImageView2 = [[UIImageView alloc]init];
    self.starImageView3 = [[UIImageView alloc]init];
    self.starImageView4 = [[UIImageView alloc]init];
    self.starImageView5 = [[UIImageView alloc]init];
    
    
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    
    [self addSubview:self.starImageView];
    [self addSubview:self.starImageView2];
    [self addSubview:self.starImageView3];
    [self addSubview:self.starImageView4];
    [self addSubview:self.starImageView5];
    
    return self;
}


-(void) layoutSubviews {
    [super layoutSubviews];
    
    UILayoutGuide *margins = self.layoutMarginsGuide;
    
    
    self.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.3f];
    
    
    self.starImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.starImageView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;

    [self.starImageView.centerYAnchor constraintEqualToAnchor:margins.centerYAnchor].active = YES;
    [self.starImageView.widthAnchor constraintEqualToConstant:20].active = YES;
    [self.starImageView.heightAnchor constraintEqualToConstant:20].active = YES;
    self.starImageView.image = [UIImage imageNamed:@"star"];
    

    self.starImageView2.translatesAutoresizingMaskIntoConstraints = false;
    [self.starImageView2.leadingAnchor constraintEqualToAnchor:self.starImageView.leadingAnchor].active = YES;
    [self.starImageView2.centerYAnchor constraintEqualToAnchor:margins.centerYAnchor].active = YES;
    [self.starImageView2.widthAnchor constraintEqualToConstant:20].active = YES;
    [self.starImageView2.heightAnchor constraintEqualToConstant:20].active = YES;
    self.starImageView2.image = [UIImage imageNamed:@"star"];
    
    self.starImageView3.translatesAutoresizingMaskIntoConstraints = false;
    [self.starImageView3.leadingAnchor constraintEqualToAnchor:self.starImageView2.leadingAnchor].active = YES;
    [self.starImageView3.centerYAnchor constraintEqualToAnchor:margins.centerYAnchor].active = YES;
    [self.starImageView3.widthAnchor constraintEqualToConstant:20].active = YES;
    [self.starImageView3.heightAnchor constraintEqualToConstant:20].active = YES;
    self.starImageView3.image = [UIImage imageNamed:@"star"];
    
    
    self.starImageView4.translatesAutoresizingMaskIntoConstraints = false;
    [self.starImageView4.leadingAnchor constraintEqualToAnchor:self.starImageView3.leadingAnchor].active = YES;
    [self.starImageView4.centerYAnchor constraintEqualToAnchor:margins.centerYAnchor].active = YES;
    [self.starImageView4.widthAnchor constraintEqualToConstant:20].active = YES;
    [self.starImageView4.heightAnchor constraintEqualToConstant:20].active = YES;
    self.starImageView4.image = [UIImage imageNamed:@"star"];
    
    self.starImageView5.translatesAutoresizingMaskIntoConstraints = false;
    [self.starImageView5.leadingAnchor constraintEqualToAnchor:self.starImageView4.leadingAnchor].active = YES;
    [self.starImageView5.centerYAnchor constraintEqualToAnchor:margins.centerYAnchor].active = YES;
    [self.starImageView5.widthAnchor constraintEqualToConstant:20].active = YES;
    [self.starImageView5.heightAnchor constraintEqualToConstant:20].active = YES;
    self.starImageView5.image = [UIImage imageNamed:@"star"];

    

    
}


@end

