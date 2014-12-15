//
//  WorldPhotosAppDelegate.m
//  WorldPhotos
//
//  Created by 이선동 on 10. 12. 3..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WorldPhotosAppDelegate.h"

@implementation WorldPhotosAppDelegate
@synthesize window;
@synthesize navigationController;
@synthesize restaurants;
@synthesize restaurantsDAO;
@synthesize sql;
@synthesize isNeedUpdate_List, isNeedUpdate_Map;
@synthesize isNeedUpdate_Name_List, isNeedUpdate_Group_List, isNeedQueryDB;
@synthesize distanceReferesher;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    sql = @"SELECT id, name, province, city, detail_addr, tel, business_hours, holiday, type, grade, homepage, latitude, longitude, menu, zip, parking, tel2, distance, rough_map_desc, price FROM vege_restaurant where name not like '본비빔밥%' and name not like '떡담%' and name not like '소딜리셔스%' and name not like '빚은%' and name not like '강가%' and name not like '서브웨이%' and name not like '커피빈%' and is_closed='false' and grade is not '일부 채식'";
    
    isNeedUpdate_List = true;
    isNeedUpdate_Map = true;
    isNeedUpdate_Name_List = true;
    isNeedUpdate_Group_List = true;
    
    NSLog(@"Start....");
    
    distanceReferesher = [[DistanceRefresher alloc] init];
    
    restaurants = [[NSMutableArray alloc] init];
    
    restaurantsDAO = [[RestaurantsDAO alloc] init];

    [self queryDB];
    isNeedQueryDB = false;
    

    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)queryDB{
    @synchronized(self) {
        [restaurantsDAO getAllRestaurants];
    }
}


- (void)updateDistance {
    [distanceReferesher updateDistance];
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    NSLog(@"application didReceiveMemoryWarning !!!");
}

- (void)dealloc {
    [distanceReferesher release];
    [restaurantsDAO release];
    [sql release];
	[navigationController release];
    [tabBarController release];
    [restaurants release];
	[window release];
	[super dealloc];
}


@end

