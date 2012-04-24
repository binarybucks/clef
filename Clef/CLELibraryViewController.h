//
//  CLELibraryViewController.h
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLEViewController.h"
#import "CLEArtistsViewController.h"
#import "CLEAlbumsViewController.h"
#import "CLETitlesViewController.h"
#import "CLEAlbum.h"
#import "CLEArtist.h"
#import "CLENavigationController.h"

@interface CLELibraryViewController : CLEViewController {
    NSDictionary *artists;
    IBOutlet CLENavigationController *navigationController;
    CLEArtist *currentArtist;
    CLEAlbum *currentAlbum;
}

@property (strong) CLEArtist *currentArtist;
@property (strong) CLEAlbum *currentAlbum;

- (void)handleFetchedLibrary;

@end
