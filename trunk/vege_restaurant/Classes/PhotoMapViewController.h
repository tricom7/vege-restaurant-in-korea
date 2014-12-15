//
//  PhotoMapViewController.h
//  WorldPhotos
//
//  Created by 이선동 on 10. 12. 5..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "RestaurantDAO.h"

@interface PhotoMapViewController : UIViewController <MKMapViewDelegate> {
    RestaurantDAO *restaurantDAO;
	MKMapView *mapView;
}

@property (nonatomic, retain) RestaurantDAO *restaurantDAO;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
- (IBAction)changeMapStyle:(id)sender;

@end
