//
//  QYZJCityChooseTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJCityChooseTVC.h"
#import <CoreLocation/CoreLocation.h>
#import "zkPickModel.h"
@interface QYZJCityChooseTVC ()<CLLocationManagerDelegate,UISearchBarDelegate>
@property(nonatomic,strong)NSMutableDictionary *dataDict;
@property(nonatomic,strong)NSMutableArray *rightDataArr;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *dataArray;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *userCityList;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *searchList;
@property(nonatomic,strong)UIView *headView,*cityView;
@property(nonatomic,assign)BOOL isSearch;
@property(nonatomic,strong)UIButton *addressBt;
@property(nonatomic,strong)NSString *cityID,*cityStr;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *cityListArr;

//定位管理
@property (nonatomic, strong) CLLocationManager* locationManager;

@end

@implementation QYZJCityChooseTVC
- (NSMutableDictionary *)dataDict {
    if (_dataDict == nil) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}

- (NSMutableArray *)rightDataArr {
    if (_rightDataArr == nil) {
        _rightDataArr = [NSMutableArray array];
    }
    return _rightDataArr;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择城市";
    self.userCityList = @[].mutableCopy;
    self.dataArray = @[].mutableCopy;
    self.searchList = @[].mutableCopy;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addheadView];;
    
 
    [self findMe];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"City" ofType:@"plist"];
           
           NSArray *provinceArray = [[NSArray alloc] initWithContentsOfFile:path];
    
    NSArray<zkPickModel *> * provincesArr = [zkPickModel mj_objectArrayWithKeyValuesArray:provinceArray];
    
    for (zkPickModel *model  in provincesArr) {
        for (zkPickModel * mm  in model.citys) {
            [self.dataArray addObject: mm];
            
        }
    }
    [self paiXunAction];
    

    
}



- (void)addheadView {
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    self.headView.backgroundColor = [UIColor whiteColor];
    
    UIView * gayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    gayView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.headView addSubview:gayView];
    
    UISearchBar * searchbar =[[UISearchBar alloc] initWithFrame:CGRectMake(20, 10, ScreenW - 40, 30)];
    searchbar.placeholder = @"搜索城市";
    searchbar.layer.cornerRadius = 8;
    searchbar.clipsToBounds = YES;
    searchbar.barStyle=UIBarStyleDefault;
    [gayView addSubview:searchbar];
    [searchbar setBarTintColor:[UIColor groupTableViewBackgroundColor]];
    
    searchbar.delegate = self;
    
//    [searchbar.searchTextField.rac_textSignal  subscribeNext:^(NSString * _Nullable x) {
//       //文字发生改变时
//        if (x.length > 0) {
//            self.isSearch = YES;
//            [self searchAction:x];
//        }else {
//            self.isSearch = NO;
//            [self.tableView reloadData];
//        }
//
//
//    }];
    self.tableView.tableHeaderView = self.headView;
    searchbar.backgroundImage = [self imageWithColor:[UIColor groupTableViewBackgroundColor] size:CGSizeMake(1,1)];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(gayView.frame)+5, ScreenW-30, 20)];
    label.textColor = CharacterGrayColor;
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"定位城市";
    [self.headView addSubview:label];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame) + 5, ScreenW - 20, 25)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button setImage:[UIImage imageNamed:@"local"] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setTitle:@"定位中..." forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:button];
    self.addressBt = button;
    
    self.headView.mj_h = CGRectGetMaxY(button.frame)+5;
    self.tableView.tableHeaderView = self.headView;
    
//    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(button.frame)+5, ScreenW-30, 20)];
//    label1.textColor = CharacterGrayColor;
//    label1.font = [UIFont systemFontOfSize:15];
//    label1.text = @"切换城市";
//    [self.headView addSubview:label1];
//
//    self.cityView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame)+5, ScreenW, 20)];
//    [self.headView addSubview:self.cityView];
    
 
}

//点击定位城市
- (void)clickAction:(UIButton *)button {
   // self.cityStr  // 定位城市的城市名字
    
    if (self.clickCityBlock != nil) {
           self.clickCityBlock(self.cityStr, @"123");
           [self.navigationController popViewControllerAnimated:YES];
       }
    
    

}


