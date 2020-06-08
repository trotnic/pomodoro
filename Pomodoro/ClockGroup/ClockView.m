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
@property (strong, nonatomic) UIViewPropertyAnimator *animator;
@property (strong, nonatomic) UIColor *currentColor;

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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)changeColorTo:(UIColor *)color {
    self.currentColor = color;
    self.ring.strokeColor = self.currentColor.CGColor;
}

- (void)pauseAnimation {
    CFTimeInterval pausedTime = [self.ring convertTime:CACurrentMediaTime() fromLayer:nil];
    self.ring.speed  = 0.0;
    self.ring.timeOffset = pausedTime;
}

- (void)resumeAnimation {
    CFTimeInterval pausedTime = self.ring.timeOffset;
    self.ring.speed = 1.0;
    self.ring.timeOffset = 0.0;
    self.ring.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.ring convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.ring.beginTime = timeSincePause;
    self.ring.strokeColor = self.currentColor.CGColor;
}

- (void)runAnimation:(NSTimeInterval)duration {
    [self resumeAnimation];
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
    self.ring.strokeStart = 0.0;
    self.ring.strokeEnd = 10.0;
    [self.layer addSublayer:self.ring];
    
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGFloat radius = sqrt(pow(point.x - self.bounds.size.width / 2, 2) + pow(point.y - self.bounds.size.height / 2, 2));
    if(radius > self.bounds.size.width / 2) {
        return false;
    }
    return true;
}

@end
