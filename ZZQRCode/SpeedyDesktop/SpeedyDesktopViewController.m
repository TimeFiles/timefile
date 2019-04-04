//
//  SpeedyDesktopViewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2019/1/28.
//  Copyright © 2019 ZP. All rights reserved.
//

#import "SpeedyDesktopViewController.h"
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"


// Log levels: off, error, warn, info, verbose
static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface SpeedyDesktopViewController ()

@property (nonatomic,strong)HTTPServer *httpServer;

@end

@implementation SpeedyDesktopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"创建桌面快捷方式" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.centerY.equalTo(self.view);
    }];
}

- (void)btnClick {
    
   
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    _httpServer = [[HTTPServer alloc] init];
    [_httpServer setType:@"_http._tcp."];
    NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
    
    DDLogInfo(@"Setting document root: %@", webPath);
    
    [_httpServer setDocumentRoot:webPath];
    
    [self startServer];
    
    
}

- (void)startServer
{
    // Start the server (and check for problems)
    
    NSError *error;
    if([_httpServer start:&error])
    {
        DDLogInfo(@"Started HTTP Server on port %hu", [_httpServer listeningPort]);
        
        // open the url.
        NSString *urlStrWithPort = [NSString stringWithFormat:@"http://localhost:%d",[_httpServer listeningPort]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStrWithPort] options:@{} completionHandler:^(BOOL success) {
            
        }];
    }
    else
    {
        DDLogError(@"Error starting HTTP Server: %@", error);
    }
}

- (void)dealloc
{
    // 停止服务
    [_httpServer stop];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
