//
//  Server.h
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import <Foundation/Foundation.h>
#include <mpd/client.h>
#include "CLESong.h"

@interface CLEServer : NSObject {
    NSMutableDictionary *queries;
    
    struct mpd_connection   *connection;
    struct mpd_status       *mpdStatus;
    struct mpd_song         *mpdSong;
    
    NSTimer  *mMpdTimer;
    NSNumber *pollingIntervall;
    
    NSNumber *currdatabaseUpdating;
    NSNumber *currrandom;
    NSNumber *currrepeat;
    NSNumber *currsingle;
    NSNumber *currconsume;
    NSNumber *currvolume;
    NSNumber *currqueueVersion;
    NSNumber *currcrossfadeTime;
    NSNumber *currsongId;
    NSNumber *currelapsedTime;
    NSNumber *currplaybackState;
    
    NSNumber *prevdatabaseUpdating;
    NSNumber *prevrandom;
    NSNumber *prevrepeat;
    NSNumber *prevsingle;
    NSNumber *prevconsume;
    NSNumber *prevvolume;
    NSNumber *prevqueueVersion;
    NSNumber *prevcrossfadeTime;
    NSNumber *prevsongId;
    NSNumber *prevelapsedTime;
    NSNumber *prevplaybackState;
    
    CLESong *currSong;
    
    // Albums are managed by artists and songs individually, as there can be more albums with the same name but distinct artist and they dont really make sense on their own
    NSMutableDictionary *artists;
    NSMutableDictionary *songs;
}


- (void)connect;
- (void)setVolumeTo:(NSNumber*)targetVolume;
- (void)togglePause;
- (void)nextSong;
- (void)previousSong;

- (void)queryCurrentSongInformation:(NSNotification*)notification;
- (void) fetchDatabase;
- (NSMutableDictionary*)artists;

@end
