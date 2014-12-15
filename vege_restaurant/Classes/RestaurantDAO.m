//
//  RestaurantDAO.m
//  WorldPhotos
//
//  Created by 이선동 on 11. 5. 2..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RestaurantDAO.h"

@implementation RestaurantDAO
@synthesize id_no;
@synthesize name;
@synthesize province;
@synthesize city;
@synthesize detail_addr;
@synthesize tel;
@synthesize business_hours;
@synthesize holiday;
@synthesize type;
@synthesize grade;
@synthesize homepage;
@synthesize latitude;
@synthesize longitude;
@synthesize menu; //TEXT
@synthesize zip;
@synthesize parking;
@synthesize tel2;
@synthesize distance;
@synthesize rough_map_desc;  
@synthesize price;  
//@synthesize seqindex;  


- (void)dealloc {
    //[seqindex release];
    [id_no release];
    [name release];
    [province release];
    [city release];
    [detail_addr release];
    [tel release];
    [business_hours release];
    [holiday release];
    [type release];
    [grade release];
    [homepage release];
    [latitude release];
    [longitude release];
    [menu release];
    [zip release];
    [parking release];
    [tel2 release];
    [distance release];
    [rough_map_desc release];  
    [price release];  
    
    [super dealloc];
}

@end
