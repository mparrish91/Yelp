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
    
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
        return nil;
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.distanceLabel];
    [self.contentView addSubview:self.ratingsImageView];
    [self.contentView addSubview:self.reviewsLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.categoriesLabel];
    [self.contentView addSubview:self.photoImageView];
    self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width;

    [self setConstraints];

    return self;
}

-(void) layoutSubviews {
    [super layoutSubviews];

}

- (void) setConstraints {
    
    UILayoutGuide *margins = self.contentView.layoutMarginsGuide;
    
    self.photoImageView.translatesAutoresizingMaskIntoConstraints = false;

    [self.photoImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:8].active = YES;
    [self.photoImageView.heightAnchor constraintEqualToConstant:65].active = YES;
    [self.photoImageView.widthAnchor constraintEqualToConstant:65].active = YES;
    [self.contentView.bottomAnchor  constraintGreaterThanOrEqualToAnchor:self.photoImageView.bottomAnchor constant:10].active = YES;
    
    NSLayoutConstraint *contt = [self.contentView.bottomAnchor  constraintEqualToAnchor:self.photoImageView.bottomAnchor constant:10];
    contt.priority = 250;
    contt.active = YES;
    
    [self.photoImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:7].active = YES;
    
    self.photoImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.height / 3;
    self.photoImageView.layer.masksToBounds = YES;
    
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.nameLabel.topAnchor constraintEqualToAnchor:self.photoImageView.topAnchor].active = YES;
    [self.nameLabel.leadingAnchor constraintEqualToAnchor:self.photoImageView.trailingAnchor constant:8].active = YES;
    [self.distanceLabel.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.nameLabel.leadingAnchor constant:8].active = YES;

    [self.nameLabel sizeToFit];
    self.nameLabel.font = [UIFont fontWithName:@"Avenir-Book" size:15];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    NSLayoutConstraint *horizontalHugging = [self.nameLabel.widthAnchor constraintLessThanOrEqualToConstant:self.nameLabel.intrinsicContentSize.width];
    horizontalHugging.priority = [self.nameLabel contentHuggingPriorityForAxis:UILayoutConstraintAxisHorizontal] - 1;
    
    
    self.distanceLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.distanceLabel.centerYAnchor constraintEqualToAnchor:self.nameLabel.centerYAnchor].active = YES;
    [self.distanceLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor constant:8].active = YES;
    
    [self.distanceLabel sizeToFit];
    self.distanceLabel.font = [UIFont fontWithName:@"Avenir-Book" size:9];
    self.distanceLabel.textColor = [UIColor grayColor];
    self.distanceLabel.numberOfLines = 0;
    self.distanceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSLayoutConstraint *horizontalCompressionResistance = [self.distanceLabel.widthAnchor constraintGreaterThanOrEqualToConstant:self.distanceLabel.intrinsicContentSize.width];
    horizontalCompressionResistance.priority = [self.distanceLabel contentHuggingPriorityForAxis:UILayoutConstraintAxisHorizontal] + 1;
    
    
    self.ratingsImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.ratingsImageView.leadingAnchor constraintEqualToAnchor:self.nameLabel.leadingAnchor constant:0].active = YES;
    [self.ratingsImageView.topAnchor constraintEqualToAnchor:self.nameLabel.bottomAnchor].active = YES;
    
    [self.ratingsImageView.heightAnchor constraintEqualToConstant:20].active = YES;
    [self.ratingsImageView.widthAnchor constraintEqualToConstant:55].active = YES;

    self.ratingsImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.reviewsLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.reviewsLabel.leadingAnchor constraintEqualToAnchor:self.ratingsImageView.trailingAnchor constant:5].active = YES;
    [self.reviewsLabel.centerYAnchor constraintEqualToAnchor:self.ratingsImageView.centerYAnchor].active = YES;
    
    [self.reviewsLabel sizeToFit];
    self.reviewsLabel.font = [UIFont fontWithName:@"Avenir-Book" size:7];
    self.reviewsLabel.textColor = [UIColor grayColor];
    self.reviewsLabel.numberOfLines = 0;
    self.reviewsLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    
    self.addressLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.addressLabel.leadingAnchor constraintEqualToAnchor:self.photoImageView.trailingAnchor constant:8].active = YES;
    [self.addressLabel.topAnchor constraintEqualToAnchor:self.ratingsImageView.bottomAnchor].active = YES;
    [self.addressLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = YES;

    [self.addressLabel sizeToFit];
    self.addressLabel.font = [UIFont fontWithName:@"Avenir-Book" size:8];
    self.addressLabel.textColor = [UIColor blackColor];
    self.addressLabel.numberOfLines = 0;
    self.addressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    //NSLayoutConstraint *verticalCompressionResistance = [self.addressLabel.heightAnchor constraintGreaterThanOrEqualToConstant:self.addressLabel.intrinsicContentSize.width];
    //verticalCompressionResistance.priority = [self.addressLabel contentCompressionResistancePriorityForAxis:UILayoutConstraintAxisVertical] + 1;
    
    self.categoriesLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.categoriesLabel.leadingAnchor constraintEqualToAnchor:self.photoImageView.trailingAnchor constant:8].active = YES;
    [self.categoriesLabel.topAnchor constraintEqualToAnchor:self.addressLabel.bottomAnchor].active = YES;
    
    [self.contentView.bottomAnchor  constraintGreaterThanOrEqualToAnchor:self.categoriesLabel.bottomAnchor constant:10].active = YES;
    
    NSLayoutConstraint *cont2 = [self.contentView.bottomAnchor  constraintEqualToAnchor:self.categoriesLabel.bottomAnchor constant:10];
    cont2.priority = 250;
    cont2.active = YES;
    
    [self.categoriesLabel sizeToFit];
    self.categoriesLabel.font = [UIFont fontWithName:@"Avenir-Book" size:7];
    self.categoriesLabel.textColor = [UIColor grayColor];
    self.categoriesLabel.numberOfLines = 0;
    self.categoriesLabel.lineBreakMode = NSLineBreakByTruncatingTail;


}


@end
