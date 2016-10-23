//
//  YPBusinessTableViewCell.m
//  Yelp
//
//  Created by parry on 10/23/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "YPBusinessTableViewCell.h"
#import "YPRatingsView.h"


@implementation YPBusinessTableViewCell

#pragma mark - Initialize

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self.photoImageView = [[UIImageView alloc]init];
    self.ratingsImageView = [[UIImageView alloc]init];

    self.nameLabel = [[UILabel alloc]init];
    self.distanceLabel = [[UILabel alloc]init];
    self.reviewsLabel = [[UILabel alloc]init];
    self.addressLabel = [[UILabel alloc]init];
    self.categoriesLabel = [[UILabel alloc]init];
    
    self.nameView = [[UIView alloc]init];
    self.ratingView  = [[UIView alloc]init];
    self.aboutView = [[UIView alloc]init];
    self.starsView = [[UIView alloc]init];
    
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
        return nil;
    
    [self.nameView addSubview:self.nameLabel];
    [self.nameView addSubview:self.distanceLabel];
    [[self contentView]addSubview:self.nameView];
    
    [self.ratingView addSubview:self.ratingsImageView];
    [self.ratingView addSubview:self.reviewsLabel];
    [[self contentView]addSubview:self.ratingView];
    
    
    [self.aboutView addSubview:self.addressLabel];
    [self.aboutView addSubview:self.categoriesLabel];
    [[self contentView]addSubview:self.aboutView];
    
    [[self contentView]addSubview:self.photoImageView];
    
    
    return self;
}

-(void) layoutSubviews {
    [super layoutSubviews];
    
    UILayoutGuide *margins = self.contentView.layoutMarginsGuide;
    
    self.photoImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.photoImageView.widthAnchor constraintEqualToAnchor:self.photoImageView.heightAnchor].active = YES;
    [self.photoImageView.widthAnchor constraintEqualToConstant:60].active = YES;
    [self.photoImageView.centerYAnchor constraintEqualToAnchor:margins.centerYAnchor].active = YES;
    [self.photoImageView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    self.photoImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.photoImageView.layer.cornerRadius = 17;
    self.photoImageView.layer.masksToBounds = YES;

    
    self.nameView.translatesAutoresizingMaskIntoConstraints = false;
    [self.nameView.topAnchor constraintEqualToAnchor:self.photoImageView.topAnchor].active = YES;
    [self.nameView.leadingAnchor constraintEqualToAnchor:self.photoImageView.trailingAnchor].active = YES;
    [self.nameView.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.nameView.bottomAnchor constraintEqualToAnchor:self.ratingView.topAnchor].active = YES;
    
    self.ratingView.translatesAutoresizingMaskIntoConstraints = false;
    [self.ratingView.leadingAnchor constraintEqualToAnchor:self.photoImageView.trailingAnchor].active = YES;
    [self.ratingView.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.ratingView.bottomAnchor constraintEqualToAnchor:self.aboutView.topAnchor].active = YES;
    
    self.aboutView.translatesAutoresizingMaskIntoConstraints = false;
    [self.aboutView.leadingAnchor constraintEqualToAnchor:self.photoImageView.trailingAnchor].active = YES;
    [self.aboutView.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.aboutView.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor].active = YES;
    
    
    UILayoutGuide *nameMargins = self.nameView.layoutMarginsGuide;
    UILayoutGuide *ratingMargins = self.ratingView.layoutMarginsGuide;
    UILayoutGuide *aboutMargins = self.aboutView.layoutMarginsGuide;
    
    
    //inner cells
    
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.nameLabel.leadingAnchor constraintEqualToAnchor:nameMargins.leadingAnchor].active = YES;
    [self.nameLabel.widthAnchor constraintGreaterThanOrEqualToConstant:100].active = YES;
    [self.nameLabel.trailingAnchor constraintEqualToAnchor:self.distanceLabel.leadingAnchor].active = YES;
    [self.nameLabel.bottomAnchor constraintEqualToAnchor:nameMargins.bottomAnchor].active = YES;
    [self.nameLabel.topAnchor constraintEqualToAnchor:nameMargins.topAnchor].active = YES;
    
    [self.nameLabel sizeToFit];
    self.nameLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    self.distanceLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.distanceLabel.trailingAnchor constraintEqualToAnchor:nameMargins.trailingAnchor].active = YES;
    [self.distanceLabel.bottomAnchor constraintEqualToAnchor:nameMargins.bottomAnchor].active = YES;
    [self.distanceLabel.topAnchor constraintEqualToAnchor:nameMargins.topAnchor].active = YES;
    
    [self.distanceLabel sizeToFit];
    self.distanceLabel.font = [UIFont fontWithName:@"Avenir-Book" size:9];
    self.distanceLabel.textColor = [UIColor grayColor];
    self.distanceLabel.numberOfLines = 0;
    self.distanceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    self.ratingsImageView.translatesAutoresizingMaskIntoConstraints = false;
