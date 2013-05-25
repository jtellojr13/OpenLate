//
//  ViewController.m
//  OpenLate
//
//  Created by Jesse Tello on 5/22/13.
//  Copyright (c) 2013 Tello. All rights reserved.
//

#import "ViewController.h"
#import "Foursquare2.h" 
#import "FSTargetCallback.h"
#import "Venue.h"


@interface ViewController ()
{
    
    NSMutableArray* IDArray;
    NSMutableArray* isOpenArray;
    NSMutableArray* arrayOfVenueObjects;
    
    NSMutableDictionary* restaurantDetailsDict;
    NSMutableDictionary* responseTwoDict;
    NSMutableDictionary* venueDict;
    NSMutableDictionary* hoursDict;
    
    
    
    
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    arrayOfVenueObjects = [[NSMutableArray alloc]init];
    
 

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    

   // [Foursquare2 authorizeWithCallback:^(BOOL success, id result) {

        
       
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(41.89374, -87.63533);
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    
    self.mapView.region = region;
    
    [self findVenueInformation];
  
    


      // }];
    


    
}

-(void)findVenueInformation
{
    [Foursquare2 searchVenuesNearByLatitude:[NSNumber numberWithFloat:41.89374]
                                  longitude:[NSNumber numberWithFloat:-87.63533]
                                 accuracyLL:nil
                                   altitude:nil
                                accuracyAlt:nil
                                      query:nil
                                   category:@"4d4b7105d754a06374d81259"
                                      limit:nil
                                     intent:0
                                     radius:[NSNumber numberWithFloat:800] callback:^(BOOL success, id result) {
                                         
                                         NSMutableDictionary* responseDictionary = [result objectForKey:@"response"];
                                         
                                       
                                         
                                         NSMutableArray *venuesArray = [NSMutableArray array];
                                         IDArray = [NSMutableArray array];
                                         restaurantDetailsDict = [[NSMutableDictionary alloc]init];
                                         responseTwoDict = [[NSMutableDictionary alloc]init];
                                         venueDict = [[NSMutableDictionary alloc]init];
                                         hoursDict = [[NSMutableDictionary alloc]init];
                                         
                                         
                                         
                                                                            
                                         
                                         venuesArray = [responseDictionary objectForKey:@"venues"];
                                         
                                         for (NSMutableDictionary* dict in venuesArray) {
                                             
                                             Venue* venue = [[Venue alloc]init];
                                             
                                             venue.restID = [dict objectForKey:@"id"];
                                             venue.title = [dict objectForKey:@"name"];
                                             venue.subtitle = [dict valueForKeyPath:@"location.address"];
                                             
                                             venue.coordinate = CLLocationCoordinate2DMake([[dict valueForKeyPath:@"location.lat"]doubleValue], [[dict valueForKeyPath:@"location.lng"]doubleValue]);
                                             
                                             
                                             IDArray = [dict objectForKey:@"id"];
                                             
                                             [arrayOfVenueObjects addObject:venue];
                                             

                                    }
                                         
                                         
                                         for (Venue* venue in arrayOfVenueObjects) {
                                             
                                             [Foursquare2 getDetailForVenue:venue.restID callback:^(BOOL success, id result) {
                                                 
                                                 
                                                 [restaurantDetailsDict addEntriesFromDictionary:result];
                                                 
                                                 responseTwoDict = [restaurantDetailsDict objectForKey:@"response"];
                                                 
                                                 venueDict = [responseTwoDict objectForKey:@"venue"];
                                                 
                                                 hoursDict = [venueDict objectForKey:@"hours"];
                                                 isOpenArray = [NSMutableArray array];
                                                 isOpenArray = [hoursDict objectForKey:@"isOpen"];
                                                 
                                                 
                                                 
                                    }];//close get detailVenue
                                             
                                             for (NSString* isOpen in isOpenArray) {
                                                 
                                                 venue.isOpen = [isOpen integerValue];
                                                 
                                             }

                                             
                                             
                            }//close for loop arrayOfVenueObjects
        
                                         for (Venue* venue in arrayOfVenueObjects) {
                                             
                                           
                                                 
                                                 [self.mapView addAnnotation:venue];

                                             
                                             
                                        }
                                         
                                         
                            }];
    
 
    
}
                                                 

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    NSString* reuseIdentifier = @"reuseIdentifier";
    MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];

    
    if (annotationView == nil) {
        
        
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
        annotationView.canShowCallout = YES;
        annotationView.rightCalloutAccessoryView  = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        
    }else{
        annotationView.annotation = annotation;
    
    }

     return annotationView;
}



@end
