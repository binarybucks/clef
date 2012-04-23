//
//  CLETitlesViewController.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLETitlesViewController.h"
#import "CLELibraryViewController.h"
#import "CLETableRowView.h"
#import "CLESong.h"
#import "CLETableCellView.h"
@implementation CLETitlesViewController

- (IBAction)prev:(id)sender {
    [(CLELibraryViewController*)self.partentViewController popViewControllerAnimated:NO];
}


- (void) willBecomeActive {
    NSLog(@"TitlesView will become active. Geting selected album from parentViewController %@", [(CLELibraryViewController*)partentViewController currentAlbum]);
    NSArray *songsUnsorted = [[[(CLELibraryViewController*)partentViewController currentAlbum] songs] allValues];
    
    [self setValue:[songsUnsorted sortedArrayUsingSelector:@selector(compareWithAnotherSong:)] forKey:@"songs"];
    [tableView reloadData];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    return [songs count];
}

-(CLETableRowView *)tableView:(NSTableView *)atableView rowViewForItem:(id)item {
    // Until we find a better way to allways highlight rows
    NSLog(@"jere");
    return [[CLETableRowView alloc] init];
}

- (NSView *)tableView:(NSTableView *)atableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    CLESong *song = [songs  objectAtIndex:row];
    CLETableCellView *result = NULL;
    
    if ([[tableColumn identifier] isEqualToString:@"mainColumn"]) {
        result = [atableView makeViewWithIdentifier:@"rowMainView" owner:self];
        
        if (result == nil) {
            result = [[CLETableCellView alloc] initWithFrame:[atableView frame]];
            result.identifier = @"rowMetaView";        
            
        }
        result.textField.stringValue = song.title;
    }    
    return result;
}

@end
