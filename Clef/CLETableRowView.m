//
//  CNVTableRowView.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLETableRowView.h"

@implementation CLETableRowView

// allways use the active (blue highlight)
- (BOOL) isEmphasized {
    return YES;
}
- (void)highlightSelectionInClipRect:(NSRect)clipRect
{
    NSLog(@"highlightselectionincliprecht called");
//    NSRange        aVisibleRowIndexes  = [self rowsInRect:clipRect];
//    NSIndexSet *    aSelectedRowIndexes = [self selectedRowIndexes];
//    int            aRow                = aVisibleRowIndexes.location;
//    int            anEndRow            = aRow +
//    aVisibleRowIndexes.length;
//    
//    NSColor *aColor = [NSColor colorWithCalibratedRed:0.929 green:
//                       0.953 blue:0.996 alpha:1.0];
//    
//    [aColor set];
//    
//    // draw highlight for the visible, selected rows
//    for (aRow; aRow < anEndRow; aRow++)
//    {
//        if([aSelectedRowIndexes containsIndex:aRow])
//        {
//            NSRect aRowRect = NSInsetRect([self rectOfRow:aRow], 2, 1);
//            NSRectFill(aRowRect);
//        }
//    }
}
@end
