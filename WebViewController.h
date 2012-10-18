
//Created by Michelle on 2/14/10.
//  Copyright 2010 _mooncatventures.com. All rights reserved.
//  Please see specific dual licensing file for gpl/lgl/mozillia  license details

#import <UIKit/UIKit.h>



@interface WebViewController : UIViewController<UIWebViewDelegate, UINavigationBarDelegate>  {
	UIWebView *webView;
	UIToolbar *toolbar;
	NSString *url;
	IBOutlet UITabBar *tabBar;	
	
	
}
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UITabBar *tabBar;

-(id)initWithTabBar;

- (void) closeDown;
- (void)playMovie:(NSString*)movieURL;
- (void)playCustom:(NSString*)movieURL;

@end
