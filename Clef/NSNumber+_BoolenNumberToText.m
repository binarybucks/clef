//
//  NSNumber+_BoolenNumberToText.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "NSNumber+_BoolenNumberToText.h"

@implementation NSNumber (_BoolenNumberToText)
- (NSString*)toYesNO {
    return [self boolValue] ? @"YES" : @"NO";
}
@end
