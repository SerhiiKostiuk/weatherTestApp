//
//  WeatherForecastModel.m
//  weatherTestApp
//
//  Created by Serhii Kostiuk on 11/9/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

#import "WeatherForecastModel.h"

@implementation WeatherForecastModel


- (instancetype)initWithForecastDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        NSDictionary *lowTempDic = [dictionary valueForKey:@"low"];
        NSDictionary *highTempDic = [dictionary valueForKey:@"high"];
        NSDictionary *dateDic = [dictionary valueForKey:@"date"];
        
        _weatherType = [dictionary valueForKey:@"conditions"];
        _weatherTempLow = [lowTempDic valueForKey:@"celsius"];
        _weatherTempHigh = [highTempDic valueForKey:@"celsius"];
        _weakDay = [dateDic valueForKey:@"weekday"];
        [self loadImageFromUrlWithString:[dictionary valueForKey:@"icon_url"]];
    }
    return self;
}


- (void)loadImageFromUrlWithString:(NSString *)stringUrl {
    [stringUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    NSURL *imgURL = [NSURL URLWithString:stringUrl];
    NSURLSessionDataTask *imageTask = [[NSURLSession sharedSession] dataTaskWithURL:imgURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.weatherImage = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageDownloaded" object:self];
        });
    }];
    
    [imageTask resume];
}

@end
