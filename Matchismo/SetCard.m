//
//  SetCard.m
//  Matchismo
//
//  Created by Sameh Fakhouri on 9/26/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard




- (int)match:(NSArray *)otherCards
{
    int score = 0;
 
    
    if (([otherCards count] == 2) &&
        [self otherCardsContainsOnlySetCards:otherCards]) {
        if ([self symbolsFormSet:otherCards] &&
            [self countsFormSet:otherCards] &&
            [self colorsFormSet:otherCards] &&
            [self shadesFormSet:otherCards]) {
            NSLog(@"We have a SET!!!!");
            score = 4;
        } else {
            NSLog(@"We DO NOT have a SET!!!!");
        }
    }
    
    return score;
}



- (BOOL)otherCardsContainsOnlySetCards:(NSArray *)otherCards
{
    BOOL answer = NO;

    id card1 = otherCards[0];
    id card2 = otherCards[1];
    if ([card1 isKindOfClass:[SetCard class]] &&
        [card2 isKindOfClass:[SetCard class]]) {
        answer = YES;
    }
    
    return answer;
}



//
// These methods are used to verify that the selected cards for a set
// by checking only the symbols.
//
// They could form a set if all the symbols are the same or all the symbols are different
//
//

- (BOOL)symbolsFormSet:(NSArray *)otherCards
{
    return [self symbolsAreAllTheSame:otherCards] || [self symbolsAreAllDifferent:otherCards];
}

- (BOOL)symbolsAreAllTheSame:(NSArray *)otherCards
{
    BOOL allTheSame = NO;
    
    SetCard *card1 = (SetCard *)otherCards[0];
    SetCard *card2 = (SetCard *)otherCards[1];

    if ([self.symbol isEqualToString:card1.symbol] &&
        [self.symbol isEqualToString:card2.symbol]) {
        allTheSame = YES;
        NSLog(@"The symbols are all the same");
    } else {
        NSLog(@"The symbols are NOT all the same");
    }

    return allTheSame;
}

- (BOOL)symbolsAreAllDifferent:(NSArray *)otherCards
{
    BOOL allDifferent = NO;
    
    SetCard *card1 = (SetCard *)otherCards[0];
    SetCard *card2 = (SetCard *)otherCards[1];

    if (![self.symbol isEqualToString:card1.symbol] &&
        ![self.symbol isEqualToString:card2.symbol] &&
        ![card1.symbol isEqualToString:card2.symbol]) {
        allDifferent = YES;
        NSLog(@"The symbols are all different");
    } else {
        NSLog(@"The symbols are NOT all different");
    }

    return allDifferent;
}

//
// These methods are used to verify that the selected cards for a set
// by checking only the counts.
//
// They could form a set if all the counts are the same or all the counts are different
//
//
- (BOOL)countsFormSet:(NSArray *)otherCards
{
    return [self countsAreAllTheSame:otherCards] || [self countsAreAllDifferent:otherCards];
}

- (BOOL)countsAreAllTheSame:(NSArray *)otherCards
{
    BOOL allTheSame = NO;
    
    SetCard *card1 = (SetCard *)otherCards[0];
    SetCard *card2 = (SetCard *)otherCards[1];
    
    if (self.count == card1.count &&
        self.count == card2.count) {
        allTheSame = YES;
        NSLog(@"The counts are all the same");
    } else {
        NSLog(@"The counts are NOT all the same");
    }
    
    return allTheSame;
}

- (BOOL)countsAreAllDifferent:(NSArray *)otherCards
{
    BOOL allDifferent = NO;
    
    SetCard *card1 = (SetCard *)otherCards[0];
    SetCard *card2 = (SetCard *)otherCards[1];
    
    if (self.count != card1.count &&
        self.count != card2.count &&
        card1.count != card2.count) {
        allDifferent = YES;
        NSLog(@"The counts are all different");
    } else {
        NSLog(@"The counts are NOT all different");
    }
    
    return allDifferent;
}



//
// These methods are used to verify that the selected cards for a set
// by checking only the colors.
//
// They could form a set if all the colors are the same or all the colors are different
//
//

- (BOOL)colorsFormSet:(NSArray *)otherCards
{
    return [self colorsAreAllTheSame:otherCards] || [self colorsAreAllDifferent:otherCards];
}

- (BOOL)colorsAreAllTheSame:(NSArray *)otherCards
{
    BOOL allTheSame = NO;
    
    SetCard *card1 = (SetCard *)otherCards[0];
    SetCard *card2 = (SetCard *)otherCards[1];
    
    if ([self.color isEqual:card1.color] &&
        [self.color isEqual:card2.color]) {
        allTheSame = YES;
        NSLog(@"The colors are all the same");
    } else {
        NSLog(@"The colors are NOT all the same");
    }
    
    return allTheSame;

}

- (BOOL)colorsAreAllDifferent:(NSArray *)otherCards
{
    BOOL allDifferent = NO;
    
    SetCard *card1 = (SetCard *)otherCards[0];
    SetCard *card2 = (SetCard *)otherCards[1];
    
    if (![self.color isEqual:card1.color] &&
        ![self.color isEqual:card2.color] &&
        ![card1.color isEqual:card2.color]) {
        allDifferent = YES;
        NSLog(@"The colors are all different");
    } else {
        NSLog(@"The colors are NOT all different");
    }
    
    return allDifferent;
}



//
// These methods are used to verify that the selected cards for a set
// by checking only the colors.
//
// They could form a set if all the shades are the same or all the shades are different
//
//

- (BOOL)shadesFormSet:(NSArray *)otherCards
{
    return [self shadesAreAllTheSame:otherCards] || [self shadesAreAllDifferent:otherCards];
}

- (BOOL)shadesAreAllTheSame:(NSArray *)otherCards
{
    BOOL allTheSame = NO;
    
    SetCard *card1 = (SetCard *)otherCards[0];
    SetCard *card2 = (SetCard *)otherCards[1];
    
    if (self.shade == card1.shade &&
        self.shade == card2.shade) {
        allTheSame = YES;
        NSLog(@"The shades are all the same");
    } else {
        NSLog(@"The shades are NOT all the same");
    }
    
    return allTheSame;
}

- (BOOL)shadesAreAllDifferent:(NSArray *)otherCards
{
    BOOL allDifferent = NO;
    
    SetCard *card1 = (SetCard *)otherCards[0];
    SetCard *card2 = (SetCard *)otherCards[1];
    
    if (self.shade != card1.shade &&
        self.shade != card2.shade &&
        card1.shade != card2.shade) {
        allDifferent = YES;
        NSLog(@"The shades are all different");
    } else {
        NSLog(@"The shades are NOT all different");
    }
    
    return allDifferent;
}

+ (NSArray *)validSymbols
{
    return @[@"Diamond", @"Squiggle", @"Oval"];
}

+ (NSArray *)validShades
{
    return @[@"Solid",@"Striped",@"Outlined"];
}

+ (NSArray *)validColors
{
    return @[[UIColor greenColor], [UIColor blueColor], [UIColor redColor]];
}

- (void)setCount:(NSUInteger)count
{
    if ((count >= 1) && (count <= 3)) {
        _count = count;
    }
}

- (void)setColor:(UIColor *)color
{
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}










@end
