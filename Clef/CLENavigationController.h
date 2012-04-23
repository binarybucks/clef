//
//  CLENavigationController.h
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLENavigationController.h"
#import "CLEViewController.h"
#import "ANSegmentedControl.h"

@interface CLENavigationController : CLEViewController {
    IBOutlet NSView *titleBarView;
    IBOutlet ANSegmentedControl *segment;
}
- (void)showViewFromViewController:(NSString*)identifier;
- (IBAction)showLibrary:(id)sender;
- (IBAction)showPlaylist:(id)sender;
- (IBAction)showQueue:(id)sender;
- (IBAction)selectedSegment:(ANSegmentedControl*)sender;

@end
