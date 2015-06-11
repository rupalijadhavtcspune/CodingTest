//
//  WFTableViewBaseCell.h
//  WeatherForecast
//
//  Created by Rupali Jadhav on 11/06/15.
//  Copyright (c) 2015 Rupali Jadhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFItems.h"

@interface WFTableViewBaseCell : UITableViewCell

-(void)configureUserElement;
-(void)setLableValue:(WFItems*)item;
-(void)applyStyleOnSummaryLable:(UILabel*)headlineLable;
-(void)applyStyleOnOtherLables:(NSArray*)allLables;
-(void)boldFontForLabel:(UILabel *)label;
-(void)arialFontForLabel:(UILabel *)label;

@end
