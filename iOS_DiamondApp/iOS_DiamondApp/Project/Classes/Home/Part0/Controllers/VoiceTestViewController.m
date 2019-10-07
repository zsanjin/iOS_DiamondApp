//
//  VoiceTestViewController.m
//  iOS_DiamondApp
//
//  Created by MrYeL on 2019/1/18.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import "VoiceTestViewController.h"

#import "VoiceRecognizerManager.h"

@interface VoiceTestViewController ()
/** HeaderView*/
@property (nonatomic, strong) UIView * headerView;
/** 识别的文字*/
@property (nonatomic, weak) UILabel * textLabel;
/** 识别管理对象*/
@property (nonatomic, strong) VoiceRecognizerManager * voiceManager;

@end

@implementation VoiceTestViewController
#pragma mark - Lazy Load
- (UIView *)headerView {
    
    if (_headerView == nil) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kScreenWidth, RATEHEIGHT_iPhone6(200))];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 20)];
        titleLabel.text = @"识别结果";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headerView addSubview:titleLabel];

        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20 + 20 + 20, kScreenWidth - 30, 100)];
        [_headerView addSubview:textLabel];
        self.textLabel = textLabel;
        
    }
    
    return _headerView;
    
}
- (VoiceRecognizerManager *)voiceManager {
    if (_voiceManager == nil) {
        _voiceManager = [VoiceRecognizerManager VoiceRecognizerWithRecognizeType:RecognizeType_Online];
    }
    return _voiceManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.headerView];

    [self.viewModel addDatasFromArray:@[@"开始识别" , @"停止"] atSection:0];
    
    self.tableView.frame = CGRectMake(0, self.headerView.height + NAVIGATION_BAR_HEIGHT, kScreenWidth, kScreenHeight - NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT - self.headerView.height);

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    NSInteger index = indexPath.row;
    AppBaseTableViewCell *baseCell  = [tableView cellForRowAtIndexPath:indexPath];
    __weak typeof(self) weakSelf = self;

    switch (index) {
        case 0://开始识别
        {
            self.textLabel.text = @"识别中…";
            [self.voiceManager startRecognizeWithFile:nil andComplete:^(VoiceRecognizerManager *manger, NSString *resultStr, NSString *errorStr) {
               
                weakSelf.textLabel.text = resultStr.length>0?resultStr:errorStr;
             
            }];
            baseCell.textLabel.text = @"重新开始";
        }
            break;
            
        case 1://停止识别
            [self.voiceManager stopRecognize:nil];
            self.textLabel.text = @"";

            break;
        default:
            break;
    }

}

@end
