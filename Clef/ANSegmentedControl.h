//
//  ANSegmentedControl.h
//
//  Created by Decors on 11/04/22.
//
//  https://github.com/Decors/ANSegmentedControl
//

#import <Foundation/Foundation.h>


@interface ANSegmentedControl : NSSegmentedControl <NSAnimationDelegate> {
@private
    NSPoint location;
}

-(void)setSelectedSegment:(NSInteger)newSegment animate:(bool)animate;
@property CGFloat fastAnimationDuration;
@property CGFloat slowAnimationDuration;

@end
