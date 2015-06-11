//
//  WFDisplayViewController.m
//  WeatherForecast
//
//  Created by Rupali Jadhav on 10/06/15.
//  Copyright (c) 2015 Rupali Jadhav. All rights reserved.
//

#import "WFDisplayViewController.h"
#import <CoreLocation/CoreLocation.h>
// This framework was imported so we could use the kCFURLErrorNotConnectedToInternet error code.
#import <CFNetwork/CFNetwork.h>
#import "WFApplicationConstants.h"
#import "JSONParseOperation.h"

#import "WFCurrentlyTableViewCell.h"
#import "WFHourlyTableViewCell.h"
#import "WFDailyTableViewCell.h"

@interface WFDisplayViewController ()<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *forecastOptionSegmentController;
@property (weak, nonatomic) IBOutlet UITableView *forecastDisplayTableView;
@property (strong, nonatomic) WFLocationManager *locationObject;
@property (nonatomic) ForecastFeedType feedType;

// the queue to run our "ParseOperation"
@property (nonatomic, strong) NSOperationQueue *queue;
// Network connection to the Weather Forecast URL
@property (nonatomic, strong) NSURLConnection *forecastConnection;
@property (nonatomic, strong) NSMutableData *forecastListData;
@property (nonatomic, strong) NSDictionary *forecastEntries;

@end

@implementation WFDisplayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.forecastDisplayTableView.delegate = self;
    self.forecastDisplayTableView.dataSource = self;    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([CLLocationManager locationServicesEnabled])
    {
        self.locationObject = [WFLocationManager sharedManager];
        [self.locationObject.locationManager requestAlwaysAuthorization];
        [self.locationObject.locationManager startUpdatingLocation];
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(getLocation:) name:@"locationNotification" object:nil];
    }
    else
    {
        NSString *title = @"Location services are off";
        NSString *message = @"To use location you must turn on 'Always' in the Location Services Settings.";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = self.forecastOptionSegmentController.selectedSegmentIndex;
    
    switch (index)
    {
        case ForecastFeedTypeCurrently:
        {
            return 400;
            break;
        }
        case ForecastFeedTypeHourly:
        {
            return 250;
            break;
        }
        case ForecastFeedTypeDaily:
        {
            return 260;
            break;
        }
        default:
            break;
    }
    
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger index = self.forecastOptionSegmentController.selectedSegmentIndex;
    
    switch (index)
    {
        case 0:
        {
            self.feedType = ForecastFeedTypeCurrently;
            return [self.forecastEntries[kCCurrently] count];
            break;
        }
        case 1:
        {
            self.feedType = ForecastFeedTypeHourly;
            return [self.forecastEntries[kCHourly] count];
            break;
        }
        case 2:
        {
            self.feedType = ForecastFeedTypeDaily;
            return [self.forecastEntries[kCDaily] count];
            break;
        }
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WFCurrentlyTableViewCell *currentlyCell = nil;
    WFHourlyTableViewCell *hourlyCell = nil;
    WFDailyTableViewCell *dailyCell = nil;
    
    WFItems *item;
    
    switch (self.feedType)
    {
        case ForecastFeedTypeCurrently:
        {
            currentlyCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WFCurrentlyTableViewCell class]) forIndexPath:indexPath];
            
            if(currentlyCell == nil)
            {
                NSArray *cellArray = [[NSBundle mainBundle]loadNibNamed:
                                      NSStringFromClass([WFCurrentlyTableViewCell class]) owner:self options:nil];
                currentlyCell = [cellArray objectAtIndex:0];
            }
            item = (WFItems *)self.forecastEntries[kCCurrently][indexPath.row];
            [currentlyCell configureUserElement];
            [currentlyCell setLableValue:item];
            return currentlyCell;
            break;
        }
        case ForecastFeedTypeHourly:
        {
            hourlyCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WFHourlyTableViewCell class]) forIndexPath:indexPath];
            
            if(hourlyCell == nil)
            {
                NSArray *cellArray = [[NSBundle mainBundle]loadNibNamed:
                                      NSStringFromClass([WFHourlyTableViewCell class]) owner:self options:nil];
                hourlyCell = [cellArray objectAtIndex:0];
            }
            
            item = (WFItems *)self.forecastEntries[kCHourly][indexPath.row];
            [hourlyCell configureUserElement];
            [hourlyCell setLableValue:item];
            
            return hourlyCell;
            break;
        }
        case ForecastFeedTypeDaily:
        {
            dailyCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WFDailyTableViewCell class]) forIndexPath:indexPath];
            
            if(dailyCell == nil)
            {
                NSArray *cellArray = [[NSBundle mainBundle]loadNibNamed:
                                      NSStringFromClass([WFDailyTableViewCell class]) owner:self options:nil];
                dailyCell = [cellArray objectAtIndex:0];
            }
            
            item = (WFItems *)self.forecastEntries[kCDaily][indexPath.row];
            [dailyCell configureUserElement];
            [dailyCell setLableValue:item];
            
            return dailyCell;
            break;
        }
        default:
            break;
    }
    
    return  nil;
}

