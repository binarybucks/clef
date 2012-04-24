//
//  SubviewController.h
//  Clef
//
//  Created by Alexander Rust on 13.04.12.
//  Copyright (c) 2012 IBM Deutschland GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@interface CLEViewController : NSViewController {
    CLEViewController   *partentViewController;
    NSMutableArray      *childViewControllerStack;
    NSMutableDictionary *childViewControllers;
    
    CLEViewController *activeChildViewController;
    
    CATransition *pushAnimation;
    CATransition *popAnimation;
}

@property (strong)NSViewController *partentViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil parentViewController:(NSViewController*)svc;


- (void)showViewController:(NSString*)identifier;

- (void)pushViewController:(CLEViewController *)newTopViewController animated:(BOOL)animated;
- (void)pushPreallocatedViewController:(NSString*)identifier animated:(BOOL) animated;
- (void)popViewControllerAnimated:(BOOL)animated;

- (void) prepareInitialViews;
- (void) willBecomeActive;
- (void) didBecomeActive;
- (void) willBecomeInactive;
- (void) didBecomeInactive;

- (NSView*)topView;         // Returns view of viewController that is ontop of the stack
- (NSView*)parentView;      // Returns view of the root controller or cascades to the root controller

- (NSString*)title;
- (NSString*)previousTitle;



@end
