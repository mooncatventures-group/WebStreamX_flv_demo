//Created by Michelle on 2/14/10.
//  Copyright 2010 _mooncatventures.com. All rights reserved.
//  Please see specific dual licensing file for gpl/lgl/mozillia  license details


#import "WebViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "SDLviewController.h"


@implementation WebViewController

@synthesize webView;

- (id)init
{
	/*
	 if (self = [super init]) {
	 }
	 */
	return self;
}

-(id) initWithTabBar {
	if ([self init]) {
		//this is the label on the tab button itself
		self.title = @"Browser";
		
		//use whatever image you want and add it to your project
		self.tabBarItem.image = [UIImage imageNamed:@"streaming.png"];
		
		// set the long name shown in the navigation bar
		self.navigationItem.title=@"Browser";
	}
	return self;
	
}




- (void)loadView
{
		
	// the base view for this view controller
	UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	contentView.backgroundColor = [UIColor blueColor];
	
	// important for view orientation rotation
	contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);	
	self.view = contentView;
	self.view.autoresizesSubviews = YES;
	CGFloat toolbarHeight = 0;
	
	
		
	//create a frame that will be used to size and place the web view
	CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
	webFrame.origin.y -= 20.0;	// shift the display up so that it covers the default open space from the content view
	webFrame.size.height -=toolbarHeight;
	
	UIWebView *aWebView = [[UIWebView alloc] initWithFrame:webFrame];
	self.webView = aWebView;
	/*
	 *	Uncomment the following line if you want the HTML to scale to fit.  
	 *	This also allows the pinch zoom in and out functionality to work.
	 */
	aWebView.scalesPageToFit = YES;
	aWebView.autoresizesSubviews = YES;
	aWebView.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
	//set the web view delegate for the web view to be itself
	[aWebView setDelegate:self];
	
	//determine the path the to the index.html file in the Resources directory
	NSString *filePathString = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
	//build the URL and the request for the index.html file
	NSURL *aURL = [NSURL fileURLWithPath:filePathString];
	NSURLRequest *aRequest = [NSURLRequest requestWithURL:aURL];
	
	
	//load the index.html file into the web view.
	[aWebView loadRequest:aRequest];
	
	//add the web view to the content view
	[contentView addSubview:webView];
	
	

	
	
	[aWebView release];
	[contentView release];
}



- (BOOL)webView:(UIWebView *)webView 
shouldStartLoadWithRequest:(NSURLRequest *)request 
 navigationType:(UIWebViewNavigationType)navigationType{
  url = [[request URL] absoluteString];
	[self playCustom:url];
	
	/*
	if([url hasSuffix:@".m4v"]==YES || [url hasSuffix:@"mp4"]==YES || [url hasSuffix:@"mov"] == YES || [url hasSuffix:@"mpg"] == YES){
		
		[self playMovie:url];
		return NO;
	}else {
		
	return YES;
	}
 */
}


-(void)movieFinishedCallback:(NSNotification*)aNotification
{
    MPMoviePlayerController* theMovie = [aNotification object];
	
    [[NSNotificationCenter defaultCenter] removeObserver:self
													name:MPMoviePlayerPlaybackDidFinishNotification
												  object:theMovie];
	
    // Release the movie instance created in playMovieAtURL:
    [theMovie release];
}

- (void)playMovie:(NSString*)movieURL
{
	
	if([url hasSuffix:@".mpeg"]==YES || [url hasSuffix:@".avi"]==YES || [url hasSuffix:@"AVI"]==YES ||  [url hasSuffix:@"MPG"]==YES || [url hasSuffix:@"mpg"] == YES){
		[self playCustom:movieURL];
	}else{

	
	MPMoviePlayerController* theMovie = [[MPMoviePlayerController alloc] initWithContentURL:
										 [NSURL URLWithString:movieURL]];
	theMovie.scalingMode = MPMovieScalingModeAspectFill;
	theMovie.movieControlMode = MPMovieControlModeDefault;
	
	// Register for the playback finished notification.
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(movieFinishedCallback:)
												 name:MPMoviePlayerPlaybackDidFinishNotification
											   object:theMovie];
	
	// Movie playback is asynchronous, so this method returns immediately.
	[theMovie play];
	}
}


-(void)playCustom:(NSString*)movieURL
{
	
	SDLviewController *sdlViewController = [[SDLviewController alloc] initWithTabBar];
	
	
	NSString *videoFilename = @"test";
	NSString *resPath = [[NSBundle mainBundle] pathForResource:videoFilename ofType:@"flv"];
	[sdlViewController setUrl:resPath ];
	sdlViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sdlViewController animated:YES];
	[sdlViewController release];
	
	
	
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Return YES it you want the interface to change when the iPhone rotates.
	return YES;
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	
	
	if(fromInterfaceOrientation == UIInterfaceOrientationPortrait){
		[webView stringByEvaluatingJavaScriptFromString:@"rotate(0)"];
		if(toolbar != nil){
			//NSLog([NSString stringWithFormat:@"Toolbar height: %f\n",[toolbar frame].size.height]);
			[toolbar removeFromSuperview];
			
			CGRect webViewBounds = self.webView.bounds;
			webViewBounds.origin.y -= [toolbar frame].size.height/2;
			webViewBounds.size.height += [toolbar frame].size.height;
			self.webView.bounds = webViewBounds;
		}
	}
	else{
		[webView stringByEvaluatingJavaScriptFromString:@"rotate(1)"];
		
		if(toolbar != nil){
			
			[self.view addSubview:toolbar];
			
			CGRect webViewBounds = self.webView.bounds;
			//webViewBounds.origin.y -= [toolbar frame].size.height/4;
			webViewBounds.size.height -= [toolbar frame].size.height;
			self.webView.bounds = webViewBounds;
		}
	}
}
// uncomment this function if you wish to use acceleration in your JavaScript application
/*
- (void) accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{
	//NSLog([NSString stringWithFormat:@"accelerate(%f, %f, %f)", acceleration.x, acceleration.y, acceleration.z]);
	NSString* javaScriptCall = [NSString stringWithFormat:@"accelerate(%f, %f, %f)", acceleration.x, acceleration.y, acceleration.z];
	[webView stringByEvaluatingJavaScriptFromString:javaScriptCall];
}
 */

- (void) closeDown
{
	NSString* javaScriptCall = @"document.getElementsByTagName('body')[0].onunload()";
	[webView stringByEvaluatingJavaScriptFromString:javaScriptCall];
	NSLog(@"closed");
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview.
	// Release anything that's not essential, such as cached data.
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	NSLog(@"An error happened during load");
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
	NSLog(@"loading started");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
	NSLog(@"finished loading");
	}


- (void)action:(id)sender
{
		
	
}


- (void)dealloc
{
	[super dealloc];
}


@end
