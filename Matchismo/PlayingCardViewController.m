//
//  PlayingCardViewController.m
//  Matchismo
//
//  Created by Sameh Fakhouri on 10/1/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardView.h"
#import "Grid.h"

@interface PlayingCardViewController ()

@end

@implementation PlayingCardViewController



- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (void) initCards:(CGFloat)aspectRatio withMinimumCells:(NSUInteger)count{
    [super initCards:aspectRatio withMinimumCells:count];
    
    for (int row = 0; row < self.grid.rowCount; row++) {
        for (int column = 0; column < self.grid.columnCount; column++) {
            PlayingCardView *card = [[PlayingCardView alloc] initWithFrame:[self.grid frameOfCellAtRow:row inColumn:column]];
            [card addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:card
                                                                               action:@selector(tap:)]];
            card.myViewController = self;
            [self.cardsView addSubview:card];
            [self.cardButtons addObject:card];
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCards:0.66 withMinimumCells:30];
}


- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"PlayingCardViewController - ViewWillAppear - Start");
    [super viewWillAppear:animated];
    // this is a 2 card matching game
    [self.game matchTwoCards];
    [self updateUI];
    NSLog(@"PlayingCardViewController - ViewWillAppear - End");
}



- (IBAction)touchDealButton:(id)sender
{
    [super touchDealButton:sender];
    
    // this is a 2 card matching game
    [self.game matchTwoCards];
    [self initCards:0.66 withMinimumCells:30];
    [self updateUI];
}


- (void)updateUI
{
    NSLog(@"PlayingCardViewController - UpdateUI - Start");
    for (PlayingCardView *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        PlayingCard *card = (PlayingCard*)[self.game cardAtIndex:cardIndex];
        cardButton.suit = card.suit;
        cardButton.rank = card.rank;
        [cardButton setBackground:card.isChosen];
        if (card.isMatched) {
            [UIView transitionWithView:cardButton
                              duration:0.5
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations: ^{
                            }
                            completion:^(BOOL finished) {
                                [cardButton removeFromSuperview];
                                [self updateGrid:0.66];
                            }];
            
        }
    } // end for cardButton
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long) self.game.score];
    NSLog(@"PlayingCardViewController - UpdateUI - End");
}


@end
