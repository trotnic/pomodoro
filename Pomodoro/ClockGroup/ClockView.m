//
//  ClockView.m
//  Pomodoro
//
//  Created by Vladislav on 4/15/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

#import "ClockView.h"

@interface ClockView ()

@property (strong, nonatomic) CAShapeLayer *ring;
@property (strong, nonatomic) CAShapeLayer *filler;

@end

@implementation ClockView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)changeColorTo:(UIColor *)color {
    self.filler.strokeColor = color.CGColor;
}

- (void)runAnimation:(NSTimeInterval)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = duration;
    animation.fromValue = [NSNumber numberWithDouble:1.0];
    animation.toValue = [NSNumber numberWithDouble:0.0];
    [self.filler addAnimation:animation forKey:@"strokeEnd"];
}

- (void)setupView {
    CGFloat radius = self.bounds.size.width / 2;
    CGFloat inset  = -10;
    
    self.ring = [CAShapeLayer layer];
    self.ring.path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, inset, inset)
                                           cornerRadius:radius-inset].CGPath;

    self.ring.fillColor   = UIColor.whiteColor.CGColor;
    self.ring.strokeColor = UIColor.lightGrayColor.CGColor;
    self.ring.lineWidth   = 1;
    
    [self.layer addSublayer:self.ring];
    
    self.filler = [CAShapeLayer layer];
    self.filler.frame = self.layer.bounds;
    
    CGRect circleBounds = CGRectMake(self.bounds.size.width / 2 - radius, self.bounds.size.height / 2 - radius, radius*2, 2*radius);
    
    self.filler.fillColor = UIColor.clearColor.CGColor;
    self.filler.strokeColor = UIColor.greenColor.CGColor;
    self.filler.lineWidth = 20;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:circleBounds cornerRadius:circleBounds.size.width / 2];
    self.filler.path = [path bezierPathByReversingPath].CGPath;
    self.filler.strokeEnd = 1;
    

    [self.layer addSublayer:self.filler];
    
    
/*
 
    A sense of the approach below is to draw a circle's sector
    and to increase it's angle over the time.
    But it's not the best way i think
 
 */
//    [self runAnimation:[NSNotificationCenter new]];
//    CAShapeLayer *slice = [CAShapeLayer layer];
//    slice.fillColor = UIColor.redColor.CGColor;
//    slice.strokeColor = UIColor.blackColor.CGColor;
//    slice.lineWidth = 2;
//
//    CGFloat angle = -60*3.14/180;
//    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.width / 2);
//    CGFloat radius = self.bounds.size.height / 3;
//
//    UIBezierPath *piePath = [UIBezierPath bezierPath];
//    [piePath moveToPoint:center];
//
//    [piePath addLineToPoint:CGPointMake(center.x + radius*cosf(angle), center.y + radius*sinf(angle))];
//    [piePath addArcWithCenter:center radius:radius startAngle:angle endAngle:2*angle clockwise:true];
//
//    [piePath closePath];
//
//    slice.path = piePath.CGPath;
//    [self.layer addSublayer:slice];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
