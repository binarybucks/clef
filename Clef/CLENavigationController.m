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

@synthesize currentNavigationTitle;
@synthesize previousNavigationTitle;


// Instantiates all mayor viewcontrollers that then take care of instantiating their childcontrollers
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"NavigationController instantiated. Instantiating children");
        [childViewControllers setValue:[[CLELibraryViewController alloc] initWithNibName:nil bundle:nil parentViewController:self] forKey:@"libraryViewController"];
        [childViewControllers setValue:[[CLEQueueViewController alloc] initWithNibName:@"QueueView" bundle:nil parentViewController:self] forKey:@"queueViewController"];
        [childViewControllers setValue:[[CLEPlaybackViewController alloc] initWithNibName:@"PlaylistView" bundle:nil parentViewController:self] forKey:@"playlistViewController"];
        [self setValue:@"" forKey:@"previousNavigationTitle"];
    }
    
    return self;
}
- (void)showViewController:(NSString*)identifier {
    [super showViewController:identifier];
    
    [self newTitle:[activeChildViewController title] previousTitle:[activeChildViewController previousTitle]];
}


- (void) prepareInitialViews {
    [super prepareInitialViews]; // Calls prepareInitialViews for all children
    [self showLibrary:nil];

}

- (NSView*)parentView {
    return self.view;
}

- (IBAction)showLibrary:(id)sender {
    NSLog(@"Showing library");
    [self  showViewController:@"libraryViewController"];
    [segment setSelectedSegment:0];
}
- (IBAction)showPlaylist:(id)sender {
    NSLog(@"Showing playlist");
    [self showViewController:@"playlistViewController"];
    [segment setSelectedSegment:1];
}
- (IBAction)showQueue:(id)sender {
    NSLog(@"Showing lqueue");
    [self showViewController:@"queueViewController"];
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

- (IBAction)goBack:(id)sender {
    [activeChildViewController popViewControllerAnimated:YES];
}

- (void)newTitle:(NSString*)newTitle {
    [self newTitle:newTitle previousTitle:@""];
}

- (void)newTitle:(NSString*)newTitle previousTitle:(NSString*)previousTitle {
    [self setValue:newTitle forKey:@"currentNavigationTitle"];
    [self setValue:previousTitle forKey:@"previousNavigationTitle"];
}



@end
