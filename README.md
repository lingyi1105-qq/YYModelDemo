# YYModelDemo

YYModelDemo 是 [YYModel](https://github.com/ibireme/YYModel)  的 demo。

[YYModel](https://github.com/ibireme/YYModel)  是 高性能 iOS/OSX 模型转换框架。(该项目是 YYKit 组件之一)。

本 demo 示例演示如何使用  [YYModel](https://github.com/ibireme/YYModel)  的部分方法。



YYModel 引用自 [ibireme/YYModel: High performance model framework for iOS/OSX. (github.com)](https://github.com/ibireme/YYModel)



数据模型实例化方法： 

```objc
+ (nullable instancetype)yy_modelWithJSON:(id)json;
```

json 参数可以是  `NSDictionary`, `NSString` or `NSData`。示例：

```objc
DemoModel *info = [DemoModel yy_modelWithJSON:data];
```



Array 类型数据实例化方法：

```objc
+ (nullable NSArray *)yy_modelArrayWithClass:(Class)cls json:(id)json;
```

json 参数可以是 `NSArray`, `NSString` or `NSData`，示例：

```objc
NSArray *arr = [NSArray yy_modelArrayWithClass:DemoModel.class json:data];
```



实例转 JSON Object 方法：

```objc
- (nullable id)yy_modelToJSONObject;
```



实例转 NSData 方法：

```objc
- (nullable NSData *)yy_modelToJSONData;
```



实例转 JSON String 方法：

```objc
- (nullable NSString *)yy_modelToJSONString;
```

