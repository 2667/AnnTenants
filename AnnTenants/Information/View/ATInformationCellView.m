//
//  ATInformationCellView.m
//  AnnTenants
//
//  Created by HuangGang on 2018/5/4.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATInformationCellView.h"

@interface ATInformationCellView()<UIWebViewDelegate>

//资讯图片
@property(nonatomic, strong) UIImageView *informationImage;
//资讯主标题
@property(nonatomic, strong) UILabel *mainTitle;
//资讯摘要
@property(nonatomic, strong) UILabel *abstract;

@end

@implementation ATInformationCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)bindInformationModel:(ATInformationModel *)informationM {
    self.informationImage.image = [UIImage imageNamed:informationM.imageName];
    self.mainTitle.text = informationM.mainTitle;
    self.abstract.text = informationM.abstract;
    
//    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString: url]]];
    
//    NSString *strurl=url;
//
//    UIWebView *web = [[UIWebView alloc] initWithFrame:self.frame];
//
//    web.delegate = self;
//
//    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strurl]]];
//
//    [self.contentView addSubview:web];
    
    
    
//    拿到网页内容
//    NSString *htmlString = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil];
////    contentStr就是我要用于显示的文本了.此方法拿到的文本是url对应网页的文本,所以根据需求自由截取长短.
//    NSString *contentStr = [self getZZwithString:htmlString];
//    self.mainTitle.text = contentStr;
}


//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    
//    UIWebView *web = webView;
//    
//    //获取所有的html
//    
//    NSString *allHtml = @"document.documentElement.innerHTML";
//    
//    //获取网页title
//    
//    NSString *htmlTitle = @"document.title";
//    
//    //获取网页的一个值
//    
//    NSString *htmlNum = @"document.getElementById('title').innerText";
//    
//    //获取到得网页内容
//    
//    NSString *allHtmlInfo = [web stringByEvaluatingJavaScriptFromString:allHtml];
//    
//    NSLog(@"%@",allHtmlInfo);
//    
//    NSString *titleHtmlInfo = [web stringByEvaluatingJavaScriptFromString:htmlTitle];
//    
//    NSLog(@"%@",titleHtmlInfo);
//    
//    NSString *numHtmlInfo = [web stringByEvaluatingJavaScriptFromString:htmlNum];
//    
//    NSLog(@"%@",numHtmlInfo);
//    
//}

//正则去除网络标签
- (NSString *)getZZwithString:(NSString *)string{
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n" options:0 error:nil];
    string = [regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    return string;
}

- (void)layoutSubviews {
    
//    [self.contentView addSubview:self.webView];
    [self.contentView addSubview:self.informationImage];
    [self.contentView addSubview:self.mainTitle];
    [self.contentView addSubview:self.abstract];

    self.informationImage.frame = CGRectMake(15, 15, ATSCREEN_WIDTH - 2*15, 190);
    self.mainTitle.frame = CGRectMake(15, 205, ATSCREEN_WIDTH - 15*2, 38);
    self.abstract.frame = CGRectMake(15, 260, ATSCREEN_WIDTH - 15*2, 85);
    
}

- (UIImageView *)informationImage {
    if (!_informationImage) {
        _informationImage = [UIImageView new];
        
    }
    return _informationImage;
}
- (UILabel *)mainTitle {
    if (!_mainTitle) {
        _mainTitle = [UILabel new];
        _mainTitle.textAlignment = NSTextAlignmentLeft;
    }
    return _mainTitle;
}

- (UILabel *)abstract {
    if (!_abstract) {
        _abstract = [ATCustomLabel new];
        //背景颜色为红色
        _abstract.backgroundColor = [UIColor whiteColor];
        //设置字体颜色为白色
        _abstract.textColor = [UIColor blackColor];
        //文字居中显示
        _abstract.textAlignment = NSTextAlignmentLeft | NSTextAlignmentNatural;
        //自动折行设置
        _abstract.lineBreakMode = NSLineBreakByWordWrapping;
        _abstract.numberOfLines = 0;
        [_abstract sizeToFit];
        
    }
    return _abstract;
}


@end
