//
//  YPInfiniteScrollActivityView.h
//  Yelp
//
//  Created by parry on 10/23/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPInfiniteScrollActivityView : UIView

+ (CGFloat)defaultHeight;

- (void)startAnimating;
- (void)stopAnimating;
@end