- (void)findMe
{

    
    if ([CLLocationManager locationServicesEnabled]) {
        // 初始化定位管理器
        self.locationManager=[[CLLocationManager alloc]init];
        self.locationManager.distanceFilter = 10.0f;
        self.locationManager.delegate=self;
        // 设置定位精确度到千米
        self.locationManager.desiredAccuracy=kCLLocationAccuracyHundredMeters;
        // 设置过滤器为无
        self.locationManager.distanceFilter=kCLDistanceFilterNone;
        //这句话ios8以上版本使用
        [ self.locationManager requestAlwaysAuthorization];
        //开始定位
        [ self.locationManager startUpdatingLocation];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法定位" message:@"请检查你的设备是否开启定位功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    
    
    //根据经纬度反向地理编译出地址信息
       CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
       
       [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
           
           for (CLPlacemark * placemark in placemarks) {
               
               NSDictionary *address = [placemark addressDictionary];
               
               //  Country(国家)  State(省)  City（市）
               NSLog(@"#####%@",address);
               
               NSLog(@"%@", [address objectForKey:@"Country"]);
               
               NSLog(@"%@", [address objectForKey:@"State"]);
               
               NSLog(@"%@", [address objectForKey:@"City"]);
              
               [self.addressBt setTitle:[address objectForKey:@"City"] forState:UIControlStateNormal];
               self.cityStr = [NSString stringWithFormat:@"%@",[address objectForKey:@"City"]];
               
               
           }
           
       }];
    
    // 2.停止定位
    [manager stopUpdatingLocation];
}

- (void)sendCity {
    
    
//    if (self.clickCityBlock != nil) {
//        self.clickCityBlock(self.cityStr, @"123");
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    
//    for (zkPickModel * model  in self.cityListArr) {
//        if ([self.cityStr isEqualToString:model.name]) {
//            self.cityID = model.ID;
//        }
//    }
    
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}



//搜索
- (void)searchAction:(NSString *)text{
    [self.searchList removeAllObjects];
    for (zkPickModel * model  in self.dataArray) {
        if ([model.name containsString:text]) {
            [self.searchList addObject:model];
        }
    }
    
    [self.tableView reloadData];

}

- (void)setBiaoQianWithArr:(NSArray<zkPickModel *> *)arr {

    [self.cityView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (arr.count == 0) {
        self.cityView.mj_h = 0;
        self.headView.mj_h = CGRectGetMaxY(self.cityView.frame) + 10;
        self.tableView.tableHeaderView = self.headView;
        return;
    }
    
    CGFloat spaceX  = 15;
    CGFloat spaceY  = 20;
    CGFloat ww = (ScreenW - 30 -10- 3 * spaceX) / 4;
    CGFloat hh = 35;
    for (int i = 0;i< arr.count; i++) {
        UIButton * newProductBTBT = [[UIButton alloc] initWithFrame:CGRectMake(15 + (spaceX + ww) * (i%4) ,10 +(spaceY + hh) * (i/4), ww, hh)];
        [newProductBTBT setBackgroundImage:[UIImage imageNamed:@"kuang"] forState:UIControlStateNormal];
        [newProductBTBT setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateSelected];
        newProductBTBT.tag = i+1000;
        newProductBTBT.titleLabel.font = [UIFont systemFontOfSize:14];
        newProductBTBT.layer.cornerRadius = 4;
        newProductBTBT.clipsToBounds = YES;
        [newProductBTBT setTitleColor:CharacterGrayColor forState:UIControlStateNormal];
//        newProductBTBT.layer.cornerRadius = 3;
//        newProductBTBT.layer.borderWidth = 1;
//        newProductBTBT.layer.borderColor = CharacterBlack112.CGColor;
        newProductBTBT.clipsToBounds = YES;
        [newProductBTBT setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [newProductBTBT setTitle:arr[i].name forState:UIControlStateNormal];
        [self.cityView addSubview:newProductBTBT];
        [newProductBTBT addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton * delectBt = [[UIButton alloc] initWithFrame:CGRectMake(15 + (spaceX + ww) * (i%4) + ww - 7.5 ,10  + (spaceY + hh) * (i/4) - 7.5 , 15, 15)];
        [delectBt setBackgroundImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];
        delectBt.tag = 100+i;
        [delectBt addTarget:self action:@selector(delectCity:) forControlEvents:UIControlEventTouchUpInside];
        [self.cityView addSubview:delectBt];
        if (i+1 == arr.count) {
            self.cityView.mj_h = 20 + newProductBTBT.mj_y + hh;
            self.headView.mj_h = CGRectGetMaxY(self.cityView.frame) + 10;
        }
        if (i == 0) {
            newProductBTBT.selected = YES;
        }

    }
    self.tableView.tableHeaderView = self.headView;
}


#pragma mark---- 点击切换城市的城市 -------
- (void)selectAction:(UIButton *)button {
    
//    [self addCityAction:self.userCityList[button.tag - 1000].ID cityStr:self.userCityList[button.tag - 1000].name];
    
    [self getCityIsOpenWithCityID:self.userCityList[button.tag - 1000].ID withCityStr:self.userCityList[button.tag - 1000].name];
    
    
    
    
    
    
}





- (void)getCityIsOpenWithCityID:(NSString *)cityID withCityStr:(NSString *)cityStr{
    
    
   
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isSearch) {
        return 1;
    }
    return self.rightDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isSearch) {
        return self.searchList.count;
    }
    NSMutableArray * arr = self.dataDict[self.rightDataArr[section]];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.isSearch) {
        zkPickModel * model = self.searchList[indexPath.row];
        cell.textLabel.text = model.name;
    }else {
       zkPickModel * model = [self.dataDict[self.rightDataArr[indexPath.section]] objectAtIndex:indexPath.row];
       cell.textLabel.text = model.name;
    }
    
    
   
   
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
    
}


