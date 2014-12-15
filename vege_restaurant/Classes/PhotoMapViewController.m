//
//  PhotoMapViewController.m
//  WorldPhotos
//
//  Created by 이선동 on 10. 12. 5..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import "PhotoMapViewController.h"

@implementation PhotoMapViewController
@synthesize mapView;
@synthesize restaurantDAO;


NSString * const GMAP_ANNOTATION_SELECTED = @"gmapselected";



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    NSLog(@"PhotoMapViewController didReceiveMemoryWarning !!!");

}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
    [restaurantDAO release];
	[mapView release];
    [super dealloc];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"PhotoMapViewController viewWillAppear...");
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[restaurantDAO.latitude doubleValue] longitude:[restaurantDAO.longitude doubleValue]];
	MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
	MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
	[mapView setRegion:region animated:YES];
    
    CLLocationCoordinate2D coordi = location.coordinate;
    MyAnnotation *placemark = [[MyAnnotation alloc] initWithCoordinate:coordi];
    
    placemark.title = restaurantDAO.name;
    placemark.subtitle = [NSString stringWithFormat:@"%.2f Km",[restaurantDAO.distance doubleValue]];

    [mapView addAnnotation:placemark]; //핀 꽂기
    [placemark release];
    [location release];

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



#pragma mark MKMapViewDelegate methods
- (MKAnnotationView *) mapView:(MKMapView *)thisMapView viewForAnnotation:(id <MKAnnotation>) annotation{
    //현재 위치는 핀이나 이미지를 표시하지 않고 기본 파란색 버튼 모양을 표시하도록(동심원도 표시)
    if(annotation == thisMapView.userLocation) { return nil; } //Returning nil will perform default behavior
    
    MKPinAnnotationView *annView = nil;
    if(annView == nil)
	{
		annView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"] autorelease];
	}
    
//    MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
    annView.pinColor = MKPinAnnotationColorGreen;
    annView.animatesDrop=TRUE;
    annView.canShowCallout = YES;
    annView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annView;
}


/*
//지도상에 어노테이션 표시 형식(UI에서 MapKit의 delegate를 File's owner로 설정해 두어야 작동함)
- (MKAnnotationView *) mapView:(MKMapView *)thisMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    //현재 위치는 핀이나 이미지를 표시하지 않고 기본 파란색 버튼 모양을 표시하도록(동심원도 표시)
    if(annotation == thisMapView.userLocation) { return nil; } //Returning nil will perform default behavior
    
	static NSString *busStopViewIdentifier = @"BusStopViewIdentifier";
    MKPinAnnotationView *annotationView = nil;
    annotationView = (MKPinAnnotationView *)[thisMapView dequeueReusableAnnotationViewWithIdentifier:busStopViewIdentifier];
    
	if(annotationView == nil)
	{
		annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:busStopViewIdentifier] autorelease];
	}
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
//    annotationView.centerOffset = CGPointMake(7,-15);
//    annotationView.calloutOffset = CGPointMake(-8,0);
    
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

    //이미지로 핀 표시
    //UIImage * image;
    if([(annotation).subtitle isEqualToString:@"비건"]) {annotationView.image = [UIImage imageNamed:@"pin_green.png"];}
    else if ([(annotation).subtitle isEqualToString:@"유란 채식"]) {annotationView.image = [UIImage imageNamed:@"pin_green_yellow.png"];}
    else if ([(annotation).subtitle isEqualToString:@"락토 채식"]) {annotationView.image = [UIImage imageNamed:@"pin_green_milky.png"];}
    else if ([(annotation).subtitle isEqualToString:@"락토 오보"]) {annotationView.image = [UIImage imageNamed:@"pin_green_yellow_milky.png"];}
    else if ([(annotation).subtitle isEqualToString:@"대부분 채식"]) {annotationView.image = [UIImage imageNamed:@"pin_mostly.png"];}
    else if ([(annotation).subtitle isEqualToString:@"일부 채식"]) {annotationView.image = [UIImage imageNamed:@"pin_partly.png"];}
    else {annotationView.image = [UIImage imageNamed:@"GPS.png"];}
    
    return annotationView;
}


- (MKAnnotationView *)mapView:(MKMapView *)thisMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if(![annotation isKindOfClass:[MyAnnotation class]]) // Don't mess user location
        return nil;
    
    MKAnnotationView *annotationView = [thisMapView dequeueReusableAnnotationViewWithIdentifier:@"spot"];
    if(!annotationView)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"spot"];
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        [(UIButton *)annotationView.rightCalloutAccessoryView addTarget:self action:@selector(openSpot:) forControlEvents:UIControlEventTouchUpInside];
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.centerOffset = CGPointMake(7,-15);
        annotationView.calloutOffset = CGPointMake(-8,0);
    }
    
    // Setup annotation view
    if([(annotation).subtitle isEqualToString:@"비건"]) {annotationView.image = [UIImage imageNamed:@"pin_green.png"];}
    else if ([(annotation).subtitle isEqualToString:@"유란 채식"]) {annotationView.image = [UIImage imageNamed:@"pin_green_yellow.png"];}
    else if ([(annotation).subtitle isEqualToString:@"락토 채식"]) {annotationView.image = [UIImage imageNamed:@"pin_green_milky.png"];}
    else if ([(annotation).subtitle isEqualToString:@"락토 오보"]) {annotationView.image = [UIImage imageNamed:@"pin_green_yellow_milky.png"];}
    else if ([(annotation).subtitle isEqualToString:@"대부분 채식"]) {annotationView.image = [UIImage imageNamed:@"pin_mostly.png"];}
    else if ([(annotation).subtitle isEqualToString:@"일부 채식"]) {annotationView.image = [UIImage imageNamed:@"pin_partly.png"];}
    else {annotationView.image = [UIImage imageNamed:@"GPS.png"];}
    
    return annotationView;
}

*/

//어노테이션의 > 버튼이 눌렸을 때
- (void)mapView:(MKMapView *)_mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    MyAnnotation *annotation=view.annotation;

    NSString* url = [NSString stringWithFormat:@"http://maps.google.com/maps?daddr=%f,%f&saddr=%f,%f&dirflg=r",
                     annotation.coordinate.latitude, 
                     annotation.coordinate.longitude,
                     _mapView.userLocation.location.coordinate.latitude,
                     _mapView.userLocation.location.coordinate.longitude]; 
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}









@end
