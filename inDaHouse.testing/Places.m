//
//  Places.m
//  inDaHouse.testing
//
//  Created by Jeff Hurray on 11/27/12.
//  Copyright (c) 2012 Newton South High School. All rights reserved.
//

#import "Places.h"

@implementation Places;
@synthesize delegate;
@synthesize placesMA;
@synthesize currentDist;
@synthesize currentCentre;
@synthesize radius;
@synthesize didLeavePlace,didArriveAtPlace;

//deal with placesMA?
static Places *sharedClient;
+(Places*) sharedInstance 
{
    
    if (sharedClient == nil) {
        sharedClient = [[Places alloc] init];
        
    }
    return sharedClient;
}
-(id)init{
    
    //self = [super init];
    
    if(self = [super init]){
        
        placesMA = [[NSMutableArray alloc]init];
    }
    
    radius = 100;
    didLeavePlace = FALSE;
    didArriveAtPlace = FALSE;
    
    return self;
    
}


-(void) queryGooglePlaces: (NSString *) googleType {
    // Build the url string to send to Google. NOTE: The kGOOGLE_API_KEY is a constant that should contain your own API key that you obtain from Google. See this link for more info:
    
    
    //NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", currentCentre.latitude, currentCentre.longitude, [NSString stringWithFormat:@"%i", currentDist], googleType, kPlacesKey];
    
    NSString *types = [NSString stringWithFormat:@"(street_address|food|gym|night_club|bar)"];
    
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%i&types=%@&sensor=true&key=%@", [Alohar currentLocation].coordinate.latitude, [Alohar currentLocation].coordinate.longitude,1000,types, kPlacesKey];
    
    //Formulate the string as a URL object.
    NSURL *googleRequestURL=[NSURL URLWithString:url];
    
    // Retrieve the results of the URL.
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

-(void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:responseData 
                          
                          options:kNilOptions 
                          error:&error];
    
    NSLog(@"%@",json);
    
    //The results from Google will be an array obtained from the NSDictionary object with the key "results".
    NSArray* places = [json objectForKey:@"results"]; 
    
    //Write out the data to the console.
    NSLog(@"Google Data: %@", places);
}

-(void)addPlace:(ALPlace *)tempPlace{
    
    if(tempPlace){
        
        NSLog(@"adding place\n");
        
    [self.delegate addPointToMap:tempPlace];
    
        NSLog(@"count is %i\n", [placesMA count]);
        
    [placesMA insertObject:tempPlace atIndex:placesMA.count];
        
    NSLog(@"%d",placesMA.count);
    }
    
}



-(void)getPlaces{
    
//    [NSURLConnection sendAsynchronousRequest:<#(NSURLRequest *)#> queue:<#(NSOperationQueue *)#> completionHandler:<#^(NSURLResponse *, NSData *, NSError *)handler#>
    
    //do the google stuff
    
    //we get a place
    
    //make an ALPlace
    //    tempPlace.placeID = [placesMA count];
    //call self addPlace
}

-(void)setCC:(CLLocationCoordinate2D)loc{
    currentCentre = loc;
}

-(void)setCD:(int)dist{
    currentDist = dist;
}

-(int)getRadius{
    return radius;
}

-(void)arrived{
    didArriveAtPlace = TRUE;
    didLeavePlace = FALSE;
}
-(void)left{
    didArriveAtPlace = FALSE;
    didLeavePlace = TRUE;
}


@end
