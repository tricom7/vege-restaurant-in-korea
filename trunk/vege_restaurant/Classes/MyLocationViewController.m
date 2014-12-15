//
//  MyLocationViewController.m
//  WorldPhotos
//
//  Created by 이선동 on 11. 5. 24..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyLocationViewController.h"

@implementation MyLocationViewController
@synthesize locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [mapView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    NSLog(@"MyLocationViewController didReceiveMemoryWarning !!!");

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    [mapView release];
    mapView = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
    
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:(BOOL)animated];
    NSLog(@"MyLocationViewController viewWillAppear...");
	
	self.locationManager = [[[CLLocationManager alloc] init] autorelease];
	self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters; //10미터 정확도
	self.locationManager.delegate = self;
	[self.locationManager startUpdatingLocation]; //CoreLocation 시작
    

    CLLocation *curPos = self.locationManager.location;
       
    CLLocation *location = [[CLLocation alloc] 
                            initWithLatitude:curPos.coordinate.latitude 
                            longitude:curPos.coordinate.longitude];
    
	MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
	MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
	[mapView setRegion:region animated:YES];
    
    [location release];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillAppear:(BOOL)animated];
	
	[self.locationManager stopUpdatingLocation]; //CoreLocation 종료
	self.locationManager = nil;	
}


- (IBAction)changeMapStyle:(id)sender {
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0: {
            mapView.mapType = MKMapTypeStandard; break;
        }
        case 1: {
            mapView.mapType = MKMapTypeSatellite; break;
        } 
        default: {
            mapView.mapType = MKMapTypeHybrid; break;
        }
    }
}
@end
