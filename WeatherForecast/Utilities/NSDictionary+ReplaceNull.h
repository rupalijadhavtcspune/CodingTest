//
//  NSDictionary+ReplaceNull.h
//  WeatherForecast
//
//  Created by Rupali Jadhav on 11/06/15.
//  Copyright (c) 2015 Rupali Jadhav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ReplaceNull)

- (NSDictionary *)dictionaryByReplacingNullsWithBlanks;

@end
