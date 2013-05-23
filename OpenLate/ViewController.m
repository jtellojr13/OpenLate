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


@interface ViewController ()
{
    
    NSMutableArray* IDArray;
    NSMutableArray* isOpenArray;
    
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
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    
   // [Foursquare2 authorizeWithCallback:^(BOOL success, id result) {
        
       
        [self findVenueInformation];
  
       
     //   }];
    


    
}

-(void)findVenueInformation
{
    [Foursquare2 searchVenuesNearByLatitude:[NSNumber numberWithFloat:41.89]
                                  longitude:[NSNumber numberWithFloat:-87.63]
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
                                             NSString* restID = [dict objectForKey:@"id"];
                                             [IDArray addObject:restID];
                                             
                                         }
                                         
                                         
                                         
                                         for (NSString* ID in IDArray) {
                                             
                                             [Foursquare2 getDetailForVenue:ID callback:^(BOOL success, id result) {
                                                 
                                                 
                                                 [restaurantDetailsDict addEntriesFromDictionary:result];
                                            
                                                 responseTwoDict = [restaurantDetailsDict objectForKey:@"response"];
                                                 
                                                 venueDict = [responseTwoDict objectForKey:@"venue"];
                                                 
                                                 
                                                 
                                                 hoursDict = [venueDict objectForKey:@"hours"];
                                                 isOpenArray = [NSMutableArray array];
                                                 isOpenArray = [hoursDict objectForKey:@"isOpen"];
                                                
                                                 NSLog(@"%@",venueDict);
                                                 
                                                 
                                                                                             
                                             
                                             
                                             }];
                                             
                                             
                                             
                                                
                                             
                                          
                                                 
                                                 
                                             

                                             
                                             
                                             
                                             
                                             
                                             
                                             
                                             
                                             
                                           
                                         }//end of for loop
                                         
        
                                     
                                     
                                     
                                     
                                     
                                     
                                     }];


    
}




@end
