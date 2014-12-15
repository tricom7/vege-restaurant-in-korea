//
//  ListViewController.h
//  WorldPhotos
//
//  Created by 이선동 on 11. 5. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantDAO.h"

@class WorldPhotosAppDelegate;

@interface ListViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate> {
    UITableView *mainTableView;
    NSMutableArray *filteredListContent;    // The content filtered as a result of a search.
    NSMutableArray *localRestaurants;

}

@property (nonatomic, retain) IBOutlet UITableView *mainTableView;
@property (nonatomic, retain) NSMutableArray *filteredListContent;
@property (nonatomic, retain) NSMutableArray *localRestaurants;

- (WorldPhotosAppDelegate *)appDelegate;

- (IBAction)refreshTable:(id)sender;

@end
