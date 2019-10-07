//
//  FaceToFaceHomeXibCell.h
//  iOS_DiamondApp
//
//  Created by MrYeL on 2019/1/23.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import "AppBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface FaceToFaceHomeXibCell : AppBaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *backSerLabel;
@property (weak, nonatomic) IBOutlet UILabel *sceneLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivedLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateTimeLabel;

@end

NS_ASSUME_NONNULL_END
