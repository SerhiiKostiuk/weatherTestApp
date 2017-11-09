//
//  WeatherManager.m
//  weatherTestApp
//
//  Created by Serhii Kostiuk on 11/9/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

#import "WeatherManager.h"
#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSUInteger, weatherApiType) {
    openWeatherMap,
    weatherUnderground
};

@interface WeatherManager () <locationManagerDelegate>
@property (nonatomic, strong) LocationManager *locationManager;

@end

@implementation WeatherManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _locationManager = [LocationManager new];
        _locationManager.delegate = self;
    }
    return self;
}

- (void)userLocation:(CLLocation *)location andCityName:(NSString *)cityName {
    [self getWeatherDataFromApiType:weatherUnderground byLocation:location];
}

- (void)getWeatherDataFromApiType:(weatherApiType)apiType byLocation:(CLLocation*)location {
    NSString *apiKey = [self weatherApiKeyForType:apiType];

//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.openweathermap.org/data/2.5/forecast?q=Kiev,ua&units=metric&appid=%@&lang=ua",
//                                       /*location.coordinate.latitude,
//                                       location.coordinate.longitude,*/
//                                       apiKey]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.wunderground.com/api/%@/forecast/q/UA/Kiev.json",
                                       /*location.coordinate.latitude,
                                        location.coordinate.longitude,*/
                                       apiKey]];
   
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"response = %@", data);
        
        if (data == nil) {
            return;
        }
        
        NSDictionary *responseJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        NSLog(@"response = %@", responseJson);
        
        NSDictionary *forecast = [responseJson valueForKey:@"forecast"];
        NSDictionary *simpleForecast = [forecast valueForKey:@"simpleforecast"];

        NSDictionary *forecastDay = [simpleForecast valueForKey:@"forecastday"];

        NSString *icon = [forecastDay valueForKey:@"low"];
         NSLog(@"pretty = %@", forecast);

    }];
    
    [task resume];
}

- (NSString *)weatherApiKeyForType:(weatherApiType)apiType {
    NSString *apiKey = @"";
    switch (apiType) {
        case openWeatherMap:
            apiKey = @"5ce2277ba476496b184e22c6633a1170";
            
            break;
        case weatherUnderground:
            apiKey = @"111d8ce743690f15";
            
            break;
        default:
            break;
    }
    
    return apiKey;
}

@end
