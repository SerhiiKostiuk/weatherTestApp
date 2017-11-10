//
//  WeatherManager.h
//  weatherTestApp
//
//  Created by Serhii Kostiuk on 11/9/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol weatherManagerDelegate <NSObject>

- (void)getLatestForecast:(NSMutableArray *)forecastArray;

@end

@interface WeatherManager : NSObject
@property (weak, nonatomic) id<weatherManagerDelegate> delegate;

@end
