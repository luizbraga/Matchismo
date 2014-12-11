//
//  SetCardsView.m
//  Matchismo
//
//  Created by Luiz Braga on 11/11/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "SetCardsView.h"
#import "SetCardsViewController.h"

@implementation SetCardsView


#pragma mark - Properties

- (void)setSymbol:(NSString *)symbol {
    _symbol = symbol;
    [self setNeedsDisplay];
}

- (void)setCount:(NSUInteger)count {
    _count = count;
    [self setNeedsDisplay];
}

- (void)setColor:(UIColor *)color{
    _color = color;
    [self setNeedsDisplay];
}
-(void) setShade:(NSString *)shade {
    _shade = shade;
    [self setNeedsDisplay];
}

#pragma mark - Set Card Methods

+ (NSArray *)validSymbols {
    return @[@"Oval",@"Diamond",@"Squiggle"];
}

+ (NSArray *)validShades {
    return @[@"Solid",@"Striped",@"Outlined"];
}

+ (NSArray *)validColors {
    return @[[UIColor greenColor], [UIColor purpleColor], [UIColor redColor]];
}

+ (NSUInteger)maxCount {
    return 3;
}

#pragma mark - touch

- (void) tap:(UITapGestureRecognizer *)gesture{
    
    if ([[self myViewController] isKindOfClass:[SetCardsViewController class]]) {
        [(SetCardsViewController*)self.myViewController tapButton:self];
    }
    
}


#pragma mark - DrawRect

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor {
    return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
}

- (CGFloat) cornerRadius {
    return CORNER_RADIUS * [self cornerScaleFactor];
}

- (void) drawRect:(CGRect)rect {
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    if ([self.symbol isEqualToString:@"Diamond"]){
        [self drawDiamond];
    } else if ([self.symbol isEqualToString:@"Oval"]){
        [self drawOval];
    } else if ([self.symbol isEqualToString:@"Squiggle"]){
        [self drawSquiggle];
    }
}

#pragma mark - Draw Diamond

#define DIAMOND_UPPER_VERTEX_OFFSET 0.10
#define DIAMOND_LOWER_VERTEX_OFFSET 0.10
#define DIAMOND_WIDTH 0.20

- (CGPoint) upperVertex {
    CGPoint upper = CGPointMake(self.bounds.size.width/2.0,
                                self.bounds.size.height * DIAMOND_UPPER_VERTEX_OFFSET);
    return upper;
}

- (CGPoint) lowerVertex {
    CGPoint lower = CGPointMake(self.bounds.size.width/2.0,
                                self.bounds.size.height - (self.bounds.size.height * DIAMOND_LOWER_VERTEX_OFFSET));
    return lower;
}

- (CGPoint) leftVertex {
    CGPoint left = CGPointMake(self.bounds.size.width/2.0 - self.bounds.size.width * DIAMOND_WIDTH / 2.0,
                               self.bounds.size.height / 2.0);
    return left;
}

- (CGPoint) rightVertex {
    CGPoint right = CGPointMake(self.bounds.size.width/2.0 + self.bounds.size.width * DIAMOND_WIDTH / 2.0,
                                self.bounds.size.height / 2.0);
    return right;
}


