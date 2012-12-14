//
//  AppDelegate.h
//  inDaHouse.testing
//
//  Created by Jeff Hurray on 11/25/12.
//  Copyright (c) 2012 Newton South High School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Alohar/Alohar.h>
#import <MapKit/MapKit.h>



#import "ViewControllerLogin.h"
#import "Places.h"


@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, ALSessionDelegate>


@property (nonatomic, strong) ViewControllerLogin *viewControllerLogin;
@property (strong, nonatomic) UIWindow *window;



@property (strong, nonatomic) UINavigationController *navSuper;




@end
