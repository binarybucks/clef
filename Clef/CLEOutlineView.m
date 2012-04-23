//
//  CNVOutlineView.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLEOutlineView.h"

@implementation CLEOutlineView

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (BOOL)acceptsFirstResponder 
{
    return NO;
}

- (id)selectedItem {
    return [self itemAtRow:[self selectedRow]];
}



@end
