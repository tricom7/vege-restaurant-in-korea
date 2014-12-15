//
//  MyLocationViewController.h
//  WorldPhotos
//
//  Created by 이선동 on 11. 5. 24..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MyLocationViewController : UIViewController <CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
    IBOutlet MKMapView *mapView;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
- (IBAction)changeMapStyle:(id)sender;

@end
