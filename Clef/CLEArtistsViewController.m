//
//  CLEArtistsViewController.m
//
//  Clef
//  Created by Alexander Rust on 04/23/12.
//

#import "CLEArtistsViewController.h"
#import "CLELibraryViewController.h"
#import "CLEAppDelegate.h"
#import "CLETableCellView.h"
#import "CLEAlbumsViewController.h"
#import "CLETableRowView.h"
@implementation CLEArtistsViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        artists = [[NSArray alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleFetchedLibrary) name:@"didFetchLibrary" object:nil];
    }
    return self;
}
        

- (IBAction)next:(id)sender {
    [(CLELibraryViewController*)self.partentViewController pushPreallocatedViewController:@"albumsViewController" animated:NO];
}


- (void)handleFetchedLibrary {
    NSLog(@"Handling fetched library");
    
    NSArray *artistsUnsorted = [[[(CLEAppDelegate*)[NSApp delegate] mpdServer] artists] allValues];
    
    [self setValue:[artistsUnsorted sortedArrayUsingSelector:@selector(compareWithAnotherArtist:)] forKey:@"artists"];
    [tableView reloadData];
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    return [artists count];
}

-(CLETableRowView *)tableView:(NSTableView *)atableView rowViewForItem:(id)item {
    // Until we find a better way to allways highlight rows
    NSLog(@"jere");
    return [[CLETableRowView alloc] init];
}

- (NSView *)tableView:(NSTableView *)atableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    CLEArtist *artist = [artists  objectAtIndex:row];
    CLETableCellView *result = NULL;
    

    
    if ([[tableColumn identifier] isEqualToString:@"mainColumn"]) {
        result = [atableView makeViewWithIdentifier:@"rowMainView" owner:self];
    
        if (result == nil) {
            result = [[CLETableCellView alloc] initWithFrame:[atableView frame]];
            result.identifier = @"rowMetaView";        
        
        }
        result.textField.stringValue = artist.name;
    } else {
        result = [atableView makeViewWithIdentifier:@"rowMetaView" owner:self];
        
        if (result == nil) {
            result = [[CLETableCellView alloc] initWithFrame:[atableView frame]];
            result.identifier = @"rowMetaView";        
            
        }
        result.textField.stringValue = [NSString stringWithFormat:@"%ld albums", artist.albums.count];

    }
    
    
    // return the result.
    
    return result;
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification {
    if (tableView.selectedRow) {
        NSLog(@"selected: %@", [artists objectAtIndex:[tableView selectedRow]]);
        [partentViewController pushPreallocatedViewController:@"albumsViewController" animated:NO];
    }
}

- (void) viewWillAppear {
    // reload foo
}
- (void) viewWillDisappear {
    NSLog(@"artistview will disappera, saving current artist %@", [artists objectAtIndex:[tableView selectedRow]] );
    [(CLELibraryViewController*)partentViewController setCurrentArtist:[artists objectAtIndex:[tableView selectedRow]]];
}



@end
