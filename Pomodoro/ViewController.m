//
//  ViewController.m
//  Pomodoro
//
//  Created by Vladislav on 4/15/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

#import "ViewController.h"
#import "ClockView.h"

typedef NS_ENUM(NSInteger, ClockState) {
    kWorkState,
    kBreakState
};

typedef NS_ENUM(NSInteger, FireState) {
    kFiredState,
    kPausedState
};


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *fireButton;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet ClockView *clock;

@property (nonatomic, assign) ClockState clockNextState;
@property (nonatomic, assign) FireState fireState;

@property (nonatomic, strong) NSDate *pauseStart;
@property (nonatomic, strong) NSDate *previousFireDate;

@property (weak, nonatomic) NSTimer *timer;
@property (nonatomic, assign) NSUInteger secondsRemain;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clockNextState = kWorkState;
    self.fireState = kFiredState;
    
    UITapGestureRecognizer *reco = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleClock:)];
    [self.clock addGestureRecognizer:reco];
    
    [self setupStateButton];
}

- (void)toggleClock:(UITapGestureRecognizer *)sender {
    if(self.fireState == kFiredState) {
        [self pauseTimer:self.timer];
        self.fireState = kPausedState;
        [self.clock pauseAnimation];
        
    } else {
        [self resumeTimer:self.timer];
        self.fireState = kFiredState;
        [self.clock resumeAnimation];
    }
}

- (void)setupStateButton {
    [self.fireButton setTitle:@"Click here to start" forState:UIControlStateNormal];
    self.timerLabel.text = @"O_o";
    self.fireButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
    
    [self.clock changeColorTo:UIColor.systemTealColor];
    self.timerLabel.font = [UIFont systemFontOfSize:40 weight:UIFontWeightSemibold];
    [self.fireButton addTarget:self action:@selector(toggleClockState) forControlEvents:UIControlEventTouchUpInside];
}

- (void)toggleClockState {
    [self fireTimer];
    self.clockNextState = self.clockNextState == kWorkState ? kBreakState : kWorkState;
    self.fireState = kFiredState;
}

// MARK: Timers Preparation

- (void)prepareWorkTimer {
    self.timerLabel.text = @"20:00";
    self.secondsRemain = 1200;
    [self.clock changeColorTo:UIColor.systemRedColor];
    [self.fireButton setTitle:@"Begin a break" forState:UIControlStateNormal];
}

- (void)prepareBreakTimer {
    self.timerLabel.text = @"5:00";
    self.secondsRemain = 300;
    [self.clock changeColorTo:UIColor.systemGreenColor];
    [self.fireButton setTitle:@"Begin a work" forState:UIControlStateNormal];
}

// MARK: Timers Firing

- (void)fireTimer {
    if(self.timer.isValid) {
        [self.timer invalidate];
    }
    if(self.clockNextState == kWorkState) {
        [self prepareWorkTimer];
    } else {
        [self prepareBreakTimer];
    }
    [self.clock runAnimation:self.secondsRemain];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer:) userInfo:nil repeats:true];
}

- (void)updateTimer:(NSTimer *)timer {
    if(self.secondsRemain > 0) {
        self.secondsRemain--;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.secondsRemain];
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"m:ss";
        [self.timerLabel setText:[formatter stringFromDate:date]];
    } else {
        [self.timer invalidate];
    }
}

// MARK: -Time Play Button Function

- (void)pauseTimer:(NSTimer *)timer {
    self.pauseStart = [NSDate dateWithTimeIntervalSinceNow:0];
    self.previousFireDate = timer.fireDate;
    [timer setFireDate:NSDate.distantFuture];
}

- (void)resumeTimer:(NSTimer *)timer {
    float pauseTime = -1*self.pauseStart.timeIntervalSinceNow;
    [timer setFireDate:[self.previousFireDate initWithTimeInterval:pauseTime sinceDate:self.previousFireDate]];
}


@end
