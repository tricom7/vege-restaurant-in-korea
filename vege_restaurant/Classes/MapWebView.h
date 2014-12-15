//
//  MapWebView.h
//  WorldPhotos
//
//  Created by SUN DONG LEE on 2014. 4. 30..
//
//

#import <UIKit/UIKit.h>

@interface MapWebView : UIViewController {
    NSString *urlStr;
}

@property (nonatomic, retain) NSString *urlStr;

@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *m_Activity;
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@end
