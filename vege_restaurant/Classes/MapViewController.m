//
//  MapViewController.m
//  지도검색
//
//  Created by 이선동 on 11. 5. 24..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "PhotoDetailViewController.h"
#import "WorldPhotosAppDelegate.h"

@implementation MapViewController

@synthesize locationManager;
@synthesize restaurantDAO;
@synthesize updateLocationButton;
@synthesize magnifyButton;
@synthesize localRestaurants;

/****************************************************
 VIEW METHOD
 ****************************************************/

- (void)dealloc
{
    //NSLog(@"MapViewController dealloc...");
    [localRestaurants release];
    [updateLocationButton release];
    [magnifyButton release];
    [restaurantDAO release];
    [mapView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"MapViewController didReceiveMemoryWarning !!!");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    //NSLog(@"MapViewController viewDidLoad...");
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.updateLocationButton;
    self.navigationItem.leftBarButtonItem = self.magnifyButton;
    //[self updateMap];
    [self spanToKorea];
    //NSLog(@"MapViewController viewDidLoad completed");
}

- (void)viewDidUnload
{
    self.locationManager = nil;
    [mapView release];
    mapView = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"MapViewController viewWillAppear...");
    if ([self appDelegate].isNeedQueryDB == true) {
        [[self appDelegate] queryDB];
        [self appDelegate].isNeedQueryDB = false;
    }
    
    [[self appDelegate] updateDistance];
    
    if ([self appDelegate].isNeedUpdate_Map == true) {
        NSLog(@"Map Update ...");
        [self updateMap];
        NSLog(@"isNeedUpdate_Map을 false로 설정...");
        [self appDelegate].isNeedUpdate_Map = false;
    } else {
        NSLog(@"Map Update 불필요");
    }
    //NSLog(@"MapViewController viewWillAppear completed");
}

- (void)viewWillDisappear:(BOOL)animated {
	[self.locationManager stopUpdatingLocation]; //CoreLocation 종료
	self.locationManager = nil;	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/****************************************************
 MKMapViewDelegate methods
 ****************************************************/

#pragma mark MKMapViewDelegate methods
//지도상에 어노테이션 표시 형식(UI에서 MapKit의 delegate를 File's owner로 설정해 두어야 작동함)
- (MKAnnotationView *) mapView:(MKMapView *)thisMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    //현재 위치는 핀이나 이미지를 표시하지 않고 기본 파란색 버튼 모양을 표시하도록(동심원도 표시)
    if(annotation == thisMapView.userLocation) { return nil; } //Returning nil will perform default behavior
    
	static NSString *busStopViewIdentifier = @"BusStopViewIdentifier";
    MKAnnotationView *annotationView = nil;
    annotationView = (MKAnnotationView *)[thisMapView dequeueReusableAnnotationViewWithIdentifier:busStopViewIdentifier];
    
	if(annotationView == nil)
	{
		annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:busStopViewIdentifier] autorelease];
	}

    annotationView.enabled = YES; 
    annotationView.canShowCallout = YES;

    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

    //이미지로 핀 표시
    //UIImage * image;
    if ([annotation.subtitle isEqualToString:@"비건"]) {annotationView.image = [UIImage imageNamed:@"pin_green.png"];}
    else if ([annotation.subtitle isEqualToString:@"유란 채식"]) {annotationView.image = [UIImage imageNamed:@"pin_green_yellow.png"];}
    else if ([annotation.subtitle isEqualToString:@"락토 채식"]) {annotationView.image = [UIImage imageNamed:@"pin_green_milky.png"];}
    else if ([annotation.subtitle isEqualToString:@"락토 오보"]) {annotationView.image = [UIImage imageNamed:@"pin_green_yellow_milky.png"];}
    else if ([annotation.subtitle isEqualToString:@"대부분 채식"]) {annotationView.image = [UIImage imageNamed:@"pin_mostly.png"];}
    else if ([annotation.subtitle isEqualToString:@"일부 채식"]) {annotationView.image = [UIImage imageNamed:@"pin_partly.png"];}
    else {annotationView.image = [UIImage imageNamed:@"GPS.png"];}

    return annotationView;
}

//어노테이션의 > 버튼이 눌렸을 때
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    MyAnnotation *annotation=view.annotation;
    
    //NSMutableArray인 restaurants에서 id_no가 일치하는 RestaurnatDAO 가져오기.
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_no == %d",annotation.tag];
    NSArray* searchedRest = [localRestaurants filteredArrayUsingPredicate: predicate];
    
    PhotoDetailViewController *detailViewController = [[PhotoDetailViewController alloc] initWithNibName:@"PhotoDetailViewController" bundle:nil];
    detailViewController.restaurantDAO = ((RestaurantDAO *)[searchedRest objectAtIndex:0]);
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    //[searchedRest release]; //release 하지마!
    [detailViewController release];
}


