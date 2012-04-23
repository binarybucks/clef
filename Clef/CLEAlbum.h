//
//  CLEAlbum.h
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLEViewController.h"

@class CLEArtist;
@class CLESong;

@interface CLEAlbum : NSObject {

    NSString *title; 
    CLEArtist *artist;
    NSMutableDictionary *songs;
}

-(id)initWithArtist:(CLEArtist*)a title:(NSString*)n;

@property (strong) NSString *title; 
@property (strong) CLEArtist *artist;
@property (strong) NSMutableDictionary *songs;

-(void)addSong:(CLESong*)song replaceIfExists:(BOOL)replace;
- (NSComparisonResult) compareWithAnotherAlbum:(CLEAlbum*) anotherAlbum;

@end
