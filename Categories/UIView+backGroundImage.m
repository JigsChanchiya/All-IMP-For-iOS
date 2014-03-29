
#import "UIView+backGroundImage.h"

@implementation UIView (backGroundImage)

-(void)setBackgroundImage
{
    //[self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ASSET_BY_SCREEN_HEIGHT(@"GroupedTableBGNew")]]];
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BackGround-568h"]]];
}

@end
