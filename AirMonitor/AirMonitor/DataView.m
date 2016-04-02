//
//  DataView.m
//  AirMonitor
//
//  Created by 武淅 段 on 16/3/26.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "DataView.h"

#define MAX_LEVEL 1200

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define HEIGHT self.bounds.size.height
#define WIDTH self.bounds.size.width


@interface DataView()

@property (nonatomic) NSMutableArray *chartViews;
@property (nonatomic) NSMutableArray *stringLabels;
@property (nonatomic, assign) NSInteger viewNum;
@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic) UILabel *dateLabel;

@end

@implementation DataView


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    if(!_dateLabel){
        _dateLabel = [[UILabel alloc]init];
        [_dateLabel setFont:[UIFont systemFontOfSize:18.0]];
        [_dateLabel setTextColor:[UIColor colorWithRGB:0xffffff alpha:0.7]];
        [_dateLabel setTextAlignment:NSTextAlignmentCenter];
//        _dateLabel.size = CGSizeMake(100, 30);
        _dateLabel.center = CGPointMake(SCREEN_WIDTH/2.0, 20);
        [self addSubview:_dateLabel];
    }
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self initChartViews];
    [self updateUI];

}


- (void) initChartViews
{
    
    CGFloat horMargin = 10.0;
    CGFloat bottom = 30.0;
    if(!_chartViews){
        _chartViews = [[NSMutableArray alloc]init];
        NSInteger num = 0;
        switch (_dataType) {
            case DataTypeHour:
                num = 24;
                break;
            case DataTypeDay:
                num = 31;
                break;
            case DataTypeMonth:
                num = 12*4;
                break;
            default:
                break;
        }
        
        if(_dataType != DataTypeMonth){
            CGFloat width = (SCREEN_WIDTH-horMargin*2)/num;
            _viewNum = num;
            _viewWidth = width;
            for(int i = 0; i < num ;i++){
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(horMargin+i*width, HEIGHT-bottom, width, 0)];
                [_chartViews addObject:view];
                [self addSubview:view];
                
                
            }
        }
        
        else{
            CGFloat width = (SCREEN_WIDTH-horMargin*2)/12.0;
            for(int i = 0; i < 12;i++){
                
                UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(horMargin+i*width, HEIGHT-bottom, width, 0)];
                UIView *v2 = [[UIView alloc]initWithFrame:CGRectMake(horMargin+i*width, HEIGHT-bottom, width, 0)];
                UIView *v3 = [[UIView alloc]initWithFrame:CGRectMake(horMargin+i*width, HEIGHT-bottom, width, 0)];
                UIView *v4 = [[UIView alloc]initWithFrame:CGRectMake(horMargin+i*width, HEIGHT-bottom, width, 0)];
                [v1 setBackgroundColor:[UIColor colorWithRGB:0xb3ee3a]];
                [v2 setBackgroundColor:[UIColor colorWithRGB:0xee9a00]];
                [v3 setBackgroundColor:[UIColor colorWithRGB:0xee0000]];
                [v4 setBackgroundColor:[UIColor colorWithRGB:0xd15fee]];
                [_chartViews addObject:v1];
                [_chartViews addObject:v2];
                [_chartViews addObject:v3];
                [_chartViews addObject:v4];
                [self addSubview:v1];
                [self addSubview:v2];
                [self addSubview:v3];
                [self addSubview:v4];
            }
        }
        
    }
}

- (void)setDataType:(DataType)dataType
{
    _dataType = dataType;
    if(dataType ==DataTypeHour){
        
        
    }
    else if(dataType == DataTypeDay){
        
    }
    else{
        
    }
}

- (void)setAqiType:(AQIType)aqiType
{
    _aqiType = aqiType;

    [self setNeedsDisplay];
    [self updateUI];
    
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self updateUI];
}

- (void)setMonthArray:(NSArray *)monthArray
{
    _monthArray = monthArray;
    [self updateUI];
}

