//
//  CLESong.h
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import <Foundation/Foundation.h>
#import <mpd/song.h>

#import "CLEArtist.h"
#import "CLEAlbum.h"

@interface CLESong : NSObject {
    NSString    * file;
    NSString    * artistName;
    NSString    * artistNameKeyified;
    NSString    * title;
    NSString    * albumTitle;
    NSString    * albumTitleKeyified;
    NSString    * track;
    NSString    * name;
    NSString    * date;
    NSString    * genre;
    NSString    * composer;
    NSString    * performer;
    NSString    * disc;
    NSString    * comment;
    NSString    * albumartist;
    NSNumber    * ttime;
    NSNumber    * pos;
    NSNumber    * iid;
    CLEAlbum    * album;
    CLEArtist   * artist;
    
    struct mpd_song* mpdSong; 
}
-(id)initWithMpdSong:(struct mpd_song*)mpdSong;
- (NSComparisonResult) compareWithAnotherSong:(CLESong*) anotherSong;

@property (strong) NSString    * file;
@property (strong) NSString    * artistName;
@property (strong) NSString    * artistNameKeyified;
@property (strong) NSString    * title;
@property (strong) NSString    * titleKeyified;
@property (strong) NSString    * albumTitle;
@property (strong) NSString    * albumTitleKeyified;
@property (strong) NSString    * track;
@property (strong) NSString    * name;
@property (strong) NSString    * date;
@property (strong) NSString    * genre;
@property (strong) NSString    * composer;
@property (strong) NSString    * performer;
@property (strong) NSString    * disc;
@property (strong) NSString    * comment;
@property (strong) NSString    * albumartist;
@property (strong) NSNumber    * ttime;
@property (strong) NSNumber    * pos;
@property (strong) NSNumber    * iid;
@property (strong) CLEAlbum    * album;
@property (strong) CLEArtist   * artist;

@end

