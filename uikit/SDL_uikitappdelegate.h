/*
    SDL - Simple DirectMedia Layer
    Copyright (C) 1997-2010 Sam Lantinga

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

    Sam Lantinga
    slouken@libsdl.org
*/

#import <UIKit/UIKit.h>
#import <SDL/SDL_uikitopenglview.h>
#import <SDL/SDL_video.h>

/* *INDENT-OFF* */
@interface SDLUIKitDelegate:NSObject<UIApplicationDelegate> {
      UIWindow *window;
	  SDL_WindowID windowID;
	  UIWindow *myWindow;
	  UITabBarController *tabBarController;
      UINavigationController *navigationController;
	  NSString *glInit;

}


@property (readwrite, retain) UIWindow *window;
@property (readwrite, assign) SDL_WindowID windowID;
@property (readwrite, retain) UIWindow *myWindow;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSString *glInit;

- (void)postFinishLaunch:(NSDictionary*)parms;
-(void)postProcessing:(NSDictionary*) parms;
-(void) quitSdl;
-(void) switchTopWindow;

+(SDLUIKitDelegate *)sharedAppDelegate;

@end
/* *INDENT-ON* */
