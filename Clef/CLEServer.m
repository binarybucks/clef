//
//  CLEServer.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLEServer.h"

#include <assert.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <mpd/client.h>
#include "NSNotification+Additions.h"
#include "NSNumber+_BoolenNumberToText.h"
#import "CLESong.h"
#import "CLEServer.h"
#import "CLEArtist.h"

#define ISIDLEENABLED 1

# pragma mark Private API
@interface CLEServer (PrivateAPI)
    - (void)poll;
    - (void)query:(NSString*)valueKey andSendNotificationIfChanged:(NSString*)notificationName;
    - (NSInteger) handleError;
    - (NSString*)playbackStateToString;
    - (struct mpd_status*) getMpdStatus;
@end

@implementation CLEServer
- (struct mpd_status*) getMpdStatus {
    return mpdStatus;
}




#pragma mark - Initializaiton

- (id) init {
        self = [super init];
    if (self) {
        
        currdatabaseUpdating = [NSNumber numberWithInt:0];
        currrandom = [NSNumber numberWithInt:0];
        currrepeat = [NSNumber numberWithInt:0];
        currsingle = [NSNumber numberWithInt:0];
        currconsume = [NSNumber numberWithInt:0];
        currvolume = [NSNumber numberWithInt:0];
        currqueueVersion = [NSNumber numberWithInt:0];
        currcrossfadeTime = [NSNumber numberWithInt:0];
        currsongId = [NSNumber numberWithInt:0];
        currelapsedTime = [NSNumber numberWithInt:0];
        currplaybackState = [NSNumber numberWithInt:0];
        
        
        artists = [[NSMutableDictionary alloc] init];
        songs = [[NSMutableDictionary alloc] init];

        
        // Make ourselves a dictionary where we can select query-functions by key for easy abstraction and less repetitive code
        // All querries in this dictionary will be executed each poll.
        queries = [[NSMutableDictionary alloc] init];
        [queries setValue:^(struct mpd_status* status) { return [NSNumber numberWithInt:mpd_status_get_update_id(status)]; } forKey:@"databaseUpdating"]; 
        [queries setValue:^(struct mpd_status* status) { return [NSNumber numberWithInt:mpd_status_get_random(status)]; } forKey:@"random"]; 
        [queries setValue:^(struct mpd_status* status) { return [NSNumber numberWithInt:mpd_status_get_repeat(status)]; } forKey:@"repeat"]; 
        [queries setValue:^(struct mpd_status* status) { return [NSNumber numberWithInt:mpd_status_get_single(status)]; } forKey:@"single"]; 
        [queries setValue:^(struct mpd_status* status) { return [NSNumber numberWithInt:mpd_status_get_consume(status)]; } forKey:@"consume"];
        [queries setValue:^(struct mpd_status* status) { return [NSNumber numberWithInt:mpd_status_get_volume(status)];} forKey:@"volume"]; 
        [queries setValue:^(struct mpd_status* status) { return [NSNumber numberWithInt:mpd_status_get_queue_version(status)]; } forKey:@"queueVersion"]; 
        [queries setValue:^(struct mpd_status* status) { return [NSNumber numberWithInt:mpd_status_get_crossfade(status)]; } forKey:@"crossfadeTime"]; 
        [queries setValue:^(struct mpd_status* status) { return [NSNumber numberWithInt:mpd_status_get_song_id(status)]; } forKey:@"songId"]; 
        [queries setValue:^(struct mpd_status* status) { return [NSNumber numberWithInt:mpd_status_get_elapsed_time(status)]; } forKey:@"elapsedTime"]; 
        [queries setValue:^(struct mpd_status* status) { return [NSNumber numberWithInt:mpd_status_get_state(status)]; } forKey:@"playbackState"]; 

        pollingIntervall = [NSNumber numberWithFloat:0.1];
        
        // We also register ourselves as observer for the songId notification, so we can requery the current songs attributes
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryCurrentSongInformation:) name:@"songId" object:nil];
    }
    return self;
}

# pragma mark - Connection
- (void)connect {
    if (connection)
        return; 
    
	connection = mpd_connection_new("fermi.local", 6600, 3000);
    
	if (mpd_connection_get_error(connection) != MPD_ERROR_SUCCESS) {
        [self handleError];
        return;
    } 
       
    NSLog(@"Starting to poll every %f seconds", [pollingIntervall floatValue]);
    mMpdTimer = [NSTimer scheduledTimerWithTimeInterval:[pollingIntervall floatValue] 
                                                 target: self 
                                               selector:@selector(poll) 
                                               userInfo: nil 
                                                repeats: YES];
    
    [self fetchDatabase];
}

