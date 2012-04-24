//
//  SubviewController.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//
#import "CLEViewController.h"

@implementation CLEViewController
@synthesize partentViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil parentViewController:(NSViewController*)pvc
{
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.partentViewController = pvc;
    }
    
    return self;
}



// The childViewControllerStack is used to build up hirarchical navigation. This means, that we can push viewcontrollers to go a level deeper and pop 
// them to go a level up. 

// Additionally we can use the childViewControllers dictionary to store preallocated viewcontrollers and access them easily via key-value coding

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        childViewControllers = [[NSMutableDictionary alloc] init];
        childViewControllerStack = [NSMutableArray array];
        
        
        
         pushAnimation = [CATransition animation];
        [pushAnimation setDuration:0.25];
        [pushAnimation setType:kCATransitionPush];
        [pushAnimation setSubtype:kCATransitionFromRight];
        [pushAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [pushAnimation setDelegate:self];

        
        popAnimation = [CATransition animation];
        [popAnimation setDuration:0.25];
        [popAnimation setType:kCATransitionPush];
        [popAnimation setSubtype:kCATransitionFromLeft];
        [popAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [popAnimation setDelegate:self];
        
    }
    
    return self;
}

// Use this to push an arbitrary viewcontroller on the childViewControllerStack and show its view
- (void)pushViewController:(CLEViewController *)newTopViewController animated:(BOOL)animated {    
    CLEViewController *oldTopViewController = [childViewControllerStack lastObject];    
    [childViewControllerStack addObject:newTopViewController];

    // Give old controller chance to prepare things for successor
    [oldTopViewController willBecomeInactive];      
    [newTopViewController willBecomeActive];

    newTopViewController.view.frame = [[self parentView] bounds];
    
    if ([[[self parentView] subviews]count] ) {
    
       [[[self parentView] layer] addAnimation:pushAnimation forKey:kCAOnOrderIn];
       [[self parentView]  addSubview:newTopViewController.view];
       [[oldTopViewController view] removeFromSuperview];
        
    } else {
        [[self parentView]  addSubview:newTopViewController.view];
    }
    
    [oldTopViewController didBecomeInactive];
    [newTopViewController didBecomeActive];
}

// Use this to push a preallocated viewcontroller from the childViewControllers on the childViewControllerStack;
- (void)pushPreallocatedViewController:(NSString*)identifier animated:(BOOL) animated{
    [self pushViewController:[childViewControllers valueForKey:identifier] animated:animated];
}



- (void)popViewControllerAnimated:(BOOL)animated {
    NSAssert(childViewControllers.count > 1, @"I'm sorry Dave, I cannot do that.");
    CLEViewController *oldTopViewController = [childViewControllerStack lastObject];    
    CLEViewController *newTopViewController = [childViewControllerStack objectAtIndex:([childViewControllerStack count]-2)];
    
    // Give old controller chance to prepare things for successor
    [oldTopViewController willBecomeInactive];
    [newTopViewController willBecomeActive];
    
    newTopViewController.view.frame = [[self parentView] bounds];
    

    
    [[[self parentView] layer] addAnimation:popAnimation forKey:kCAOnOrderIn];
    [[self parentView] addSubview:newTopViewController.view];
    [oldTopViewController.view removeFromSuperview];
    
    
    
    [childViewControllerStack removeLastObject];
    
    [oldTopViewController didBecomeInactive];
    [newTopViewController didBecomeActive];
}



- (void)showViewController:(NSString*)identifier {
    if ([activeChildViewController isEqualTo:[childViewControllers valueForKey:identifier]]) {
        NSLog(@"Asked to show view that is already been shown. Doing nothing");
        return;
    }
    
    activeChildViewController = [childViewControllers valueForKey:identifier];
    NSView *oldTopView = self.view.subviews.lastObject;
        
    [[activeChildViewController topView] setFrame:self.view.bounds ];
    [self.view addSubview:[activeChildViewController topView]];
    [oldTopView removeFromSuperview];
}



- (NSView*)topView {
    // If we have a stack, return view of topmost viewcontroller
    if ([childViewControllerStack count] > 0) {
        return [[childViewControllerStack lastObject] view];        
    } else {
        // Return out view otherwise
        NSAssert([self view], @"Assuming we had a view, but we did not");
        return [self view];
    }
}

// Overwrite at controller that controlls the actual view 
- (NSView*)parentView {
    return [partentViewController parentView];
}

// Put code to prepare the initial viewstate here. This method will be called during the applicationDidFinishLaunching and cascades from the main navigation controller
// to all its children. Therefore it is save to assume that the awakeFromNib method of all children has been called and all views are ready. Thus you may place the initial 
// push to the childViewControllerStack here to setup a viewcontroller as a non-removable root for the hirarchy.
- (void) prepareInitialViews {
    for (CLEViewController * child in [childViewControllers allValues]) {
        [child prepareInitialViews];
    }
}

- (NSString*)title {return @"overwrite me";};
- (NSString*)previousTitle { return @"overwrite me";};


// Up to subclasses to implement those actions that are called during push and pop
- (void) willBecomeActive {};
- (void) didBecomeActive  {};
- (void) willBecomeInactive {};
- (void) didBecomeInactive {};
@end
