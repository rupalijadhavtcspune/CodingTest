//
//  UIView+ActivityIndicator.m
//  WeatherForecast
//
//  Created by Rupali Jadhav on 11/06/15.
//  Copyright (c) 2015 Rupali Jadhav. All rights reserved.
//

#import "UIView+ActivityIndicator.h"
#import "WFActivityIndicatorView.h"

@implementation UIView (ActivityIndicator)

#pragma - mark accessor
- (WFActivityIndicatorView *) activityView
{
    WFActivityIndicatorView *activityView = [self previousActivityView];
    if (!activityView)
    {
        activityView = [[WFActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        activityView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    }
    
    return activityView;
}

- (WFActivityIndicatorView *) previousActivityView
{
    NSArray *allSubviews = [self subviews];
    for (UIView *subview in allSubviews)
    {
        if ([subview isKindOfClass:[WFActivityIndicatorView class]])
        {
            return (WFActivityIndicatorView *)subview;
        }
    }
    return nil;
}

#pragma mark - Alert handling

//Function      : addActivityIndicator
//Purpose       : Method to add activity indicator.
//Parameter     : void
//ReturnType    : void
//Comments      : none

- (void) addActivityIndicator
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        WFActivityIndicatorView *activityView = [self activityView];
        [self setUserInteractionEnabled:NO];
        [self addSubview:activityView];
        [activityView startAnimating];
        
    });
}

//Function      : removeActivityIndicator
//Purpose       : Method to remove activity indicator.
//Parameter     : void
//ReturnType    : void
//Comments      : none

- (void) removeActivityIndicator
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        WFActivityIndicatorView *activityView = [self previousActivityView];
        if ([activityView superview])
        {
            [activityView removeActivityIndicator];
            [activityView removeFromSuperview];
        }
        [self setUserInteractionEnabled:YES];
    });
}

@end