- (void) drawDiamond {
    UIBezierPath *diamond = [[UIBezierPath alloc]init];
    diamond.lineWidth = 2;
    [diamond moveToPoint:[self upperVertex]];
    [diamond addLineToPoint:[self rightVertex]];
    [diamond addLineToPoint:[self lowerVertex]];
    [diamond addLineToPoint:[self leftVertex]];
    [diamond addLineToPoint:[self upperVertex]];
    
    [self.color setStroke];
    
    if (self.count == 2){
        UIBezierPath *rightDiamond = [diamond copy];
        CGAffineTransform rightTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.15, 0.0};
        [rightDiamond applyTransform:rightTransform];
        
        CGAffineTransform leftDiamond = {1.0,0.0,0.0,1.0, self.bounds.size.width * 0.15 * -1, 0.0};
        [diamond applyTransform:leftDiamond];
        
        [diamond appendPath:rightDiamond];
        
    } else if (self.count == 3){
        // Copy this diamond using UIBezierPath transformation
        UIBezierPath *leftDiamond = [diamond copy];
        CGAffineTransform leftTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.30 * -1, 0.0};
        [leftDiamond applyTransform:leftTransform];
        
        UIBezierPath *rightDiamond = [diamond copy];
        CGAffineTransform rightTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.30, 0.0};
        [rightDiamond applyTransform:rightTransform];
        
        [diamond appendPath:leftDiamond];
        [diamond appendPath:rightDiamond];
        
    }
    
    
    if ([self.shade isEqualToString:@"Solid"]){
        [self.color setFill];
    } else if ([self.shade isEqualToString:@"Striped"]) {
        // To make it striped
        [[UIColor clearColor]setFill];
        CGPoint start = CGPointMake(0.0, 0.0);
        CGPoint end = CGPointMake(self.bounds.size.width, 0.0);
        CGFloat dy = self.bounds.size.height / 15.0;
        [diamond addClip];
        while (start.y <= self.bounds.size.height) {
            [diamond moveToPoint:start];
            [diamond addLineToPoint:end];
            start.y += dy;
            end.y += dy;
        }
        
    }
    
    // Say it to draw
    [diamond fill];
    [diamond stroke];
}

// PS!!!
// To draw a squiggle, use addCurve that uses controlPoints to create a curve
// And use addArcWithCenter method to make the top and bottom

#pragma mark - Draw Ovals

#define OVAL_UPPER_VERTEX_OFFSET 0.20
#define OVAL_LOWER_VERTEX_OFFSET 0.20
#define OVAL_WIDTH 0.10

- (CGPoint) upperRightOvalVertex {
    CGPoint upperRight = CGPointMake(self.bounds.size.width/2.0 + self.bounds.size.width * OVAL_WIDTH / 2.0,
                                     self.bounds.size.height * OVAL_UPPER_VERTEX_OFFSET);
    return upperRight;
}

- (CGPoint) lowerLeftOvalVertex {
    CGPoint lowerLeft = CGPointMake(self.bounds.size.width/2.0 - self.bounds.size.width * OVAL_WIDTH / 2.0,
                                    self.bounds.size.height - self.bounds.size.height * OVAL_LOWER_VERTEX_OFFSET);
    return lowerLeft;
}

- (CGPoint) upperOvalCenter {
    CGPoint upperCenter = CGPointMake(self.bounds.size.width/2.0,
                                      self.bounds.size.height * OVAL_UPPER_VERTEX_OFFSET);
    return upperCenter;
}

- (CGPoint) lowerOvalCenter {
    CGPoint lowerCenter = CGPointMake(self.bounds.size.width/2.0,
                                      self.bounds.size.height - self.bounds.size.height * OVAL_LOWER_VERTEX_OFFSET);
    return lowerCenter;
}


- (CGFloat) radiusOval {
    CGFloat radius = self.bounds.size.width * OVAL_WIDTH/2.0;
    return radius;
}

