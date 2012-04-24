//
//  CLELibraryViewController.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLELibraryViewController.h"
#import "CLENavigationController.h"
#import "CLEAppDelegate.h"
#import "CLEAppDelegate.h"



@implementation CLELibraryViewController
@synthesize currentAlbum;
@synthesize currentArtist;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"LibraryViewController instantiated. Instantiating children");
        [childViewControllers setValue:[[CLEArtistsViewController alloc] initWithNibName:@"ArtistsView" bundle:nil parentViewController:self] forKey:@"artistsViewController"];
        [childViewControllers setValue:[[CLEAlbumsViewController alloc] initWithNibName:@"AlbumsView" bundle:nil parentViewController:self] forKey:@"albumsViewController"];
        [childViewControllers setValue:[[CLETitlesViewController alloc] initWithNibName:@"TitlesView" bundle:nil parentViewController:self] forKey:@"titlesViewController"];
    }
    return self;
}


// Catches push calls and sets title of main window accordingly. This is yet a quick and diry proof-of-concept and needs to be streamlined
- (void)pushPreallocatedViewController:(NSString*)identifier animated:(BOOL) animated {
    [super pushPreallocatedViewController:identifier animated:animated];
    [(CLENavigationController*)partentViewController newTitle:[self title] previousTitle:[self previousTitle]];
}

- (void)popViewControllerAnimated:(BOOL)animated {
    [super popViewControllerAnimated:animated];
    [(CLENavigationController*)partentViewController newTitle:[self title] previousTitle:[self previousTitle]];
}


- (void)handleFetchedLibrary {
    NSLog(@"Handling fetched library");
    //[self setValue:[[(CLEAppDelegate*)[NSApp delegate] mpdServer] artists] forKey:@"artists"];
}

- (void) prepareInitialViews {
    [super prepareInitialViews];
    [self pushViewController:[childViewControllers valueForKey:@"artistsViewController"] animated:NO];
}


// This viewcontroller does not have an own view, but presents the topmost view of its manage view hirarchy when asked for a view;
- (NSView*)view {
    return [self topView];
}


- (NSString*)title { 
    return [[childViewControllerStack lastObject] title];
};



- (NSString*)previousTitle { 
    return [[childViewControllerStack lastObject] previousTitle];
}

@end
