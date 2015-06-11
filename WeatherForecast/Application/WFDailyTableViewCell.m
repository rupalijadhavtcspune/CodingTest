//
//  WFDailyTableViewCell.m
//  WeatherForecast
//
//  Created by Rupali Jadhav on 11/06/15.
//  Copyright (c) 2015 Rupali Jadhav. All rights reserved.
//

#import "WFDailyTableViewCell.h"

@interface WFDailyTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *forecastIcon;
@property (weak, nonatomic) IBOutlet UILabel *summaryLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *temperaminLable;
@property (weak, nonatomic) IBOutlet UILabel *humidityLable;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLable;
@property (weak, nonatomic) IBOutlet UILabel *cloudCoverLable;
@property (weak, nonatomic) IBOutlet UILabel *visibilityLable;
@property (weak, nonatomic) IBOutlet UILabel *temperamaxLable;

@end

@implementation WFDailyTableViewCell

-(void)configureUserElement
{
    [self setBackgroundColor:[UIColor lightGrayColor]];
    [self applyStyleOnSummaryLable:self.summaryLable];
    
    NSArray *allLabels = [[NSArray alloc] initWithObjects:self.timeLable,self.temperaminLable, self.humidityLable, self.windSpeedLable,self.cloudCoverLable,self.visibilityLable,self.temperamaxLable, nil];
    
    [self applyStyleOnOtherLables:allLabels];
}

-(void)setLableValue:(WFItems*)item
{
    self.summaryLable.text = [item.summary description];
    self.summaryLable.numberOfLines = 2;
    self.timeLable.text = [item.time description];
    self.temperaminLable.text = [NSString stringWithFormat:@"%@ ºF",[item.temperatureMin description]];
    self.temperamaxLable.text = [NSString stringWithFormat:@"%@ ºF",[item.temperatureMax description]];
    self.humidityLable.text = [item.humidity description];
    self.windSpeedLable.text = [item.windSpeed description];
    self.visibilityLable.text = [item.visibility description];
    self.cloudCoverLable.text = [item.cloudCover description];
    self.forecastIcon.image = [UIImage imageNamed:[item.icon description]];
}
@end
