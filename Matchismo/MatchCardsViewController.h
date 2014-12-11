//
//  MatchCardsViewController.h
//  Matchismo
//
//  Created by sameh on 3/26/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//
// Abstract class. Subclasses must implement abstract methods
// listed below.

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "Deck.h"
#import "Grid.h"

@interface MatchCardsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *cardsView;
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) NSMutableArray *cardButtons;
@property (weak, nonatomic) IBOutlet UIButton *moreCardsButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) Grid *grid;

// these are protected methods
// for subclasses only
- (Deck *)createDeck;   // abstract
- (void)updateUI;       // abstract

- (void) updateGrid:(CGFloat)aspectRatio;
- (void) initCards:(CGFloat)aspectRatio withMinimumCells:(NSUInteger)count;

- (void) tapButton:(UIView *)sender;

- (IBAction)touchDealButton:(id)sender;


@end
