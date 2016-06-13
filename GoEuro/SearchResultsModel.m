//
//  GoEuroMainModel.m
//  GoEuro
//
//  Created by Zak on 6/13/16.
//  Copyright © 2016 Zak. All rights reserved.
//

#import "SearchResultsModel.h"
#import <AFNetworking/AFNetworking.h>
#import "Constants.h"
#import "CountryLocationModel.h"
#import "NSDictionary+CheckNull.h"
#import "singleToneClassValues.h"


@implementation SearchResultsModel

-(void)fetchLocationsArrayWithKeyWord:(NSString *)Keyword;
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:[NSString stringWithFormat:URL_GetCurrentLocationCities,Keyword] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSArray *ArrayFetchedResults=[self ParseFetchedLocations:responseObject];
         [_delegate didFetchLocationsArrayWithStatus:YES andMessage:@"Success" andLocationsArray:ArrayFetchedResults];
     }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSString *Message;
         if (error.code == NSURLErrorTimedOut) {
             Message=@"SlowInternetConnection";
         }
         else if(error.code==NSURLErrorNotConnectedToInternet||error.code==NSURLErrorNetworkConnectionLost||error.code==NSURLErrorSecureConnectionFailed)
         {
             Message=@"NoInternetConnection";
         }
         else
         {
             Message=@"SomethingWrong";
         }
         
         [_delegate didFetchLocationsArrayWithStatus:NO andMessage:Message andLocationsArray:nil];
     }];
}

-(NSArray*)ParseFetchedLocations:(NSArray*)Arr_Data
{
    NSMutableArray *Arr_FetchedLocation=[[NSMutableArray alloc]init];
    for (NSDictionary *DicData in Arr_Data) {
        CountryLocationModel *LocationModel=[[CountryLocationModel alloc]init];
        LocationModel.CountryId=[DicData CheckobjectForKey:@"_id"];
        LocationModel.alternativeNames=[DicData CheckobjectForKey:@"alternativeNames"];
        LocationModel.country=[DicData CheckobjectForKey:@"country"];
        LocationModel.countryCode=[DicData CheckobjectForKey:@"countryCode"];
        LocationModel.distance=[DicData CheckobjectForKey:@"distance"];
        LocationModel.fullName=[DicData CheckobjectForKey:@"fullName"];
        LocationModel.latitude=[[DicData CheckobjectForKey:@"geo_position"] CheckobjectForKey:@"latitude"];
        LocationModel.longitude=[[DicData CheckobjectForKey:@"geo_position"] CheckobjectForKey:@"longitude"];
        LocationModel.iata_airport_code=[DicData CheckobjectForKey:@"iata_airport_code"];
        LocationModel.key=[DicData CheckobjectForKey:@"key"];
        LocationModel.locationId=[[DicData CheckobjectForKey:@"locationId"] intValue];
        LocationModel.name=[DicData CheckobjectForKey:@"name"];
        LocationModel.names=[DicData CheckobjectForKey:@"names"];
        LocationModel.type=[DicData CheckobjectForKey:@"type"];
        LocationModel.coreCountry=[(NSNumber *)[DicData CheckobjectForKey: @"coreCountry"] boolValue];
        LocationModel.inEurope=[(NSNumber *)[DicData CheckobjectForKey: @"inEurope"] boolValue];
        
        CLLocation *CityLocation = [[CLLocation alloc] initWithLatitude:[[[DicData CheckobjectForKey:@"geo_position"] CheckobjectForKey:@"latitude"] floatValue] longitude:[[[DicData CheckobjectForKey:@"geo_position"] CheckobjectForKey:@"longitude"] floatValue]];

        LocationModel.CityLocation=CityLocation;
        
        [Arr_FetchedLocation addObject:LocationModel];
    }
    return [singleToneClassValues SortLocationsToNearestOne:Arr_FetchedLocation];
}

@end
