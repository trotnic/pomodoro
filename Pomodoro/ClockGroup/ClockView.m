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
    self.ring.strokeColor = color.CGColor;
}

- (void)runAnimation:(NSTimeInterval)duration {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = duration;
    animation.fromValue = [NSNumber numberWithDouble:1.0];
    animation.toValue = [NSNumber numberWithDouble:0.0];
    [self.ring addAnimation:animation forKey:@"strokeEnd"];
    
}

- (void)setupView {
    
    CGFloat radius = self.bounds.size.width / 2;
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineCap = kCALineCapRound;
    layer.lineWidth = 20.0;
    layer.fillColor = UIColor.clearColor.CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];

    layer.path = path.CGPath;
    layer.strokeColor = UIColor.redColor.CGColor;
    self.ring = layer;
    [self.layer addSublayer:self.ring];
    
}

@end
