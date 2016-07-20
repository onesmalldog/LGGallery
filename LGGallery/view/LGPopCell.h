
//  Created by lee on 16/7/9.
//

#import <UIKit/UIKit.h>

@interface LGPopCell : UITableViewCell
@property (weak, nonatomic) UIImageView *imageV;
@property (weak, nonatomic) UILabel *nameLabel;
@property (weak, nonatomic) UILabel *countLabel;
+ (LGPopCell *)popCellWithTableView:(UITableView *)tableView;
@end
