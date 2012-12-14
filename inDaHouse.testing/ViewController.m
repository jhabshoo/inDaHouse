//
//  ViewController.m
//  inDaHouse.testing
//
//  Created by Jeff Hurray on 11/25/12.
//  Copyright (c) 2012 Newton South High School. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize _mapView;
@synthesize search;
@synthesize cellView;

-(void)addPointToMap:(ALPlace *)tempPlace{
    NSLog(@"POINT DOWN\n\n");
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    
    point.title = [tempPlace name];
    point.subtitle = [tempPlace category];
    //NSLog(@"the latitude is %f",tempPlace.location.coordinate.latitude);
    point.coordinate = tempPlace.location.coordinate;
    
    [_mapView addAnnotation:point];
}

-(BOOL)isInRange: (ALPlace *) temp{
    
    MKMapPoint a = MKMapPointForCoordinate([Alohar currentLocation].coordinate);
    MKMapPoint b = MKMapPointForCoordinate(temp.location.coordinate);
    
    
    CLLocationDistance dist = MKMetersBetweenMapPoints(a, b);
    
    NSLog(@"DISTANCE IS : %f\n\n",dist);
    
    if(dist < [[Places sharedInstance] getRadius]){
        return YES;
    }
    return NO;
    
}

//******** API SHIT**********
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    //Get the east and west points on the map so you can calculate the distance (zoom level) of the current map view.
    MKMapRect mRect = self._mapView.visibleMapRect;
    MKMapPoint eastMapPoint = MKMapPointMake(MKMapRectGetMinX(mRect), MKMapRectGetMidY(mRect));
    MKMapPoint westMapPoint = MKMapPointMake(MKMapRectGetMaxX(mRect), MKMapRectGetMidY(mRect));
    
    //Set your current distance instance variable.
   [[Places sharedInstance] setCD: MKMetersBetweenMapPoints(eastMapPoint, westMapPoint)];
    //Set your current center point on the map instance variable.
    [[Places sharedInstance] setCC: self._mapView.centerCoordinate];
}







//******LOADS ANNOTATION VIEWS***********

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    static NSString *reuseId = @"StandardPin";
    
    MKPinAnnotationView *aView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    
    
    
    if (aView == nil)
    {
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation 
                                                 reuseIdentifier:reuseId] ;
       aView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        aView.canShowCallout = YES;
    }
    aView.pinColor = MKPinAnnotationColorPurple;
    aView.annotation = annotation;
    
    
    return aView;

}

//******TAP FOR RIGHT BUTTON***********

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"calloutAccessoryControlTapped");
    
    if(!cellView){
        ViewControllerTC *temp = [[ViewControllerTC alloc]init];
        self.cellView = temp;
    }
    
    //get the sheeeit
    cellView.titleHeader = view.annotation.title;
    cellView.category = view.annotation.subtitle;
    cellView.latitude = view.annotation.coordinate.latitude;
    cellView.longitude = view.annotation.coordinate.longitude;
    NSLog(@"%@\n\n",cellView.titleHeader);
    [cellView makeChanges];
    
    
    [self.navigationController pushViewController:self.cellView animated:YES];
    

}


- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [Alohar setMotionDelegate:self];
    //fux with the searchbar
    [search setPlaceholder:@"search a place"];
    [search setBarStyle: UIBarStyleBlackTranslucent];
    [search setTintColor:[UIColor grayColor]];
    [search setShowsCancelButton:YES];
    
    //set up the places delagate
    [[Places sharedInstance] setDelegate:self];
    
    
    //Saving data when app quits
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"places"])
        [[Places sharedInstance] setPlacesMA:[defaults objectForKey:@"places"]];
    
    for (ALPlace*place in [[Places sharedInstance] placesMA]) {
        //every point goes on the map
        [self addPointToMap:place];
        
    }
    

	// Do any additional setup after loading the view, typically from a nib
}

//cancells the keyboard
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [search resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //NSLog(searchBar.text);
    if(searchBar.text){
    [[Places sharedInstance] queryGooglePlaces:searchBar.text];
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self.tabBarController.tabBar setHidden:NO];
    
    
}

-(void)checkUserStay{
    
    for(ALPlace*place in [[Places sharedInstance] placesMA]){
        if  ( ![self isInRange:place] ){
            return ;
        }
        
    }
    [[Places sharedInstance] left];
    return;
}


///*********update motion state*********

- (void)didUpdateToMotionState:(ALMotionState *)newMotionState fromMotionState:(ALMotionState *)oldMotionState
{
    //declare motion state
    NSLog(@"New Motion State: %@", newMotionState.stateDescription);
    
    //declare coordinates
     NSLog(@"\n\nNew latitude is: %f\nNew Longitude is: %f\n", [Alohar currentLocation].coordinate.latitude, [Alohar currentLocation].coordinate.longitude);
    
    //set view region for mapkit
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance([Alohar currentLocation].coordinate, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    // udjast that shit
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];                
    // adjust and center at current location
    [_mapView setCenterCoordinate:[Alohar currentLocation].coordinate];
    [_mapView setRegion:adjustedRegion animated:YES];  
    //so the map moves with you
    [self checkUserStay];
    //set up notifications
    
    
    for (ALPlace*place in [[Places sharedInstance] placesMA]){
        
        
        if( [self isInRange:place]){
            
            NSLog(@"place in range\n\n");
            
            
            if(![[Places sharedInstance] didArriveAtPlace]){
                
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            alert.message = [NSString stringWithFormat:@"You Are now at %@",place.name];
            [alert show];
                [[Places sharedInstance] arrived];
            }
        }
    
       }
}




- (void)viewDidUnload
{
    search= nil;
    _mapView = nil;
    _mapView = nil;
    [self set_mapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
