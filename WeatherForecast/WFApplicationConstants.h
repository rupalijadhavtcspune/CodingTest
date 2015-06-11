//
//  WFApplicationConstants.h
//  WeatherForecast
//
//  Created by Rupali Jadhav on 11/06/15.
//  Copyright (c) 2015 Rupali Jadhav. All rights reserved.
//

#ifndef WeatherForecast_WFApplicationConstants_h
#define WeatherForecast_WFApplicationConstants_h

// the http URL used for fetching the Weather Forecast Feeds
#define kForecastURL @"https://api.forecast.io/forecast/%@/%.8f,%.8f"
// the API Key used for fetching the Weather Forecast Feeds
#define kForecastAPIKey @"925160e7eab0471073b12c03f005e727"

//Main Keys
#define kCCurrently             @"currently"
#define kCHourly                @"hourly"
#define kCDaily                 @"daily"
#define kCData                  @"data"

//Sub Keys
#define kCTime                  @"time"
#define kCSummary               @"summary"
#define kCIcon                  @"icon"
#define kCTemperature           @"temperature"
#define kCHumidity              @"humidity"
#define kCWindSpeed             @"windSpeed"
#define kCCloudCover            @"cloudCover"
#define kCVisibility            @"visibility"

//For Daily Key
#define kCTemperatureMin        @"temperatureMin"
#define kCTemperatureMax        @"temperatureMax"

typedef NS_ENUM(NSUInteger, ForecastFeedType) {
    ForecastFeedTypeCurrently = 0,
    ForecastFeedTypeHourly,
    ForecastFeedTypeDaily,
    ForecastFeedTypeUnknown,
};

#endif
