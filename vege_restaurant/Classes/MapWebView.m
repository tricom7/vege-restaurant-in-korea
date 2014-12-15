//
//  MapWebView.m
//  WorldPhotos
//
//  Created by SUN DONG LEE on 2014. 4. 30..
//
//

#import "MapWebView.h"


@interface MapWebView ()

@end

@implementation MapWebView

@synthesize urlStr;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)webViewDidStartLoad:(UIWebView *)webView {  // 로딩이 시작될때 Activity 애니메이션 시작
    //NSLog(@"로딩이 시작될때 Activity 애니메이션 시작");
    [_m_Activity startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView { // 로딩이 정지될때 Activity 애니메이션 정지
    //NSLog(@"로딩이 정지될때 Activity 애니메이션 정지");
    [_m_Activity stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_webView release];
    [_m_Activity release];
    [super dealloc];
}
- (void)viewDidUnload {
    [urlStr release];
    
    [self setWebView:nil];
    [self setM_Activity:nil];
    [super viewDidUnload];
}
@end
