//
//  CLEArtist.h
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLEViewController.h"

@class CLESong;
@class CLEAlbum;

@interface CLEArtist : NSObject {
    NSString *name; 
    NSMutableDictionary *albums;
}
    
@property (strong) NSString *name; 
@property (strong) NSMutableDictionary *albums;


-(id)initWithName:(NSString*)n;
-(void)addSong:(CLESong*)song replaceIfExists:(BOOL)replace;
-(void)addAlbum:(CLEAlbum*)album replaceIfExists:(BOOL)replace;
- (NSComparisonResult) compareWithAnotherArtist:(CLEArtist*) anotherArtist;

@end
