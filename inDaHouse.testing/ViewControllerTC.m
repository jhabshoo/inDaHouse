//
//  ViewControllerTC.m
//  inDaHouse.testing
//
//  Created by Jeff Hurray on 12/7/12.
//  Copyright (c) 2012 Newton South High School. All rights reserved.
//

#import "ViewControllerTC.h"

@interface ViewControllerTC ()

@end

@implementation ViewControllerTC
@synthesize textBox;
@synthesize titleHeader,category;
@synthesize textBox2;
@synthesize latitude,longitude;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{

    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    textBox.delegate = self;
    
    UIColor *grad = [UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f / 255.0f alpha:1.0f];
    UIColor *border = [UIColor colorWithRed:161/255.0f green:55/255.0f blue:192/255.0f alpha:1.0f];
    
    [[self view] setBackgroundColor:grad];

    textBox = [[UITextView alloc] initWithFrame:CGRectMake	(20, 20, 280, 40)];
    [textBox setBackgroundColor:[UIColor darkGrayColor]];
    [textBox setFont:[UIFont boldSystemFontOfSize:20.0]];
    [textBox setTextAlignment:UITextAlignmentCenter];
    [textBox setEditable:NO];
    
    // For the border and rounded corners
    [[textBox layer] setBorderColor:[border CGColor]];
    [[textBox layer] setBorderWidth:2.3];
    [[textBox layer] setCornerRadius:15];
    [textBox setClipsToBounds: YES];
    
    [textBox setText:titleHeader];
    [textBox setTextColor:[UIColor whiteColor]];
    
    [[self view] addSubview:textBox];
    
    //now the second box with all da info init
    
    textBox2 = [[UITextView alloc] initWithFrame:CGRectMake	(20, 100, 280, 250)];
    [textBox2 setBackgroundColor:[UIColor darkGrayColor]];
    [textBox2 setFont:[UIFont boldSystemFontOfSize:16.0]];
    [textBox2 setTextAlignment:UITextAlignmentLeft];
    [textBox2 setEditable:NO];
    
    // For the border and rounded corners
    [[textBox2 layer] setBorderColor:[border CGColor]];
    [[textBox2 layer] setBorderWidth:2.3];
    [[textBox2 layer] setCornerRadius:15];
    [textBox2 setClipsToBounds: YES];
    NSString *body = [NSString stringWithFormat:@"Category: %@\n\n\nLatitude: %f\nLongitude: %f\n\n\n",category,latitude,longitude];
    [textBox2 setText:body];
    [textBox2 setTextColor:[UIColor whiteColor]];
    
    [[self view] addSubview:textBox2];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)makeChanges{
    [textBox setText:titleHeader];
    [textBox2 setText:[NSString stringWithFormat:@"Category: %@\n\n\nLatitude: %f\nLongitude: %f\n\n\n",category,latitude,longitude]];
    
     
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
