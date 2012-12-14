//
//  ViewControllerLogin.h
//  inDaHouse.testing
//
//  Created by Jeff Hurray on 12/3/12.
//  Copyright (c) 2012 Newton South High School. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "UIButton+Glossy.h"
#import "sneakyTab.h"


@interface ViewControllerLogin : UIViewController 

@property (strong, nonatomic) IBOutlet UIButton *login; 


-(IBAction)loginAttempt:(id)sender;
@end