- (IBAction)forecastOptionChanged:(id)sender
{
    [self.forecastDisplayTableView reloadData];
}

#pragma mark - Get Current Location (Lat, Lng)
-(void)getLocation:(NSNotification*)notification
{
    NSString *forecastUrl = [NSString stringWithFormat:kForecastURL,kForecastAPIKey, self.locationObject.location.coordinate.latitude,self.locationObject.location.coordinate.longitude];
    [self getWeatherForcastFeedFromUrl:forecastUrl];
}

#pragma mark - NSURLConnection Request
-(void)getWeatherForcastFeedFromUrl:(NSString*)url
{
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    self.forecastConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    
    // Test the validity of the connection object. The most likely reason for the connection object
    // to be nil is a malformed URL, which is a programmatic error easily detected during development
    
    NSAssert(self.forecastConnection != nil, @"Failure to create URL connection.");
    
    // show in the status bar that network activity is starting
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

#pragma mark - NSURLConnection Error handler
// -------------------------------------------------------------------------------
//	handleError:error
//  Reports any error with an alert which was received from connection or loading failures.
// -------------------------------------------------------------------------------
- (void)handleError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot Show Weather Forecast Feeds"
                                                        message:errorMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - NSURLConnection Delegates

// The following are delegate methods for NSURLConnection. Similar to callback functions.
#pragma mark - NSURLConnectionDelegate

// -------------------------------------------------------------------------------
//	connection:didReceiveResponse:response
//  Called when enough data has been read to construct an NSURLResponse object.
// -------------------------------------------------------------------------------
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.forecastListData = [NSMutableData data];    // start off with new data
}

// -------------------------------------------------------------------------------
//	connection:didReceiveData:data
//  Called with a single immutable NSData object to the delegate, representing the next
//  portion of the data loaded from the connection.
// -------------------------------------------------------------------------------
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.forecastListData appendData:data];  // append incoming data
}

// -------------------------------------------------------------------------------
//	connection:didFailWithError:error
//  Will be called at most once, if an error occurs during a resource load.
//  No other callbacks will be made after.
// -------------------------------------------------------------------------------
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if (error.code == kCFURLErrorNotConnectedToInternet)
    {
        // if we can identify the error, we can present a more precise message to the user.
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey:@"No Connection Error"};
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
                                                         code:kCFURLErrorNotConnectedToInternet
                                                     userInfo:userInfo];
        [self handleError:noConnectionError];
    }
    else
    {
        // otherwise handle the error generically
        [self handleError:error];
    }
    
    self.forecastConnection = nil;   // release our connection
}

// -------------------------------------------------------------------------------
//	connectionDidFinishLoading:connection
//  Called when all connection processing has completed successfully, before the delegate
//  is released by the connection.
// -------------------------------------------------------------------------------
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.forecastConnection = nil;   // release our connection
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // create the queue to run our ParseOperation
    self.queue = [[NSOperationQueue alloc] init];
    
    // create an JSONParseOperation (NSOperation subclass) to parse the Weather Forecast feed data
    // so that the UI is not blocked
    JSONParseOperation *parser = [[JSONParseOperation alloc] initWithData:self.forecastListData];
    
    parser.errorHandler = ^(NSError *parseError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self handleError:parseError];
        });
    };
    
    __strong JSONParseOperation *weakParser = parser;
    
    parser.completionBlock = ^(void) {
        if (weakParser.forecastRecordList) {
            // The completion block may execute on any thread.  Because operations
            // involving the UI are about to be performed, make sure they execute
            // on the main thread.
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.forecastEntries = [weakParser.forecastRecordList copy];
                
                // tell our table view to reload its data, now that parsing has completed
                [self.forecastDisplayTableView reloadData];
            });
        }
        
        // we are finished with the queue and our ParseOperation
        self.queue = nil;
    };
    
    [self.queue addOperation:parser]; // this will start the "ParseOperation"
    
    // ownership of appListData has been transferred to the parse operation
    // and should no longer be referenced in this thread
    self.forecastListData = nil;    
}


@end
