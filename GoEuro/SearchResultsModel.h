//
//  GoEuroMainModel.h
//  GoEuro
//
//  Created by Zak on 6/13/16.
//  Copyright © 2016 Zak. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol SearchResultsModelLocationsDelegate <NSObject>
@optional
-(void)didFetchLocationsArrayWithStatus:(BOOL)isSucces andMessage:(NSString*)message andLocationsArray:(NSArray*)locations;
@end

@interface SearchResultsModel : NSObject
@property (nonatomic,weak) id <SearchResultsModelLocationsDelegate> delegate;
-(void)fetchLocationsArrayWithKeyWord:(NSString *)Keyword;
@end



