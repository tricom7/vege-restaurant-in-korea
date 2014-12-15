//
//  RootViewController.m
//  WorldPhotos
//
//  Created by 이선동 on 10. 12. 3..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "RootViewController.h"
#import "WorldPhotosAppDelegate.h"
#import "PhotoDetailViewController.h"

@implementation RootViewController
@synthesize mainTableView;
@synthesize updateLocationButton;
@synthesize localRestaurants;

/****************************************************
 VIEW METHOD
 ****************************************************/
- (void)dealloc {
    [localRestaurants release];
    [mainTableView release];
    [updateLocationButton release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"RootViewController didReceiveMemoryWarning !!!");
}

- (void)viewDidLoad {
    NSLog(@"RootViewController viewDidLoad...");
    [super viewDidLoad];
	self.navigationItem.title = @"채식식당 목록(거리순)";
    //self.navigationItem.rightBarButtonItem = self.updateLocationButton;
    

//    UIImage* image3 = [UIImage imageNamed:@"myGPS3.png"];
//    CGRect frameimg = CGRectMake(0, 0, image3.size.width, image3.size.height);
//    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
//    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
//    [someButton addTarget:self action:@selector(sendmail)
//         forControlEvents:UIControlEventTouchUpInside];
//    [someButton setShowsTouchWhenHighlighted:YES];
//    
//    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
//    self.navigationItem.rightBarButtonItem=mailbutton;
//    [someButton release];
    
    
    
    self.navigationItem.rightBarButtonItem = self.updateLocationButton;
    
    NSLog(@"RootViewController viewDidLoad completed");
}

- (void)viewDidUnload {
    [updateLocationButton release];
    updateLocationButton = nil;
    [self setMainTableView:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"RootViewController viewWillAppear...");
    
    if ([self appDelegate].isNeedQueryDB == true) {
        [[self appDelegate] queryDB];
        [self appDelegate].isNeedQueryDB = false;
    }
    
    [[self appDelegate] updateDistance];
    
    if ([self appDelegate].isNeedUpdate_List == true) {
        [self refreshTable:self];
        [self appDelegate].isNeedUpdate_List = false;
    }
    NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES selector:nil];
    [localRestaurants sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [sortDescriptor release];
    [mainTableView reloadData];
    
    //NSLog(@"RootViewController viewWillAppear completed");
}

/****************************************************
 LOAD TABLE
 ****************************************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [localRestaurants count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PhotoTableCell" owner:self options:nil];
		cell = [topLevelObjects objectAtIndex:0];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
	UILabel *label;
	label = (UILabel *)[cell viewWithTag:2];

    label.text = ((RestaurantDAO *)[localRestaurants objectAtIndex:indexPath.row]).name;
    
    label = (UILabel *)[cell viewWithTag:3];
    label.text = [NSString stringWithFormat:@"%.2f Km",[((RestaurantDAO *)[localRestaurants objectAtIndex:indexPath.row]).distance doubleValue]];
    
    label = (UILabel *)[cell viewWithTag:5];
    label.text = ((RestaurantDAO *)[localRestaurants objectAtIndex:indexPath.row]).city;
    
	UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    if ([(((RestaurantDAO *)[localRestaurants objectAtIndex:indexPath.row]).grade) isEqualToString:@"비건"]) {
        imageView.image = [UIImage imageNamed:@"ICO_all_green.png"];
    } else if ([(((RestaurantDAO *)[localRestaurants objectAtIndex:indexPath.row]).grade) isEqualToString:@"유란 채식"]) {
        imageView.image = [UIImage imageNamed:@"ICO_green_yellow.png"];
    } else if ([(((RestaurantDAO *)[localRestaurants objectAtIndex:indexPath.row]).grade) isEqualToString:@"락토 채식"]) {
        imageView.image = [UIImage imageNamed:@"ICO_green_milky.png"];
    } else if ([(((RestaurantDAO *)[localRestaurants objectAtIndex:indexPath.row]).grade) isEqualToString:@"락토 오보"]) {
        imageView.image = [UIImage imageNamed:@"ICO_green_yellow_milky.png"];
    } else if ([(((RestaurantDAO *)[localRestaurants objectAtIndex:indexPath.row]).grade) isEqualToString:@"대부분 채식"]) {
        imageView.image = [UIImage imageNamed:@"ICO_mostly_green.png"];
    } else if ([(((RestaurantDAO *)[localRestaurants objectAtIndex:indexPath.row]).grade) isEqualToString:@"일부 채식"]) {
        imageView.image = [UIImage imageNamed:@"ICO_partly_green.png"];
    } else {
        NSLog(@"-%@-",(((RestaurantDAO *)[localRestaurants objectAtIndex:indexPath.row]).grade));
    }
    
    
    UIImageView *imageView2 = (UIImageView *)[cell viewWithTag:4];
    if ([(((RestaurantDAO *)[localRestaurants objectAtIndex:indexPath.row]).type) isEqualToString:@"주문식"]) {
        imageView2.image = [UIImage imageNamed:@"ICO_order.png"];
    } else if ([(((RestaurantDAO *)[localRestaurants objectAtIndex:indexPath.row]).type) isEqualToString:@"뷔페"]) {
        imageView2.image = [UIImage imageNamed:@"ICO_buffet.png"];
    } else if ([(((RestaurantDAO *)[localRestaurants objectAtIndex:indexPath.row]).type) isEqualToString:@"빵집"] || [(((RestaurantDAO *)[localRestaurants objectAtIndex:indexPath.row]).type) isEqualToString:@"떡카페"]) {
        imageView2.image = [UIImage imageNamed:@"ICO_bakery.png"];
    } else if ([(((RestaurantDAO *)[localRestaurants objectAtIndex:indexPath.row]).type) isEqualToString:@"카페"]) {
        imageView2.image = [UIImage imageNamed:@"ICO_cafe.png"];
    } else {
        NSLog(@"-%@-",(((RestaurantDAO *)[localRestaurants objectAtIndex:indexPath.row]).type));
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoDetailViewController *detailViewController = [[PhotoDetailViewController alloc] initWithNibName:@"PhotoDetailViewController" bundle:nil];
    detailViewController.restaurantDAO = ((RestaurantDAO *)[localRestaurants objectAtIndex:indexPath.row]);
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}



/****************************************************
 USER METHOD
 ****************************************************/
- (WorldPhotosAppDelegate *)appDelegate {
	return [[UIApplication sharedApplication] delegate];	
}

- (IBAction)refreshTable:(id)sender { //현재 위치를 기준으로(GPS정보등) 가까운 식당 순으로 보이도록 테이블을 다시 소트(갱신)

//    [localRestaurants release];
//    [localRestaurants dealloc];
//    localRestaurants = [[[NSMutableArray alloc] initWithArray:[self appDelegate].restaurants] autorelease];
//    [localRestaurants retain];

    localRestaurants = [self appDelegate].restaurants;
//    localRestaurants = [[[self appDelegate].restaurants mutableCopy] autorelease];
    
//    NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES selector:nil];
//    [localRestaurants sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
//    [sortDescriptor release];
//    [mainTableView reloadData];
    
    
}


@end

