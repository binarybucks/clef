//
//  CLEArtist.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLEArtist.h"

#import "CLESong.h"
#import "CLEAlbum.h"

@implementation CLEArtist
@synthesize name; 
@synthesize albums;


-(id)initWithName:(NSString*)n {
    self = [super init];
    if (self) {        
        albums = [[NSMutableDictionary alloc] init];
        name = n;
    }
    return self;
}

-(void)addSong:(CLESong*)song replaceIfExists:(BOOL)replace {
    CLEAlbum *album = [albums valueForKey:[song albumTitle]];   

    // Create album if not exisiting
    if (!album) {
        album = [[CLEAlbum alloc] initWithArtist:self title:[song albumTitle]];
        [albums setValue:album forKey:[song albumTitle]];
    } 

    // Cascade add down to album
    [album addSong:song replaceIfExists:(BOOL)replace]; 
    
    // Set self as artist 
    [song setValue:self forKey:@"artist"];

}

-(void)addAlbum:(CLEAlbum*)album replaceIfExists:(BOOL)replace {
    if (([albums valueForKey:[album title]]) && (!replace)) {
        NSLog(@"addAlbum would replace existing one but replace flag was not set.");
        return;
    }   
    [albums setValue:albums forKey:[album title]];
    
}

- (NSComparisonResult) compareWithAnotherArtist:(CLEArtist*) anotherArtist {
        return [[self name] compare:[anotherArtist name] options:NSCaseInsensitiveSearch];
    
}


- (NSString*)description {
    return [NSString stringWithFormat:@"CLEArtist: %@", name];
}

@end
