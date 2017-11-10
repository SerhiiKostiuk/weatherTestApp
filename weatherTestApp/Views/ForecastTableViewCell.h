//
//  ForecastTableViewCell.h
//  weatherTestApp
//
//  Created by Serhii Kostiuk on 11/10/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeatherForecastModel;

@interface ForecastTableViewCell : UITableViewCell

- (void)fillCellWithWeatherModel:(WeatherForecastModel *)model;

@end
