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

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBackground];
}

#pragma mark - UI related methods

-(void) initBackground {
    
    self.clockView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, self.view.frame.size.width - 40)];
    [self.clockView setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    
    UIImageView *clockImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.clockView.frame.size.width, self.clockView.frame.size.height)];
    clockImageView.image = [UIImage imageNamed:@"clock"];
    [self.clockView insertSubview:clockImageView atIndex:0];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view addSubview:self.clockView];
    });
    
}


@end
