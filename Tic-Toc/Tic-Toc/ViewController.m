//
//  ViewController.m
//  Tic-Toc
//
//  Created by Tanjim Hossain on 1/11/18.
//  Copyright © 2018 Tanjim Hossain. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *clockView;

@end

@implementation ViewController {
    CAShapeLayer *secondHandLayer;
    CAShapeLayer *minuteHandLayer;
    CAShapeLayer *hourHandLayer;
    
    CGPoint clockCenter;
    
    CGFloat secondHandLength;
    CGFloat minuteHandLength;
    CGFloat hourHandLength;
    
    CGFloat currentSecondHandAngel;
    CGFloat currentMinuteHandAngel;
    CGFloat currentHourHandAngel;
    
    int timeInSeconds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBackground];
    [self initCurrentClockView];
}

#pragma mark - UI related methods

-(void) initBackground {
    
    self.clockView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, self.view.frame.size.width - 40)];
    [self.clockView setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    
    UIImageView *clockImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.clockView.frame.size.width, self.clockView.frame.size.height)];
    clockImageView.image = [UIImage imageNamed:@"clock"];
    [self.clockView insertSubview:clockImageView atIndex:0];
    
    clockCenter = CGPointMake(self.clockView.frame.size.width/2, self.clockView.frame.size.height/2);
    secondHandLength = self.clockView.frame.size.width/2 - 30;
    minuteHandLength = self.clockView.frame.size.width/2 - 40;
    hourHandLength = self.clockView.frame.size.width/2 - 60;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view addSubview:self.clockView];
    });
    
}

-(void) initCurrentClockView {
    secondHandLayer = [[CAShapeLayer alloc] init];
    minuteHandLayer = [[CAShapeLayer alloc] init];
    hourHandLayer = [[CAShapeLayer alloc] init];
    
    [secondHandLayer setLineWidth:1];
    [minuteHandLayer setLineWidth:3];
    [hourHandLayer setLineWidth:5];
    
    [secondHandLayer setStrokeColor:[UIColor blackColor].CGColor];
    [minuteHandLayer setStrokeColor:[UIColor blackColor].CGColor];
    [hourHandLayer setStrokeColor:[UIColor blackColor].CGColor];
    
    [self.clockView.layer addSublayer:secondHandLayer];
    [self.clockView.layer addSublayer:minuteHandLayer];
    [self.clockView.layer addSublayer:hourHandLayer];
    
    [self initCurrentTime];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self drawClockView];
    });
    
}

-(void) drawClockView {
    
    UIBezierPath *helperPath = [UIBezierPath bezierPath];
    UIBezierPath *secondHandPath = [UIBezierPath bezierPath];
    UIBezierPath *minuteHandPath = [UIBezierPath bezierPath];
    UIBezierPath *hourHandPath = [UIBezierPath bezierPath];
    
    [secondHandPath moveToPoint:clockCenter];
    [minuteHandPath moveToPoint:clockCenter];
    [hourHandPath moveToPoint:clockCenter];
    
    [helperPath addArcWithCenter:clockCenter radius:secondHandLength startAngle:0 endAngle:(currentSecondHandAngel*M_PI)/180 clockwise:NO];
    [secondHandPath addLineToPoint:[helperPath currentPoint]];
    
    [helperPath addArcWithCenter:clockCenter radius:minuteHandLength startAngle:0 endAngle:(currentMinuteHandAngel*M_PI)/180 clockwise:NO];
    [minuteHandPath addLineToPoint:[helperPath currentPoint]];
    
    [helperPath addArcWithCenter:clockCenter radius:hourHandLength startAngle:0 endAngle:(currentHourHandAngel*M_PI)/180 clockwise:NO];
    [hourHandPath addLineToPoint:[helperPath currentPoint]];
    
    secondHandLayer.path = secondHandPath.CGPath;
    minuteHandLayer.path = minuteHandPath.CGPath;
    hourHandLayer.path = hourHandPath.CGPath;
    
    timeInSeconds++;

    [self updateAngelsForCurrentTime];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self drawClockView];
    });
}

#pragma mark - private methods

-(void) initCurrentTime {
    
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    
    NSArray *timeEachPart = [resultString componentsSeparatedByString:@":"];
    int hour = [[timeEachPart objectAtIndex:0] intValue];
    int minute = [[timeEachPart objectAtIndex:1] intValue];
    int second = [[timeEachPart objectAtIndex:2] intValue];
    
    NSLog(@"%d:%d:%d",hour,minute,second);
    
    timeInSeconds = hour*3600+minute*60+second;
    
    [self updateAngelsForCurrentTime];
}

-(void) updateAngelsForCurrentTime {
    
    CGFloat angleInSecond = (360.0/60)*timeInSeconds;
    CGFloat angleInMinute = (360.0/3600)*timeInSeconds;
    CGFloat angleInHour = (360.0/43200)*timeInSeconds;
    
    //NSLog(@"%f:%f:%f",angleInHour, angleInMinute, angleInSecond);
    
    currentSecondHandAngel = angleInSecond  - 90;
    currentMinuteHandAngel = angleInMinute - 90;
    currentHourHandAngel = angleInHour - 90;
}

@end
