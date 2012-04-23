//
//  StateToIsPlaying.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "StateToIsPlaying.h"
#import "mpd/client.h"
@implementation StateToIsPlaying
+ (Class)transformedValueClass
{
    return [NSNumber class];
}

- (id)transformedValue:(id)value
{
    if ([(NSNumber*)value intValue] == MPD_STATE_PLAY) {
        return [NSNumber numberWithBool:YES];
    } else {
        return [NSNumber numberWithBool:NO];
    }
}
@end
