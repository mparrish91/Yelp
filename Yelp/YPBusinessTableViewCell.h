//
//  YPBusinessTableViewCell.h
//  Yelp
//
//  Created by parry on 10/23/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPBusinessTableViewCell : UITableViewCell

@property(strong,readwrite,nonatomic) UILabel *nameLabel;
@property(strong,readwrite,nonatomic) UILabel *distanceLabel;
@property(strong,readwrite,nonatomic) UILabel *reviewsLabel;
@property(strong,readwrite,nonatomic) UILabel *addressLabel;

@property(strong,readwrite,nonatomic) UILabel *categoriesLabel;

@property(strong,readwrite,nonatomic) UIImageView *photoImageView;

@property(strong,readwrite,nonatomic) UIView *nameView;
@property(strong,readwrite,nonatomic) UIView *ratingView;
@property(strong,readwrite,nonatomic) UIView *aboutView;

@property(strong,readwrite,nonatomic) UIView *starsView;


@end