- (void) drawOval {
    UIBezierPath *oval = [[UIBezierPath alloc]init];
    oval.lineWidth = 2;
    [oval moveToPoint:[self upperRightOvalVertex]];
    [oval addArcWithCenter:[self upperOvalCenter] radius:[self radiusOval] startAngle:0.0 endAngle:M_PI clockwise:NO];
    [oval addLineToPoint:[self lowerLeftOvalVertex]];
    [oval addArcWithCenter:[self lowerOvalCenter] radius:[self radiusOval] startAngle:M_PI endAngle:0.0 clockwise:NO];
    [oval addLineToPoint:[self upperRightOvalVertex]];
    
    [self.color setStroke];
    
    
    // Set the number of copies
    if (self.count == 2){
        UIBezierPath *rightOval = [oval copy];
        CGAffineTransform rightTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.10, 0.0};
        [rightOval applyTransform:rightTransform];
        
        CGAffineTransform leftOval = {1.0,0.0,0.0,1.0, self.bounds.size.width * 0.10 * -1, 0.0};
        [oval applyTransform:leftOval];
        
        [oval appendPath:rightOval];
        
    } else if (self.count == 3){
        // Copy this diamond using UIBezierPath transformation
        UIBezierPath *leftOval = [oval copy];
        // 0.30 is how much I want to move in percentage (x-axis)
        CGAffineTransform leftTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.20 * -1, 0.0};
        [leftOval applyTransform:leftTransform];
        
        UIBezierPath *rightOval = [oval copy];
        CGAffineTransform rightTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.20, 0.0};
        [rightOval applyTransform:rightTransform];
        
        [oval appendPath:leftOval];
        [oval appendPath:rightOval];
        
    }
    
    // Set the color
    if ([self.shade isEqualToString:@"Solid"]){
        [self.color setFill];
    } else if ([self.shade isEqualToString:@"Striped"]) {
        // To make it striped
        [[UIColor clearColor]setFill];
        CGPoint start = CGPointMake(0.0, 0.0);
        CGPoint end = CGPointMake(self.bounds.size.width, 0.0);
        CGFloat dy = self.bounds.size.height / 15.0;
        [oval addClip];
        while (start.y <= self.bounds.size.height) {
            [oval moveToPoint:start];
            [oval addLineToPoint:end];
            start.y += dy;
            end.y += dy;
        }
        
    }
    
    [oval fill];
    [oval stroke];
}

#pragma mark - Draw Squiggles

#define SQUIGGLE_UPPER_VERTEX_OFFSET 0.20
#define SQUIGGLE_LOWER_VERTEX_OFFSET 0.20
#define SQUIGGLE_WIDTH 0.10

- (CGPoint) upperRightSquiggleVertex {
    CGPoint upperRight = CGPointMake(self.bounds.size.width/2.0 + self.bounds.size.width * SQUIGGLE_WIDTH / 2.0,
                                     self.bounds.size.height * SQUIGGLE_UPPER_VERTEX_OFFSET);
    return upperRight;
}

- (CGPoint) lowerLeftSquiggleVertex {
    CGPoint lowerLeft = CGPointMake(self.bounds.size.width/2.0 - self.bounds.size.width * SQUIGGLE_WIDTH / 2.0,
                                    self.bounds.size.height - self.bounds.size.height * SQUIGGLE_LOWER_VERTEX_OFFSET);
    return lowerLeft;
}

- (CGPoint) upperSquiggleCenter {
    CGPoint upperCenter = CGPointMake(self.bounds.size.width/2.0,
                                      self.bounds.size.height * SQUIGGLE_UPPER_VERTEX_OFFSET);
    return upperCenter;
}

- (CGPoint) lowerSquiggleCenter {
    CGPoint lowerCenter = CGPointMake(self.bounds.size.width/2.0,
                                      self.bounds.size.height - self.bounds.size.height * SQUIGGLE_LOWER_VERTEX_OFFSET);
    return lowerCenter;
}

- (CGFloat) radiusSquiggle {
    CGFloat radius = self.bounds.size.width * SQUIGGLE_WIDTH/2.0;
    return radius;
}

- (CGPoint) upperRightControl {
    CGPoint upperRightControl = CGPointMake(self.bounds.size.width/2.0 + self.bounds.size.width * SQUIGGLE_WIDTH,
                                            self.bounds.size.height/2.0);
    return upperRightControl;
}

