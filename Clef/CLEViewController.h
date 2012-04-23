//
//  SubviewController.h
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import <Cocoa/Cocoa.h>

@interface CLEViewController : NSViewController {
    CLEViewController *partentViewController;
    NSMutableArray *childViewControllerStack;
    NSMutableDictionary *childViewControllers;
}
@property (strong)NSViewController *partentViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil parentViewController:(NSViewController*)svc;


- (void)pushViewController:(CLEViewController *)newTopViewController animated:(BOOL)animated;
- (void)pushPreallocatedViewController:(NSString*)identifier animated:(BOOL) animated;

- (void)popViewControllerAnimated:(BOOL)animated;


- (NSView*)topView;         // Returns view of viewController that is ontop of the stack
- (NSView*)parentView;      // Returns view of the parentViewController if this is the root controller or cascades to the root controller

- (void) prepareInitialViews;

- (void) viewWillAppear;
- (void) viewWillDisappear;


@end
