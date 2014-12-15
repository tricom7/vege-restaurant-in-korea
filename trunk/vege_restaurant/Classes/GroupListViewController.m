//
//  GroupListViewController.m
//  지역별
//
//  Created by 이선동 on 11. 5. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GroupListViewController.h"
#import "WorldPhotosAppDelegate.h"
#import "PhotoDetailViewController.h"

@implementation GroupListViewController
@synthesize mainTableView;
@synthesize arraySection;
@synthesize arraySectionTitles;
@synthesize localRestaurants;

/****************************************************
 VIEW METHOD
 ****************************************************/

- (void)dealloc
{
    [localRestaurants release];
    [arraySection release];
    [arraySectionTitles release];
    [mainTableView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"GroupListViewController didReceiveMemoryWarning !!!");
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //NSLog(@"GroupListViewController viewDidLoad...");
    [super viewDidLoad];
    arraySection = [[NSMutableArray alloc] init];
    arraySectionTitles = [[NSMutableArray alloc] init];
    //NSLog(@"GroupListViewController viewDidLoad completed");
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

NSString *compName;

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"GroupListViewController viewWillAppear...");
    
    if ([self appDelegate].isNeedQueryDB == true) {
        [[self appDelegate] queryDB];
        [self appDelegate].isNeedQueryDB = false;
    }
    
    [[self appDelegate] updateDistance];
    
    if ([self appDelegate].isNeedUpdate_Group_List == true) {
        [self refreshTable:self]; 
        [self appDelegate].isNeedUpdate_Group_List = false;
    } 
    
    
    NSSortDescriptor *sorter1=[[NSSortDescriptor alloc] initWithKey:@"province" ascending:YES selector:nil];
    NSSortDescriptor *sorter2=[[NSSortDescriptor alloc] initWithKey:@"city" ascending:YES selector:nil];
    NSSortDescriptor *sorter3=[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:nil];
    [localRestaurants sortUsingDescriptors:[NSArray arrayWithObjects:sorter1, sorter2, sorter3, nil]];
    [sorter1 release];
    [sorter2 release];
    [sorter3 release];
    
    //아래를 필요한 경우만 수행하도록 조치 필요(성능 개선)
    [arraySection removeAllObjects];

    [arraySectionTitles removeAllObjects];

    int sectionCnt = 0;
    //NSString *compName=@"";
    for (RestaurantDAO *aRest in localRestaurants) {
        if ([aRest.province isEqualToString:compName]) {
            [[arraySection objectAtIndex:sectionCnt-1] addObject:aRest];
        } else {
            compName = aRest.province;
            [arraySectionTitles addObject:compName];//
            NSMutableArray *province = [[NSMutableArray alloc] init];
            [arraySection addObject:province];
            [province release];
            sectionCnt++;
            [[arraySection objectAtIndex:sectionCnt-1] addObject:aRest];
            
        }
        //[aRest release];
    }
    //[compName release];

    [mainTableView reloadData];
    compName=@"";
    
    //NSLog(@"GroupListViewController viewWillAppear completed");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/****************************************************
 LOAD TABLE
 ****************************************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    NSLog(@"numberOfSectionsInTableView ==> 섹션수:%d",[arraySection count]);
    return [arraySection count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"numberOfRowsInSection ==> 섹션(%d)의 row수:%d",section ,[[arraySection objectAtIndex:section] count]);
    return [[arraySection objectAtIndex:section] count];
}

