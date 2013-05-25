//
//  Venue.h
//  OpenLate
//
//  Created by Jesse Tello on 5/23/13.
//  Copyright (c) 2013 Tello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Venue : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString* title; //Restaurant Name
@property (nonatomic, copy) NSString* subtitle; //Address
@property (nonatomic,strong) NSString* restID;
@property (nonatomic) int isOpen;



@end
