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

@interface CLELibraryViewController : CLEViewController {
    NSDictionary *artists;
    
    CLEArtist *currentArtist;
    CLEAlbum *currentAlbum;
}

@property (strong) CLEArtist *currentArtist;
@property (strong) CLEAlbum *currentAlbum;

@property (strong) NSDictionary *artists;

- (void)handleFetchedLibrary;

@end
