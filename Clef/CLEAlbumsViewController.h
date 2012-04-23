//
//  CLEAlbumsViewController.h
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLEViewController.h"

@interface CLEAlbumsViewController : CLEViewController <NSTableViewDelegate, NSTableViewDataSource>{
    IBOutlet NSButton *next;
    IBOutlet NSButton *prev;
    NSArray *albums;
    IBOutlet NSTableView *tableView;

}


- (IBAction)next:(id)sender;
- (IBAction)prev:(id)sender;

@end
