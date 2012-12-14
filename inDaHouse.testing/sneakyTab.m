//
//  sneakyTab.m
//  inDaHouse.testing
//
//  Created by Jeff Hurray on 12/4/12.
//  Copyright (c) 2012 Newton South High School. All rights reserved.
//

#import "sneakyTab.h"

@interface SneakyTab ()

@end

@implementation SneakyTab

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        UIOffset verticalOffset = UIOffsetMake(0,-10);
        
        ViewController *v1 = [[ViewController alloc]init ];
        ViewControllerTV *vTV = [[ViewControllerTV alloc]init];
    
        
        UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:v1 ];
        [nav1 setNavigationBarHidden:YES];
        
        nav1.navigationBar.barStyle = UIBarStyleBlackOpaque;
        
        nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"MAP" image:nil tag:0];
        [nav1.tabBarItem setTitlePositionAdjustment:verticalOffset];
        [nav1.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 [UIColor whiteColor], UITextAttributeTextColor, 
                                                 [UIFont fontWithName:@"Knewave" size:23.0], UITextAttributeFont ,nil]
                                       forState:UIControlStateNormal];
        
        
        //TABLEVIEW
        UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:vTV ];
        
        [nav2 setNavigationBarHidden:NO
         ];
        
        nav2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"TABLE" image:nil tag:1];
        
        [nav2.tabBarItem setTitlePositionAdjustment:verticalOffset];
        [nav2.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 [UIColor whiteColor], UITextAttributeTextColor, 
                                                 [UIFont fontWithName:@"Knewave" size:23.0], UITextAttributeFont ,nil]
                                       forState:UIControlStateNormal];
        
        
        //make the array
        self.viewControllers = [NSArray arrayWithObjects:nav1,nav2, nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
