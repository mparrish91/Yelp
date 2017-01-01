//
//  YPMapViewController.m
//  Yelp
//
//  Created by parry on 12/31/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "YPMapViewController.h"
#import <MapKit/MapKit.h>



@interface YPMapViewController ()

@property(nonatomic,strong) MKMapView *mapView;


@end

@implementation YPMapViewController



- (instancetype)init
{
    self.mapView = [[MKMapView alloc]init];

    if (!(self = [super init]))
        return nil;
    
    return self;
}

- (void)goToLocation:(CLLocation *) location {
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
    [self.mapView setRegion:region animated:false];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
