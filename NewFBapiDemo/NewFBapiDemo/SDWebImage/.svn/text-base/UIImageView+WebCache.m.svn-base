/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"

@implementation UIImageView (WebCache)

- (void)setImageWithURL:(NSURL *)url
{
    //if (self.image==nil) {
        [self setImageWithURL:url placeholderImage:nil];
    //}
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
//    
//    [[self viewWithTag:6900]removeFromSuperview];
//    
//    
//    UIActivityIndicatorView *scrollingWheel = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    float x = self.bounds.size.width/2;
//    float y = self.bounds.size.height/2;
//    scrollingWheel.center = CGPointMake(x, y);
//    scrollingWheel.hidesWhenStopped = YES;
//    scrollingWheel.tag=6900;
//    [self addSubview:scrollingWheel];
//    self.clipsToBounds = YES;
//    [scrollingWheel startAnimating];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];

    UIImage *cachedImage = nil;
    if (url)
    {
        cachedImage = [manager imageWithURL:url];
    }

    if (cachedImage)
    {
        self.image = cachedImage;
    }
    else
    {
        if (placeholder)
        {
            self.image = placeholder;
        }

        if (url)
        {
            [manager downloadWithURL:url delegate:self];
        }
    }
}

- (void)cancelCurrentImageLoad
{
    //[[self viewWithTag:6900]removeFromSuperview];
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    //[[self viewWithTag:6900]removeFromSuperview];
    self.image = image;
}

@end
