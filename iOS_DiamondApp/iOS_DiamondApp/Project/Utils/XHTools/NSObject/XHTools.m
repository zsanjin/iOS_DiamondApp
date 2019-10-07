//
//  XHTools.m
//  CangoToB
//
//  Created by MrYeL on 2018/3/8.
//  Copyright © 2018年 Kiddie. All rights reserved.
//

#import "XHTools.h"

@implementation XHTools
+ (UIView *)xh_getUIViewWithFrame:(CGRect)frame withBackgroundColor:(UIColor *)backgroundColor{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = backgroundColor;
    return view;
}
/** 创建label*/
+ (UILabel *)xh_getUILabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color font:(CGFloat)font textAligment:(NSTextAlignment)textAligment {
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = textAligment;
    return label;
}
+ (UILabel *)getUILabelWithFrame:(CGRect)frame withTitle:(NSString *)title withFont:(CGFloat)fontSize withTextColor:(UIColor *)textColor {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.numberOfLines = 0;
    label.text = title;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = textColor;
    return label;
}
/** 普通Btn*/
+(UIButton *)xh_getUIButtonWithFrame:(CGRect)rect withTitle:(NSString *)text withFont:(CGFloat)fontSize  withTarge:(id)target withSel:(SEL)sel{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
+(UIButton *)xh_getUIButtonWithCustromWithFrame:(CGRect)rect withTitle:(NSString *)text withFont:(CGFloat)fontSize textColor:(UIColor*)textColor withBackgroundColor:(UIColor *)backgroundColor withTarge:(id)target withSel:(SEL)sel{
    
    UIButton *btn = [XHTools xh_getUIButtonWithFrame:rect withTitle:text withFont:fontSize withTarge:target withSel:sel];
    [btn setTitleColor:textColor forState:0];
    btn.backgroundColor = backgroundColor;
    return btn;
}
+(YHResetFrameButton *)xh_getUIButtonWithFrame:(CGRect)rect withTitle:(NSString *)title titleRect:(CGRect)titleRect withFont:(CGFloat)fontSize withImageName:(NSString *)imageName imageRect:(CGRect)imageRect withTarge:(id)target withSel:(SEL)sel {
    
    YHResetFrameButton *btn = [YHResetFrameButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleRect = titleRect;
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btn.imageRect = imageRect;
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
//    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    return btn;
    
    return btn;
}
/**ImageView*/
+ (UIImageView *)xh_getUIImageViewWithFrame:(CGRect)frame withImageName:(NSString *)imageName {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    if (imageName.length) {
        imageView.image = [UIImage imageNamed:imageName];

    }
    return imageView;
}
//date转string
+ (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}
+ (void)showTimePIckerWithDatePickerMode:(UIDatePickerMode)datePickerMode withCanChooseBeforeTodayTime:(BOOL)isBeforeTime withAllBtn:(BOOL)showAll fromDate:(NSDate *)date andSelectTime:(DateTimeSelectWithType)selectTimeBlock {

    XHShowTimePicker *picker = [XHShowTimePicker new];
    picker.datePickerMode = datePickerMode;
    picker.isBeforeTime = isBeforeTime;
    picker.allTimeBtn.enabled = YES;
    picker.selectDate = date;
    picker.allTimeBtn.hidden = !showAll;
    [picker didFinishSelectedDateWithType:selectTimeBlock];
}
+ (void)showTimePIckerWithDatePickerMode:(UIDatePickerMode)datePickerMode withCanChooseMinDate:(NSDate*)minDate withAllBtn:(BOOL)showAll andSelectTime:(DateTimeSelectWithType)selectTimeBlock {

    XHShowTimePicker *picker = [XHShowTimePicker new];
    picker.datePickerMode = datePickerMode;
    picker.minSelectDate = minDate;
    picker.allTimeBtn.enabled = YES;
    picker.allTimeBtn.hidden = !showAll;
    [picker didFinishSelectedDateWithType:selectTimeBlock];
}
+ (void)showDrawerViewWithArray:(NSArray *)titleArray WithIndexAndClickInfo:(void(^)(NSInteger index,NSString *clickInfo))block {
    XHDrawer *drawer = [XHDrawer new];
    [drawer showDrawerViewWithTitleArray:titleArray];
    
    drawer.selectInfo = ^(NSInteger index,NSString *clickInfo) {

        block(index,clickInfo);
    };
    
}
+ (void)showDrawerTableViewWithArray:(NSArray *)titleArray WithIndexAndClickInfo:(void(^)(NSInteger index,NSString *clickInfo))block {
    XHDrawer *drawer = [XHDrawer new];
    [drawer showDrawerTableViewWithTitleArray:titleArray];
    
    drawer.selectInfo = ^(NSInteger index,NSString *clickInfo) {
     
        block(index,clickInfo);
    };
}
/** 获取 dete x年x月x天后（前）的时间*/
+ (NSDate *)historyOrFutureDateWithDate:(NSDate*)date yearCount:(NSInteger)yearCount mounthCount:(NSInteger)mounthCount dayCount:(NSInteger)dayCount {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:yearCount];
    [adcomps setMonth:mounthCount];
    [adcomps setDay:dayCount];
    
    if (!date) {
        date = [NSDate date];
    }
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    NSDate *newDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    
    return newDate;
    
}
//字符串转化成日期
+ (NSInteger)calculateDateStringBeforeOrFutureDateCount:(NSString *)dateString withType:(NSInteger)calculateType
{
    //字符串转化成日期
    NSDate *pubDate = [self chageStringToDate:dateString withFormatStr:@""];
    //计算时间差
    //日历对象
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    /*
     计算两个日期之间的时间差
     第一个参数:时间差订阅的参数(年月日时分秒)
     第二个参数:开始时间
     第三个参数:结束时间
     第三个参数:其他参数(0)
     */
    unsigned int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dc = [calendar components:unit fromDate:pubDate toDate:[NSDate date] options:0];
    //日期字符串
    NSInteger dateCount = 0;
    
    switch (calculateType) {
        case 0://年
            dateCount = [dc year];
            break;
        case 1://月
            dateCount = [dc month];

            break;
        case 2://日
            dateCount = [dc day];

            break;
        case 3://时
            dateCount = [dc hour];

            break;
        case 4://分
            dateCount = [dc minute];

            break;
        case 5://秒
            dateCount = [dc second];

            break;
            
        default:
            break;
    }
    
    return dateCount;
}
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents    * comp = [calendar components:NSCalendarUnitDay
                                             fromDate:fromDate
                                               toDate:toDate
                                              options:NSCalendarWrapComponents];
    NSLog(@" -- >>  comp : %@  << --",comp);
        return comp.day;
}
+ (NSDate *)chageStringToDate:(NSString *)dateStr withFormatStr:(NSString *)format{
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    dateFormater.dateFormat = format.length? format:@"YYYY-MM-dd";
    NSDate *date = dateStr.length? [dateFormater dateFromString:dateStr]:[NSDate date];
    
    return date;
}
+ (NSString *)chageDateToString:(NSDate *)date withFormatStr:(NSString *)format {
    
    if (!date) {
        date = [NSDate date];
    }
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    dateFormater.dateFormat = format.length? format:@"YYYY-MM-dd";
    NSString *dateStr = [dateFormater stringFromDate:date];
    return dateStr;
}

