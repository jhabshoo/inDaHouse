//
//  ViewController.h
//  inDaHouse.testing
//
//  Created by Jeff Hurray on 11/25/12.
//  Copyright (c) 2012 Newton South High School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Alohar/Alohar.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Places.h"
#import "ViewControllerTC.h"


#define METERS_PER_MILE 1609.344

@interface ViewController : UIViewController <ALMotionDelegate ,  MKMapViewDelegate, UISearchBarDelegate, PlacesDelegate> {

    BOOL _doneInitialZoom;
    
}
@property (weak, nonatomic) IBOutlet MKMapView *_mapView;
@property (strong, nonatomic) IBOutlet UISearchBar *search;
@property (strong, nonatomic) ViewControllerTC *cellView;
//NSJSONSerialization JSONObject for Data 

-(BOOL)isInRange: (ALPlace *) temp;
-(void)checkUserStay;

@end
