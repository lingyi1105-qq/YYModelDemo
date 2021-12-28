//
//  DemoModel.h
//  YYModelDemo
//
//  Created by LarryZhang on 2021/12/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 在线Api接口生成
 https://retool.com/api-generator/?ref=producthunt
 设计数据模型后，Generate API 生成 Endpoint URL，将 URL 替换 ServerAddress
 */

@interface DemoModel : NSObject
//"id": 1,
//"name": "Delphinia Veare",
//"media": "image.jpg",
//"content": "Enterprise Plan"

@property (nonatomic, strong) NSNumber *id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *media;

@property (nonatomic, copy) NSString *content;


+ (NSString *)ServerAddress;

@end

NS_ASSUME_NONNULL_END
