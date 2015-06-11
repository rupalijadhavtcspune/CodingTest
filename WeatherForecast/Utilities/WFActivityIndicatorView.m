//
//  WFActivityIndicatorView.m
//  WeatherForecast
//
//  Created by Rupali Jadhav on 11/06/15.
//  Copyright (c) 2015 Rupali Jadhav. All rights reserved.
//

#import "WFActivityIndicatorView.h"

@interface WFActivityIndicatorView ()

@property (nonatomic, strong) UIView *blockingView;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end

@implementation WFActivityIndicatorView

#pragma mark - Accessor

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.blockingView];
        [self.blockingView addSubview:self.activityView];
        self.blockingView.center = self.center;
        self.activityView.center = self.blockingView.center;
    }
    return self;
}

- (UIActivityIndicatorView *)activityView
{
    if (_activityView) return _activityView;
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityView.hidesWhenStopped = YES;
    return _activityView;
}

- (UIView *)blockingView
{
    if (_blockingView) return _blockingView;
    
    _blockingView = [[UIView alloc] initWithFrame:self.bounds];
    _blockingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    
    return _blockingView;
}

#pragma mark - Useful methods

//Function      : startAnimating
//Purpose       : Method to add animation on activity .
//Parameter     : void
//ReturnType    : void
//Comments      : none

- (void) startAnimating
{
    [self.activityView startAnimating];
}

//Function      : stopAnimating
//Purpose       : Method to stop animation on activity .
//Parameter     : void
//ReturnType    : void
//Comments      : none

- (void) stopAnimating
{
    [self.activityView stopAnimating];
}



@end
