//
//  WFItems.h
//  WeatherForecast
//
//  Created by Rupali Jadhav on 11/06/15.
//  Copyright (c) 2015 Rupali Jadhav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WFApplicationConstants.h"



@interface WFItems : NSObject

@property (nonatomic, strong) NSString *currently;
@property (nonatomic, strong) NSString *hourly;
@property (nonatomic, strong) NSString *daily;
@property (nonatomic, strong) NSString *data;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) NSString *humidity;
@property (nonatomic, strong) NSString *windSpeed;
@property (nonatomic, strong) NSString *cloudCover;
@property (nonatomic, strong) NSString *visibility;
@property (nonatomic, strong) NSString *temperatureMin;
@property (nonatomic, strong) NSString *temperatureMax;

@end