# pragma mark - Polling
//Private method
- (void)query:(NSString*)valueKey andSendNotificationIfChanged:(NSString*)notificationName{
    NSString *currentValueKey = [NSString stringWithFormat:@"curr%@", valueKey];
    NSString *previousValueKey= [NSString stringWithFormat:@"prev%@",valueKey];

    // Moves the current value to the previous value
    [self setValue:[self valueForKey:currentValueKey] forKey:previousValueKey];
    
    // Get corresponding query function from dict and execute it with current mpdStaus as parameter
    NSNumber* (^codeblock)(struct mpd_status*) = [queries valueForKey:valueKey];//    
    [self setValue:codeblock(mpdStatus)  forKey:[NSString stringWithFormat:@"curr%@",valueKey]];
    
    // Compares previous and current values and sends notification when changed    
    if (!([[self valueForKey:currentValueKey] isEqualToNumber:[self valueForKey:previousValueKey]])) {
          [[NSNotificationCenter defaultCenter] postNotificationOnMainThreadWithName:notificationName object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[self valueForKey:currentValueKey], valueKey, nil]];
    }
}

- (void)queryLibrary {
//    mpd_send_list_all_meta(struct mpd_connection *connection, const char *path);
//    mpd_response_finish(struct mpd_connection *connection);
//    
//    /**
//     * Finishes the response of the current list command.  If there are
//     * data pairs left, they are discarded.
//     *
//     * @return true on success, false on error
//     */
//    bool
//    mpd_response_next(struct mpd_connection *connection);

}

#pragma mark Database
- (void) fetchDatabase {    
    NSLog(@"Fetching library");
    mpd_send_list_all_meta(connection, NULL);
    int i = 0;
    struct mpd_entity *entity = NULL;
    while ((entity = mpd_recv_entity(connection))) {
        
        if (mpd_entity_get_type(entity) == MPD_ENTITY_TYPE_SONG) {
            struct mpd_song *s = mpd_entity_get_song(entity);
            CLESong *song = [[CLESong alloc] initWithMpdSong:s];
            CLEArtist *artist = [artists valueForKey:[song artistName]];
            
            
            
            if (!artist) {
                artist = [[CLEArtist alloc] initWithName:[song artistName]];
                [artists setValue:artist forKey:[artist name]];
            }
        
            [artist addSong:song replaceIfExists:YES];
            
            i++;
        } else {
            //NSLog(@"entity not of type song");
        }
    }
    
    
    NSLog(@"Got %d songs from server", i);
    NSLog(@"Stored the following artists in internal structures %@", artists);
    [[NSNotificationCenter defaultCenter] postNotificationOnMainThreadWithName:@"didFetchLibrary" object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:currSong, @"songObject", nil]];

}

// Returns a threadsave copy of artists dict
- (NSMutableDictionary*)artists {
    return [artists copy];
}


- (void)queryCurrentSongInformation:(NSNotification*)notification {
    if (!connection) 
        return; 
        
    // Song is freed when deallocating CLESong object
    mpdSong = mpd_run_current_song(connection);
        
    if (!mpdSong)
        return;
    
    currSong = [[CLESong alloc] initWithMpdSong:mpdSong];
    
    [[NSNotificationCenter defaultCenter] postNotificationOnMainThreadWithName:@"songObject" object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:currSong, @"songObject", nil]];
}



//Private method
- (void) poll {    
	if (!connection)
		return;
    
	mpdStatus = mpd_run_status(connection);
    if (!mpdStatus)
        return;
    
    for (NSString* key in [queries allKeys]) {
        [self query:key andSendNotificationIfChanged:key];
        [self handleError];
    }
    
    mpd_status_free(mpdStatus);
}



#pragma mark - Error detection & handling
//Private method
- (NSInteger) handleError {
    if (mpd_connection_get_error(connection) != MPD_ERROR_SUCCESS) {
        NSLog(@"Error: %@", [NSString stringWithFormat:@"%s", mpd_connection_get_error_message(connection)]);
        return EXIT_FAILURE;
    } else {
        return EXIT_SUCCESS;
    }
}

# pragma mark - User actions
- (void)setVolumeTo:(NSNumber*)targetVolume {
    if (!connection){
        return;
    }
    mpd_run_set_volume(connection, [targetVolume intValue]);
    
    [self handleError];
}

- (void)togglePause {
    mpd_run_toggle_pause(connection);
    [self handleError];
}

- (void)nextSong {
    mpd_run_next(connection);
    [self handleError];
}

- (void)previousSong {
    mpd_run_previous(connection);
    [self handleError];
}


# pragma mark - Description
- (NSString*)description {
    return[NSString stringWithFormat:@"Current server status:\n isDatabaseUpdating: %@\n isRandomOn: %@\n isRepeatOn: %@\n isSingleOn: %@\n isConsumeOn: %@\n volume: %@%%\n queueVersionNumber: %@\n crossfadeTime: %@s\n currentSongId: %@\n currentSongElapsedTime: %@s\n playbackState: %@", [currdatabaseUpdating toYesNO], [currrandom toYesNO], [currrepeat toYesNO], [currsingle toYesNO], [currconsume toYesNO], currvolume, currqueueVersion, currcrossfadeTime, currsongId, currelapsedTime, [self playbackStateToString]];
}

//Private method
- (NSString*)playbackStateToString {
    switch ([currplaybackState intValue]) 
    {
        case MPD_STATE_PLAY:
            return @"Play";
            break;
        case MPD_STATE_PAUSE:
            return @"Playing, but paused";
            break;
        case MPD_STATE_STOP:
            return @"Stoped";
            break;            
        default:
            return @"Unknown";
    }
}
@end
