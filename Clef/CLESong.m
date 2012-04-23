//
//  CLESong.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLESong.h"

# pragma mark Private API
@interface CLESong (PrivateAPI)
-(NSString*)unsaveTagToString:(const char *)unsaveTag;
@end

@implementation CLESong

@synthesize file;
@synthesize artistName;
@synthesize title;
@synthesize albumTitle;
@synthesize track;
@synthesize name;
@synthesize date;
@synthesize genre;
@synthesize composer;
@synthesize performer;
@synthesize disc;
@synthesize comment;
@synthesize albumartist;
@synthesize ttime;
@synthesize pos;
@synthesize iid;
@synthesize album;
@synthesize artist;
@synthesize albumTitleKeyified;
@synthesize artistNameKeyified;
@synthesize titleKeyified;

-(id)initWithMpdSong:(struct mpd_song*)sng {
    self = [super init];
    if (self) {
        mpdSong = sng;

        artistName = [self unsaveTagToString:mpd_song_get_tag(mpdSong, MPD_TAG_ARTIST, 0)];
        albumTitle = [self unsaveTagToString:mpd_song_get_tag(mpdSong, MPD_TAG_ALBUM, 0)];
        title = [self unsaveTagToString:mpd_song_get_tag(mpdSong, MPD_TAG_TITLE, 0)];
        
        file = @"";
//        track = [NSString stringWithCString:mpd_song_get_tag(mpdSong, MPD_TAG_TRACK, 0) encoding:NSUTF8StringEncoding];
//        name = [NSString stringWithCString:mpd_song_get_tag(mpdSong, MPD_TAG_NAME, 0) encoding:NSUTF8StringEncoding];
//        date = [NSString stringWithCString:mpd_song_get_tag(mpdSong, MPD_TAG_DATE, 0) encoding:NSUTF8StringEncoding];
//        genre = [NSString stringWithCString:mpd_song_get_tag(mpdSong, MPD_TAG_GENRE, 0) encoding:NSUTF8StringEncoding];
//        composer = [NSString stringWithCString:mpd_song_get_tag(mpdSong, MPD_TAG_COMPOSER, 0) encoding:NSUTF8StringEncoding];
//        performer = [NSString stringWithCString:mpd_song_get_tag(mpdSong, MPD_TAG_PERFORMER, 0) encoding:NSUTF8StringEncoding];
//        disc = [NSString stringWithCString:mpd_song_get_tag(mpdSong, MPD_TAG_DISC, 0) encoding:NSUTF8StringEncoding];
//        comment = [NSString stringWithCString:mpd_song_get_tag(mpdSong, MPD_TAG_COMMENT, 0) encoding:NSUTF8StringEncoding];
//        disc = [NSString stringWithCString:mpd_song_get_tag(mpdSong, MPD_TAG_DISC, 0) encoding:NSUTF8StringEncoding];
//        albumartist = [NSString stringWithCString:mpd_song_get_tag(mpdSong, MPD_TAG_ALBUM_ARTIST, 0) encoding:NSUTF8StringEncoding];
        ttime = [NSNumber numberWithInt:1];
        pos = [NSNumber numberWithInt:1];
        iid = [NSNumber numberWithInt:1];    
    }
    return self;
}

-(void)dealloc {
    mpd_song_free(mpdSong);
}



// Some tags might return empty results, so we catch that here
-(NSString*)unsaveTagToString:(const char *)unsaveTag {
    if (unsaveTag) {
        return [NSString stringWithCString:unsaveTag encoding:NSUTF8StringEncoding];
    }
    return @"//InformationMissing//";
}

- (NSString*)description {
    return [NSString stringWithFormat:@"CleSong: Artist:%@, Album: %@, Title: %@", [artist name], [album title], title];
}

- (NSComparisonResult) compareWithAnotherSong:(CLESong*) anotherSong {
    return [[self title] compare:[anotherSong title] options:NSCaseInsensitiveSearch];
    
}
@end

