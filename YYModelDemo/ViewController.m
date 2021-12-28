//
//  ViewController.m
//  YYModelDemo
//
//  Created by LarryZhang on 2021/12/27.
//

#import "ViewController.h"

#import "YYModel.h"
#import "DemoModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


- (IBAction)buttonAcion:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    NSString *title = [button titleForState:UIControlStateNormal];
    NSLog(@"title:%@", title);
    if (title == nil) {
        return;
    }
    
    if ([title isEqualToString:@"getListAll"]) {
        [self getListAll];
    } else if ([title isEqualToString:@"getListPage"]) {
        [self getListPage:2 size:5];
    } else if ([title isEqualToString:@"getListFilter"]) {
        [self getListFilter:@"name=LarryPage"];
    } else if ([title isEqualToString:@"getOneById"]) {
        [self getOneById:2];
    } else if ([title isEqualToString:@"Post"]) {
//        [self postList];
        [self postOneNamed:@"LarryPage"];
    } else if ([title isEqualToString:@"Put"]) {
        [self putOneById:2 named:@"LarryPage"];
    } else if ([title isEqualToString:@"Patch"]) {
        [self patchOneById:2];
    } else if ([title isEqualToString:@"Delete"]) {
        [self deleteOneById:25];
    }
    
}


- (void)getListAll {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", DemoModel.ServerAddress]]];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          if ([(NSHTTPURLResponse*)response statusCode] == 200) {
                                              NSArray *arr = [NSArray yy_modelArrayWithClass:DemoModel.class json:data];
                                              NSLog(@"%s succeese arr.count:%ld", __func__, arr.count);
                                              for (DemoModel *info in arr) {
                                                  NSLog(@"info:%@", info);
                                              }
                                          } else {
                                              NSLog(@"getListAll 数据请求失败%ld", (long)[(NSHTTPURLResponse*)response statusCode]);
                                          }
                                      }];
    
    [dataTask resume];
}

- (void)getListPage:(NSUInteger)page size:(NSUInteger)size {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?_page=%@&_limit=%@", DemoModel.ServerAddress, @(page), @(size)]]];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          if ([(NSHTTPURLResponse*)response statusCode] == 200) {
                                              NSArray *arr = [NSArray yy_modelArrayWithClass:DemoModel.class json:data];
                                              NSLog(@"%s succeese arr.count:%ld", __func__, arr.count);
                                              for (DemoModel *info in arr) {
                                                  NSLog(@"info:%@", info);
                                              }
                                          } else {
                                              NSLog(@"getListPage 数据请求失败%ld", (long)[(NSHTTPURLResponse*)response statusCode]);
                                          }
                                      }];
    
    [dataTask resume];
}

- (void)getListFilter:(NSString *)filter {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", DemoModel.ServerAddress, filter]]];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          if ([(NSHTTPURLResponse*)response statusCode] == 200) {
                                              NSArray *arr = [NSArray yy_modelArrayWithClass:DemoModel.class json:data];
                                              NSLog(@"%s succeese arr.count:%ld", __func__, arr.count);
                                              for (DemoModel *info in arr) {
                                                  NSLog(@"info:%@", info);
                                              }
                                          } else {
                                              NSLog(@"getListFilter 数据请求失败%ld", (long)[(NSHTTPURLResponse*)response statusCode]);
                                          }
                                      }];
    
    [dataTask resume];
}

- (void)getOneById:(NSUInteger)identity {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", DemoModel.ServerAddress, @(identity)]]];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          if ([(NSHTTPURLResponse*)response statusCode] == 200) {
                                              DemoModel *info = [DemoModel yy_modelWithJSON:data];
                                              NSLog(@"info:%@", info);
                                          } else {
                                              NSLog(@"getOneById 数据请求失败%ld", (long)[(NSHTTPURLResponse*)response statusCode]);
                                          }
                                      }];
    
    [dataTask resume];
}

