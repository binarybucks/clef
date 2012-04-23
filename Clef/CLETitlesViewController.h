//
//  CLETitlesViewController.h
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLEViewController.h"

@interface CLETitlesViewController : CLEViewController <NSTableViewDelegate, NSTableViewDataSource>{
    NSButton *prev;
    NSArray *songs;
    IBOutlet NSTableView *tableView;

}

- (IBAction)prev:(id)sender;

@end
