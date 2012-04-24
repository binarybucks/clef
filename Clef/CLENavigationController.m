//
//  CLENavigationController.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLENavigationController.h"
#import "CLELibraryViewController.h"
#import "CLEQueueViewController.h"
#import "CLEPlaybackViewController.h"
#import <Quartz/Quartz.h>
@implementation CLENavigationController


// Instantiates all mayor viewcontrollers that then take care of instantiating their childcontrollers
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"NavigationController instantiated. Instantiating children");
        [childViewControllers setValue:[[CLELibraryViewController alloc] initWithNibName:nil bundle:nil parentViewController:self] forKey:@"libraryViewController"];
        [childViewControllers setValue:[[CLEQueueViewController alloc] initWithNibName:@"QueueView" bundle:nil parentViewController:self] forKey:@"queueViewController"];
        [childViewControllers setValue:[[CLEPlaybackViewController alloc] initWithNibName:@"PlaylistView" bundle:nil parentViewController:self] forKey:@"playlistViewController"];
    }
    
    return self;
}

- (void)showViewFromViewController:(NSString*)identifier {
    CLEViewController *newTopViewController = [childViewControllers valueForKey:identifier];
    NSView *oldTopView = self.view.subviews.lastObject;

    if ([oldTopView isEqual:[newTopViewController topView]]) {
        NSLog(@"Asked to show view that is already been shown. Doing nothing");
        return;
    }

    [currentNavigationTitle setStringValue:@"foo"];
    
    [[newTopViewController topView] setFrame:self.view.bounds ];
    [self.view addSubview:[newTopViewController topView]];
    [oldTopView removeFromSuperview];
    
    [self newTitle:[newTopViewController title] previousTitle:[newTopViewController previousTitle]];
}

- (void) prepareInitialViews {
    [super prepareInitialViews]; // Calls prepareInitialViews for all children
    [self showLibrary:nil];

}

- (NSView*)parentView {
    return self.view;
}

- (IBAction)goBack:(id)sender {
    
}

- (IBAction)showLibrary:(id)sender {
    NSLog(@"Showing library");
    [self showViewFromViewController:@"libraryViewController"];
    [segment setSelectedSegment:0];
}
- (IBAction)showPlaylist:(id)sender {
    NSLog(@"Showing playlist");
    [self showViewFromViewController:@"playlistViewController"];
    [segment setSelectedSegment:1];
}
- (IBAction)showQueue:(id)sender {
    NSLog(@"Showing lqueue");
    [self showViewFromViewController:@"queueViewController"];
    [segment setSelectedSegment:2];
}

- (IBAction)selectedSegment:(ANSegmentedControl*)sender {
    NSLog(@"changed selected segment");
    switch ([sender selectedSegment]) {
        case 0:
            [self showLibrary:nil];
            break;
        case 1:
            [self showPlaylist:nil];
            break;
        case 2:
            [self showQueue:nil];
            break;
    }
}

- (void)newTitle:(NSString*)newTitle {
    [currentNavigationTitle setStringValue:newTitle];
    [previousNavigationTitle setStringValue:@""];

}
- (void)newTitle:(NSString*)newTitle previousTitle:(NSString*)previousTitle {
    [currentNavigationTitle setStringValue:newTitle];
    [previousNavigationTitle setStringValue:previousTitle];
}



@end
