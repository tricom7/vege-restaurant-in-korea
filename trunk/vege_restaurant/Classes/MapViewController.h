//
//  MapViewController.h
//  WorldPhotos
//
//  Created by 이선동 on 11. 5. 24..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "RestaurantDAO.h"

@class WorldPhotosAppDelegate;

@interface MapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {
    IBOutlet MKMapView *mapView;
    CLLocationManager *locationManager;
    RestaurantDAO *restaurantDAO;
    UIBarButtonItem *updateLocationButton;
    UIBarButtonItem *magnifyButton;
    NSMutableArray *localRestaurants;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) RestaurantDAO *restaurantDAO;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *updateLocationButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *magnifyButton;
@property (nonatomic, retain) NSMutableArray *localRestaurants;

- (WorldPhotosAppDelegate *)appDelegate;

- (void)updateMap;

- (IBAction)spanToHere:(id)sender;
- (IBAction)magnify:(id)sender;
- (void)spanToKorea;

- (IBAction)changeMapStyle:(id)sender;
- (void)showConfirmAlert:(NSString *)title msg:(NSString *)msg;

@end
