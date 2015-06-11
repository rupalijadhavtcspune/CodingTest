//
//  JSONParseOperation.h
//  WeatherForecast
//
//  Created by Rupali Jadhav on 11/06/15.
//  Copyright (c) 2015 Rupali Jadhav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONParseOperation : NSOperation

@property (nonatomic, copy) void (^errorHandler)(NSError *error);
// NSArray containing forecastRecordList instances for each entry parsed from the input data.
@property (nonatomic, strong, readonly) NSMutableDictionary *forecastRecordList;

// The initializer for this NSOperation subclass.
- (instancetype)initWithData:(NSData *)data;

@end