//    [self.ratingsImageView.widthAnchor constraintEqualToConstant:80].active = YES;
    [self.ratingsImageView.leadingAnchor constraintEqualToAnchor:ratingMargins.leadingAnchor].active = YES;
    [self.ratingsImageView.bottomAnchor constraintEqualToAnchor:ratingMargins.bottomAnchor].active = YES;
    [self.ratingsImageView.topAnchor constraintEqualToAnchor:ratingMargins.topAnchor].active = YES;
    self.ratingsImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    self.reviewsLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.reviewsLabel.leadingAnchor constraintEqualToAnchor:_ratingsImageView.trailingAnchor constant:10].active = YES;
    [self.reviewsLabel.bottomAnchor constraintEqualToAnchor:ratingMargins.bottomAnchor].active = YES;
    [self.reviewsLabel.topAnchor constraintEqualToAnchor:ratingMargins.topAnchor].active = YES;
    
    
    [self.reviewsLabel sizeToFit];
    self.reviewsLabel.font = [UIFont fontWithName:@"Avenir-Book" size:7];
    self.reviewsLabel.textColor = [UIColor grayColor];
    self.reviewsLabel.numberOfLines = 0;
    self.reviewsLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    
    self.addressLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.addressLabel.leadingAnchor constraintEqualToAnchor:aboutMargins.leadingAnchor].active = YES;
    [self.addressLabel.centerYAnchor constraintEqualToAnchor:aboutMargins.centerYAnchor constant:-5].active = YES;

//    [self.addressLabel.topAnchor constraintEqualToAnchor:aboutMargins.topAnchor].active = YES;
//
//    [self.addressLabel.bottomAnchor constraintEqualToAnchor:aboutMargins.bottomAnchor].active = YES;

//    [self.addressLabel.trailingAnchor constraintEqualToAnchor:aboutMargins.trailingAnchor].active = YES;
//    [self.addressLabel.topAnchor constraintEqualToAnchor:aboutMargins.topAnchor].active = YES;
    
    [self.addressLabel sizeToFit];
    self.addressLabel.font = [UIFont fontWithName:@"Avenir-Book" size:8];
    self.addressLabel.textColor = [UIColor blackColor];
    self.addressLabel.numberOfLines = 0;
    self.addressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    
    self.categoriesLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.categoriesLabel.leadingAnchor constraintEqualToAnchor:aboutMargins.leadingAnchor].active = YES;
    [self.categoriesLabel.centerYAnchor constraintEqualToAnchor:aboutMargins.centerYAnchor constant:0].active = YES;

//    [self.categoriesLabel.trailingAnchor constraintEqualToAnchor:ratingMargins.trailingAnchor].active = YES;
//    [self.categoriesLabel.bottomAnchor constraintEqualToAnchor:ratingMargins.bottomAnchor].active = YES;
//    [self.categoriesLabel.topAnchor constraintEqualToAnchor:self.addressLabel.bottomAnchor].active = YES;
    
    [self.categoriesLabel sizeToFit];
    self.categoriesLabel.font = [UIFont fontWithName:@"Avenir-Book" size:7];
    self.categoriesLabel.textColor = [UIColor grayColor];
    self.categoriesLabel.numberOfLines = 0;
    self.categoriesLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    
    self.nameView.backgroundColor = [UIColor redColor];
    self.ratingView.backgroundColor = [UIColor yellowColor];
    self.aboutView.backgroundColor = [UIColor greenColor];
}


@end
