//
//  WFLocationManager.h
//  WeatherForecast
//
//  Created by Rupali Jadhav on 11/06/15.
//  Copyright (c) 2015 Rupali Jadhav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface WFLocationManager : NSObject <CLLocationManagerDelegate>

@property (strong, atomic) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *location;

+(WFLocationManager*)sharedManager;

@end
