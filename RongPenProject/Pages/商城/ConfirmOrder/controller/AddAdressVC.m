//
//  AddAdressVC.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/17.
//

#import "AddAdressVC.h"
#import "AddressPickerView.h"
#import "ReLayoutButton.h"
#import "AddAdressCell.h"
#import "AddressModel.h"
#import "ZRPickerView.h"
#import "AreaModel.h"
#import <ContactsUI/ContactsUI.h>

@interface AddAdressVC () <AddressPickerViewDelegate, CNContactPickerDelegate,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,NetManagerDelegate>
@property (nonatomic, strong) NetManager                *net;
@property (nonatomic, strong) AddressPickerView         *pickerView;
@property (strong, nonatomic)  UITextField              *nameTF;
@property (strong, nonatomic)  UITextField              *phoneTF;
@property (nonatomic, strong)  NSString                 *addressStr;
@property (strong, nonatomic)  UITextView               *addressTV;
@property (nonatomic, strong)  NSString                 *xiangxiaddressStr;

@property (strong, nonatomic)  ReLayoutButton           *quyuBtn;
@property (strong, nonatomic)  UITableView              *tableView;
@property (nonatomic, strong)  UIButton                 *addadressBtn;
@property (nonatomic, strong)  UIButton                 *delbtn;
@property (nonatomic, strong)  UIButton                 *defualbtn;

//通讯录姓名电话
@property (nonatomic,strong) NSString                   *namestr;   //姓名
@property(nonatomic, strong) NSString                   *phoneNumberstr;   //电话号码
@property(nonatomic, strong) NSMutableArray             *dataArray;
@property (nonatomic,strong) NSString                   *isSetdefaul; //是否默认地址
@property (nonatomic,strong) NSString                   *markstr;   //标签
@property (nonatomic,strong) NSString                   *provinceId;   //省
@property (nonatomic,strong) NSString                   *provinceName;   //省
@property (nonatomic,strong) NSString                   *cityId;   //市
@property (nonatomic,strong) NSString                   *cityName;   //市
@property (nonatomic,strong) NSString                   *areaId;   //县
@property (nonatomic,strong) NSString                   *areaName;   //县

@property (nonatomic,strong) AddressModel               *Addressmodel;
@property (nonatomic,strong) NSArray                    *areAry;   //县


@property (nonatomic, strong) ZRPickerView      *zrPickerView;
@property (nonatomic, strong) NSMutableArray    *areaArray;
/// 当前选择省份信息
@property (nonatomic, strong) AreaModel          *currentProvinceModel;
/// 当前选择城市信息
@property (nonatomic, strong) AreaModel          *currentCityModel;
/// 当前选择县区信息
@property (nonatomic, strong) AreaModel          *currentAreaModel;

@end

@implementation AddAdressVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:243/255.0 green:245/255.0 blue:248/255.0 alpha:1.0];
    self.leftImgBtn.hidden=NO;
    self.toptitle.hidden=NO;
    self.topview.hidden=NO;
    self.isSetdefaul=@"0";//新增地址初始状态为非默认
