//
//  DistanceRefresher.h
//  WorldPhotos
//
//  Created by 이선동 on 11. 6. 2..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class WorldPhotosAppDelegate;

@interface DistanceRefresher : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

@property (nonatomic, retain) CLLocationManager *locationManager;

- (void)updateDistance;
- (void)showConfirmAlert:(NSString *)title msg:(NSString *)msg;
- (WorldPhotosAppDelegate *)appDelegate;
- (NSArray *)getMyLocation;
@end
