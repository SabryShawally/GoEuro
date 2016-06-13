//
//  ViewController.m
//  GoEuro
//
//  Created by Zak on 6/11/16.
//  Copyright © 2016 Zak. All rights reserved.
//

#import "GoEuroMainViewController.h"
#import "singleToneClassValues.h"
#import "CalendarViewController.h"
#import "SearchResultsLocations.h"

@interface GoEuroMainViewController ()<GoEuroCalendarDelegate,CLLocationManagerDelegate,SelectedResultsDelegate>
@property(nonatomic,strong)IBOutlet UIView *View_FieldsContainer;
@property(nonatomic,strong)IBOutlet UIButton *btn_Calendar_Date;
@property(nonatomic,strong)IBOutlet UIButton *btn_Departure_Place;
@property(nonatomic,strong)IBOutlet UIButton *btn_Arrival_Place;
@property(nonatomic,strong)IBOutlet UIButton *btn_Seacrh;
@property(nonatomic,strong)CLLocationManager *locationManager;
@property(nonatomic,strong)CLLocation *Currentlocation;



@end

@implementation GoEuroMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self GetCurrentLocation];
    [self AdjustControllers];
    [_btn_Calendar_Date setTitle:[singleToneClassValues GetSelectedDateStrFromDate:[NSDate date]] forState:UIControlStateNormal];
}

#pragma mark GetCurrentLocation
-(void)GetCurrentLocation
{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if (IS_OS_8_OR_LATER) {
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager startUpdatingLocation];
        [_locationManager startMonitoringSignificantLocationChanges];
    }
    else
        [_locationManager startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationFailed" object:nil];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _Currentlocation=[locations lastObject];
    [singleToneClassValues setgetCurrentLocation:_Currentlocation];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:_Currentlocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       [self FillDepartureTitleWithCurrentLocation:[NSString stringWithFormat:@"%@,%@",[placemark locality],placemark.ISOcountryCode]];
                   }];
    [_locationManager stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    _Currentlocation=newLocation;
    [singleToneClassValues setgetCurrentLocation:_Currentlocation];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       [self FillDepartureTitleWithCurrentLocation:[NSString stringWithFormat:@"%@,%@",[placemark locality],placemark.ISOcountryCode]];
                   }];
    [_locationManager stopUpdatingLocation];
}

#pragma marks Get Data Actions
- (IBAction)getDepartureDate:(id)sender {
    [self performSegueWithIdentifier:@"S_Calendar" sender:nil];
}
- (IBAction)SearchForDepartureLocation:(id)sender {
    [self performSegueWithIdentifier:@"S_SearchLocations" sender:@"Departure"];
}
- (IBAction)SearchForArrivalLocation:(id)sender {
    [self performSegueWithIdentifier:@"S_SearchLocations" sender:@"Arrival"];
}
- (IBAction)SearchForAllTrip:(id)sender {
    
    if ([UIAlertController class])
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Search is not yet implemented" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        SHOW_STANDARD_ALERT(@"Alert", @"Search is not yet implemented", @"Ok", nil);
    }
}


#pragma mark GoEuroCalendarDelegate
-(void)DidGetSelectedDateStr:(NSString *)SelectedDateStr
{
    [_btn_Calendar_Date setTitle:SelectedDateStr forState:UIControlStateNormal];
}

#pragma mark -fill Destinations
-(void)FillDepartureTitleWithCurrentLocation:(NSString*)CurrentLocation
{
    [_btn_Departure_Place setTitle:CurrentLocation forState:UIControlStateNormal];
}

-(void)FillArrivalTitleWithCurrentLocation:(NSString*)CurrentLocation
{
    [_btn_Arrival_Place setTitle:CurrentLocation forState:UIControlStateNormal];
}

#pragma mark -SelectedResultsDelegate
-(void)DidSelectLocation:(CountryLocationModel*)SelectedLocation andType:(NSString*)Type
{
    if ([Type isEqualToString:@"Arrival"]) {
        [self FillArrivalTitleWithCurrentLocation:[NSString stringWithFormat:@"%@,%@",SelectedLocation.name,SelectedLocation.country]];
    }
    else
    {
        [self FillDepartureTitleWithCurrentLocation:[NSString stringWithFormat:@"%@,%@",SelectedLocation.name,SelectedLocation.country]];
    }
    //enble search button
    [self AdjustControllers];
}


#pragma mark fillData
-(BOOL)CheckIfAllDataFilled
{
    if (![_btn_Arrival_Place.titleLabel.text isEqualToString:@"To"]&&_btn_Arrival_Place.titleLabel.text.length > 0 &&![_btn_Departure_Place.titleLabel.text isEqualToString:@"From"]&&_btn_Departure_Place.titleLabel.text.length > 0 ) {
        return YES;

    }
    else
    {
        return NO;
    }
}


-(void)AdjustControllers
{
    [singleToneClassValues MaskviewWithRoundedCorners:_View_FieldsContainer withMaskValue:4 andBorderValue:1 andColor:CL_Main_blue];
    [singleToneClassValues MaskviewWithRoundedCorners:_btn_Calendar_Date withMaskValue:4 andBorderValue:1 andColor:CL_Main_blue];
    [singleToneClassValues MaskviewWithRoundedCorners:_btn_Arrival_Place withMaskValue:4 andBorderValue:1 andColor:CL_Main_blue];
    [singleToneClassValues MaskviewWithRoundedCorners:_btn_Departure_Place withMaskValue:4 andBorderValue:1 andColor:CL_Main_blue];
    [singleToneClassValues ChangeBtnFont:_btn_Seacrh size:20];
    [singleToneClassValues ChangeBtnFont:_btn_Calendar_Date size:16];
    [singleToneClassValues ChangeBtnFont:_btn_Arrival_Place size:16];
    [singleToneClassValues ChangeBtnFont:_btn_Departure_Place size:16];
    
    if ([self CheckIfAllDataFilled]) {
        [_btn_Seacrh setEnabled:YES];
        [singleToneClassValues MaskviewWithRoundedCorners:_btn_Seacrh withMaskValue:4 andBorderValue:1 andColor:CL_Main_blue];
        [_btn_Seacrh setTitleColor:CL_Main_blue forState:UIControlStateNormal];
    }
    else
    {
        [_btn_Seacrh setEnabled:NO];
        [singleToneClassValues MaskviewWithRoundedCorners:_btn_Seacrh withMaskValue:4 andBorderValue:1 andColor:[UIColor lightGrayColor]];
        [_btn_Seacrh setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"S_SearchLocations"])
    {
        UINavigationController *controller = (UINavigationController*)segue.destinationViewController;
        NSArray *viewControllers = controller.viewControllers;
        SearchResultsLocations *SearchResultsLocationsView = (SearchResultsLocations*)[viewControllers objectAtIndex:0];
        [SearchResultsLocationsView setType:sender];
        [SearchResultsLocationsView setDelegate:self];
    }
    else
    {
        UINavigationController *controller = (UINavigationController*)segue.destinationViewController;
        NSArray *viewControllers = controller.viewControllers;
        CalendarViewController *View_Calendar = (CalendarViewController*)[viewControllers objectAtIndex:0];
        [View_Calendar setDelegate:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
