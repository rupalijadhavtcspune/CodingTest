//
//  JSONParseOperation.m
//  WeatherForecast
//
//  Created by Rupali Jadhav on 11/06/15.
//  Copyright (c) 2015 Rupali Jadhav. All rights reserved.
//

#import "JSONParseOperation.h"
#import "NSDictionary+ReplaceNull.h"
#import "WFApplicationConstants.h"
#import "WFItems.h"


@interface JSONParseOperation ()

@property (nonatomic, strong) NSMutableDictionary *forecastRecordList;
@property (nonatomic, strong) NSData *dataToParse;
//@property (nonatomic, strong) NewsFeedItems *workingEntry;

@end

@implementation JSONParseOperation

// -------------------------------------------------------------------------------
//	initWithData:
// -------------------------------------------------------------------------------
- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self != nil)
    {
        _dataToParse = data;
    }
    return self;
}

- (void)main
{
    if (![self isCancelled])
    {
        NSError *error;
        // Parsing the JSON data received from web service into an NSDictionary object
        NSDictionary *responseDictinary = [NSJSONSerialization JSONObjectWithData: self.dataToParse
                                                                          options: NSJSONReadingMutableContainers
                                                                            error: &error];
        
        responseDictinary = [responseDictinary dictionaryByReplacingNullsWithBlanks];
        
        self.forecastRecordList = [[NSMutableDictionary alloc] init];
        
        if (responseDictinary != nil)
        {
            //Parsing Hourly Weather Forcast Data
            NSDictionary *currentlyDict = responseDictinary[kCCurrently];
            NSMutableArray *currentDataArray = [[NSMutableArray alloc] initWithCapacity:0];
            if (currentlyDict != nil)
            {
                WFItems *item = [[WFItems alloc] init];
                item.time =[self getDateFromUnixTimeStamp:[currentlyDict[kCTime] doubleValue]];
                item.summary = currentlyDict[kCSummary];
                item.icon = currentlyDict[kCIcon];
                item.temperature = currentlyDict[kCTemperature];
                item.humidity = currentlyDict[kCHumidity];
                item.windSpeed = currentlyDict[kCWindSpeed];
                item.cloudCover = currentlyDict[kCCloudCover];
                item.visibility = currentlyDict[kCVisibility];
                
                [currentDataArray addObject:item];
            }
            
            // Set Forecast Item to the List
            self.forecastRecordList[kCCurrently] = currentDataArray;
            
            //Parsing Hourly Weather Forcast Data
            NSDictionary *hourlyDict = responseDictinary[kCHourly];
            NSMutableArray *hourlyDataArray = [[NSMutableArray alloc] initWithCapacity:0];
            if (hourlyDict != nil)
            {
                NSArray * hourlyDataList = hourlyDict[kCData];
                for (NSDictionary *dataObject in hourlyDataList)
                {
                    WFItems *item = [[WFItems alloc] init];
                    item.time =[self getDateFromUnixTimeStamp:[dataObject[kCTime] doubleValue]];
                    item.summary = dataObject[kCSummary];
                    item.icon = dataObject[kCIcon];
                    item.temperature = dataObject[kCTemperature];
                    item.humidity = dataObject[kCHumidity];
                    item.windSpeed = dataObject[kCWindSpeed];
                    item.cloudCover = dataObject[kCCloudCover];
                    item.visibility = dataObject[kCVisibility];
                    
                    [hourlyDataArray addObject:item];
                }
            }
            
            // Set Forecast Item to the List
            self.forecastRecordList[kCHourly] = hourlyDataArray;
            
            //Parsing Daily Weather Forcast Data
            NSDictionary *dailyDict = responseDictinary[kCDaily];
            NSMutableArray *dailyDataArray = [[NSMutableArray alloc] initWithCapacity:0];
            if (dailyDict != nil)
            {
                NSArray * dailyDataList = dailyDict[kCData];
                for (NSDictionary *dataObject in dailyDataList)
                {
                    WFItems *item = [[WFItems alloc] init];
                    item.time =[self getDateFromUnixTimeStamp:[dataObject[kCTime] doubleValue]];
                    item.summary = dataObject[kCSummary];
                    item.icon = dataObject[kCIcon];
                    item.temperature = dataObject[kCTemperature];
                    item.humidity = dataObject[kCHumidity];
                    item.windSpeed = dataObject[kCWindSpeed];
                    item.cloudCover = dataObject[kCCloudCover];
                    item.visibility = dataObject[kCVisibility];
                    item.temperatureMin = dataObject[kCTemperatureMin];
                    item.temperatureMax = dataObject[kCTemperatureMax];
                    
                    [dailyDataArray addObject:item];
                }
            }
            
            // Set Forecast Item to the List
            self.forecastRecordList[kCDaily] = dailyDataArray;
        }
        
        //NSLog(@"Count self.forecastRecordList : %lu ",(unsigned long)[self.forecastRecordList count]);
        //NSLog(@"forecastRecordList : %@ ",[self.forecastRecordList description]);
    }
    self.dataToParse = nil;
}

-(NSString*)getDateFromUnixTimeStamp:(double)value
{
    double timestampval =  value;
    NSTimeInterval timestamp = (NSTimeInterval)timestampval;
    NSDate *updatetimestamp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM yyyy hh:mm:ss"];
    
    NSString *stringFromDate = [formatter stringFromDate:updatetimestamp];
    return stringFromDate;
}
@end
