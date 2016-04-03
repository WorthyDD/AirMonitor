//
//  AQIIndex.m
//  AirMonitor
//
//  Created by 武淅 段 on 16/3/26.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "AQIIndex.h"

@implementation AQIIndex



- (void)setLevel:(NSInteger)level
{
    _level = level;
    if(level <= _level3){
        self.colorStr = @"#b3ee3a";
        if(level <= _level1){
            _rank = 1;
        }
        else if(level <= _level2){
            _rank = 2;
        }
        else{
            _rank = 3;
        }
        
    }
    else if(level <= _level6){
        self.colorStr = @"#ee9a00";
        
        if(level <= _level4){
            _rank = 4;
        }
        else if(level <= _level5){
            _rank = 5;
        }
        else{
            _rank = 6;
        }
    }
    else if(level < _level9){
        self.colorStr = @"#ee0000";
        
        if(level <= 7){
            _rank = 7;
        }
        else if(level <= _level8){
            _rank = 8;
        }
        else{
            _rank = 9;
        }
    }
    else{
        self.colorStr = @"#d15fee";
        _rank = 10;
    }
}
@end
