//
//  GoEuroMainViewModel.m
//  GoEuro
//
//  Created by Zak on 6/13/16.
//  Copyright © 2016 Zak. All rights reserved.
//

#import "SearchResultsLocationsViewModel.h"
#import "SearchResultsModel.h"

@interface SearchResultsLocationsViewModel()<SearchResultsModelLocationsDelegate>

@property (nonatomic,strong) NSMutableArray *LocationsArray;
@property (nonatomic,strong) SearchResultsModel *GoEuroLocationsModel;
@end
@implementation SearchResultsLocationsViewModel

-(id)init
{
    self=[super init];
    if (self) {
        _GoEuroLocationsModel=[[SearchResultsModel alloc] init];
        _GoEuroLocationsModel.delegate=self;
    }
    return self;
}

-(void)GetSearchLocationWithLocationsArrWithSearchKeyWord:(NSString*)SearchKeyWord
{
    [_GoEuroLocationsModel fetchLocationsArrayWithKeyWord:SearchKeyWord];
}


-(void)didFetchLocationsArrayWithStatus:(BOOL)isSucces andMessage:(NSString *)message andLocationsArray:(NSArray *)locations
{
    [_delegate UpdateSearchLocationWithLocationsArr:locations];

}


@end
