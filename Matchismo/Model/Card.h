//
//  Card.h
//  Matchismo
//
//  Created by sameh on 3/26/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

- (NSAttributedString *)attributedContents;

@end
