//
//  WeatherForecastModel.h
//  weatherTestApp
//
//  Created by Serhii Kostiuk on 11/9/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WeatherForecastModel : NSObject
@property (nonatomic, strong) NSString *weatherTemp;
@property (nonatomic, strong) NSString *weatherTempLow;
@property (nonatomic, strong) NSString *weatherTempHigh;
@property (nonatomic, strong) NSString *weakDay;
@property (nonatomic, strong) NSString *weatherType;
@property (nonatomic, strong) UIImage  *weatherImage;

- (instancetype)initWithForecastDictionary:(NSDictionary *)dictionary;


@end
