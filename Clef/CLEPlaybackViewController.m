//
//  CLEPlaybackViewController.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLEPlaybackViewController.h"
#import "CLEAppDelegate.h"
#import "CLEViewController.h"

@implementation CLEPlaybackViewController

@synthesize databaseUpdating;
@synthesize random;
@synthesize repeat;
@synthesize single;
@synthesize consume;
@synthesize volume;
@synthesize queueVersion;
@synthesize crossfadeTime;
@synthesize songId;
@synthesize elapsedTime;
@synthesize playbackState;

#pragma mark - Initzalization
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {        
        
        // We could probably generalize this, but lets make it visible for which notifications we listen 
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangedGenericValue:) name:@"databaseUpdating" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangedGenericValue:) name:@"random" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangedGenericValue:) name:@"repeat" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangedGenericValue:) name:@"single" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangedGenericValue:) name:@"consume" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangedGenericValue:) name:@"volume" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangedGenericValue:) name:@"queueVersion" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangedGenericValue:) name:@"crossfadeTime" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangedGenericValue:) name:@"songId" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangedGenericValue:) name:@"elapsedTime" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangedGenericValue:) name:@"playbackState" object:nil];
        
        // Song changed notification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangedSongObject:) name:@"songObject" object:nil];
    }
    return self;
}


#pragma mark - Notification handlers
// Generic method that assigns values from notifications according to dictionary key
// Therefore our ivars have to have the same name as in the sending class. 
// For different behaviour replace selector with an own method
- (void)handleChangedGenericValue:(NSNotification*)notification {
    NSLog(@"Changed values: %@", [notification userInfo]);
    [self setValuesForKeysWithDictionary:[notification userInfo]];
}
- (void)handleChangedSongObject:(NSNotification*)notification {
    // currentSong = [[notification userInfo] valueForKey:@"songObject"];
}

#pragma mark - User actions
-(IBAction)changeVolume:(id)sender {
    [[(CLEAppDelegate*)[NSApp delegate] mpdServer] setVolumeTo:volume];
}
-(IBAction)togglePause:(id)sender {
    [[(CLEAppDelegate*)[NSApp delegate] mpdServer] togglePause];
}
-(IBAction)nextSong:(id)sender {
    [[(CLEAppDelegate*)[NSApp delegate] mpdServer] nextSong];
}
-(IBAction)previousSong:(id)sender {
    [[(CLEAppDelegate*)[NSApp delegate] mpdServer] previousSong];
}

- (void)awakeFromNib
{
    [super awakeFromNib];    
    [[playPauseButton image] setTemplate:NO];
}



@end
