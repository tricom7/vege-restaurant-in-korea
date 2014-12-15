//
//  SearchAroundHere.h
//  WorldPhotos
//
//  Created by 이선동 on 11. 6. 5..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchAroundHere : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    IBOutlet UITextField *urlTextfield;
    NSMutableArray * myData;

    IBOutlet UIPickerView *myPicker;
    NSString * path;
}
@property (nonatomic, retain) NSMutableArray * myData;
@property (nonatomic, retain) NSString * path;

- (IBAction)goUrl:(id)sender;
- (IBAction)addWord:(id)sender;
- (IBAction)removeWord:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;

@end
