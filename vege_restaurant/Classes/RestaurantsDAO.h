//
//  RestaurantsDAO.h
//  WorldPhotos
//
//  Created by 이선동 on 11. 5. 2..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "RestaurantDAO.h"

@class WorldPhotosAppDelegate;

@interface RestaurantsDAO : NSObject {
    sqlite3 *database;
//    NSMutableArray *restsArray;
}

//@property (retain) NSMutableArray *restsArray;
- (WorldPhotosAppDelegate *)appDelegate;
- (void) getAllRestaurants;

@end
