//
//  CalendarViewController.m
//  GoEuro
//
//  Created by Zak on 6/12/16.
//  Copyright © 2016 Zak. All rights reserved.
//

#import "CalendarViewController.h"
#import "singleToneClassValues.h"


@interface CalendarViewController ()
{
    NSString *SelectedDateStr;
}
@property(nonatomic,strong)IBOutlet UILabel *lbl_title;
@property(nonatomic,strong)IBOutlet UIButton *btn_Done;
@end

@implementation CalendarViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addMenuButtons];
    [self AdjustControllers];
    [self addingCalndar];
    self.title=@"Choose Date";
}

#pragma mark -Adding Calendar View
-(void)addingCalndar
{
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    // Create a min and max date for limit the calendar, optional
    [self createMinAndMaxDate];
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:_todayDate];
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

#pragma date selection confirmation
- (IBAction)ConfirmSelectedDate:(id)sender {
    if (!_dateSelected) {
        [_delegate DidGetSelectedDateStr:[singleToneClassValues GetSelectedDateStrFromDate:[NSDate date]]];
    }
    else
    {
        [_delegate DidGetSelectedDateStr:[singleToneClassValues GetSelectedDateStrFromDate:_dateSelected]];
    }
    [self CloseView:nil];
}
#pragma mark - Buttons callback
- (IBAction)didGoTodayTouch
{
    [_calendarManager setDate:_todayDate];
}

- (IBAction)didChangeModeTouch
{
    _calendarManager.settings.weekModeEnabled = !_calendarManager.settings.weekModeEnabled;
    [_calendarManager reload];
    
    CGFloat newHeight = 300;
    if(_calendarManager.settings.weekModeEnabled){
        newHeight = 85.;
    }
    
    self.calendarContentViewHeight.constant = newHeight;
    [self.view layoutIfNeeded];
}

#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = CL_Main_blue_light;
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = CL_Main_blue;
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = CL_Main_blue;
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

#pragma mark - CalendarManager delegate - Page mangement

// Used to limit the date for the calendar, optional
- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date
{
    return [_calendarManager.dateHelper date:date isEqualOrAfter:_minDate andEqualOrBefore:_maxDate];
}

- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Next page loaded");
}

- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Previous page loaded");
}


- (void)createMinAndMaxDate
{
    _todayDate = [NSDate date];
    
    // Min date will be 2 month before today
    _minDate = [_calendarManager.dateHelper addToDate:_todayDate months:0];
    
    // Max date will be 2 month after today
    _maxDate = [_calendarManager.dateHelper addToDate:_todayDate months:12];
}

// Used only to have a key for _eventsByDate
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

#pragma mark AdjustController
-(void)AdjustControllers
{
    [singleToneClassValues ChangeFont:_lbl_title size:16];
    [singleToneClassValues MaskviewWithRoundedCorners:_btn_Done withMaskValue:4 andBorderValue:1 andColor:CL_Main_blue];
    [singleToneClassValues ChangeBtnFont:_btn_Done size:20];
}



@end

