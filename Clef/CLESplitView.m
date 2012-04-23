//
//  CNVSplitView.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLESplitView.h"

@implementation CLESplitView

- (NSColor *)dividerColor {
   return [NSApp isActive] ? [NSColor darkGrayColor] : [NSColor lightGrayColor];
}



@end
