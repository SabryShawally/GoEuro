
//
//  SearchResultsLocations.m
//  GoEuro
//
//  Created by Zak on 6/11/16.
//  Copyright © 2016 Zak. All rights reserved.
//



#import "SearchResultsLocations.h"
#import "CountryCell.h"
#import "CountryLocationModel.h"
#import "SearchResultsLocationsViewModel.h"

@interface SearchResultsLocations () <UISearchBarDelegate, UISearchResultsUpdating,SearchResultsViewModelDelegate>

@property (strong, nonatomic) NSArray *filteredList;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) SearchResultsLocationsViewModel *ResultsViewModel;



@end

@implementation SearchResultsLocations
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=_Type;
    _ResultsViewModel=[[SearchResultsLocationsViewModel alloc]init];
    _ResultsViewModel.delegate=self;
    [self ConfigureSearchController];
    [self addMenuButtons];
}
-(void)ConfigureSearchController
{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = NO;
    [self.searchController.searchBar sizeToFit];
    self.navigationController.extendedLayoutIncludesOpaqueBars=YES;
}

#pragma mark addBarbuttonItems

-(void)addMenuButtons
{
    
    UIImageView *bgimg;
    
    bgimg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 17, 18)];
    bgimg.image=[UIImage imageNamed:@"btn_Close"];
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame=CGRectMake(10, 0,17,18);
    [button addSubview:bgimg];
    [button addTarget:self action:@selector(CloseView:) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *customItem = [[UIBarButtonItem alloc] initWithCustomView: button];
    self.navigationItem.leftBarButtonItem = customItem;
}

-(IBAction)CloseView:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.filteredList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CountryCell";
    CountryCell * Cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (Cell == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    CountryLocationModel *Model_Country=[self.filteredList objectAtIndex:indexPath.row];
    Cell.lbl_Capital.text=Model_Country.name;
    Cell.lbl_Country.text=Model_Country.country;
    Cell.lbl_Coordinates.text=[NSString stringWithFormat:@"%@,%@",Model_Country.longitude,Model_Country.latitude];
    return Cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchController setActive:NO];
    CountryLocationModel *Model_Country=[self.filteredList objectAtIndex:indexPath.row];
    [_delegate DidSelectLocation:Model_Country andType:_Type];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}
#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self updateSearchResultsForSearchController:self.searchController];
}

#pragma mark -UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    [_ResultsViewModel GetSearchLocationWithLocationsArrWithSearchKeyWord:searchString];
}

#pragma mark -SearchResultsViewModelDelegate
-(void)UpdateSearchLocationWithLocationsArr:(NSArray *)locationsArr
{
    self.filteredList=locationsArr;
    [self.tableView reloadData];
}


@end
