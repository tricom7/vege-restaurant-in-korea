//
//  GroupListViewController.h
//  WorldPhotos
//
//  Created by 이선동 on 11. 5. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantDAO.h"

@class WorldPhotosAppDelegate;

@interface GroupListViewController : UITableViewController {
    UITableView *mainTableView;
    NSMutableArray *arraySection;
    NSMutableArray *arraySectionTitles;
    NSMutableArray *localRestaurants;
}

@property (nonatomic, retain) IBOutlet UITableView *mainTableView;
@property (nonatomic, retain) NSMutableArray *arraySection;
@property (nonatomic, retain) NSMutableArray *arraySectionTitles;
@property (nonatomic, retain) NSMutableArray *localRestaurants;

- (WorldPhotosAppDelegate *)appDelegate;

- (IBAction)refreshTable:(id)sender;

@end
