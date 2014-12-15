//
//  PhotoDetailViewController.h
//  WorldPhotos
//
//  Created by 이선동 on 10. 12. 5..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantDAO.h"

@interface PhotoDetailViewController : UIViewController {
    RestaurantDAO *restaurantDAO;
	UIImageView *photoImageView;
    
    IBOutlet UILabel *name;
    IBOutlet UILabel *detail_addr;
    IBOutlet UILabel *rough_map_desc;
    IBOutlet UIButton *tel;
    IBOutlet UILabel *distance;
    IBOutlet UILabel *grade;
    IBOutlet UILabel *type;
    IBOutlet UIButton *homepage;
    IBOutlet UILabel *business_hours;
    IBOutlet UILabel *holiday;
    IBOutlet UILabel *menu;
    IBOutlet UIImageView *IMG_grade;
    IBOutlet UIImageView *IMG_type;
    IBOutlet UILabel *price;
    IBOutlet UILabel *parking;
    
    IBOutlet UIButton *tel_confirm;
    
    IBOutlet UIScrollView *scrollView;
}

@property (nonatomic, retain) RestaurantDAO *restaurantDAO;
@property (nonatomic, retain) IBOutlet UIImageView *photoImageView;

- (IBAction)goToMapView:(id)sender;
- (IBAction)call:(id)sender;
- (IBAction)gotoHomepage:(id)sender;

@end
