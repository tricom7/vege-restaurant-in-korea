//
//  WorldPhotosAppDelegate.h
//  WorldPhotos
//
//  Created by 이선동 on 10. 12. 3..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantsDAO.h"
#import "DistanceRefresher.h"


@interface WorldPhotosAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
    IBOutlet UITabBarController *tabBarController;
    NSMutableArray *restaurants;
    RestaurantsDAO *restaurantsDAO;
    DistanceRefresher *distanceReferesher;

    NSString *sql;
    
    BOOL isNeedUpdate_List;
    BOOL isNeedUpdate_Map;
    BOOL isNeedUpdate_Name_List;
    BOOL isNeedUpdate_Group_List;
    
    BOOL isNeedUpdateQueryDB;

}

@property (nonatomic, retain) DistanceRefresher *distanceReferesher;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSMutableArray *restaurants;
@property (nonatomic, retain) RestaurantsDAO *restaurantsDAO;

@property (nonatomic, retain) NSString *sql;

@property BOOL isNeedUpdate_List;
@property BOOL isNeedUpdate_Map;
@property BOOL isNeedUpdate_Name_List;
@property BOOL isNeedUpdate_Group_List;

@property BOOL isNeedQueryDB;


- (void)queryDB;
- (void)updateDistance;

////Java Developer’s Guide to Static variables in Objective-C
////http://iphonedevelopertips.com/objective-c/java-developers-guide-to-static-variables-in-objective-c.html
//+ (NSMutableArray *)restaurants;
//+ (void)setRestaurants:(NSMutableArray *)newRestaurants;


@end

