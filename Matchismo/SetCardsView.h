//
//  SetCardsView.h
//  Matchismo
//
//  Created by Luiz Braga on 11/11/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardsView : UIView

@property (nonatomic,strong) UIViewController *myViewController;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) UIColor *color;
@property ( nonatomic) NSUInteger count;
@property (nonatomic, strong) NSString *shade;

- (void)tap:(UITapGestureRecognizer *)gesture;

+ (NSArray *)validSymbols;
+ (NSArray *)validShades;
+ (NSArray *)validColors;
+ (NSUInteger)maxCount;

@end