//    [self.rightImgBtn setTitle:@"删除" forState:UIControlStateNormal];
//    self.rightImgBtn.titleLabel.font=[UIFont systemFontOfSize:14];
//    [self.rightImgBtn setTitleColor:[MTool colorWithHexString:@"#555555"] forState:UIControlStateNormal];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight,  SCREEN_WIDTH, 4*55+12) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor clearColor];
    [self.tableView setSeparatorColor:[MTool colorWithHexString:@"c0c0c0"]];
    self.tableView.tableFooterView=[UIView new];
    self.tableView.scrollEnabled=NO;
    [self.view addSubview:self.tableView];
    
    self.addressTV.layer.cornerRadius = 8;
    self.addressTV.layer.borderColor = UIColorFromRGB(0xDDDDDD).CGColor;
    self.addressTV.layer.borderWidth = 1;
    
    self.delbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.delbtn.frame = CGRectMake(ScreenWidth-LeftMargin-60,SafeAreaTopHeight-64+(64-15)/2, 60, 30);
    [self.delbtn setTitle:@"删除" forState:UIControlStateNormal];
    self.delbtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.delbtn setTitleColor:[MTool colorWithHexString:@"#555555"] forState:UIControlStateNormal];
    [self.delbtn addTarget:self action:@selector(delbtnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.delbtn];
    
    self.defualbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.defualbtn.frame = CGRectMake(10,self.tableView.bottom+15, 90, 30);
    [self.defualbtn setTitle:@"默认地址" forState:UIControlStateNormal];
    [self.defualbtn setImage:[UIImage imageNamed:@"quan_btn"] forState:UIControlStateNormal];
    [self.defualbtn setTitleColor:[MTool colorWithHexString:@"#555555"] forState:UIControlStateNormal];
    self.defualbtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.defualbtn addTarget:self action:@selector(defualbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.defualbtn];
    
    self.addadressBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.addadressBtn.frame=CGRectMake(20, self.defualbtn.bottom+30,SCREEN_WIDTH-40,80*SCREEN_WIDTH/750);
    [self.addadressBtn addTarget:self action:@selector(commitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    self.addadressBtn.cornerRadius=20;
    [self.addadressBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.addadressBtn setBackgroundColor:[MTool colorWithHexString:@"#FF4E4E"]];
    [self.addadressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addadressBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    [self.view addSubview: self.addadressBtn];
       
    
    if (_VCtag==1) {
        self.toptitle.text = @"新增地址";
        self.rightImgBtn.hidden=YES;
        
    }
    else{
        self.toptitle.text = @"编辑地址";
        self.rightImgBtn.hidden=YES;
        
    }
    
    self.areaArray = [self getAreaPlist];
    [self.view addSubview:self.zrPickerView];
}


/// 获取省市县信息
- (NSMutableArray *)getAreaPlist{
    NSMutableArray * CityList = [[NSMutableArray alloc] initWithCapacity:35];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
     NSString *plistPath = [paths objectAtIndex:0];
       //得到完整的文件名
     NSString *filename=[plistPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", @"Areaaaaaaaa"]];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:filename];

       for (NSInteger i = 0; i < data.count; i++) {
           AreaModel * model = [[AreaModel alloc] init];
           model.name = [data[i] objectForKey:@"name"];
           model.ID = [data[i] objectForKey:@"id"];
           model.second = [AreaModel mj_objectArrayWithKeyValuesArray:[data[i] objectForKey:@"second"]];
           [CityList addObject:model];
       }
    return CityList;
}



#pragma mark -TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    if (indexPath.row>2) {
//        return 84*SCREEN_WIDTH/750;
//    }
//    else{
//        return 84*SCREEN_WIDTH/750; return 12;
//
//    }
    return 55;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor =[UIColor colorWithRed:243/255.0 green:245/255.0 blue:248/255.0 alpha:1.0];
    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *cellIdentifier = @"AddAdressCell";
    AddAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[AddAdressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    cell.model=self.Addressmodel;
    if (indexPath.row==0) {
        cell.textLabel.text=@"收货人";
        cell.textfieldStrBlock = ^(NSString * _Nonnull str) {
            self.namestr=str;
        };
        if (self.namestr.length==0) {
            cell.phoneTF.placeholder=@"请填写收货人姓名";
            
        }
        else{
            cell.phoneTF.text=self.namestr;
            
        }
        
    }
    else if (indexPath.row==1) {
        cell.textLabel.text=@"联系方式";
        cell.textfieldStrBlock = ^(NSString * _Nonnull str) {
            self.phoneNumberstr=str;
        };
        if (self.phoneNumberstr.length==0) {
            cell.phoneTF.placeholder=@"请填写收货人手机号码";
            
        }
        else{
            cell.phoneTF.text=self.phoneNumberstr;
        }
        
    }
    else  if (indexPath.row==2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text=@"所在地区";
        if (self.addressStr.length==0) {
            cell.phoneTF.placeholder=@"请填选择所在地区";
            
        }
        else{
            cell.phoneTF.text=self.addressStr
            ;
        }
        cell.adressbtn.hidden=NO;
        cell.textfieldStrBlock = ^(NSString * _Nonnull str) {
            [self addressBtnClick];
        };
        
    }
    else  if (indexPath.row==3) {
//        cell.titleLab.hidden=NO;
//        cell.addressTV.hidden=NO;
//        cell.phoneTF.hidden=YES;
//        cell.textfieldStrBlock = ^(NSString * _Nonnull str) {
//            self.xiangxiaddressStr=str;
//        };
//        if (self.xiangxiaddressStr.length!=0) {
//            cell.addressTV.text=self.xiangxiaddressStr;
//        }
        cell.textLabel.text=@"详细地址";
        cell.textfieldStrBlock = ^(NSString * _Nonnull str) {
            self.xiangxiaddressStr=str;
        };
        if (self.xiangxiaddressStr.length==0) {
            cell.phoneTF.placeholder=@"街道 门牌号等";
            
        }
        else{
            cell.phoneTF.text=self.xiangxiaddressStr;
        }
        
    }
    else  if (indexPath.row==4) {
        cell.textLabel.text=@"设置默认地址";
        cell.phoneTF.hidden=YES;
        cell.swi.hidden=NO;
        cell.textfieldStrBlock = ^(NSString * _Nonnull str) {
            if ([str isEqualToString:@"on"]) {
                self.isSetdefaul=@"1";
            }
            else{
                self.isSetdefaul=@"0";
            }
        };
        
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
}
#pragma mark - AddressPickerViewDelegate
- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area {
    [self.quyuBtn setTitle:[NSString stringWithFormat:@"%@%@%@", province, city, area] forState:UIControlStateNormal];
    self.provinceName=province;
    self.cityName=city;
    self.areaName=area;
    self.addressStr = [NSString stringWithFormat:@"%@,%@,%@", province, city, area];
    [self.tableView reloadData];
//    [self.pickerView hide];
    self.zrPickerView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 220);

}
#pragma mark - Function
- (void)cancelBtnClick {
    NSLog(@"点击了取消按钮");
    [self.pickerView hide];
}
#pragma mark-- XibFunction

//确认添加
- (void)commitBtnClicked {
//    if (self.namestr.length == 0) {
//        [DZTools showNOHud:@"名字不能为空" delay:2];
//        return;
//    }
//    if (self.phoneNumberstr.length == 0) {
//        [DZTools showNOHud:@"电话不能为空" delay:2];
//        return;
//    }
//    if (self.xiangxiaddressStr.length == 0) {
//        [DZTools showNOHud:@"详细地址不能为空" delay:2];
//        return;
//    }
//    if (self.addressStr.length == 0) {
//        [DZTools showNOHud:@"所在区域不能为空" delay:2];
//        return;
//    }
    NSString *regex = @"^((13[0-9])|(14[0-9])|(17[0-9])|(15[^4,\\D])|(18[0-9])|(19[0-9])|(16[0-9])|(17[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self.phoneNumberstr];
    if (!isMatch) {
        
        [DZTools showNOHud:@"手机号格式不正确" delay:2.0];
        return;
    }
    if (_VCtag==1) {//增加地址
        User*user=[User getUser];
        self.net.requestId=1001;
        [self.net Member_addresstjWithUid:user.uid Name:self.namestr Mobile:self.phoneNumberstr Sheng:self.provinceId Shi:self.cityId Qu:self.areaId Address:[NSString stringWithFormat:@"%@%@",self.addressStr,self.xiangxiaddressStr] Defaults:self.isSetdefaul];
        
    }
    else{//编辑地址
        self.net.requestId=1003;
        [self.net Member_addresseditdoWithUid:[User getUserID] Id:self.address_id Name:self.namestr Mobile:self.phoneNumberstr Sheng:self.provinceId Shi:self.cityId Qu:self.areaId Address:[NSString stringWithFormat:@"%@%@",self.addressStr,self.xiangxiaddressStr]  Defaults:self.isSetdefaul];
    }
    
    
}
//删除
-(void)delbtnclick{
    
    self.net.requestId=1004;
    [self.net Member_addressdelWithUid:[User getUserID] Id:self.address_id];
    
}
-(void)defualbtnclick:(UIButton*)btn{
    
    btn.selected = !btn.selected;
    if (btn.selected==YES) {
        [self.defualbtn setImage:[UIImage imageNamed:@"quan_btn_s"] forState:UIControlStateNormal];
        self.isSetdefaul=@"1";
        self.net.requestId=1005;
        [self.net Member_setdefaultWithUid:[User getUserID] Id:self.address_id];
    }
    else{
        [self.defualbtn setImage:[UIImage imageNamed:@"quan_btn"] forState:UIControlStateNormal];
        self.isSetdefaul=@"0";
        
       
    }
}

- (void)addressBtnClick {
    [self.view endEditing:YES];
//    [[DZTools getAppWindow] addSubview:self.pickerView];
//    [self.pickerView show];
    
    self.zrPickerView.frame = CGRectMake(0, ScreenHeight - 220, ScreenWidth, 220);
}

#pragma mark – 懒加载

- (ZRPickerView *)zrPickerView{
 
//    @WeakObj(self);
    if (!_zrPickerView) {
        _zrPickerView = [[ZRPickerView alloc] initWithFrame:CGRectMake(0, ScreenHeight , ScreenWidth, 220) WithDataArray:self.areaArray];
        _zrPickerView.pickerRow = 3;
        _zrPickerView.backgroundColor = [MTool colorWithHexString:@"#E5E5E5"];
        __weak typeof(self) weakSelf = self;
        _zrPickerView.didSelectRowBlock = ^(AreaModel * _Nonnull provinceModel, AreaModel * _Nonnull cityModel, AreaModel * _Nonnull areaModel) {
            NSLog(@"%@,%@,%@",provinceModel.name,cityModel.name,areaModel.name);
            weakSelf.provinceId=provinceModel.ID;
            weakSelf.provinceName=provinceModel.name;
            weakSelf.cityId=cityModel.ID;
            weakSelf.cityName=cityModel.name;
            weakSelf.areaId=areaModel.ID;
            weakSelf.areaName=areaModel.name;
            weakSelf.addressStr = [NSString stringWithFormat:@"%@%@%@", provinceModel.name, cityModel.name, areaModel.name];

            [weakSelf.tableView reloadData];
        };
    }
    
    return _zrPickerView;
    
}


- (AddressPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc] init];
        _pickerView.delegate = self;
        [_pickerView setTitleHeight:50 pickerViewHeight:165];
        // 关闭默认支持打开上次的结果
        //        _pickerView.isAutoOpenLast = NO;
    }
    return _pickerView;
}

-(void)getPersonData{
    
    
    //创建选择联系人的导航控制器
    CNContactPickerViewController * peoplePickVC = [[CNContactPickerViewController alloc] init];
    
    //设置代理
    peoplePickVC.delegate = self;
    
    // 3. 模态弹出
    [self presentViewController:peoplePickVC animated:YES completion:nil];
}
-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
{
    //获取联系人姓名
    NSString * firstName = contact.familyName;
    NSString * lastName = contact.givenName;
    NSLog(@"姓名：%@%@",firstName,lastName);
    self.namestr=firstName;
    
    //数组保存各种类型的联系方式的字典（可以理解为字典） 字典的key和value分别对应号码类型和号码
    NSArray * phoneNums = contact.phoneNumbers;
    
    //通过遍历获取联系人各种类型的联系方式
    for (CNLabeledValue *labelValue in phoneNums)
    {
        //取出每一个字典，根据键值对取出号码和号码对应的类型
        NSString *phoneValue = [labelValue.value stringValue];
        NSString *phoneLabel = labelValue.label;
        self.phoneNumberstr= [phoneValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"%@:%@",phoneLabel,phoneValue);
    }
    [self.tableView reloadData];
}


#pragma mark === NetManagerDelegate ===

- (void)requestDidFinished:(NetManager *)request result:(NSMutableDictionary *)result{
    NSDictionary*code=result[@"head"];
    if ([code[@"res_code"]intValue]!=0002) {
        
        [DZTools showNOHud:code[@"res_msg"] delay:2];
        return;
    }
    else{
        if (self.net.requestId==1001) {//新增地址
            [DZTools showOKHud:code[@"res_msg"] delay:2];
            [self.navigationController popViewControllerAnimated:YES];
        }
        if (self.net.requestId==1003) {//编辑地址
            [DZTools showOKHud:code[@"res_msg"] delay:2];
            [self.navigationController popViewControllerAnimated:YES];
        }
        if (self.net.requestId==1004) {//删除地址
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        if (self.net.requestId==1005) {//设置默认
            
            self.defualbtn.enabled=NO;
        }
        if (self.net.requestId==1002) {
            
            NSDictionary*dic=result[@"body"];
            _Addressmodel=[AddressModel mj_objectWithKeyValues:dic];
            if ([_Addressmodel.moren isEqualToString:@"0"]) {
                
            [self.defualbtn setImage:[UIImage imageNamed:@"quan_btn"] forState:UIControlStateNormal];

            }
            else{
            [self.defualbtn setImage:[UIImage imageNamed:@"quan_btn_s"] forState:UIControlStateNormal];
            self.defualbtn.enabled=NO;

            }
            self.namestr=_Addressmodel.name;
            self.phoneNumberstr=_Addressmodel.mobile;
            self.isSetdefaul=_Addressmodel.moren;
            self.provinceId=_Addressmodel.sheng;
            self.cityId=_Addressmodel.shi;
            self.areaId=_Addressmodel.qu;
            self.addressStr=[NSString stringWithFormat:@"%@%@%@",_Addressmodel.sheng1,_Addressmodel.shi1,_Addressmodel.qu1];
            self.xiangxiaddressStr=_Addressmodel.address;
            [self.tableView reloadData];
        }
    }
    
}

- (void)requestError:(NetManager *)request error:(NSError*)error{
    
}

- (void)requestStart:(NetManager *)request{
    
}
- (NetManager *)net{
    if (!_net) {
        self.net = [[NetManager alloc] init];
        _net.delegate = self;
    }
    return _net;
}
-(void)setVCtag:(NSInteger)VCtag{
    _VCtag=VCtag;//1 添加 2 编辑
    if (VCtag==1) {
        self.toptitle.text = @"新增地址";
    }
    else{
        self.toptitle.text = @"编辑地址";
        self.rightImgBtn.hidden=YES;
    }
    
}

-(void)setAddress_id:(NSString *)address_id{
    _address_id=address_id;
    self.net.requestId=1002;
    [self.net Member_addresseditWithUid:[User getUserID] Id:self.address_id];
}
@end
