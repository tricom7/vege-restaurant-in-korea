//
//  RestaurantDAO.h
//  WorldPhotos
//
//  Created by 이선동 on 11. 5. 2..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestaurantDAO : NSObject {
    NSNumber *id_no;
    NSString *name;
    NSString *province;
    NSString *city;
    NSString *detail_addr;
    NSString *tel;
    NSString *business_hours;
    NSString *holiday;
    NSString *type;
    NSString *grade;
    NSString *homepage;
    NSNumber *latitude;
    NSNumber *longitude;
    NSString *menu; //TEXT
    NSString *zip;
    NSString *parking;
    NSString *tel2;
    NSNumber *distance;
    NSString *rough_map_desc;    
    NSString *price;    
//    NSNumber *seqindex;
}

@property (nonatomic, retain) NSNumber *id_no;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *province;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *detail_addr;
@property (nonatomic, retain) NSString *tel;
@property (nonatomic, retain) NSString *business_hours;
@property (nonatomic, retain) NSString *holiday;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *grade;
@property (nonatomic, retain) NSString *homepage;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) NSString *menu; //TEXT
@property (nonatomic, retain) NSString *zip;
@property (nonatomic, retain) NSString *parking;
@property (nonatomic, retain) NSString *tel2;
@property (nonatomic, retain) NSNumber *distance;
@property (nonatomic, retain) NSString *rough_map_desc; 
@property (nonatomic, retain) NSString *price; 

//@property (nonatomic, retain) NSNumber *seqindex;


@end
