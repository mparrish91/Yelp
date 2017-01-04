//
//  YPFilterSettings.m
//  Yelp
//
//  Created by parry on 1/4/17.
//  Copyright © 2017 parry. All rights reserved.
//

#import "YPFilterSettings.h"


@interface YPFilterSettings ()

@end


@implementation YPFilterSettings

- (id)init {
    self = [super init];
    if (self) {
        
        self.category = [[NSMutableDictionary alloc]init];
        self.distance = [[NSMutableDictionary alloc] init];
        self.deals = [[NSMutableDictionary alloc]init];
        self.sort = [[NSMutableDictionary alloc] init];

        
    }
    return self;
}


@end
