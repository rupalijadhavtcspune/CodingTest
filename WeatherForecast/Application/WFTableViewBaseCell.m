//
//  WFTableViewBaseCell.m
//  WeatherForecast
//
//  Created by Rupali Jadhav on 11/06/15.
//  Copyright (c) 2015 Rupali Jadhav. All rights reserved.
//

#import "WFTableViewBaseCell.h"

@implementation WFTableViewBaseCell

-(void)applyStyleOnSummaryLable:(UILabel*)summaryLable
{
    [self boldFontForLabel:summaryLable];
    summaryLable.numberOfLines = 2;
}

-(void)applyStyleOnOtherLables:(NSArray*)allLables
{
    for (UILabel* lable in allLables)
    {
        if ([lable isKindOfClass:[UILabel class]]) {
            [self arialFontForLabel:lable];
            lable.numberOfLines = 1;
        }

    }
}

#pragma mark Subclasses should override to configure User Elements

-(void)configureUserElement
{
    
}

-(void)setLableValue:(WFItems*)item
{
    
}

#pragma mark Some useful Methods

-(void)boldFontForLabel:(UILabel *)label{
    UIFont* boldFont = [UIFont boldSystemFontOfSize:17.0];
    label.font = boldFont;
}

-(void)arialFontForLabel:(UILabel *)label{
    UIFont* arialFont = [UIFont fontWithName:@"Arial" size:15];
    label.font = arialFont;
}

@end
