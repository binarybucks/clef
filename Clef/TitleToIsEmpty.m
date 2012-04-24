//
//  TitleToIsNotEmpty.m
//  Clef
//
//  Created by Alexander Rust on 24.04.12.
//  Copyright (c) 2012 IBM Deutschland GmbH. All rights reserved.
//

#import "TitleToIsEmpty.h"

@implementation TitleToIsEmpty
+ (Class)transformedValueClass
{
    return [NSString class];
}

- (id)transformedValue:(id)value
{
    if ([value isEqualToString:@""]) {
        return [NSNumber numberWithBool:YES];
    } else {
        return [NSNumber numberWithBool:NO];
    }
}
@end
