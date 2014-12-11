//
//  SetCardsViewController.m
//  Matchismo
//
//  Created by Sameh Fakhouri on 9/26/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "SetCardsViewController.h"
#import "CardMatchingGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardsView.h"
#import "Grid.h"

@interface SetCardsViewController ()
@end


@implementation SetCardsViewController



- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (void) initCards:(CGFloat)aspectRatio withMinimumCells:(NSUInteger)count {
    [super initCards:aspectRatio withMinimumCells:count];
    int pos = 0;
    int row = 0;
    int column = 0;
    while (pos != self.grid.minimumNumberOfCells){
        SetCardsView *card = [[SetCardsView alloc] initWithFrame:[self.grid frameOfCellAtRow:row inColumn:column]];
        [card addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:card
                                                                           action:@selector(tap:)]];
        card.myViewController = self;
        [self.cardsView addSubview:card];
        [self.cardButtons addObject:card];
        if (column != self.grid.columnCount-1) {
            column++;
        } else {
            column = 0;
            row++;
        }
        pos++;
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initCards:1.5 withMinimumCells:12];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // this is a 3 card matching game
    [self.game matchThreeCards];
    
    [self updateUI];
}



- (IBAction)touchDealButton:(id)sender
{
    [super touchDealButton:sender];
    [self initCards:1.5 withMinimumCells:12];
    // this is a 3 card matching game
    [self.game matchThreeCards];
    [self updateUI];
}

- (IBAction)touchMoreCards:(id)sender {
    if (self.game.numberOfCardsInPlay != 81){
        [self.game addNewCards:3];
        for (int i = 0; i<3; i++){
            SetCardsView *card = [[SetCardsView alloc] init];
            [card addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:card
                                                                               action:@selector(tap:)]];
            card.myViewController = self;
            [self.cardsView addSubview:card];
            [self.cardButtons addObject:card];
        }
       
        [self updateUI];
    } else {
        self.moreCardsButton.enabled = NO;
    }
    
}


- (void)updateUI
{
    for (SetCardsView *cardView in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardView];
        SetCard *card = (SetCard*)[self.game cardAtIndex:cardIndex];
        if ([card isKindOfClass:[SetCard class]]) {
            cardView.symbol = card.symbol;
            cardView.shade = card.shade;
            cardView.color = card.color;
            cardView.count = card.count;
        }
        if (card.isMatched){
            [cardView removeFromSuperview];
            
        }
        
        if (card.isChosen && !card.isMatched) {
            cardView.layer.borderColor = [UIColor redColor].CGColor;
            cardView.layer.borderWidth = 3.0f;
        } else {
            cardView.layer.borderColor = [UIColor clearColor].CGColor;
        }
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long) self.game.score];
    [self updateGrid:1.5];
}

@end
