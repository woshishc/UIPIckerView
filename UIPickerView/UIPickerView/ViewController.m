//
//  ViewController.m
//  UIPickerView
//
//  Created by suhc on 16/3/25.
//  Copyright © 2016年 kongjianjia. All rights reserved.
//

#define SingerPickerView 0
#define SingPickerView  1
#import "ViewController.h"
#import <HCTools/HCTools.h>

@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, weak) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *singerData;
@property (nonatomic, strong) NSArray *songData;
@property (nonatomic, weak) IBOutlet UIButton *selectBtn;
@property (nonatomic, strong) NSDictionary *pickerDic;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //显示选中框
    self.pickerView.showsSelectionIndicator = YES;
    
    NSURL *songInfo = [[NSBundle mainBundle] URLForResource:@"songList" withExtension:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:songInfo];
    self.pickerDic = dic;
    
    NSArray *components = [dic allKeys];
    self.singerData = components;
    
    NSString *selectedState = [self.singerData firstObject];
    NSArray *array = [dic objectForKey:selectedState];
    self.songData = array;
   
}

- (IBAction)buttonPressed:(UIButton *)btn{
    NSInteger singerRow = [self.pickerView selectedRowInComponent:SingerPickerView];
    NSInteger singRow = [self.pickerView selectedRowInComponent:SingPickerView];
    NSString *selectedsinger = [self.singerData objectAtIndex:singerRow];
    NSString *selectedsing = [self.songData objectAtIndex:singRow];
    NSString *message = [[NSString alloc] initWithFormat:@"你选择了%@的%@",selectedsinger,selectedsing];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了OK");
    }];
    
    [alert addAction:OKAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerViewt numberOfRowsInComponent:(NSInteger)components{
    if (components == SingerPickerView) {
        return [self.singerData count];
    }else{
        return [self.songData count];
    }
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == SingerPickerView) {
        return [self.singerData objectAtIndex:row];
    }else{
        return [self.songData objectAtIndex:row];
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == SingerPickerView) {
        NSString *selectedState = [self.singerData objectAtIndex:row];
        NSArray *array = [self.pickerDic objectForKey:selectedState];
        self.songData = array;
        [self.pickerView selectRow:0 inComponent:SingPickerView animated:YES];
        [self.pickerView reloadComponent:SingPickerView];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component == SingerPickerView) {
        return 120;
    }
    return 200;
}

@end
