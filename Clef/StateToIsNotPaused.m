//
//  StateToIsNotPaused.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "StateToIsNotPaused.h"
#import "mpd/client.h"
@implementation StateToIsNotPaused
+ (Class)transformedValueClass
{
    return [NSNumber class];
}

- (id)transformedValue:(id)value
{
    if ([(NSNumber*)value intValue] == MPD_STATE_PAUSE) {
        return [NSNumber numberWithBool:NO];
    } else {
        return [NSNumber numberWithBool:YES];
    }
}
@end
