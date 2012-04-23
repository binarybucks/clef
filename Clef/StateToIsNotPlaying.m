//
//  StateToIsNotPlaying.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "StateToIsNotPlaying.h"
#import "mpd/client.h"
@implementation StateToIsNotPlaying
+ (Class)transformedValueClass
{
    return [NSNumber class];
}

- (id)transformedValue:(id)value
{
    if ([(NSNumber*)value intValue] != MPD_STATE_PLAY) {
        return [NSNumber numberWithBool:YES];
    } else {
        return [NSNumber numberWithBool:NO];
    }
}
@end
