//
//  ClockView.h
//  Pomodoro
//
//  Created by Vladislav on 4/15/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface ClockView : UIView

- (void)changeColorTo:(UIColor *)color;
- (void)runAnimation:(NSTimeInterval)duration;
- (void)pauseAnimation;
- (void)resumeAnimation;

@end

NS_ASSUME_NONNULL_END
