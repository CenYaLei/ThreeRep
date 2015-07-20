//
//  App.h
//  aixianmian
//
//  Created by qianfeng on 15-7-8.
//  Copyright (c) 2015年 CenYaLei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface App : NSObject
//每个属性代表的意义应该在公司的接口文档中有详细的描述
//不应该是程序员意淫的
/**
 *  应用id
 */
@property (nonatomic,copy)NSString * applicationId;
/**
 *  应用英文名称
 */
@property (nonatomic,copy)NSString * slug;
/**
 *  应用中文名称
 */
@property (nonatomic,copy)NSString * name;
/**
 *  发布时间
 */
@property (nonatomic,copy)NSString * releaseDate;
/**
 *  版本
 */
@property (nonatomic,copy)NSString * version;

//@property (nonatomic,copy)NSString * description;
/**
 *  应用描述
 */
@property (nonatomic,copy)NSString * descript;
/**
 *  分类ID
 */
@property (nonatomic,copy)NSString * categoryId;
/**
 *  分类名称
 */
@property (nonatomic,copy)NSString * categoryName;

@property (nonatomic,copy)NSString * iconUrl;

@property (nonatomic,copy)NSString * itunesUrl;

@property (nonatomic,copy)NSString * starCurrent;

@property (nonatomic,copy)NSString * starOverall;

@property (nonatomic,copy)NSString * ratingOverall;

@property (nonatomic,copy)NSString * downloads;

@property (nonatomic,copy)NSString * currentPrice;

@property (nonatomic,copy)NSString * lastPrice;

@property (nonatomic,copy)NSString * priceTrend;

@property (nonatomic,copy)NSString * expireDatetime;

@property (nonatomic,copy)NSString * releaseNotes;

@property (nonatomic,copy)NSString * updateDate;

@property (nonatomic,copy)NSString * fileSize;

@property (nonatomic,copy)NSString * ipa;

@property (nonatomic,copy)NSString * shares;

@property (nonatomic,copy)NSString * favorites;


/**
 *  app模型的类方法
 *
 *  @param dict <#dict description#>
 *
 *  @return <#return value description#>
 *
 *  @exception <#exception description#>
 */
+(id)appWithDict:(NSDictionary *)dict;
/**
 *  构造方法
 *
 *  @param dict <#dict description#>
 *
 *  @return <#return value description#>
 *
 *  @exception <#exception description#>
 */
-(id)initWithDict:(NSDictionary *)dict;


@end
