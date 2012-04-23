//
//  CLEAppDelegate.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLEAppDelegate.h"
#import "CLELibraryViewController.h"
#import "CLEArtistsViewController.h"

@implementation CLEAppDelegate

@synthesize window = _window;
@synthesize mpdServer;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    self.window.trafficLightButtonsLeftMargin = 7.0;
    self.window.fullScreenButtonRightMargin = 7.0; 
    self.window.hideTitleBarInFullScreen = YES;    
    self.window.centerFullScreenButton = YES;    
    self.window.titleBarHeight = 40.0;

    titleBarView.frame = self.window.titleBarView.bounds;
    titleBarView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.window.titleBarView addSubview:titleBarView];
    
    // By now all viewcontrollers will have prepared their views. 
    // So we can call the navigation controller to prepare the initial state of all subviews
    [navigationController prepareInitialViews];
     
    
    mpdServer = [[CLEServer alloc] init];
    [mpdServer connect];
}



@end
