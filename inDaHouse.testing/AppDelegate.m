//
//  AppDelegate.m
//  inDaHouse.testing
//
//  Created by Jeff Hurray on 11/25/12.
//  Copyright (c) 2012 Newton South High School. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize navSuper;
@synthesize window = _window;
@synthesize viewControllerLogin;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [Alohar registerWithAppID:@"240"
                    andAPIKey:@"c5a6215c5b36af7814fdc70a398cc063d57df48c"
                 withDelegate:self];
    
    //Login screen
    viewControllerLogin = [[ViewControllerLogin alloc] init];
    
    self.navSuper = [[UINavigationController alloc] initWithRootViewController:viewControllerLogin];
    [self.navSuper setNavigationBarHidden:YES];
    
    _window.rootViewController = navSuper;
    
    [_window makeKeyAndVisible];
    
    UILocalNotification *localNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];  
    if (localNotif) {       
        [self.navSuper pushViewController:viewControllerLogin animated:YES];
  }

    // Override point for customization after application launch.
    return YES;
}

//*********** LOGIN ************
- (void)aloharDidLogin:(NSString *)userToken
{
    NSLog(@"User is logged in!");
    [Alohar startMonitoringUser];
    NSLog(@"\nNew latitude is: %f\n New Longitude is: %f\n", [Alohar currentLocation].coordinate.latitude, [Alohar currentLocation].coordinate.longitude);
    
    [[Places sharedInstance]placesMA]; 
    
    ALPlace *place1 = [[ALPlace alloc] init];
    ALPlace *place2 = [[ALPlace alloc] init];
    ALPlace *place3 = [[ALPlace alloc] init];
    ALPlace *place4 = [[ALPlace alloc] init];
    
    place1.name = @"UGLI";
    place2.name = @"CHI PHI";
    place3.name = @"NORTH CAMPUS";
    place4.name = @"NO THAI";
    
    place1.category = @"library";
    place2.category = @"house";
    place3.category = @"area";
    place4.category = @"restaurant";
    
    place1.placeID = 0;
    place2.placeID = 1;
    place3.placeID = 2;
    place4.placeID = 3;
    
    CLLocationCoordinate2D loc1;
    CLLocationCoordinate2D loc2;
    CLLocationCoordinate2D loc3;
    CLLocationCoordinate2D loc4;
    
    NSLog(@"latitude: %f\n\n Longitude: %f\n\n",[Alohar currentLocation].coordinate.latitude,[Alohar currentLocation].coordinate.longitude);
    
    loc1.latitude = 42.2755;
    loc1.longitude = -83.7375;
    loc2.latitude = 42.273493;
    loc2.longitude = -83.729935;
    loc3.latitude = 42.292619;
    loc3.longitude = -83.716189;
    loc4.latitude = [Alohar currentLocation].coordinate.latitude + 0.003;
    loc4.longitude = [Alohar currentLocation].coordinate.longitude - 0.003;
    
    place1.location = [[CLLocation alloc] initWithLatitude:loc1.latitude longitude:loc1.longitude];
    place2.location = [[CLLocation alloc] initWithLatitude:loc2.latitude longitude:loc2.longitude];
    place3.location = [[CLLocation alloc] initWithLatitude:loc3.latitude longitude:loc3.longitude];
    place4.location = [[CLLocation alloc] initWithLatitude:loc4.latitude longitude:loc4.longitude];
    
    [[Places sharedInstance]addPlace:place1];
    [[Places sharedInstance]addPlace:place2];
    [[Places sharedInstance]addPlace:place3];
    [[Places sharedInstance]addPlace:place4];
}

///*********LOGIN ERROR*********
- (void)aloharDidFailWithError:(NSError *)error
{
    NSLog(@"User couldn't be logged in! Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //what to do!!!
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
   // isAppResumingFromBackground = YES;
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[[Places sharedInstance] placesMA] forKey:@"places"];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
