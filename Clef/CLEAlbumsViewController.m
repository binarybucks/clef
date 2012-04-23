//
//  CLEAlbumsViewController.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLEAlbumsViewController.h"
#import "CLELibraryViewController.h"
#import "CLEAppDelegate.h"
#import "CLETableCellView.h"
#import "CLETableRowView.h"
@implementation CLEAlbumsViewController



- (IBAction)prev:(id)sender {
    [(CLELibraryViewController*)self.partentViewController popViewControllerAnimated:NO];
}

- (IBAction)next:(id)sender {
    [(CLELibraryViewController*)self.partentViewController pushPreallocatedViewController:@"titlesViewController" animated:NO];
}

- (void) willBecomeActive {
    
    NSLog(@"AlbumsView will become active. Geting selected artist from parentViewController %@", [(CLELibraryViewController*)partentViewController currentArtist]);
    NSArray *albumsUnsorted = [[[(CLELibraryViewController*)partentViewController currentArtist] albums] allValues];
    
    [self setValue:[albumsUnsorted sortedArrayUsingSelector:@selector(compareWithAnotherAlbum:)] forKey:@"albums"];
    [tableView reloadData];
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    return [albums count];
}

-(CLETableRowView *)tableView:(NSTableView *)atableView rowViewForItem:(id)item {
    return [[CLETableRowView alloc] init];
}

- (NSView *)tableView:(NSTableView *)atableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    CLEAlbum *album = [albums  objectAtIndex:row];
    CLETableCellView *result = NULL;
    
    
    
    if ([[tableColumn identifier] isEqualToString:@"mainColumn"]) {
        result = [atableView makeViewWithIdentifier:@"rowMainView" owner:self];
        
        if (result == nil) {
            result = [[CLETableCellView alloc] initWithFrame:[atableView frame]];
            result.identifier = @"rowMetaView";        
            
        }
        result.textField.stringValue = album.title;
    } else {
        result = [atableView makeViewWithIdentifier:@"rowMetaView" owner:self];
        
        if (result == nil) {
            result = [[CLETableCellView alloc] initWithFrame:[atableView frame]];
            result.identifier = @"rowMetaView";        
            
        }
        result.textField.stringValue = [NSString stringWithFormat:@"%ld titles", album.songs.count];
        
    }
    
    return result;
}



- (void)tableViewSelectionDidChange:(NSNotification *)aNotification {

    // Best way I know to check if a tablerow was selected
    if ([tableView numberOfSelectedRows]) {

        // Save album to parentviewcontroller
        NSLog(@"AlbumsView will become inactive. Saving selected album to parentViewController %@", [albums objectAtIndex:[tableView selectedRow]]);
        [(CLELibraryViewController*)partentViewController setCurrentAlbum:[albums objectAtIndex:[tableView selectedRow]]];
        
        // Push titlesViewController
        [partentViewController pushPreallocatedViewController:@"titlesViewController" animated:NO];
    }
}





@end
