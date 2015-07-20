//
//  App.m
//  aixianmian
//
//  Created by qianfeng on 15-7-8.
//  Copyright (c) 2015年 CenYaLei. All rights reserved.
//

#import "App.h"

@implementation App

+(id)appWithDict:(NSDictionary *)dict
{

    return [[self alloc]initWithDict:dict];
}

-(id)initWithDict:(NSDictionary *)dict
{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
//重写forUndefinedKey的方法，获得没有声明的key值，与value值，将他们转存到其他属性中去
//这个方法用来解决后台数据字段与model关键字冲突的问题
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqualToString:@"description"]) {
        self.descript = value;
    }

}

-(NSString *)description
{

    return [NSString stringWithFormat:@"%@",_descript];

}

@end
