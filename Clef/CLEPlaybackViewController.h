//
//  CLEPlaybackViewController.h
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import <Cocoa/Cocoa.h>
#import "CLESong.h"
#import "INAppStoreWindow.h"
#import "CLEOutlineView.h"
#import "CLEViewController.h"

@interface CLEPlaybackViewController : CLEViewController {
    IBOutlet NSButton *prevSongButton;
    IBOutlet NSButton *playPauseButton;
    IBOutlet NSButton *nextSongButton;
    IBOutlet NSSlider *volumeSlider;
    
    NSNumber *databaseUpdating;
    NSNumber *random;
    NSNumber *repeat;
    NSNumber *single;
    NSNumber *consume;
    NSNumber *volume;
    NSNumber *queueVersion;
    NSNumber *crossfadeTime;
    NSNumber *songId;
    NSNumber *elapsedTime;
    NSNumber *playbackState;    
}


@property (strong) NSNumber *databaseUpdating;
@property (strong) NSNumber *random;
@property (strong) NSNumber *repeat;
@property (strong) NSNumber *single;
@property (strong) NSNumber *consume;
@property (strong) NSNumber *volume;
@property (strong) NSNumber *queueVersion;
@property (strong) NSNumber *crossfadeTime;
@property (strong) NSNumber *songId;
@property (strong) NSNumber *elapsedTime;
@property (strong) NSNumber *playbackState;

- (void)handleChangedGenericValue:(NSNotification*)notification;
- (void)handleChangedSongObject:(NSNotification*)notification;

-(IBAction)changeVolume:(id)sender;
-(IBAction)togglePause:(id)sender;
-(IBAction)nextSong:(id)sender;
-(IBAction)previousSong:(id)sender;

@end
