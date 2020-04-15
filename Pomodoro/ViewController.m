//
//  ViewController.m
//  Pomodoro
//
//  Created by Vladislav on 4/15/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *fireButton;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (weak, nonatomic) NSTimer *timer;
@property (nonatomic) NSUInteger secondsRemain;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    [self.fireButton.layer setBorderWidth:1.0];
    [self.fireButton.layer setCornerRadius:5.0];
    [self.fireButton setTitle:@"Begin a work" forState:UIControlStateNormal];
    
    [self.timerLabel.layer setBorderWidth:1.0];
    [self.timerLabel.layer setCornerRadius:5.0];
    
    [self.fireButton addTarget:self action:@selector(setupWorkTimer) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupWorkTimer {
    if([self.timer isValid]) {
        [self.timer invalidate];
    }
    
    [self.timerLabel setText:@"20:00"];
    self.secondsRemain = 1200;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer:) userInfo:nil repeats:true];
    
    [self.fireButton removeTarget:self action:@selector(setupWorkTimer) forControlEvents:UIControlEventTouchUpInside];
    [self.fireButton addTarget:self action:@selector(setupBreakTimer) forControlEvents:UIControlEventTouchUpInside];
    [self.fireButton setTitle:@"Begin a break" forState:UIControlStateNormal];
}

- (void)setupBreakTimer {
    if([self.timer isValid]) {
        [self.timer invalidate];
    }
    
    [self.timerLabel setText:@"5:00"];
    self.secondsRemain = 300;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer:) userInfo:nil repeats:true];
    
    [self.fireButton removeTarget:self action:@selector(setupBreakTimer) forControlEvents:UIControlEventTouchUpInside];
    [self.fireButton addTarget:self action:@selector(setupWorkTimer) forControlEvents:UIControlEventTouchUpInside];
    [self.fireButton setTitle:@"Begin a work" forState:UIControlStateNormal];
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

@end
