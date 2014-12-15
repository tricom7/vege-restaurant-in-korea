//
//  RestaurantsDAO.m
//  WorldPhotos
//
//  Created by 이선동 on 11. 5. 2..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RestaurantsDAO.h"
#import "WorldPhotosAppDelegate.h"

@implementation RestaurantsDAO
//@synthesize restsArray;

-(void)dealloc {
//    [restsArray release];
    [super dealloc];
}

- (WorldPhotosAppDelegate *)appDelegate {
	return [[UIApplication sharedApplication] delegate];	
}

//전체 select

//- (id)init {
//    if (self = [super init]) {
//        NSLog(@"RestaurantsDAO constructor...");
////        restsArray = [[NSMutableArray alloc] init];
//    }
//    return self;
//}

NSFileManager *fileManager;
NSString *theDBPath;
sqlite3_stmt *statement;

- (void) getAllRestaurants {

    NSLog(@"getAllRestaurants(DB 쿼리)의 SQL: %@",[self appDelegate].sql);
    
    @synchronized(self) {
    //NSMutableArray *imsiRestsArray = [[NSMutableArray alloc] init];

   
    @try {
        
//        for(RestaurantDAO *bRest in [self appDelegate].restaurants) {
//            NSLog(@"bRest retainCount=%d",[bRest retainCount]);
//            int j=[bRest retainCount];
//            for (int i=0; i<j; i++) {
//                NSLog(@"%@'s bRest retainCount=%d",bRest.name,[bRest retainCount]);
//                [bRest release];
//            }
//            //[bRest release];
//        }
        
        [[self appDelegate].restaurants removeAllObjects];
        
        fileManager = [NSFileManager defaultManager];
        theDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"vege_restaurant.sqlite"];
        
        BOOL success = [fileManager fileExistsAtPath:theDBPath];
        if (!success) {
            NSLog(@"Failed to find database file '%@'.",theDBPath);    
        }
        if (!(sqlite3_open([theDBPath UTF8String], &database) == SQLITE_OK)) {
            NSLog(@"An error opening database, normally handle error here.");
        }

        //const char* cStringSQL = [[self appDelegate].sql cStringUsingEncoding:NSUTF8StringEncoding];

        if (sqlite3_prepare_v2(database, [[self appDelegate].sql cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"Error, failed to prepare statement, normally handle error here.");
            
        }
        //free ((void*) cStringSQL);
        
        int i=0;
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            RestaurantDAO *aRest = [[[RestaurantDAO alloc] init] autorelease];
//            aRest.seqindex = [NSNumber numberWithInt:i];
            i++;
            aRest.id_no = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
            aRest.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 1)];
            aRest.province = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 2)];
            aRest.city = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 3)];
            aRest.type = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 8)];
            aRest.grade = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 9)];
            aRest.latitude = [NSNumber numberWithDouble:sqlite3_column_double(statement, 11)];
            aRest.longitude = [NSNumber numberWithDouble:sqlite3_column_double(statement, 12)];
            //aRest.distance = [NSNumber numberWithDouble:sqlite3_column_double(statement, 17)];
            
            if (sqlite3_column_text(statement, 4) != nil) {
                aRest.detail_addr = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 4)];
            }
            if (sqlite3_column_text(statement, 5) != nil) {
                aRest.tel = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 5)];
            }
            if (sqlite3_column_text(statement, 6) != nil) {
                aRest.business_hours = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 6)];
            }
            if (sqlite3_column_text(statement, 7) != nil) {
                aRest.holiday = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 7)];
            }
            if (sqlite3_column_text(statement, 10) != nil) {
                aRest.homepage = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 10)];
            }
            if (sqlite3_column_text(statement, 13) != nil) {
                aRest.menu = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 13)];
            }
            if (sqlite3_column_text(statement, 19) != nil) {
                aRest.price = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 19)];
            }
            if (sqlite3_column_text(statement, 15) != nil) {
                aRest.parking = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 15)];
            }
            if (sqlite3_column_text(statement, 18) != nil) {
                aRest.rough_map_desc = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 18)];
            }

            //[imsiRestsArray addObject:aRest];
            [[self appDelegate].restaurants addObject:aRest];
            //[aRest release];
        }
        if (sqlite3_finalize(statement) != SQLITE_OK) {
            NSLog(@"1Failed to finalize data statement, normally error handling here.");
        }
        if (sqlite3_close(database) != SQLITE_OK) {
            NSLog(@"Failed to close database, normally error handling here.");
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occurred: %@", [exception reason]);
    }
    @finally {
        
    }

    //return restsArray;
    }
}

@end
