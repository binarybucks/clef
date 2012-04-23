//
//  CLEAlbumsViewController.h
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLEViewController.h"

@interface CLEAlbumsViewController : CLEViewController <NSTableViewDelegate, NSTableViewDataSource>{
    NSButton *next;
    NSButton *prev;
    NSArray *albums;
    IBOutlet NSTableView *tableView;

}

- (IBAction)next:(id)sender;
- (IBAction)prev:(id)sender;

@end
