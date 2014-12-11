//
//  SetCard.h
//  Matchismo
//
//  Created by Sameh Fakhouri on 9/26/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSString *symbol;
@property (nonatomic) NSUInteger count;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic) NSString *shade;

+ (NSArray *)validSymbols;
+ (NSArray *)validShades;
+ (NSArray *)validColors;

@end
