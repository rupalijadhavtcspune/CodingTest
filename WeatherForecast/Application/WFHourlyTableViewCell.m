//
//  WFHourlyTableViewCell.m
//  WeatherForecast
//
//  Created by Rupali Jadhav on 11/06/15.
//  Copyright (c) 2015 Rupali Jadhav. All rights reserved.
//

#import "WFHourlyTableViewCell.h"

@interface WFHourlyTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *forecastIcon;
@property (weak, nonatomic) IBOutlet UILabel *summaryLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLable;
@property (weak, nonatomic) IBOutlet UILabel *humidityLable;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLable;
@property (weak, nonatomic) IBOutlet UILabel *cloudCoverLable;
@property (weak, nonatomic) IBOutlet UILabel *visibilityLable;

@end

@implementation WFHourlyTableViewCell

-(void)configureUserElement
{
    //[self setBackgroundColor:[UIColor lightGrayColor]];
    [self applyStyleOnSummaryLable:self.summaryLable];

    NSArray *allLabels = [[NSArray alloc] initWithObjects:self.timeLable,self.temperatureLable, self.humidityLable, self.windSpeedLable,self.cloudCoverLable,self.visibilityLable, nil];
    
    [self applyStyleOnOtherLables:allLabels];
}

-(void)setLableValue:(WFItems*)item
{    
    self.summaryLable.text = [item.summary description];
    self.summaryLable.numberOfLines = 2;
    self.timeLable.text = [item.time description];
    self.temperatureLable.text = [NSString stringWithFormat:@"%@ ºF",[item.temperature description]];
    self.humidityLable.text = [item.humidity description];
    self.windSpeedLable.text = [item.windSpeed description];
    self.visibilityLable.text = [item.visibility description];
    self.cloudCoverLable.text = [item.cloudCover description];
    self.forecastIcon.image = [UIImage imageNamed:[item.icon description]];
}

@end