#pragma mark - Car
/** 创建label*/
+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color font:(CGFloat)font textAligment:(NSTextAlignment)textAligment {
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = color;
//    label.font = KFontSize(font);
    label.textAlignment = textAligment;
    return label;
}
//Label 文字两端对齐
+ (void)label:(UILabel *)label alightLeftAndRightWithWidth:(CGFloat)labelWidth {
    
    if (!label.text.length)return;
    
    CGSize testSize = [label.text boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine| NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :label.font} context:nil].size;
    
    CGFloat margin = (labelWidth - testSize.width)/(label.text.length - 1);
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:label.text];
    
    [attribute addAttribute: NSKernAttributeName value:number range:NSMakeRange(0, label.text.length - 1 )];
    
    label.attributedText = attribute;
}

//字符串转化成日期
+ (NSString *)timeStringFromDateString:(NSString *)dateString
{
    //字符串转化成日期
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //2016-01-11 13:09:27
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *pubDate = [df dateFromString:dateString];
    
    //计算时间差
    //日历对象
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    /*
     计算两个日期之间的时间差
     第一个参数:时间差订阅的参数(年月日时分秒)
     第二个参数:开始时间
     第三个参数:结束时间
     第三个参数:其他参数(0)
     */
    unsigned int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dc = [calendar components:unit fromDate:pubDate toDate:[NSDate date] options:0];
    //日期字符串
    NSString *dateStr = @"";
    if ([dc year] > 0) {
        dateStr = [NSString stringWithFormat:@"%ld年前",(long)[dc year]];
    }else if ([dc month] > 0) {
        dateStr = [NSString stringWithFormat:@"%ld月前",(long)[dc month]];
    }else if ([dc day] > 0){
        dateStr = [NSString stringWithFormat:@"%ld天前",(long)[dc day]];
    }else if ([dc hour] > 0) {
        dateStr = [NSString stringWithFormat:@"%ld小时前",(long)[dc hour]];
    }else if ([dc minute] > 0){
        dateStr = [NSString stringWithFormat:@"%ld分钟前",(long)[dc minute]];
    }else if ([dc second] > 1) {
        dateStr = [NSString stringWithFormat:@"%ld秒前",(long)[dc second]];
    }else{
        dateStr = @"刚刚";
    }
    NSLog(@"%@",dateStr);
    
    return dateStr;
}
//clipImage：截取image
+(UIImage *)clipImage:(UIImage *)image withRect:(CGRect)rect{
    
    CGImageRef cgImage = image.CGImage;
    
    cgImage = CGImageCreateWithImageInRect(cgImage,rect);
    
    image = [UIImage imageWithCGImage:cgImage];
    
    return image;
}
/** * 画圆*/
+ (UIImage *)circleImage:(UIImage *)image{
    //开启image绘制
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //做一个圆
    CGRect circleRect = (CGRect){
        (CGPoint){0,0},
        image.size
    };
    //画圆
    CGContextAddEllipseInRect(ctx, circleRect);
    //设置裁剪图片
    CGContextClip(ctx);
    //画上iamge
    [image drawInRect:circleRect];
    
    //获取画后的圆的image
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束image绘制
    UIGraphicsEndImageContext();
    
    return circleImage;
    
}
//压缩图片
+(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage =UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}
/** 计算文字尺寸*/
+ (CGSize)calculateSizeWithText:(NSString *)text maxSize:(CGSize)maxSize attributes:(NSDictionary *)attributes{
    
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return size;
}
/** 通过文件名获取文件路径*/
+ (NSString *)fileSavePathWithfileName:(NSString *)fileName{
    
    //存储路径
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
    
    return filePath;
}
/** 获取当前系统日期时间YYYY-MM-dd*/
+ (NSString *)currentSystemTimeString{
    
    NSString *timeStr = @"2016-07-01";
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"YYYY-MM-dd"];
    timeStr = [df stringFromDate:currentDate];
    
    return timeStr;
}
//+ (NSDate *)chageStringToDate:(NSString *)dateStr withFormatStr:(NSString *)format{
//
//    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
//    dateFormater.dateFormat = format.length? format:@"YYYY-MM-dd";
//    NSDate *date = [dateFormater dateFromString:dateStr];
//
//    return date;
//}
+ (NSString *)changeDateToString:(NSDate *)date withFormatStr:(NSString *)format{

    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    dateFormater.dateFormat = format.length? format:@"YYYY-MM-dd";
    NSString *dateString = [dateFormater stringFromDate:date];

    if (dateString) {
        return dateString;
    }
    return @"";
}
+ (NSInteger)getMounthCountWithYearStr:(NSString *)yearStr andMounth:(NSString *)mounthStr{
 
    NSInteger count = 0;
 
    NSInteger yearValue = yearStr.integerValue;
    BOOL isRunYear = NO;
    
    if ((yearValue % 400 == 0) || (yearValue % 4 == 0 && yearValue % 100)) {
        isRunYear = YES;
    }
    
    switch (mounthStr.integerValue) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
        case 13://第二年
            count = 31;
            break;
        case 2:
            count = isRunYear? 29:28;
            break;
            
        default:
            count = 30;
            break;
    }

    return count;
}
/** 获取 dete x年x月x天后（前）的时间*/

