//
//  Places.h
//  inDaHouse.testing
//
//  Created by Jeff Hurray on 11/27/12.
//  Copyright (c) 2012 Newton South High School. All rights reserved.
//
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#define GOOGLEURL [NSURL URLWithString @"https://maps.googleapis.com/maps/api/place/search/output?parameters"]
#define kPlacesKey @"AIzaSyD3qNIcYzb5IrYl_j7YJLbQaE-Ynw7jALg"

#import <Alohar/Alohar.h>
#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>


@class Places;

@protocol PlacesDelegate <NSObject>

-(void)addPointToMap:(ALPlace*)tempPlace;
@end


@interface Places : NSObject
{
    id <PlacesDelegate> delagate;
}

@property (strong,nonatomic) NSMutableArray *placesMA;
@property int currentDist;
@property CLLocationCoordinate2D currentCentre;
@property (nonatomic, assign) id <PlacesDelegate> delegate;
@property int radius;
@property BOOL didArriveAtPlace;
@property BOOL didLeavePlace;


+(id) sharedInstance;
-(void) queryGooglePlaces: (NSString *) googleType;
-(void)addPlace:(ALPlace *)tempPlace;// andPoint:(CLLocationCoordinate2D)tempPoint;
-(void)getPlaces;
-(void)setCD:(int) dist;
-(void)setCC:(CLLocationCoordinate2D) loc;
-(int)getRadius;
-(void)arrived;
-(void)left;

@end


