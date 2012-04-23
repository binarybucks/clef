//
//  CLETableView.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLETableView.h"

@implementation CLETableView
//Display the background for the table in the given clipping rectangle.
- (void)highlightSelectionInClipRect:(NSRect)clipRect
{
    NSColor *evenColor   // empirically determined color, matches iTunes etc.
    = [NSColor colorWithCalibratedRed:0.929
                                green:0.953 blue:0.996 alpha:1.0];
    NSColor *oddColor  = [NSColor whiteColor];
    
    float rowHeight
    = [self rowHeight] + [self intercellSpacing].height;
    NSRect visibleRect = [self visibleRect];
    NSRect highlightRect;
    
    highlightRect.origin = NSMakePoint(
                                       NSMinX(visibleRect),
                                       (int)(NSMinY(clipRect)/rowHeight)*rowHeight);
    highlightRect.size = NSMakeSize(
                                    NSWidth(visibleRect),
                                    rowHeight - [self intercellSpacing].height);
    
    while (NSMinY(highlightRect) < NSMaxY(clipRect))
    {
        NSRect clippedHighlightRect
        = NSIntersectionRect(highlightRect, clipRect);
        int row = (int)
        ((NSMinY(highlightRect)+rowHeight/2.0)/rowHeight);
        NSColor *rowColor
        = (0 == row % 2) ? evenColor : oddColor;
        [rowColor set];
        NSRectFill(clippedHighlightRect);
        highlightRect.origin.y += rowHeight;
    }
    
    [super highlightSelectionInClipRect: clipRect];
}
//
//drawGridInClipRect:
//Draw the grid, but only the vertical lines.
- (void)drawGridInClipRect:(NSRect)rect
{
    NSRange columnRange = [self columnsInRect:rect];
    int i;
    [[NSColor lightGrayColor] set];
    for (   i = columnRange.location ;
         i < NSMaxRange(columnRange) ;
         i++ )
    {
        NSRect colRect = [self rectOfColumn:i];
        int rightEdge
        = (int) 0.5 + colRect.origin.x + colRect.size.width;
        [NSBezierPath strokeLineFromPoint:
         NSMakePoint(-0.5+rightEdge, -0.5+rect.origin.y)
                                  toPoint:
         NSMakePoint(-0.5+rightEdge, -0.5+rect.origin.y +
                     rect.size.height)];
    }
}


@end