- (CGPoint) upperLeftControl {
    CGPoint upperLeftControl = CGPointMake(self.bounds.size.width/2.0 + self.bounds.size.width * SQUIGGLE_WIDTH / 4.0,
                                           self.bounds.size.height/2.0);
    return upperLeftControl;
}

- (CGPoint) lowerRightControl {
    CGPoint lowerRightControl = CGPointMake(self.bounds.size.width/2.0 - self.bounds.size.width * SQUIGGLE_WIDTH / 4.0,
                                            self.bounds.size.height/2.0 + self.bounds.size.height * SQUIGGLE_WIDTH / 2.0);
    return lowerRightControl;
}

- (CGPoint) lowerLeftControl {
    CGPoint lowerLeftControl = CGPointMake(self.bounds.size.width/2.0 - self.bounds.size.width * SQUIGGLE_WIDTH,
                                           self.bounds.size.height/2.0 + self.bounds.size.height * SQUIGGLE_WIDTH / 2.0);
    return lowerLeftControl;
}

- (void) drawSquiggle {
    UIBezierPath *squiggle = [[UIBezierPath alloc]init];
    squiggle.lineWidth = 2;
    [squiggle moveToPoint:[self upperRightSquiggleVertex]];
    [squiggle addArcWithCenter:[self upperSquiggleCenter] radius:[self radiusSquiggle] startAngle:0.0 endAngle:M_PI clockwise:NO];
    [squiggle addCurveToPoint:[self lowerLeftSquiggleVertex] controlPoint1:[self upperLeftControl] controlPoint2:[self lowerLeftControl]];
    [squiggle addArcWithCenter:[self lowerSquiggleCenter] radius:[self radiusSquiggle] startAngle:M_PI endAngle:0.0 clockwise:NO];
    [squiggle addCurveToPoint:[self upperRightSquiggleVertex] controlPoint1:[self lowerRightControl] controlPoint2:[self upperRightControl]];
    
    [self.color setStroke];
    
    // Set the number of copies (2 or 3)
    if (self.count == 2){
        UIBezierPath *rightSquiggle = [squiggle copy];
        CGAffineTransform rightTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.10, 0.0};
        [rightSquiggle applyTransform:rightTransform];
        
        CGAffineTransform leftTransform = {1.0,0.0,0.0,1.0, self.bounds.size.width * 0.10 * -1, 0.0};
        [squiggle applyTransform:leftTransform];
        
        [squiggle appendPath:rightSquiggle];
        
    } else if (self.count == 3){
        // Copy this diamond using UIBezierPath transformation
        UIBezierPath *leftSquiggle = [squiggle copy];
        // 0.30 is how much I want to move in percentage (x-axis)
        CGAffineTransform leftTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.20 * -1, 0.0};
        [leftSquiggle applyTransform:leftTransform];
        
        UIBezierPath *rightSquiggle = [squiggle copy];
        CGAffineTransform rightTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.20, 0.0};
        [rightSquiggle applyTransform:rightTransform];
        
        [squiggle appendPath:leftSquiggle];
        [squiggle appendPath:rightSquiggle];
        
    }
    
    // Set the color
    if ([self.shade isEqualToString:@"Solid"]){
        [self.color setFill];
    } else if ([self.shade isEqualToString:@"Striped"]) {
        // To make it striped
        [[UIColor clearColor]setFill];
        CGPoint start = CGPointMake(0.0, 0.0);
        CGPoint end = CGPointMake(self.bounds.size.width, 0.0);
        CGFloat dy = self.bounds.size.height / 15.0;
        [squiggle addClip];
        while (start.y <= self.bounds.size.height) {
            [squiggle moveToPoint:start];
            [squiggle addLineToPoint:end];
            start.y += dy;
            end.y += dy;
        }
        
    }
    
    // End number of copies
    [squiggle fill];
    [squiggle stroke];
}


#pragma mark - Initialization

- (void) setup {
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void) awakeFromNib {
    [self setup];
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        // Initialization Code
    }
    return self;
}

@end