/****************************************************
 CLLocationManagerDelegate METHOD
 ****************************************************/

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self showConfirmAlert:@"위치 정보 수집 에러" msg:[error description]];
}



/****************************************************
 USER METHOD
 ****************************************************/

- (WorldPhotosAppDelegate *)appDelegate {
	return [[UIApplication sharedApplication] delegate];	
}



//내 위치 근처로 줌(Zoom)
- (IBAction)spanToHere:(id)sender { //현재 위치를 기준으로(GPS정보등) (갱신)
    self.locationManager = [[[CLLocationManager alloc] init] autorelease]; 
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; //kCLLocationAccuracyNearestTenMeters; //10미터 정확도
    self.locationManager.delegate = self;
    
	[self.locationManager startUpdatingLocation]; //CoreLocation 시작
    
    CLLocation *curPos = self.locationManager.location;
    CLLocationCoordinate2D curPos2D = curPos.coordinate;
    [mapView setCenterCoordinate:curPos2D animated:YES];
    
//    
//	MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
//	MKCoordinateRegion region = MKCoordinateRegionMake(curPos.coordinate, span);
//	[mapView setRegion:region animated:YES];
    
    [self.locationManager stopUpdatingLocation]; //CoreLocation 종료
    
//    [self.locationManager release]; //LSD 20111125
//    self.locationManager = nil; //LSD 20111125
}


- (IBAction)magnify:(id)sender { //정해진 크기로 줌 하면서 현재 위치로 이동 시킴
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; //kCLLocationAccuracyNearestTenMeters; //10미터 정확도
    self.locationManager.delegate = self;
    
	[self.locationManager startUpdatingLocation]; //CoreLocation 시작
    
    CLLocation *curPos = self.locationManager.location;
    
	MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
	MKCoordinateRegion region = MKCoordinateRegionMake(curPos.coordinate, span);
	[mapView setRegion:region animated:YES];
    
    [self.locationManager stopUpdatingLocation]; //CoreLocation 종료

}


//남한 전체로 줌(Zoom)
- (void)spanToKorea { 
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; //kCLLocationAccuracyNearestTenMeters; //10미터 정확도
    self.locationManager.delegate = self;
    
	[self.locationManager startUpdatingLocation]; //CoreLocation 시작
    
	CLLocationCoordinate2D center;
	center.latitude = 36.6;
	center.longitude = 127.990723;
    
	MKCoordinateSpan span;
	span.latitudeDelta = 4;
	span.longitudeDelta = 4;
	
	MKCoordinateRegion region;
	region.center = center;
	region.span = span;
	mapView.region = [mapView regionThatFits:region];
    
    [self.locationManager stopUpdatingLocation]; //CoreLocation 종료
    
//    [self.locationManager release]; //LSD 20111125
//    self.locationManager = nil; //LSD 20111125
}

//맵에 어노테이션 표시
- (void)updateMap {
//    [localRestaurants release];
//    [localRestaurants dealloc];
//    localRestaurants = [[[NSMutableArray alloc] initWithArray:[self appDelegate].restaurants] autorelease];
//    [localRestaurants retain];

    localRestaurants = [self appDelegate].restaurants;
//    localRestaurants = [[[self appDelegate].restaurants mutableCopy] autorelease];

    //맵에 있는 기존의 어토테이션들 삭제
    NSMutableArray *toRemove = [[NSMutableArray alloc] init];;
    for (id annotation in mapView.annotations)
        if (annotation != mapView.userLocation)
            [toRemove addObject:annotation];
    //NSLog(@"before removeAnnotations ...");
    [mapView removeAnnotations:toRemove];
    //NSLog(@"after removeAnnotations ...");

    [toRemove release];
    
    CLLocation *location;
    CLLocationCoordinate2D coordi;
    
    for (RestaurantDAO *aRest in localRestaurants) {
        //어노테이션표시
        location = [[CLLocation alloc] 
                    initWithLatitude:[aRest.latitude doubleValue]
                    longitude:[aRest.longitude doubleValue]];
        
        coordi = location.coordinate;
        MyAnnotation *placemark = [[MyAnnotation alloc] initWithCoordinate:coordi withTag:[aRest.id_no intValue] withTitle:aRest.name withSubtitle:aRest.grade];
        
//        placemark.title = [aRest.name retain];
//        placemark.subtitle = [aRest.grade retain];
        
        placemark.title = aRest.name;
        placemark.subtitle = aRest.grade;
//        placemark.seqindex = aRest.seqindex;
        
        [mapView addAnnotation:placemark];
        
        [placemark release];
        [location release];
        //[aRest release];
    }
    
}



//맵 타입 선택
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





@end