/** wangzhi pand */
+ (BOOL)isWebUrl:(NSString *)string {
    
    NSError *error;
    
    // 正则1
    NSString *regulaStr =@"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    
    // 正则2
    regulaStr =@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                  
                                                                           options:NSRegularExpressionCaseInsensitive
                                  
                                                                             error:&error];
    
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    
    
    for (NSTextCheckingResult *match in arrayOfAllMatches){
        
        NSString* substringForMatch = [string substringWithRange:match.range];
        
        NSLog(@"匹配^ : %@",substringForMatch);
        
        return YES;
        
    }
    return NO;
}
/** 手机号判断*/
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
/** 是否可用密码*/
+ (BOOL)isValidPassword:(NSString *)password {
    
    if (password.length < 8)
    {
        return NO;
    }
    
    //^(?=.*[0-9A-Za-z])(?=.*[A-Z]).{8,20}$
    //    NSString *MOBILE = @"^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{8,20}$";//数字和字母
    //
    //    NSString *CM = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$";
    //
    //    NSString *CU = @"(?![0-9A-Z]+$)(?![0-9a-z]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$";
    //
    //    NSString *CT = @"^(?=.*[0-9].*)(?=.*[A-Z].*)(?=.*[a-z].*).{8,20}$";
    
    
    NSString *MOBILE = @"^(?=.*\\d)(?=.*[A-Z]).{8,20}$";
    
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (
        ([regextestmobile evaluateWithObject:password] == YES)
        //        || ([regextestcm evaluateWithObject:password] == YES)
        //        || ([regextestct evaluateWithObject:password] == YES)
        //        || ([regextestcu evaluateWithObject:password] == YES)
        )
    {
        return YES;
    }
    
    return NO;
}
/** 最大并发数*/
+ (void)maxConcurrent_QueueWithMaxConcurrent_Count:(NSInteger)maxCount assignmentCount:(NSInteger)assigntnmetCount andAssignmentBlock:(void(^)(void))assignmentBlock{
    dispatch_queue_t workConcurrentQueue = dispatch_queue_create("cccccccc", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_queue_t serialQueue = dispatch_queue_create("sssssssss",DISPATCH_QUEUE_SERIAL);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(maxCount);
    
    for (NSInteger i = 0; i < assigntnmetCount; i++) {
        
        dispatch_async(serialQueue, ^{
            
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            
            dispatch_async(workConcurrentQueue, ^{
                
                
                NSLog(@"thread-info:%@开始执行任务%d",[NSThread currentThread],(int)i);
                //                sleep(1);
                
                if (assignmentBlock) {
                    
                    assignmentBlock();
                }
                
                
                NSLog(@"thread-info:%@结束执行任务%d",[NSThread currentThread],(int)i);
                
                dispatch_semaphore_signal(semaphore);});
            
        });}
    
    NSLog(@"主线程...!");
    
}
//改圆角
+ (void)shapeRadiusWithView:(UIView *)view withTop:(BOOL)isTop {
    UIBezierPath *maskPath;
    if (isTop) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5,5)];
    } else {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5,5)];
    }
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    
}
// 当前日期所在的 周 起始日期 startType:周首日
- (void)getBeginDate:(NSDate *)newDate withStartType:(NSInteger)type andFromate:(NSString *)fromate{
    if (newDate == nil) {
        newDate = [NSDate date];
    }
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    BOOL ok = NO;
    [calendar setFirstWeekday:type];//设定0 周六 1周天 2周一 为周首日
    ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
   
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return;
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    [NSString stringWithFormat:@"%@-%@",beginString,endString];
}


@end
