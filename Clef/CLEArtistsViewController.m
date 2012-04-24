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

#pragma mark - Initialization
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        artists = [[NSArray alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleFetchedLibrary) name:@"didFetchLibrary" object:nil];
    }
    return self;
}
      
- (void)handleFetchedLibrary {    
    NSArray *artistsUnsorted = [[[(CLEAppDelegate*)[NSApp delegate] mpdServer] artists] allValues];
    
    [self setValue:[artistsUnsorted sortedArrayUsingSelector:@selector(compareWithAnotherArtist:)] forKey:@"artists"];
    [tableView reloadData];
}

# pragma mark - TableView delegate methods
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    return [artists count];
}

-(CLETableRowView *)tableView:(NSTableView *)atableView rowViewForItem:(id)item {
    // Until we find a better way to allways highlight rows
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
    }
    return result;
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification {

    // Best way I know to check if a tablerow was selected
    if ([tableView numberOfSelectedRows]) {
            
        // Save album to parentviewcontroller
        NSLog(@"ArtistsView will become inactive. Saving selected artist to parentViewController %@", [artists objectAtIndex:[tableView selectedRow]]);
        [(CLELibraryViewController*)partentViewController setCurrentArtist:[artists objectAtIndex:[tableView selectedRow]]];

        // Push albumsViewController
        [partentViewController pushPreallocatedViewController:@"albumsViewController" animated:NO];
    }
}

- (NSString*)title { 
    return @"Artists";
};



- (NSString*)previousTitle { 
    return @"";
}


@end
