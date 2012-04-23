//
//  CLEAppDelegate.h
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import <Cocoa/Cocoa.h>
#import "CLEServer.h"
#import "INAppStoreWindow.h"
#import "CLENavigationController.h"
@interface CLEAppDelegate : NSObject <NSApplicationDelegate> {
    CLEServer *mpdServer;
    IBOutlet NSView *titleBarView;
    IBOutlet CLENavigationController *navigationController;
    INAppStoreWindow *_window;

}

@property (strong) IBOutlet INAppStoreWindow *window;
@property (strong) CLEServer *mpdServer;

- (IBAction)clickButton1:(id)sender;
- (IBAction)clickButton2:(id)sender;
- (IBAction)clickButton3:(id)sender;


@end
