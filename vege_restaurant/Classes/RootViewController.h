//
//  RootViewController.h
//  WorldPhotos
//
//  Created by 이선동 on 10. 12. 3..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantDAO.h"

@class WorldPhotosAppDelegate;

@interface RootViewController : UITableViewController {
    UITableView *mainTableView;
    UIBarButtonItem *updateLocationButton;
    NSMutableArray *localRestaurants;
}

@property (nonatomic, retain) IBOutlet UITableView *mainTableView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *updateLocationButton;
@property (nonatomic, retain) NSMutableArray *localRestaurants;

- (WorldPhotosAppDelegate *)appDelegate;

- (IBAction)refreshTable:(id)sender;

@end
