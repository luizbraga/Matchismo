//
//  Deck.h
//  Matchismo
//
//  Created by sameh on 3/26/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
