//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Sameh Fakhouri on 3/28/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger numberOfCardsToMatch;
@property (nonatomic, readwrite) NSInteger numberOfCardsInPlay;
@property (nonatomic, strong) NSMutableArray *cards; // of card
@property (nonatomic, strong) NSMutableAttributedString *lastMatch;
@property (nonatomic, strong) NSAttributedString *space;
@property (nonatomic, strong) NSAttributedString *newLine;
@property (nonatomic, strong) NSMutableAttributedString *gameHistory;
@end

@implementation CardMatchingGame


//- (NSMutableAttributedString *)lastMatch
//{
//    if (!_lastMatch) {
//        _lastMatch = [[NSMutableAttributedString alloc] init];
//    }
//    return _lastMatch;
//}

- (NSInteger) numberOfCardsInPlay {
    return [self.cards count];
}

- (NSAttributedString *)newLine
{
    if (!_newLine) {
        _newLine = [[NSAttributedString alloc] initWithString:@"\n"];
    }
    return _newLine;
}



- (NSAttributedString *)space
{
    if (!_space) {
        _space = [[NSAttributedString alloc] initWithString:@" "];
    }
    return _space;
}



- (NSMutableAttributedString *)gameHistory
{
    if (!_gameHistory) {
        _gameHistory = [[NSMutableAttributedString alloc] init];
    }
    return _gameHistory;
}

- (NSAttributedString *)getGameHistory
{
    NSLog(@"CardMatchingGame - getGameHistory - Start");
    NSLog(@"CardMatchingGame - getGameHistory - End");
    return [self.gameHistory copy];
}


- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        if (count < 2) {
            self = nil;
            return self;
        } // end if count
        
        NSLog(@"CardMatchingGame - initWithCardCount:UsingDeck - Initializing Game With %ld Cards", (long) count);
        self.deck = deck;
        for ( int i = 0 ; i < count ; i++ ) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            } // end if card
            card.chosen = NO;
            card.matched = NO;
        } // end for i
    }
    
    return self;
}

- (instancetype)init
{
    return nil;
}

- (void)matchTwoCards
{
    self.numberOfCardsToMatch = 2;
    NSLog(@"CardMatchingGame - matchTwoCards - Number Of Cards To Match = %ld", (long) self.numberOfCardsToMatch);
}

- (void)matchThreeCards
{
    self.numberOfCardsToMatch = 3;
    NSLog(@"CardMatchingGame - matchThreeCards - Number Of Cards To Match = %ld", (long) self.numberOfCardsToMatch);
}

- (void) addNewCards:(NSUInteger)count  {
    
    // Verify if there is a deck in the cards already chosen
    for (int x = 0; x < self.cards.count-2; x++) {
        for (int y=0; y < self.cards.count-2; y++) {
            Card *card = [self.cards objectAtIndex:x];
            Card *card2 = [self.cards objectAtIndex:y+1];
            Card *card3 = [self.cards objectAtIndex:y+2];
            
            NSArray *others = [[NSArray alloc]initWithObjects:card, card2, nil];
            if (!card.isMatched && !card2.isMatched && !card3.isMatched) {
                int score = [card3 match:others];
                if (score) {
                    self.score -= 5;
                    
                }
            }

        }
        
    }
    
    for (int i = 0; i < count; i++) {
        Card *card = [self.deck drawRandomCard];
        card.chosen = NO;
        card.matched = NO;
        [self.cards addObject:card];
    }
}

- (void)resetScore
{
    self.score = 0;
}

- (NSInteger)countOfChosenUnmatchedCards
{
    NSInteger count = 0;
    
    for (Card *card in self.cards) {
        if (card.isChosen && !card.isMatched) {
            count++;
        } // end if card.isChosen
    } // end for Card

    NSLog(@"CardMatchingGame - countOfChosenUnmatchedCards - Count of chosen and unmatched cards = %ld", (long) count);
    
    return count;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (NSMutableArray *)getListOfCardsWaitingForMatch
{
    NSMutableArray *otherCards = [[NSMutableArray alloc] init];

    for (Card *otherCard in self.cards) {
        if (otherCard.isChosen && !otherCard.isMatched) {
            NSLog(@"CardMatchingGame - getListOfCardsWaitingForMatch - Adding %@ Card to otherCards", otherCard.contents);
            [otherCards addObject:otherCard];
        } // end if otherCard.isChosen
    } // end for Card *otherCard in self.cards
    
    return otherCards;
}

- (NSAttributedString *)feedback
{
    NSLog(@"CardMatchingGame - feedback - Start");

    NSMutableAttributedString *feedbackAttributedString;
    
    if ([self countOfChosenUnmatchedCards] != 0) {
        // we are in the middle of matching
        feedbackAttributedString = [[NSMutableAttributedString alloc] initWithString:@"Matching: "];
        for (Card *card in [self getListOfCardsWaitingForMatch]) {
            [feedbackAttributedString appendAttributedString:card.attributedContents];
            [feedbackAttributedString appendAttributedString:self.space];
        } // end for (Card *card in [self getListOfCardsWaitingForMatch])
    } else if (self.lastMatch) {
        // We have a match or a mismatch
        feedbackAttributedString = [[NSMutableAttributedString alloc] init];
        [feedbackAttributedString appendAttributedString:self.lastMatch];
        self.lastMatch = nil;
    } else {
        // No Previous Match or mismatch
        feedbackAttributedString = [[NSMutableAttributedString alloc] initWithString:@""];
    } // end if ([self countOfChosenUnmatchedCards] != 0)
    
    NSLog(@"CardMatchingGame - feedback - End");
    return feedbackAttributedString;
}


static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    NSLog(@"CardMatchingGame - chooseCardAtIndex - Start with index %ld", (long) index);

    Card *card = [self cardAtIndex:index];
    NSMutableArray *otherCards;

    // are we just flipping the card back down?
    if (!card.isMatched && card.isChosen) {
        card.chosen = NO;
        NSLog(@"CardMatchingGame - chooseCardAtIndex - Unchoosing the card");
        NSLog(@"CardMatchingGame - chooseCardAtIndex - End");
        return;
    } // end if !card.isMatched && card.isChosen

    // enough cards chosen? then create an array of cards to match
    if ([self countOfChosenUnmatchedCards] == self.numberOfCardsToMatch - 1) {
        otherCards = [self getListOfCardsWaitingForMatch];
    } else {
        // mark current card as chosen and take away cost of choosing
        NSLog(@"CardMatchingGame - Not enough cards have been chosen");
        card.chosen = YES;
        self.score -=COST_TO_CHOOSE;
        NSLog(@"CardMatchingGame - chooseCardAtIndex - End");
        return;
    } // end if [self countOfChosenCards] == self.numberOfCardsToMatch - 1

    NSLog(@"CardMatchingGame - Count of cards in otherCards = %ld", (long) [otherCards count]);
    
    int matchScore = [card match:otherCards];
    if (matchScore) {
        self.score += matchScore * MATCH_BONUS;
        card.chosen = YES;
        card.matched = YES;
        for (Card *otherCard in otherCards) {
            otherCard.matched = YES;
        }
    } else {
        self.score -= MISMATCH_PENALTY;
        for (Card *otherCard in otherCards) {
            otherCard.chosen = NO;
        } // end for (Card *otherCard in otherCards)
        card.chosen = YES;
        card.matched = NO;
    } // end if matchScore
    
    // take away cost of choosing
    self.score -=COST_TO_CHOOSE;
    NSLog(@"CardMatchingGame - chooseCardAtIndex - End");
}

@end
