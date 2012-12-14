//
//  aloharDemo
//
//  Created by Sam Warmuth on 2/23/12.
//

#import "ADRealTimeViewController.h"

@implementation ADRealTimeViewController
@synthesize callbackTimer, motionContainer, currentLocation, mapView;
@synthesize motionStateLabel;
@synthesize oldMobileStateLabel;
@synthesize currentMobileStateLabel;
@synthesize mobileStateLabel;

#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    [super viewDidLoad];    
}
- (void)viewWillAppear:(BOOL)animated
{
    //set timeer to query the current motion state
    self.callbackTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(updateMotionStateAndLocation) userInfo:nil repeats:YES];
    [self updateMotionStateAndLocation];
    
    //listen mobile state
    [Alohar setMobileStateDelegate:self];
}

- (void)updateMotionStateAndLocation
{
    //piggyback the mobile state 
    ALMobileState *mobileState = [Alohar currentMobileState];
    self.mobileStateLabel.text = [mobileState stateDescription];
    
    //read motion state
    UIImageView *newImageView;
    ALMotionState *motionState = [Alohar currentMotionState];
    if ([motionState.state intValue] == ALMotionStateSmoothMoving){
        newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(280, 10, 42, 21)];
        newImageView.image = [UIImage imageNamed:@"drive2"];
        self.motionStateLabel.text = @"Smooth Moving";
    } else if ([motionState.state intValue] == ALMotionStateWalking){
        newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(290, 10, 14, 24)];
        newImageView.image = [UIImage imageNamed:@"walk"];
        self.motionStateLabel.text = @"Walking";
    } else if ([motionState.state intValue] == ALMotionStateStationary){
        newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(290, 10, 14, 24)];
        newImageView.image = [UIImage imageNamed:@"standing"];
        self.motionStateLabel.text = @"Stationary";
    } else if ([motionState.state intValue] == ALMotionStateRotation){
        newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(283, 10, 28, 28)];
        newImageView.image = [UIImage imageNamed:@"bigmove"];
        self.motionStateLabel.text = @"Rotation";
    } else{
        newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(285, 14, 24, 19)];
        newImageView.image = [UIImage imageNamed:@"nodata"];
        self.motionStateLabel.text = @"No Data";
    }
    
    [motionContainer addSubview:newImageView];
    [motionContainer sendSubviewToBack:newImageView];
    
    [UIView animateWithDuration:20.0
                          delay:0 
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear
                     animations:^{
                         CGRect oldFrame = newImageView.frame;
                         newImageView.frame = CGRectMake(-40, 10, oldFrame.size.width, oldFrame.size.height);
                     } completion:^ (BOOL finished) {
                         [newImageView removeFromSuperview];
                     }];
    
    CLLocation *newLocation = [Alohar currentLocation];
    if (![newLocation isEqual:self.currentLocation]){
        self.currentLocation = newLocation;
        float lat = self.currentLocation.coordinate.latitude;
        float lng = self.currentLocation.coordinate.longitude;
        if (fabs(lat) > 90.0 || lat <= 0.0 || fabs(lng) > 180.0 || lng == 0.0){
            //bad location data.
            lat = 0.0;
            lng = 0.0;
        }
        
        
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(lat, lng), 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
        MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
        
        [self.mapView setRegion:adjustedRegion animated:YES]; 
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = self.currentLocation.coordinate;
        [self.mapView addAnnotation:annotation];
    }
    
}

- (void)viewDidUnload
{
    [self setMotionStateLabel:nil];
    [self setOldMobileStateLabel:nil];
    [self setCurrentMobileStateLabel:nil];
    [self setCurrentMobileStateLabel:nil];
    [self setMobileStateLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    if (self.callbackTimer != nil) [self.callbackTimer invalidate]; 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didUpdateToMobileState:(ALMobileState *)newMobileState fromMobileState:(ALMobileState *)oldMobileState
{
    self.oldMobileStateLabel.text = [oldMobileState stateDescription];
    self.currentMobileStateLabel.text = [newMobileState stateDescription];
}

@end
