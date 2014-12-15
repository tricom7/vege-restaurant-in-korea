//
//  SearchAroundHere.m
//  WorldPhotos
//
//  Created by 이선동 on 11. 6. 5..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchAroundHere.h"
#import "DistanceRefresher.h"
#import "MapWebView.h"

@implementation SearchAroundHere
@synthesize myData;
@synthesize path;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [path release];
    [urlTextfield release];
    [myData release];
    
    [myPicker release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"SearchAroundHere didReceiveMemoryWarning !!!");
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"SearchViewController viewWillAppear...");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    path = [[NSString alloc] initWithString:[(NSString *)[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"search.dat"]];
    
//    NSString * path = [(NSString *)[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"properties.plist"];
    
    NSArray * initData = [[NSArray alloc] initWithObjects:@"보리밥뷔페", @"두부", @"두부마을", @"팥죽", @"팥칼국수", @"동치미막국수", @"떡집", @"롯데마트", @"홈플러스", @"이마트", @"백화점", @"들깨", @"보리밥", @"뷔페", @"한정식", nil];

    myData = [[NSMutableArray alloc] initWithContentsOfFile:path];

    if ([myData count] == 0) {
        myData = [[NSMutableArray alloc] initWithArray:initData];
    }

    urlTextfield.text = [myData objectAtIndex:0];
    [initData release];
}

- (void)viewDidUnload
{
    [urlTextfield release];
    urlTextfield = nil;

    [myPicker release];
    myPicker = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

NSString *searchQuery;
NSString *urlString;
NSString *lat;
NSString *lon;

- (IBAction)goUrl:(id)sender {
    [urlTextfield resignFirstResponder];
    
    DistanceRefresher * dr = [[DistanceRefresher alloc] init];
    NSArray * myLoc = [[NSArray alloc] initWithArray:[dr getMyLocation]];

    lat = [[myLoc objectAtIndex:0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    lon = [[myLoc objectAtIndex:1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    // Be careful to always URL encode things like spaces and other symbols that aren't URL friendly
    searchQuery = [urlTextfield.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // Now create the URL string …
    NSString* urlString = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@&near=%@,%@", searchQuery, lat, lon];
 
    // An the final magic … openURL!
    // 예전 방식 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]]; ==> 아래 4줄로 수정하여 WebView 안에서 지도가 나오도록 수정함.
    
    
    MapWebView *mapWebViewController = [[MapWebView alloc] initWithNibName:@"MapWebView" bundle:nil];
    
    mapWebViewController.urlStr = urlString;
    
    [self.navigationController pushViewController:mapWebViewController animated:YES];
    [mapWebViewController release];
    
    
    
    [myLoc release];
    [dr release];
}

NSString * testString;
- (IBAction)addWord:(id)sender {
    int i = 0;
    for (testString in myData) {
        if ([[urlTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:testString]) {
            return;
        }
        i++;
    }
    
    [myData addObject:[urlTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    [myPicker reloadAllComponents];
    [myPicker selectRow:i inComponent:0 animated:YES];
    [myData writeToFile:path atomically:YES];
}


- (IBAction)removeWord:(id)sender {
    int c = (int)[myData count];
    for (int i=0; i<c ;i++) {
        testString = [myData objectAtIndex:i];
        if ([[urlTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:testString]) {
            [myData removeObjectAtIndex:i];
            [myPicker reloadAllComponents];
            [myData writeToFile:path atomically:YES];
            return;
        }  
    }
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}


//Picker delegate methods
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    urlTextfield.text = [self.myData objectAtIndex:row];
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.myData count];
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.myData objectAtIndex:row];
}


@end
