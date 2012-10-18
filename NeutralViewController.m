//
//  NeutralViewController.m
//  StreamX
//
//  Created by Michelle on 2/14/10.
//  Copyright 2010 __mooncatventures.com__. All rights reserved.
//

#import "NeutralViewController.h"


@implementation NeutralViewController
@synthesize tabBar;

-(id) initWithTabBar {
	if ([self init]) {
		//this is the label on the tab button itself
		self.title = @"Info";
		
		//use whatever image you want and add it to your project
		self.tabBarItem.image = [UIImage imageNamed:@"photos.png"];
		
		// set the long name shown in the navigation bar
		self.navigationItem.title=@"Info";
	}
	return self;
	
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:NO];
	tabBar.selectedItem = [tabBar.items objectAtIndex:0];
		
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
