//
//  CLEArtistsViewController.h
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLEViewController.h"

@interface CLEArtistsViewController : CLEViewController <NSTableViewDelegate, NSTableViewDataSource>{
    IBOutlet NSButton *next;
    NSArray *artists;
    IBOutlet NSTableView *tableView;
    

}
- (IBAction)next:(id)sender;
- (void)handleFetchedLibrary;
- (void)handleDoubleClickOnTableRow;

@end