- (void)postList {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", DemoModel.ServerAddress]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSMutableArray *list = [NSMutableArray array];
    for (int i=1; i<8; i++) {
        DemoModel *info = [DemoModel new];
        info.name = [NSString stringWithFormat:@"LarryPage-%02x", i];
        info.media = [NSString stringWithFormat:@"media.mp%d", i];
        info.content = [NSString stringWithFormat:@"content-%02x plan", i];
        [list addObject:info];
    }
    
    NSString *value = [list yy_modelToJSONString];
    [request setHTTPBody:[value dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          if ([(NSHTTPURLResponse*)response statusCode] == 200 || [(NSHTTPURLResponse*)response statusCode] == 201) {
                                              DemoModel *info = [DemoModel yy_modelWithJSON:data];
                                              NSLog(@"info:%@", info);
                                          } else {
                                              NSLog(@"postList 数据请求失败%ld", (long)[(NSHTTPURLResponse*)response statusCode]);
                                          }
                                      }];
    
    [dataTask resume];
}

- (void)postOneNamed:(NSString *)name {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", DemoModel.ServerAddress]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    DemoModel *info = [DemoModel new];
    info.name = name;
    info.media = [name stringByAppendingString:@"media.mp1"];
    info.content = [name stringByAppendingString:@"content plan1"];
    
    NSString *value = [info yy_modelToJSONString];
    [request setHTTPBody:[value dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          if ([(NSHTTPURLResponse*)response statusCode] == 200 || [(NSHTTPURLResponse*)response statusCode] == 201) {
                                              DemoModel *info = [DemoModel yy_modelWithJSON:data];
                                              NSLog(@"info:%@", info);
                                          } else {
                                              NSLog(@"postOneById 数据请求失败%ld", (long)[(NSHTTPURLResponse*)response statusCode]);
                                          }
                                      }];
    
    [dataTask resume];
}

- (void)putOneById:(NSUInteger)identity named:(NSString *)name {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", DemoModel.ServerAddress, @(identity)]]];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    DemoModel *info = [DemoModel new];
    info.name = name;
    info.media = [name stringByAppendingString:@"-media"];
    
    NSString *value = [info yy_modelToJSONString];
    [request setHTTPBody:[value dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          if ([(NSHTTPURLResponse*)response statusCode] == 200) {
                                              DemoModel *info = [DemoModel yy_modelWithJSON:data];
                                              NSLog(@"info:%@", info);
                                          } else {
                                              NSLog(@"putOneById 数据请求失败%ld", (long)[(NSHTTPURLResponse*)response statusCode]);
                                          }
                                      }];
    
    [dataTask resume];
}

- (void)patchOneById:(NSUInteger)identity {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", DemoModel.ServerAddress, @(identity)]]];
    [request setHTTPMethod:@"PATCH"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    DemoModel *info = [DemoModel new];
    info.media = @"media.mp8";
    info.content = @"content cnn";
    
    NSString *value = [info yy_modelToJSONString];
    [request setHTTPBody:[value dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          if ([(NSHTTPURLResponse*)response statusCode] == 200) {
                                              DemoModel *info = [DemoModel yy_modelWithJSON:data];
                                              NSLog(@"info:%@", info);
                                          } else {
                                              NSLog(@"patchOneById 数据请求失败%ld", (long)[(NSHTTPURLResponse*)response statusCode]);
                                          }
                                      }];
    
    [dataTask resume];
}

- (void)deleteOneById:(NSUInteger)identity {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", DemoModel.ServerAddress, @(identity)]]];
    [request setHTTPMethod:@"DELETE"];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                     completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          if ([(NSHTTPURLResponse*)response statusCode] == 200) {
                                              NSLog(@"data:%@", data);
                                          } else {
                                              NSLog(@"deleteOneById 数据请求失败%ld", (long)[(NSHTTPURLResponse*)response statusCode]);
                                          }
                                      }];
    // 使用resume方法启动任务
    [dataTask resume];
}


@end
