//
//  ConfigViewController.h
//  WorldPhotos
//
//  Created by 이선동 on 11. 5. 26..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class WorldPhotosAppDelegate;

@interface ConfigViewController : UIViewController <CLLocationManagerDelegate> {
    IBOutlet UISwitch *switch_vegan;
    IBOutlet UISwitch *switch_lacto;
    IBOutlet UISwitch *switch_ovo;
    IBOutlet UISwitch *switch_lacto_ovo;
    IBOutlet UISwitch *switch_mostly;
    IBOutlet UISwitch *switch_partly;
    
    IBOutlet UISwitch *switch_order;
    IBOutlet UISwitch *switch_buffet;
    IBOutlet UISwitch *switch_bakery;
    IBOutlet UISwitch *switch_cafe;
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UISwitch *switch_bon;
    IBOutlet UISwitch *switch_dduck;
    IBOutlet UISwitch *switch_sodelicious;
    IBOutlet UISwitch *switch_bizon;
    IBOutlet UISwitch *switch_gangga;
    IBOutlet UISwitch *switch_subway;
    IBOutlet UISwitch *switch_coffeebean;
    
    
    CLLocationManager *locationManager;
}

@property (nonatomic, retain) CLLocationManager *locationManager;

- (WorldPhotosAppDelegate *)appDelegate;

- (void)showConfirmAlert:(NSString *)title msg:(NSString *)msg;

- (IBAction)configChanged:(id)sender;

@end