/**每一组的标题*/
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.isSearch) {
        return nil;
    }
    return self.rightDataArr[section];
}

/** 右侧索引列表*/
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{    
    if (self.isSearch) {
        return @[];
    }
    return self.rightDataArr;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.isSearch) {
        return 0.01;;
    }
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 50)];
        lb.font = [UIFont systemFontOfSize:14];
        [view addSubview:lb];
        lb.tag = 100;
    }
    
    UILabel * lb = (UILabel *)[view viewWithTag:100];
    lb.text = self.rightDataArr[section];
    view.clipsToBounds = YES;
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.isSearch) {
        zkPickModel * model = self.searchList[indexPath.row];
//        [self addCityAction:model.ID cityStr:model.name];
        [self getCityIsOpenWithCityID:model.ID withCityStr:model.name];
        
        if (self.clickCityBlock != nil) {
            self.clickCityBlock(model.name, @"123");
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }else {
        zkPickModel * model = [self.dataDict[self.rightDataArr[indexPath.section]] objectAtIndex:indexPath.row];
         if (self.clickCityBlock != nil) {
            self.clickCityBlock(model.name, @"123");
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    
}




//排序
- (void)paiXunAction {
    for (int i = 0 ; i < self.dataArray.count; i++) {
        if (self.dataArray[i]) {
            //将取出的名字转换成字母
            NSMutableString *pinyin = [self.dataArray[i].name mutableCopy];
            CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
            CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
            /*多音字处理*/
            NSString * firstStr = [self.dataArray[i].name substringToIndex:1];
            if ([firstStr compare:@"长"] == NSOrderedSame)
            {
                if (pinyin.length>=5)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chang"];
                }
            }
            else if ([firstStr compare:@"沈"] == NSOrderedSame)
            {
                if (pinyin.length>=4)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 4) withString:@"shen"];
                }
            }
            else if ([firstStr compare:@"厦"] == NSOrderedSame)
            {
                if (pinyin.length>=3)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 3) withString:@"xia"];
                }
            }
            else if ([firstStr compare:@"地"] == NSOrderedSame)
            {
                if (pinyin.length>=3)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 3) withString:@"di"];
                }
            }
            else if ([firstStr compare:@"重"] == NSOrderedSame)
            {
                if (pinyin.length>=5)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
                }
            }
            //将拼音转换成大写拼音
            NSString * upPinyin = [pinyin uppercaseString];
            //取出第一个首字母当做字典的key
            NSString * firstChar = [upPinyin substringToIndex:1];
            NSMutableArray * arr = [self.dataDict objectForKey:firstChar];
            if (!arr)
            {
                arr = [NSMutableArray array];
                [_dataDict setObject:arr forKey:firstChar];
            }
            [arr addObject:self.dataArray[i]];
        }
        else
        {
            NSMutableArray * arr = [self.dataDict objectForKey:@"#"];
            if (!arr)
            {
                arr = [NSMutableArray array];
                [self.dataDict setObject:arr forKey:@"#"];
            }
            [arr addObject:self.dataArray[i]];
        }
    }
    
    self.rightDataArr = [self paixuArrWithArr:self.dataDict.allKeys].mutableCopy;
    if (self.rightDataArr.count > 0 && [[self.rightDataArr firstObject] isEqualToString:@"#"]) {
        [self.rightDataArr removeObjectAtIndex:0];
        [self.rightDataArr addObject:@"#"];
    }
    [self.tableView reloadData];
    
}

//排序
- (NSArray * )paixuArrWithArr:(NSArray *)arr {
    
    if (arr.count == 0) {
        return arr;
    }
    NSArray *resultkArrSort = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    
    return resultkArrSort;
}

- (UIImage *)imageWithColor:(UIColor*)color size:(CGSize)size{
    
       CGRect rect =CGRectMake(0,0, size.width, size.height);
    
        UIGraphicsBeginImageContext(rect.size);
    
        CGContextRef context =UIGraphicsGetCurrentContext();
    
        CGContextSetFillColorWithColor(context, [color CGColor]);
    
        CGContextFillRect(context, rect);
    
        UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    
        UIGraphicsEndImageContext();
    
        return image;
    
}


#pragma mark ----- searchBr事件 --------
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //searchText是searchBar上的文字 每次输入或删除都都会打印全部
    NSLog(@"%@",searchText);

   //文字发生改变时
    if (searchText.length > 0) {
        self.isSearch = YES;
        [self searchAction:searchText];
    }else {
        self.isSearch = NO;
        [self.tableView reloadData];
    }
    
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
