//
//  QYZJLocationTool.h
//  QYZJAPP
//
//  Created by zk on 2019/11/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
NS_ASSUME_NONNULL_BEGIN

@interface QYZJLocationTool : NSObject
- (void)locationAction;
@property(nonatomic,copy)void(^locationBlock)(NSString *cityStr,NSString * cityID,NSString *province);
@end

NS_ASSUME_NONNULL_END
