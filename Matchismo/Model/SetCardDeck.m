//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Sameh Fakhouri on 9/26/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSString *symbol in [SetCard validSymbols]) {
            for (int count = 1 ; count <= 3 ; count++) {
                for (UIColor *color in [SetCard validColors]) {
                    for (NSString *shade in [SetCard validShades]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = symbol;
                        card.count = count;
                        card.color = color;
                        card.shade = shade;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
