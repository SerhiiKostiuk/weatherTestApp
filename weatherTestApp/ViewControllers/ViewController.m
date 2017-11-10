//
//  ViewController.m
//  weatherTestApp
//
//  Created by Serhii Kostiuk on 11/9/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

#import "ViewController.h"
#import "WeatherManager.h"
#import "WeatherForecastModel.h"
#import "ForecastTableViewCell.h"

@interface ViewController () <weatherManagerDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *weatherTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempMaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempMinLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UITableView *forecastTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;


@property (nonatomic, strong) WeatherManager *weatherManager;
@property (nonatomic, strong) NSArray *weatherForecastArray;
@property (nonatomic, strong) WeatherForecastModel *todayForecast;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.weatherManager = [WeatherManager new];
    self.weatherManager.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdated) name:@"ImageDownloaded" object:nil];
    
    self.weatherImageView.hidden = YES;
    self.weatherTypeLabel.hidden = YES;
    self.tempMaxLabel.hidden = YES;
    self.tempMinLabel.hidden = YES;
    self.tempLabel.hidden = YES;

    self.backgroundImageView.image = [UIImage imageNamed:@"Cloudy"];
}


- (void)getLatestForecast:(NSMutableArray *)forecastArray {
    self.todayForecast = forecastArray[0];
    self.weatherForecastArray = [(NSArray *)forecastArray subarrayWithRange:NSMakeRange(1, forecastArray.count -1)];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.forecastTableView reloadData];

        self.tempMaxLabel.text = [NSString stringWithFormat:@"max: %@°", self.todayForecast.weatherTempHigh];
        self.tempMinLabel.text = [NSString stringWithFormat:@"min: %@°", self.todayForecast.weatherTempLow];
        self.tempLabel.text = [NSString stringWithFormat:@"%@°", self.todayForecast.weatherTempHigh];
        self.weatherTypeLabel.text = self.todayForecast.weatherType;
        
        self.weatherImageView.hidden = NO;
        self.weatherTypeLabel.hidden = NO;
        self.tempMaxLabel.hidden = NO;
        self.tempMinLabel.hidden = NO;
        self.tempLabel.hidden = NO;
        
        self.backgroundImageView.image = [self updateBackgroundImage];
    });
}

- (void)imageUpdated {
    self.weatherImageView.image = self.todayForecast.weatherImage;
    [self.forecastTableView reloadData];
}

- (UIImage *)updateBackgroundImage {
    if ([self.todayForecast.weatherType containsString:@"Rain"]) {
        return [UIImage imageNamed:@"Rain"];
    }
    if ([self.todayForecast.weatherType containsString:@"Snow"]) {
        return [UIImage imageNamed:@"Snow"];
    }
    if ([self.todayForecast.weatherType containsString:@"unny"]) {
        return [UIImage imageNamed:@"Snow"];
    }
    
    return [UIImage imageNamed:@"Cloudy"];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.weatherForecastArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ForecastTableViewCell class]) forIndexPath:indexPath];
    
    [cell fillCellWithWeatherModel:self.weatherForecastArray[indexPath.item]];
    return cell;
}

@end
