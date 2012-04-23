//
//  CLEAlbum.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLEAlbum.h"

#import "CLEArtist.h"
#import "CLESong.h"

@implementation CLEAlbum
@synthesize title; 
@synthesize artist;
@synthesize songs;


-(id)initWithArtist:(CLEArtist*)a title:(NSString*)t{
    self = [super init];
    if (self) {
        artist = a;
        title = t;
        songs = [[NSMutableDictionary alloc] init];
    }
    return self;
}


-(void)addSong:(CLESong*)song replaceIfExists:(BOOL)replace {
    
    
    if (([songs valueForKey:[song albumTitle]]) && (!replace)) {
        NSLog(@"addSong would replace existing one but replace flag was not set.");
        return;
    }
    
    [songs setValue:song forKey:[song title]];
    
    [song setValue:self forKey:@"album"];
}

- (NSString*)description {
    return [NSString stringWithFormat:@"CLEAlbum: :%@", title];
}
- (NSComparisonResult) compareWithAnotherAlbum:(CLEAlbum*) anotherAlbum {
    return [[self title] compare:[anotherAlbum title] options:NSCaseInsensitiveSearch];
    
}


@end

