//
//  DistanceRefresher.m
//  WorldPhotos
//
//  Created by 이선동 on 11. 6. 2..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DistanceRefresher.h"
#import "WorldPhotosAppDelegate.h"

@implementation DistanceRefresher
@synthesize locationManager;

- (void)dealloc {
    [locationManager release];
	[super dealloc];
}

- (void) updateDistance {
    
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; //kCLLocationAccuracyNearestTenMeters; //10미터 정확도
    self.locationManager.delegate = self;
    
    [self.locationManager startUpdatingLocation]; 
    
    CLLocation *curPos, *destPos;
    CLLocationDistance kilometers;
    
    curPos = self.locationManager.location;
    
    //Update...
    for (int i=0; i<[[self appDelegate].restaurants count]; i++) {
        destPos = [[CLLocation alloc] 
                   initWithLatitude:[((RestaurantDAO *)[[self appDelegate].restaurants objectAtIndex:i]).latitude doubleValue]    
                   longitude:[((RestaurantDAO *)[[self appDelegate].restaurants objectAtIndex:i]).longitude doubleValue]];
        
        if ((curPos != nil) && (destPos != nil)) {
            kilometers = [curPos distanceFromLocation:destPos];                
            ((RestaurantDAO *)[[self appDelegate].restaurants objectAtIndex:i]).distance = [NSNumber numberWithDouble:kilometers/1000];
        } else {
            if (curPos == nil) {
                NSLog(@"curPos is nil. 시뮬레이터를 사용하면 GPS가 없어서 curPos가 nil인것 같습니다.");
            } else {
                NSLog(@"destPos is nil.");
            }
        }
        [destPos release];
    }
    
    
    
    
    //Sort the array since we just added a new drink
	NSSortDescriptor *nameSorter=[[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES selector:nil];
	[[self appDelegate].restaurants sortUsingDescriptors:[NSArray arrayWithObject:nameSorter]];
	[nameSorter release];
    
    
    
    
    
    [self.locationManager stopUpdatingLocation];
    
//    [self.locationManager release]; //LSD 20111125
//    self.locationManager = nil; //LSD 20111125
}






- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self showConfirmAlert:@"위치 정보 수집 에러" msg:[error description]];
}

- (void)showConfirmAlert:(NSString *)title msg:(NSString *)msg
{
	UIAlertView *alert = [[UIAlertView alloc] init];
	[alert setTitle:title];
	[alert setMessage:msg];
	[alert setDelegate:self];
	[alert addButtonWithTitle:@"OK"];
	[alert show];
	[alert release];
}

- (WorldPhotosAppDelegate *)appDelegate {
	return [[UIApplication sharedApplication] delegate];	
}

NSArray * myLoc;

- (NSArray *)getMyLocation {
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; //kCLLocationAccuracyNearestTenMeters; //10미터 정확도
    self.locationManager.delegate = self;
    
    [self.locationManager startUpdatingLocation]; 

    CLLocation *curPos = self.locationManager.location;
    NSString * lat  = [NSString stringWithFormat:@"%f",curPos.coordinate.latitude];
    NSString * lon  = [NSString stringWithFormat:@"%f",curPos.coordinate.longitude];

    myLoc = [[[NSArray alloc] initWithObjects:lat, lon, nil] autorelease];
    
    [self.locationManager stopUpdatingLocation];
    
//    [self.locationManager release]; //LSD 20111125
//    self.locationManager = nil; //LSD 20111125
    
    return myLoc;
}

@end
