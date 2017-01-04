//
//  YPFilterSettings.h
//  Yelp
//
//  Created by parry on 1/4/17.
//  Copyright © 2017 parry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPFilterSettings : NSObject

@property(strong,readwrite,nonatomic) NSMutableDictionary *deals;
@property(strong,readwrite,nonatomic) NSMutableDictionary *sort;
@property(strong,readwrite,nonatomic) NSMutableDictionary *distance;
@property(strong,readwrite,nonatomic) NSMutableDictionary *category;

@end
