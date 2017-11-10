//
//  ForecastTableViewCell.m
//  weatherTestApp
//
//  Created by Serhii Kostiuk on 11/10/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

#import "ForecastTableViewCell.h"
#import "WeatherForecastModel.h"

@interface ForecastTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *weekDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempMaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempMinLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;

@end


@implementation ForecastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)fillCellWithWeatherModel:(WeatherForecastModel *)model {
    self.weekDayLabel.text = model.weakDay;
    self.tempMaxLabel.text = [NSString stringWithFormat:@"max: %@°", model.weatherTempHigh];
    self.tempMinLabel.text = [NSString stringWithFormat:@"min: %@°", model.weatherTempLow];
    self.weatherImageView.image = model.weatherImage;
}

@end
