//
//  LocationManager.m
//  weatherTestApp
//
//  Created by Serhii Kostiuk on 11/9/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationManager () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation        *userLocation;
@property (nonatomic, strong) CLGeocoder        *geocoder;

@end

@implementation LocationManager

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _locationManager = [CLLocationManager new];
        _geocoder = [CLGeocoder new];
        _userLocation = [CLLocation new];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager startUpdatingLocation];
    }
    
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    self.userLocation = locations[0];
    __weak __typeof(self)weakSelf = self;

    [self.geocoder reverseGeocodeLocation:self.userLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        CLPlacemark *placeMark = placemarks.lastObject;
        
        [strongSelf.delegate userLocation:placeMark.location andCityName:placeMark.locality];
    }];
}

@end
