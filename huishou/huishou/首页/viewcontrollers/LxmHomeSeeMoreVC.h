//
//  LxmHomeSeeMoreVC.h
//  huishou
//
//  Created by 李晓满 on 2020/3/17.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LxmHomeSeeMoreVC : BaseViewController

@property (nonatomic, strong) NSArray  <LxmHomeFirstTypeModel *>*list;/*所有分类*/

@property (nonatomic, strong) NSString *firstTypeID;

/**  */
@property(nonatomic , assign)BOOL isTab;

@end

NS_ASSUME_NONNULL_END
