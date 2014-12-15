//
//  ListViewController.m
//  이름순
//
//  Created by 이선동 on 11. 5. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ListViewController.h"
#import "WorldPhotosAppDelegate.h"
#import "PhotoDetailViewController.h"

@implementation ListViewController
@synthesize mainTableView;
@synthesize filteredListContent;
@synthesize localRestaurants;

/****************************************************
 VIEW METHOD
 ****************************************************/
- (void)dealloc
{
    [localRestaurants release];
    [filteredListContent release];
    [mainTableView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    NSLog(@"ListViewController didReceiveMemoryWarning !!!");
    
    // Release any cached data, images, etc that aren't in use.
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
    //NSLog(@"ListViewController viewDidLoad...");
    [super viewDidLoad];
    filteredListContent = [[NSMutableArray alloc] init];
    //NSLog(@"ListViewController viewDidLoad completed");
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setMainTableView:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"ListViewController viewWillAppear...");
    
    if ([self appDelegate].isNeedQueryDB == true) {
        [[self appDelegate] queryDB];
        [self appDelegate].isNeedQueryDB = false;
    }
    
    [[self appDelegate] updateDistance];
    
    if ([self appDelegate].isNeedUpdate_Name_List == true) {
        [self refreshTable:self]; 
        [self appDelegate].isNeedUpdate_Name_List = false;
    }
    
    NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:nil];
    [localRestaurants sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [sortDescriptor release];
    [mainTableView reloadData];
    
    //NSLog(@"ListViewController viewWillAppear completed");
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
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/****************************************************
 LOAD TABLE
 ****************************************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredListContent count];
    } else {
        return [localRestaurants count];
    }    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PhotoTableCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UILabel *label;
    
    RestaurantDAO *aRest  = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        aRest = [self.filteredListContent objectAtIndex:indexPath.row];
    } else {
        
        aRest  = (RestaurantDAO *)[localRestaurants objectAtIndex:indexPath.row];
    }    

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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RestaurantDAO *aRest  = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        aRest = [self.filteredListContent objectAtIndex:indexPath.row];
    } else {
        aRest  = (RestaurantDAO *)[localRestaurants objectAtIndex:indexPath.row];
    }    
    
    PhotoDetailViewController *detailViewController = [[PhotoDetailViewController alloc] initWithNibName:@"PhotoDetailViewController" bundle:nil];
    detailViewController.restaurantDAO = aRest;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
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
    
//    NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:nil];
//    [localRestaurants sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
//    [sortDescriptor release];
//    [mainTableView reloadData];
}



/////search 관련
- (void)filterContentForSearchText:(NSString*)searchText
{
    
    [self.filteredListContent removeAllObjects]; // First clear the filtered array.
    
    /*
     Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
     */
    for (RestaurantDAO *aRest in localRestaurants)
    {
        // NSComparisonResult result = [person.name localizedCompare:searchText];
        NSRange range = [aRest.name rangeOfString:searchText];
        if (range.location != NSNotFound)
        {
            [self.filteredListContent addObject:aRest];
            //NSLog(@"%@",person.name);
        }
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


@end