- (void) updateUI{
    if(_dataArray){
        if(_dataType != DataTypeMonth){
            
            CGFloat num = _dataType == DataTypeHour ? 24.0 : 31.0;
            CGFloat hor = 10;
            CGFloat bottom = 30;
            CGFloat width = (SCREEN_WIDTH-hor*2)/num;
            
            for(int i = 0; i < _dataArray.count; i++){
                
                AQIIndexCollection *collection = _dataArray[i];
                AQIIndex *aqi;
                switch (_aqiType) {
                    case AQI:
                        aqi = collection.mainAQI;
                        break;
                    case PM25:
                        aqi = collection.PM25;
                        break;
                    case PM10:
                        aqi = collection.PM10;
                        break;
                    case O3:
                        aqi = collection.O3;
                        break;
                    case NO2:
                        aqi = collection.NO2;
                        break;
                    case SO2:
                        aqi = collection.SO2;
                        break;
                    default:
                        break;
                }
                
                CGFloat MAX = 0;
                if(_aqiType == PM10 || _aqiType == O3 || _aqiType == PM25){
                    MAX = 300.0;
                }
                else{
                    MAX = 1000.0;
                }
                
                CGFloat height = (HEIGHT-100-bottom)*(aqi.level/(float)MAX);
                UIView *view = _chartViews[i];
                
                
                //                __weak typeof(self) WeakSelf = self;
                
               // NSLog(@"1--i--  %d",i);
                //NSLog(@"1-size of dataArray %ld",_dataArray.count);
                [UIView animateWithDuration:1.0 animations:^{
                    
                   // NSLog(@"2--i--  %d",i);
                   // NSLog(@"2-size of dataArray %ld",_dataArray.count);
                    view.frame = CGRectMake(hor+i*width+1, HEIGHT-bottom-height, width-2, height);
                    [view setBackgroundColor:[UIColor colorWithHexString:aqi.colorStr]];
                    
                } completion:^(BOOL finished) {
                    
                }];
            }
            
        
            for(int i = (int)_dataArray.count;i < _chartViews.count;i++){
                UIView *v = _chartViews[i];
                [UIView animateWithDuration:1.0 animations:^{
                   
                    v.size = CGSizeMake(width, 0);
                }];
            }
            
            //update num label
            CGFloat MAX = 0;
            if(_aqiType == PM10 || _aqiType == O3 || _aqiType == PM25){
                MAX = 300.0;
            }
            else{
                MAX = 1000.0;
            }
            if(_stringLabels){
                for(int i = 0; i<_stringLabels.count;i++){
                    
                    UILabel *label = _stringLabels[i];
                    NSString *num = [NSString stringWithFormat:@"%.1f", (float)(MAX - i*(MAX/10.0))];
                    [label setText:num];
                }
            }
        }
    }
    
    if(_dataType == DataTypeMonth && _monthArray){
        
        CGFloat hor = 10;
        CGFloat bottom = 30;
        CGFloat width = (SCREEN_WIDTH-hor*2)/12;
        for(int i = 0; i < _monthArray.count/4;i++){
            
            int a = ((NSNumber *)_monthArray[4*i]).intValue;
            int b = ((NSNumber *)_monthArray[4*i+1]).intValue;
            int c = ((NSNumber *)_monthArray[4*i+2]).intValue;
            int d = ((NSNumber *)_monthArray[4*i+3]).intValue;
            UIView *v1 = _chartViews[4*i];
            UIView *v2 = _chartViews[4*i+1];
            UIView *v3 = _chartViews[4*i+2];
            UIView *v4 = _chartViews[4*i+3];
            
           
            CGFloat height1 = (HEIGHT-100-bottom)*(a/100.0);
            CGFloat height2 = (HEIGHT-100-bottom)*(b/100.0);
            CGFloat height3 = (HEIGHT-100-bottom)*(c/100.0);
            CGFloat height4 = (HEIGHT-100-bottom)*(d/100.0);

            [UIView animateWithDuration:1.0 animations:^{
               
                v1.frame = CGRectMake(hor+i*width+2, HEIGHT-30-height1, width-2, height1);
                v2.frame = CGRectMake(hor+i*width+2, HEIGHT-30-height1-height2, width-2, height2);
                v3.frame = CGRectMake(hor+i*width+2, HEIGHT-30-height1-height2-height3, width-2, height3);
                v4.frame = CGRectMake(hor+i*width+2, HEIGHT-30-height1-height2-height3-height4, width-2, height4);
            }];
            
        }
        
        for(int i = (int)_monthArray.count;i < 48;i++){
            UIView *view = _chartViews[i];
            
            [UIView animateWithDuration:1.0 animations:^{
                view.size = CGSizeMake(width, 0);    
            }];
            
        }
    }
    
    if(_dateString){
        [_dateLabel setText:_dateString];
        [_dateLabel sizeToFit];
        _dateLabel.center = CGPointMake(SCREEN_WIDTH/2.0, 20);
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if(_dataType != DataTypeMonth){
        
        CGFloat MAX = 1000.0;
        if(!_stringLabels){
            
            _stringLabels = [[NSMutableArray alloc]init];
            for(int i = 0;i < 10;i++){
                
                CGFloat y = 100+i*((HEIGHT-100-30)/10.0);
                CGFloat height = 20;
                NSString *num = [NSString stringWithFormat:@"%.1f", (float)(MAX - i*(MAX/10.0))];
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, y-height, 50, height)];
                [label setTextColor:[UIColor colorWithWhite:1.0 alpha:0.7]];
                [label setFont:[UIFont systemFontOfSize:14.0]];
                [label setText:num];
                [self addSubview:label];
                [_stringLabels addObject:label];
            }
            
        }
        
        
        CGContextSetRGBStrokeColor(context, 1, 1, 1, 0.2);
        for(int i = 0; i < 10;i++){
            
            CGFloat y = 100+i*((HEIGHT-100-30)/10.0);
            CGContextMoveToPoint(context, 0, y);
            CGContextAddLineToPoint(context, WIDTH, y);
        //    CGContextStrokePath(context);
           // NSString *num = [NSString stringWithFormat:@"%.1f", (float)(MAX_LEVEL - i*(MAX_LEVEL/10.0))];
        }
        
        NSLog(@"2-height %f", HEIGHT);
        CGContextMoveToPoint(context, 0, HEIGHT-30);
        CGContextAddLineToPoint(context, WIDTH, HEIGHT-30);
        CGContextStrokePath(context);
        
        
        if(_dataType == DataTypeHour){
            
            CGFloat width = (SCREEN_WIDTH-20)/24.0;
            for(int i = 0;i < 23;i+=2){
                NSString *hour = [NSString stringWithFormat:@"%d",i];
                UIColor *color = [UIColor colorWithWhite:1.0 alpha:0.7];
                UIFont *font = [UIFont systemFontOfSize:13.0f];
                [hour drawAtPoint:CGPointMake(10+width*i, HEIGHT-30) withAttributes:@{NSForegroundColorAttributeName : color,
                                                                                   NSFontAttributeName : font}];
            }
        }
        else{
            CGFloat width = (SCREEN_WIDTH-20)/31.0;
            for(int i = 1;i <= 31;i+=2){
                NSString *day = [NSString stringWithFormat:@"%d",i];
                UIColor *color = [UIColor colorWithWhite:1.0 alpha:0.7];
                UIFont *font = [UIFont systemFontOfSize:13.0f];
                [day drawAtPoint:CGPointMake(10+width*(i-1), HEIGHT-30) withAttributes:@{NSForegroundColorAttributeName : color,
                                                                                      NSFontAttributeName : font}];
            }
        }
        
    }
    else{
        CGContextSetRGBStrokeColor(context, 1, 1, 1, 0.6);
        CGContextMoveToPoint(context, 0, 100);
        CGContextAddLineToPoint(context, WIDTH, 100);
        CGContextMoveToPoint(context, 0, HEIGHT-30);
        CGContextAddLineToPoint(context, WIDTH, HEIGHT-30);
        CGContextStrokePath(context);
        CGFloat width = (SCREEN_WIDTH-20)/12.0;
        for(int i = 1;i <= 12;i++){
            NSString *month = [NSString stringWithFormat:@"%d",i];
            UIColor *color = [UIColor colorWithWhite:1.0 alpha:0.7];
            UIFont *font = [UIFont systemFontOfSize:13.0f];
            [month drawAtPoint:CGPointMake(10+width*(i-1), HEIGHT-30) withAttributes:@{NSForegroundColorAttributeName : color,
                                                                                     NSFontAttributeName : font}];
        }
    }
}

@end
