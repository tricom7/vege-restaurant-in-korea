//
//  PhotoDetailViewController.m
//  WorldPhotos
//
//  Created by 이선동 on 10. 12. 5..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "PhotoMapViewController.h"
#import "MapWebView.h"

@implementation PhotoDetailViewController
@synthesize photoImageView;
@synthesize restaurantDAO;

- (void)viewDidLoad {
    [super viewDidLoad];
    scrollView.contentSize = self.view.frame.size;
}
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"PhotoDetailViewController viewWillAppear...");
    
    self.navigationItem.title = restaurantDAO.name;
    name.text = restaurantDAO.name;
    detail_addr.text = restaurantDAO.detail_addr;
    
    if (restaurantDAO.tel == nil) {
        [tel setAlpha:0.0];
        [tel_confirm setAlpha:0.0];
    } else {
        [tel setAlpha:1.0];
        [tel_confirm setAlpha:1.0];
    }
    
    [tel setTitle:restaurantDAO.tel forState:UIControlStateNormal];
    
    business_hours.text = restaurantDAO.business_hours;
    holiday.text = restaurantDAO.holiday;
    type.text = restaurantDAO.type;
    grade.text = restaurantDAO.grade;

    if (restaurantDAO.homepage == nil || [restaurantDAO.homepage length]==0) {
        [homepage setAlpha:0.0];
    } else {
        [homepage setAlpha:1.0];
    }
    
    if (restaurantDAO.tel == nil || [restaurantDAO.tel length]==0) {
        [tel setAlpha:0.0];
        [tel_confirm setAlpha:0.0];
    } else {
        [tel setAlpha:1.0];
        [tel_confirm setAlpha:1.0];
    }
    
    [homepage setTitle:restaurantDAO.homepage forState:UIControlStateNormal];
    menu.text = restaurantDAO.menu;
    distance.text = [NSString stringWithFormat:@"%.2f Km",[restaurantDAO.distance doubleValue]];
    

    if ([restaurantDAO.grade isEqualToString:@"비건"]) {
        IMG_grade.image = [UIImage imageNamed:@"ICO_all_green.png"];
    } else if ([restaurantDAO.grade isEqualToString:@"유란 채식"]) {
        IMG_grade.image = [UIImage imageNamed:@"ICO_green_yellow.png"];
    } else if ([restaurantDAO.grade isEqualToString:@"락토 채식"]) {
        IMG_grade.image = [UIImage imageNamed:@"ICO_green_milky.png"];
    } else if ([restaurantDAO.grade isEqualToString:@"락토 오보"]) {
        IMG_grade.image = [UIImage imageNamed:@"ICO_green_yellow_milky.png"];
    } else if ([restaurantDAO.grade isEqualToString:@"대부분 채식"]) {
        IMG_grade.image = [UIImage imageNamed:@"ICO_mostly_green.png"];
    } else if ([restaurantDAO.grade isEqualToString:@"일부 채식"]) {
        IMG_grade.image = [UIImage imageNamed:@"ICO_partly_green.png"];
    } else {
        NSLog(@"-%@-",restaurantDAO.grade);
    }
    
    if ([restaurantDAO.type isEqualToString:@"주문식"]) {
        IMG_type.image = [UIImage imageNamed:@"ICO_order.png"];
    } else if ([restaurantDAO.type isEqualToString:@"뷔페"]) {
        IMG_type.image = [UIImage imageNamed:@"ICO_buffet.png"];
    } else if ([restaurantDAO.type isEqualToString:@"빵집"] || [restaurantDAO.type isEqualToString:@"떡카페"]) {
        IMG_type.image = [UIImage imageNamed:@"ICO_bakery.png"];
    } else if ([restaurantDAO.type isEqualToString:@"카페"]) {
        IMG_type.image = [UIImage imageNamed:@"ICO_cafe.png"];
    } else {
        NSLog(@"-%@-",restaurantDAO.type);
    }
    
    parking.text = restaurantDAO.parking;
    price.text = restaurantDAO.price;
    rough_map_desc.text = restaurantDAO.rough_map_desc;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    NSLog(@"PhotoDetailViewController didReceiveMemoryWarning !!!");

}

- (void)viewDidUnload {
    [detail_addr release];
    detail_addr = nil;
    [tel release];
    tel = nil;
    [distance release];
    distance = nil;
    [grade release];
    grade = nil;
    [type release];
    type = nil;
    [homepage release];
    homepage = nil;
    [holiday release];
    holiday = nil;
    [name release];
    name = nil;
    [IMG_grade release];
    IMG_grade = nil;
    [IMG_type release];
    IMG_type = nil;
    [business_hours release];
    business_hours = nil;
    [menu release];
    menu = nil;
    [price release];
    price = nil;
    [parking release];
    parking = nil;
    [tel_confirm release];
    tel_confirm = nil;
    [rough_map_desc release];
    rough_map_desc = nil;
    [scrollView release];
    scrollView = nil;
    [super viewDidUnload];
}

- (void)dealloc {
    [restaurantDAO release];
	[photoImageView release];
    [detail_addr release];
    [tel release];
    [distance release];
    [grade release];
    [type release];
    [homepage release];
    [holiday release];
    [name release];
    [IMG_grade release];
    [IMG_type release];
    [business_hours release];
    [menu release];
    [price release];
    [parking release];
    [tel_confirm release];
    [rough_map_desc release];
    [scrollView release];
    [super dealloc];
}

//- (IBAction)goToMapView:(id)sender {
//	PhotoMapViewController *mapViewController = [[PhotoMapViewController alloc] initWithNibName:@"PhotoMapViewController" bundle:nil];
//    mapViewController.restaurantDAO = restaurantDAO;
//	[self.navigationController pushViewController:mapViewController animated:YES];
//	[mapViewController release];
//}



NSString *urlString;
NSString *lat;
NSString *lon;

//- (IBAction)goToMapView:(id)sender {
//
//    lat = [restaurantDAO.latitude stringValue];
//    lon = [restaurantDAO.longitude stringValue];
//    
//    // Now create the URL string …
////    https://maps.google.com/maps?q=37.480686,126.980968&z=18
//    NSString* urlString = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@,%@&z=18", lat, lon];
//    
//    // An the final magic … openURL!
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
//}

- (IBAction)goToMapView:(id)sender {
    
    lat = [restaurantDAO.latitude stringValue];
    lon = [restaurantDAO.longitude stringValue];
    
    //    https://maps.google.com/maps?q=37.480686,126.980968&z=18
    NSString* urlString = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@,%@&z=18", lat, lon];
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    
    
    
    
    
    MapWebView *mapWebViewController = [[MapWebView alloc] initWithNibName:@"MapWebView" bundle:nil];
    
    mapWebViewController.urlStr = urlString;
    
    [self.navigationController pushViewController:mapWebViewController animated:YES];
    [mapWebViewController release];
    
}



- (IBAction)call:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",restaurantDAO.tel]]];
}

- (IBAction)gotoHomepage:(id)sender {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:restaurantDAO.homepage]];
    
    MapWebView *mapWebViewController = [[MapWebView alloc] initWithNibName:@"MapWebView" bundle:nil];
    
    mapWebViewController.urlStr = restaurantDAO.homepage;
    
    [self.navigationController pushViewController:mapWebViewController animated:YES];
    [mapWebViewController release];
}

@end
