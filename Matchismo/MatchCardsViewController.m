//
//  MatchCardsViewController.m
//  Matchismo
//
//  Created by sameh on 3/26/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "MatchCardsViewController.h"


@interface MatchCardsViewController ()
@end

@implementation MatchCardsViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}


- (Deck *)createDeck
{
    // abstract method
    return nil;
}

//
// Touching the "Deal" button resets the game
//
- (IBAction)touchDealButton:(id)sender {
    NSLog(@"MatchCardViewController - touchDealButton - Deal button has been pressed");
    self.game = nil;
    for (UIView *view in self.cardsView.subviews){
        [view removeFromSuperview];
    }
    [self.game resetScore];
   // [self updateUI];
}



- (void) initCards:(CGFloat)aspectRatio withMinimumCells:(NSUInteger)count{
    self.cardButtons = [NSMutableArray array];
    
    self.grid = [[Grid alloc]init];
    self.grid.cellAspectRatio = aspectRatio;
    self.grid.size = self.cardsView.bounds.size;
    self.grid.minimumNumberOfCells = count;
    
    // abstract
}

- (void) updateGrid:(CGFloat)aspectRatio{
    self.grid = [[Grid alloc]init];
    self.grid.cellAspectRatio = aspectRatio;
    self.grid.minimumNumberOfCells = self.cardsView.subviews.count;
    self.grid.size = self.cardsView.bounds.size;
    
    int row = 0;
    int column = 0;
    
    for (UIView *cardView in self.cardsView.subviews){
        
        cardView.frame = [self.grid frameOfCellAtRow:row inColumn:column];
        if (column != self.grid.columnCount-1) {
            column++;
        } else {
            column = 0;
            row++;
        }
    }
}


- (void)tapButton:(UIView *)sender{
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    NSLog(@"MatchCardViewController - touchCardButton - Card with index %ld has been pressed", (long) cardIndex);
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}


- (void)updateUI
{
    // abstract method
}

@end
