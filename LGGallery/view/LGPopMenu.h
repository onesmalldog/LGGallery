
//  Created by lee on 16/7/8.
//

#import <UIKit/UIKit.h>

@class LGPopMenu;
@protocol LGPopMenuDelegate <NSObject>

- (void)popMenuDidChooseAlbum:(LGPopMenu *)popMenu chooseName:(NSString *)name;

@end

@interface LGPopMenu : UIView

/** table 的行高 */
@property (assign, nonatomic) CGFloat tableRowHeight;

@property (weak, nonatomic) UITableView *tableView;

@property (weak, nonatomic) id <LGPopMenuDelegate> delegate;

/** 相册列表，tableView的数据源 data source of album list */
@property (strong, nonatomic, readonly) NSArray<NSString *> *tableList;

- (void)show;

- (void)hide;

@end
