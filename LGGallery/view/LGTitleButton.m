
//  Created by lee on 16/7/8.
//

#import "LGTitleButton.h"
#import "UIView+Extention.h"
#import "UIImage+Image.h"


@implementation LGTitleButton 

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.currentImage == nil) return;
    if (self.titleLabel.x > self.imageView.x) {
        // title
        self.titleLabel.x = self.imageView.x;
        // image
        self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    }
}

// 重写setTitle方法，扩展计算尺寸功能
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
//    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
//    [self sizeToFit];
}
@end
