//
//  Card.m
//  Matchismo
//
//  Created by sameh on 3/26/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//


#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

- (NSAttributedString *)attributedContents
{
    NSAttributedString *attributedContents = nil;
    
    return attributedContents;
}


@end
