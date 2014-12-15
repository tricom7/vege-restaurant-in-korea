//
//  TwitViewController.m
//  WorldPhotos
//
//  Created by 이선동 on 11. 6. 1..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitViewController.h"
#import "MapWebView.h"


@implementation TwitViewController

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

    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    NSLog(@"TwitViewController didReceiveMemoryWarning !!!");
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"TwitViewController viewWillAppear...");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//- (IBAction)sendText:(id)sender {
////    //TWITTER BLACK MAGIC
////    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://VegeRestaurants:twittu7@twitter.com/statuses/update.xml"]
////    cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
////    
////    [theRequest setHTTPMethod:@"POST"];
////    [theRequest setHTTPBody:[[NSString stringWithFormat:@"status=%@", [textView text]] dataUsingEncoding:NSUTF8StringEncoding]];
////    
////    NSURLResponse* response;
////    NSError* error;
////    NSData* result = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
////    NSLog(@"%@", [[[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding] autorelease]);
////    //END TWITTER BLACK MAGIC
//    
//    //TWITTER BLACK MAGIC
//    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://VegeRestaurants:twittu7@twitter.com/statuses/update.xml"]
//                                                            cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0]; 
//    [theRequest setHTTPMethod:@"POST"];
//                                     
//    [theRequest setHTTPBody:[[NSString stringWithFormat:@"status=%@", @"ttttest"] dataUsingEncoding:NSASCIIStringEncoding]];
//                                     
//    NSURLResponse* response;
//                                     
//    NSError* error;
//                                     
//    NSData* result = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
//                                     
//    NSLog(@"%@", [[[NSString alloc] initWithData:result encoding:NSASCIIStringEncoding] autorelease]);
//                                     
//    //	END TWITTER BLACK MAGIC
//}

- (IBAction)sendMail:(id)sender {
    NSURL *url = [[NSURL alloc] initWithString:@"mailto:vegerestaurants@gmail.com"];
    [[UIApplication sharedApplication] openURL:url];
    [url release];
    
//    [self goUrlWebView:@"mailto:vegerestaurants@gmail.com"]; //어차피 웹뷰안에 보이지 않으므로 위와 같이 원복함.
}

- (IBAction)goHanulvut1:(id)sender {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://cafe.naver.com/ululul/98016"]];
    
    [self goUrlWebView:@"http://cafe.naver.com/ululul/126812"];
}

- (IBAction)goHanulvut2:(id)sender {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://cafe.naver.com/ululul/98017"]];
    
    [self goUrlWebView:@"http://cafe.naver.com/ululul/126829"];
}

- (IBAction)goVeganCook:(id)sender {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://cafe.naver.com/vegancook"]];
    
    [self goUrlWebView:@"http://cafe.naver.com/vegancook"];
}

- (IBAction)goYogihut:(id)sender {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.yogihut.com"]];
    
    [self goUrlWebView:@"http://www.yogihut.com"];
}

- (IBAction)goVegeOrg:(id)sender {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.vege.or.kr"]];
    
    [self goUrlWebView:@"http://www.vege.or.kr"];
}

- (IBAction)goVegeDoctor:(id)sender {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://vegedoctor.com"]];
    
    [self goUrlWebView:@"http://vegedoctor.com"];
}

- (IBAction)goMeetFreeMonday:(id)sender {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.meatfreemonday.co.kr"]];
    
    [self goUrlWebView:@"http://www.meatfreemonday.co.kr"];
}

- (IBAction)goIVU:(id)sender {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://ivu.org"]];
    
    [self goUrlWebView:@"http://ivu.org"];
}

- (IBAction)goHappyCow:(id)sender {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.happycow.net"]];
    
    [self goUrlWebView:@"http://www.happycow.net"];
}




- (void)goUrlWebView:(NSString *)urlStr {
    
    MapWebView *mapWebViewController = [[MapWebView alloc] initWithNibName:@"MapWebView" bundle:nil];
    
    mapWebViewController.urlStr = urlStr;
    
    [self.navigationController pushViewController:mapWebViewController animated:YES];
    [mapWebViewController release];
}
   


@end