RestaurantDAO *aRest;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"cellForRowAtIndexPath");
    
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];

    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PhotoTableCell2" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UILabel *label;

    //RestaurantDAO *aRest  = nil;

    aRest = [[arraySection objectAtIndex:section] objectAtIndex:row];

    label = (UILabel *)[cell viewWithTag:2];
    label.text = aRest.name;
    
    label = (UILabel *)[cell viewWithTag:3];
    label.text = [NSString stringWithFormat:@"%.2f Km",[aRest.distance doubleValue]];
    
    label = (UILabel *)[cell viewWithTag:5];
    label.text = aRest.city;
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    if ([aRest.grade isEqualToString:@"비건"]) {
        imageView.image = [UIImage imageNamed:@"ICO_all_green.png"];
    } else if ([aRest.grade isEqualToString:@"유란 채식"]) {
        imageView.image = [UIImage imageNamed:@"ICO_green_yellow.png"];
    } else if ([aRest.grade isEqualToString:@"락토 채식"]) {
        imageView.image = [UIImage imageNamed:@"ICO_green_milky.png"];
    } else if ([aRest.grade isEqualToString:@"락토 오보"]) {
        imageView.image = [UIImage imageNamed:@"ICO_green_yellow_milky.png"];
    } else if ([aRest.grade isEqualToString:@"대부분 채식"]) {
        imageView.image = [UIImage imageNamed:@"ICO_mostly_green.png"];
    } else if ([aRest.grade isEqualToString:@"일부 채식"]) {
        imageView.image = [UIImage imageNamed:@"ICO_partly_green.png"];
    } else {
        NSLog(@"-%@-", aRest.grade);
    }
    
    UIImageView *imageView2 = (UIImageView *)[cell viewWithTag:4];
    if ([aRest.type isEqualToString:@"주문식"]) {
        imageView2.image = [UIImage imageNamed:@"ICO_order.png"];
    } else if ([aRest.type isEqualToString:@"뷔페"]) {
        imageView2.image = [UIImage imageNamed:@"ICO_buffet.png"];
    } else if ([aRest.type isEqualToString:@"빵집"] || [aRest.type isEqualToString:@"떡카페"]) {
        imageView2.image = [UIImage imageNamed:@"ICO_bakery.png"];
    } else if ([aRest.type isEqualToString:@"카페"]) {
        imageView2.image = [UIImage imageNamed:@"ICO_cafe.png"];
    } else {
        NSLog(@"-%@-", aRest.type);
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    NSLog(@"titleForHeaderInSection 타이틀:%@",[arraySectionTitles objectAtIndex:section]);
    NSString *provinceName = nil;
    provinceName = [arraySectionTitles objectAtIndex:section];
    return provinceName;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"didSelectRowAtIndexPath");
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    //RestaurantDAO *aRest  = nil;
 
    aRest = [[arraySection objectAtIndex:section] objectAtIndex:row];

    PhotoDetailViewController *detailViewController = [[PhotoDetailViewController alloc] initWithNibName:@"PhotoDetailViewController" bundle:nil];
    detailViewController.restaurantDAO = aRest;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

//섹션 인덱스 추가
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    NSLog(@"sectionIndexTitlesForTableView");
    return arraySectionTitles;
}

/****************************************************
 USER METHOD
 ****************************************************/
- (WorldPhotosAppDelegate *)appDelegate {
	return [[UIApplication sharedApplication] delegate];	
}



- (IBAction)refreshTable:(id)sender {
//    [localRestaurants release];
//    [localRestaurants dealloc];
//    localRestaurants = [[[NSMutableArray alloc] initWithArray:[self appDelegate].restaurants] autorelease];
//    [localRestaurants retain];

    localRestaurants = [self appDelegate].restaurants;
//    localRestaurants = [[[self appDelegate].restaurants mutableCopy] autorelease];

//    NSSortDescriptor *sorter1=[[NSSortDescriptor alloc] initWithKey:@"province" ascending:YES selector:nil];
//    NSSortDescriptor *sorter2=[[NSSortDescriptor alloc] initWithKey:@"city" ascending:YES selector:nil];
//    NSSortDescriptor *sorter3=[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:nil];
//    [localRestaurants sortUsingDescriptors:[NSArray arrayWithObjects:sorter1, sorter2, sorter3, nil]];
//    [sorter1 release];
//    [sorter2 release];
//    [sorter3 release];
//    
//        NSLog(@"111");
//    //아래를 필요한 경우만 수행하도록 조치 필요(성능 개선)
//    [arraySection removeAllObjects];
//        NSLog(@"222");
//    [arraySectionTitles removeAllObjects];
//        NSLog(@"333");
//    int sectionCnt = 0;
//    //NSString *compName=@"";
//    for (RestaurantDAO *aRest in localRestaurants) {
//        if ([aRest.province isEqualToString:compName]) {
//            [[arraySection objectAtIndex:sectionCnt-1] addObject:aRest];
//        } else {
//            compName = aRest.province;
//            [arraySectionTitles addObject:compName];//
//            NSMutableArray *province = [[NSMutableArray alloc] init];
//            [arraySection addObject:province];
//            [province release];
//            sectionCnt++;
//            [[arraySection objectAtIndex:sectionCnt-1] addObject:aRest];
//            
//        }
//        //[aRest release];
//    }
//    //[compName release];
//        NSLog(@"444");
//    [mainTableView reloadData];
//        NSLog(@"555");
}


@end
