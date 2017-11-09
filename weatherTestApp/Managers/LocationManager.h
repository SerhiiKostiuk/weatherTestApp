//
//  LocationManager.h
//  weatherTestApp
//
//  Created by Serhii Kostiuk on 11/9/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;

@protocol locationManagerDelegate <NSObject>
    
- (void)userLocation:(CLLocation *)location andCityName:(NSString *)cityName;

@end

@interface LocationManager : NSObject
@property (weak, nonatomic) id<locationManagerDelegate> delegate;


@end
