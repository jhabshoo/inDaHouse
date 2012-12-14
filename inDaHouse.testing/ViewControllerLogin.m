//
//  ViewControllerLogin.m
//  inDaHouse.testing
//
//  Created by Jeff Hurray on 12/3/12.
//  Copyright (c) 2012 Newton South High School. All rights reserved.
//

#import "ViewControllerLogin.h"

@interface ViewControllerLogin ()

@end

@implementation ViewControllerLogin
@synthesize login;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    //for rotation
    bool rotate = false;
    
    if(rotate){self.login.transform = CGAffineTransformMakeRotation(M_PI / 180 * 5.0f);}
    
    NSArray *buttons = [NSArray arrayWithObjects:login, nil];
    
    for(UIButton *btn in buttons){
    
    UIColor *border = [UIColor colorWithRed:161/255.0f green:55/255.0f blue:192/255.0f alpha:1.0f];
        
    // Set the button Text Color
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:border
              forState:UIControlStateHighlighted];
    //new font
    [[btn titleLabel] setFont:[UIFont fontWithName:@"Knewave" size:35.0f]];
    //[btn makeGlossy];   //WHY?
        
    // Draw a custom gradient
    
    // Set the button Background Color
    //[login setBackgroundColor:[UIColor blackColor]];
    
    // Draw a custom gradient
    CAGradientLayer *btnGradient = [CAGradientLayer layer];
    btnGradient.frame = btn.bounds;
    btnGradient.colors = [NSArray arrayWithObjects:
                          (id)[[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f] CGColor],
                          (id)[[UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f / 255.0f alpha:1.0f] CGColor],
                          nil];
    [login.layer insertSublayer:btnGradient atIndex:0];
    
    //rounding corners
    CALayer *btnLayer = [login layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
    //set a border
    // Apply a 1 pixel, black border
    [btnLayer setBorderWidth:2.5f];
    [btnLayer setBorderColor:[[UIColor blackColor] CGColor]];
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self.tabBarController.tabBar setHidden:YES];
    
    
}

-(IBAction)loginAttempt:(id)sender{

    SneakyTab *TBC = [[SneakyTab alloc]init];
    
    [self.navigationController pushViewController:TBC animated:YES];
    
    NSLog(@"button pressed\n\n");
    
    //start in the background
    //[self.parentViewController.view setHidden:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
