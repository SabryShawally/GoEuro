//
//  LocationModel.h
//  GoEuro
//
//  Created by Zak on 6/13/16.
//  Copyright © 2016 Zak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CountryLocationModel : NSObject
@property(nonatomic,strong)NSString *CountryId;
@property(nonatomic,strong)NSDictionary *alternativeNames;
@property(nonatomic,strong)NSString *country;
@property(nonatomic,strong)NSString *countryCode;
@property(nonatomic,strong)NSString*distance;
@property(nonatomic,strong)NSString *fullName;
@property(nonatomic,strong)NSString *latitude;
@property(nonatomic,strong)NSString *longitude;
@property(nonatomic,strong)NSString *iata_airport_code;
@property(nonatomic,strong)NSString *key;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSDictionary *names;
@property(nonatomic,strong)NSString *type;
@property(nonatomic)BOOL coreCountry;
@property(nonatomic)BOOL inEurope;
@property(nonatomic)int locationId;
@property(nonatomic,strong) CLLocation *CityLocation;


@end
