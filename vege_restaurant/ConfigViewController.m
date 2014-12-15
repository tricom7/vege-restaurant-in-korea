//
//  ConfigViewController.m
//  WorldPhotos
//
//  Created by 이선동 on 11. 5. 26..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConfigViewController.h"
#import "WorldPhotosAppDelegate.h"

@implementation ConfigViewController
@synthesize locationManager;

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
    [switch_vegan release];
    [switch_lacto release];
    [switch_ovo release];
    [switch_lacto_ovo release];
    [switch_mostly release];
    [switch_partly release];
    [switch_order release];
    [switch_buffet release];
    [switch_bakery release];
    [switch_cafe release];
    [scrollView release];
    [switch_bon release];
    [switch_dduck release];
    [switch_sodelicious release];
    [switch_bizon release];
    [switch_gangga release];
    [switch_subway release];
    [switch_coffeebean release];
    [super dealloc];
}

- (WorldPhotosAppDelegate *)appDelegate {
	return [[UIApplication sharedApplication] delegate];	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"ConfigViewController didReceiveMemoryWarning !!!");

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //scrollView.contentSize = self.view.frame.size;
    
    [scrollView setContentSize:CGSizeMake(320, 724)];
//    [scrollView setScrollEnabled:YES];
//    //scrollView.contentSize = self.view.frame.size;
//    //또는 아래와 같은 방식으로 가능.
//    [scrollView setContentSize:CGSizeMake(320, 1000)];
}

- (void)viewDidUnload
{

    self.locationManager = nil;
    [switch_vegan release];
    switch_vegan = nil;
    [switch_lacto release];
    switch_lacto = nil;
    [switch_ovo release];
    switch_ovo = nil;
    [switch_lacto_ovo release];
    switch_lacto_ovo = nil;
    [switch_mostly release];
    switch_mostly = nil;
    [switch_partly release];
    switch_partly = nil;
    [switch_order release];
    switch_order = nil;
    [switch_buffet release];
    switch_buffet = nil;
    [switch_bakery release];
    switch_bakery = nil;
    [switch_cafe release];
    switch_cafe = nil;
    [scrollView release];
    scrollView = nil;
    [switch_bon release];
    switch_bon = nil;
    [switch_dduck release];
    switch_dduck = nil;
    [switch_sodelicious release];
    switch_sodelicious = nil;
    [switch_bizon release];
    switch_bizon = nil;
    [switch_gangga release];
    switch_gangga = nil;
    [switch_subway release];
    switch_subway = nil;
    [switch_coffeebean release];
    switch_coffeebean = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"ConfigViewController viewWillAppear...");
}

//bool isConfig_changed = false;

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"Config View 나갑니다...");
}

- (void)makeSQL {
    NSString *whereString = @"SELECT id, name, province, city, detail_addr, tel, business_hours, holiday, type, grade, homepage, latitude, longitude, menu, zip, parking, tel2, distance, rough_map_desc, price FROM vege_restaurant";
    
    NSString *whereString_grade = @"grade in (";
    NSString *whereString_type = @"type in (";
    NSString *whereString_name = @"";
    
    if (switch_vegan.on) {
        whereString_grade = [whereString_grade stringByAppendingString:@"'비건', "];
    }
        
    if (switch_lacto.on) {
        whereString_grade = [whereString_grade stringByAppendingString:@"'락토 채식', "];
    }
        
    if (switch_ovo.on) {
        whereString_grade = [whereString_grade stringByAppendingString:@"'유란 채식', "];
    }
        
    if (switch_lacto_ovo.on) {
        whereString_grade = [whereString_grade stringByAppendingString:@"'락토 오보', "];
    }
        
    if (switch_mostly.on) {
        whereString_grade = [whereString_grade stringByAppendingString:@"'대부분 채식', "];
    }
        
    if (switch_partly.on) {
        whereString_grade = [whereString_grade stringByAppendingString:@"'일부 채식'"];
    }
        
    NSString *result = [whereString_grade substringWithRange: NSMakeRange([whereString_grade length]-2,2)];
        
    if ([result isEqualToString:@", "]) {
        whereString_grade = [whereString_grade substringToIndex:[whereString_grade length]-2];
    }
        
        
    if (switch_order.on) {
        whereString_type = [whereString_type stringByAppendingString:@"'주문식', "];
    }
    if (switch_buffet.on) {
        whereString_type = [whereString_type stringByAppendingString:@"'뷔페', "];
    }
    if (switch_bakery.on) {
        whereString_type = [whereString_type stringByAppendingString:@"'빵집', '떡카페', "];
    }
    if (switch_cafe.on) {
        whereString_type = [whereString_type stringByAppendingString:@"'카페'"];
    }
        
    result = [whereString_type substringWithRange: NSMakeRange([whereString_type length]-2,2)];
        
        
    if ([result isEqualToString:@", "]) {
        whereString_type = [whereString_type substringToIndex:[whereString_type length]-2];
    }
        

        

    
    // 프렌차이즈 필터링
    if (!switch_bon.on) { //본비빔밥
        whereString_name = [whereString_name stringByAppendingString:@" and name not like ('본비빔밥%')"];
    }
    
    if (!switch_dduck.on) { //떡담
        whereString_name = [whereString_name stringByAppendingString:@" and name not like ('떡담%')"];
    }
    
    if (!switch_sodelicious.on) { //소딜리셔스 
        whereString_name = [whereString_name stringByAppendingString:@" and name not like ('소딜리셔스%')"];
    }
    
    if (!switch_bizon.on) { //빚은 
        whereString_name = [whereString_name stringByAppendingString:@" and name not like ('빚은%')"];
    }
    
    if (!switch_gangga.on) { //강가 
        whereString_name = [whereString_name stringByAppendingString:@" and name not like ('강가%')"];
    }
    
    if (!switch_subway.on) { //서브웨이
        whereString_name = [whereString_name stringByAppendingString:@" and name not like ('서브웨이%')"];
    }
    
    if (!switch_coffeebean.on) { //커피빈
        whereString_name = [whereString_name stringByAppendingString:@" and name not like ('커피빈%')"];
    }
    
    
    whereString = [whereString stringByAppendingFormat:@" where  is_closed='false' and %@) and %@) %@",whereString_grade,whereString_type,whereString_name];
    
    [self appDelegate].sql = whereString;
    

    NSLog(@"Maked SQL: \n%@",whereString);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self showConfirmAlert:@"위치 정보 수집 에러" msg:[error description]];
}

- (void)showConfirmAlert:(NSString *)title msg:(NSString *)msg
{
	UIAlertView *alert = [[UIAlertView alloc] init];
	[alert setTitle:title];
	[alert setMessage:msg];
	[alert setDelegate:self];
	[alert addButtonWithTitle:@"OK"];
	[alert show];
	[alert release];
}

- (IBAction)configChanged:(id)sender {
    
    
    [self appDelegate].isNeedUpdate_List = true;
    NSLog(@"isNeedUpdate_Map을 true로 설정...");
    [self appDelegate].isNeedUpdate_Map = true;
    [self appDelegate].isNeedUpdate_Name_List = true;
    [self appDelegate].isNeedUpdate_Group_List = true;
    
    [self appDelegate].isNeedQueryDB = true;
    
    [self makeSQL];
}

@end
