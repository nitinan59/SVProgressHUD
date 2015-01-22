//
//  SVProgressHUDViewController.m
//  SVProgressHUD
//
//  Created by Sam Vermette on 27.03.11.
//  Copyright 2011 Sam Vermette. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"

@implementation ViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}


#pragma mark - Notification Methods Sample

-(void)viewDidLoad{
    [super viewDidLoad];
    [SVProgressHUD setDefaultAnimatedImage:[UIImage animatedImageWithImages:@[
                                                                              [UIImage imageNamed:@"frame_000.gif"],
                                                                              [UIImage imageNamed:@"frame_001.gif"],
                                                                              [UIImage imageNamed:@"frame_002.gif"],
                                                                              [UIImage imageNamed:@"frame_003.gif"],
                                                                              [UIImage imageNamed:@"frame_004.gif"],
                                                                              [UIImage imageNamed:@"frame_005.gif"],
                                                                              [UIImage imageNamed:@"frame_006.gif"],
                                                                              [UIImage imageNamed:@"frame_007.gif"],
                                                                              [UIImage imageNamed:@"frame_008.gif"],
                                                                              [UIImage imageNamed:@"frame_009.gif"],
                                                                              [UIImage imageNamed:@"frame_010.gif"],
                                                                              [UIImage imageNamed:@"frame_011.gif"]
                                                                              ]
                                                                   duration:1.0]];
    [SVProgressHUD setDefaultAnimatedImageSize:CGSizeMake(50, 50)];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDWillAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDWillDisappearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidDisappearNotification
                                               object:nil];
}

- (void)handleNotification:(NSNotification *)notif
{
    NSLog(@"Notification recieved: %@", notif.name);
    NSLog(@"Status user info key: %@", [notif.userInfo objectForKey:SVProgressHUDStatusUserInfoKey]);
}


#pragma mark - Show Methods Sample

- (void)show {
//	[SVProgressHUD show];
    [SVProgressHUD showAnimatedImage];
}

- (void)showWithStatus {
//	[SVProgressHUD showWithStatus:@"Doing Stuff"];
    [SVProgressHUD showAnimatedImageWithStatus:@"Doing Stuff"];
}

static float progress = 0.0f;

- (IBAction)showWithProgress:(id)sender {
    progress = 0.0f;
    [SVProgressHUD showProgress:0 status:@"Loading"];
    [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3f];
}

- (void)increaseProgress {
    progress+=0.1f;
    [SVProgressHUD showProgress:progress status:@"Loading"];

    if(progress < 1.0f)
        [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3f];
    else
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.4f];
}


#pragma mark - Dismiss Methods Sample

- (void)dismiss {
	[SVProgressHUD dismiss];
}

- (IBAction)dismissInfo{
    [SVProgressHUD showInfoWithStatus:@"Useful Information."];
}

- (void)dismissSuccess {
	[SVProgressHUD showSuccessWithStatus:@"Great Success!"];
}

- (void)dismissError {
	[SVProgressHUD showErrorWithStatus:@"Failed with Error"];
}

@end
