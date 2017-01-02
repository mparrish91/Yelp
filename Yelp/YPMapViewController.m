//
//  YPMapViewController.m
//  Yelp
//
//  Created by parry on 12/31/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "YPMapViewController.h"
#import <MapKit/MapKit.h>
#import "Yelp-Swift.h"



@interface YPMapViewController ()

@property(nonatomic,strong) MKMapView *mapView;


@end

@implementation YPMapViewController



- (instancetype)init
{
    self.mapView = [[MKMapView alloc]init];
    self.businesses = [[NSArray alloc] init];

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

    CLLocation *centerLocation = [[CLLocation alloc]initWithLatitude:37.7833 longitude:-122.4167];
    [self goToLocation:centerLocation];
    
    UIBarButtonItem *map = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStylePlain target:self action:@selector(backHome)];
    
    [self.navigationItem setLeftBarButtonItem:map];
    
    for (Business *biz in self.businesses) {
       CLLocationCoordinate2D cor = biz.location2D;
        [self addAnnotationAtCoordinate:cor];
        
    }
    
    [self setConstraints];


}

- (void)loadView
{
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
    [view addSubview:self.mapView];
    
}


-(void)setConstraints
{
    
    UIView *view= self.view;
    
    self.mapView.translatesAutoresizingMaskIntoConstraints = false;
    [self.mapView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
    [self.mapView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
    [self.mapView.topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
    [self.mapView.bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
    
}

- (void)backHome{
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)addAnnotationAtCoordinate:(CLLocationCoordinate2D ) coordinate {
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
    annotation.coordinate = coordinate;
    annotation.title = @"An annotation";
    [self.mapView addAnnotation:annotation];
}

- (void)addAnnotationAtAddress:(NSString *) address withTitle:(NSString *)title {
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks != nil)
        {
         if ([placemarks count] != 0)
         {
             CLLocation *coordinate = placemarks.firstObject.location;
             MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
             annotation.coordinate = coordinate.coordinate;
             annotation.title = @"An annotation";
             [self.mapView addAnnotation:annotation];
         }
             
        }
    }
     ];


}

@end
