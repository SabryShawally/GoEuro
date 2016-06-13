//
//  GoEuroMainViewModel.h
//  GoEuro
//
//  Created by Zak on 6/13/16.
//  Copyright © 2016 Zak. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SearchResultsViewModelDelegate <NSObject>
@optional

-(void)UpdateSearchLocationWithLocationsArr:(NSArray*)locationsArr;

@end

@interface SearchResultsLocationsViewModel : NSObject
@property (nonatomic,weak) id <SearchResultsViewModelDelegate> delegate;
-(void)GetSearchLocationWithLocationsArrWithSearchKeyWord:(NSString*)SearchKeyWord;
@end
