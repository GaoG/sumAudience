//
//  ViewController.m
//  SumAudience
//
//  Created by  GaoGao on 2020/5/24.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import "ViewController.h"
#import "StartView.h"
#import "AnswerView.h"
#import "GCDAsyncUdpSocket.h"

#define CLIENTPORT 8085
#define SERVERPORT 9600

@interface ViewController ()<GCDAsyncUdpSocketDelegate>

@property (nonatomic, strong) StartView *startView;

@property (nonatomic, strong) AnswerView *answerView;

@property (nonatomic, strong)NSMutableArray *viewArr;

@end

@implementation ViewController {
    
     GCDAsyncUdpSocket *sendSocket;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    dispatch_queue_t qQueue = dispatch_queue_create("Client queue", NULL);
    sendSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self
                                               delegateQueue:qQueue];
    NSError *error;
    [sendSocket bindToPort:CLIENTPORT error:&error];
    if (error) {
        NSLog(@"客户端绑定失败");
    }
    [sendSocket beginReceiving:nil];
    
    
    [self.view addSubview:self.answerView];
    [self.view addSubview:self.startView];
    
    
    
    [self.viewArr addObjectsFromArray:@[self.startView,self.answerView]];
    
    [self operateView:self.startView withState:NO];
    
    [self testMessage];
    
}

/// 测试消息
-(void)testMessage {
    
    NSData *sendData = [@"testMessage" dataUsingEncoding:NSUTF8StringEncoding];
    [sendSocket sendData:sendData
                  toHost:@"192.168.0.106"
                    port:SERVERPORT
             withTimeout:60
                     tag:200];
    
}


#pragma mark - delegate
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error {
    
    if (tag == 200) {
        NSLog(@"client发送失败-->%@",error);
    }
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext {
    
    NSString *receiveStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    dispatch_sync(dispatch_get_main_queue(), ^{
        
        if([receiveStr isEqualToString:@"testMessage"]){
            
            UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"连接成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [al show];
            
        }else if ([receiveStr isEqualToString:@"10"]){
            /// 回答完毕
            [self operateView:self.answerView withState:NO];
            
        }else if ([receiveStr isEqualToString:@"20"]){
            /// 晋级成功
            self.startView.tipsLabel.text = @"晋级成功";
            [self operateView:self.startView withState:NO];
            
        }else if ([receiveStr isEqualToString:@"30"]){
            /// 晋级失败
            self.startView.tipsLabel.text = @"晋级失败";
            [self operateView:self.startView withState:NO];
            
        }
        
        
        
        
        
        
    });
}









- (void)dealloc {
    
    [sendSocket close];
    sendSocket = nil;
}



-(StartView *)startView {
    
    if (!_startView) {
        _startView = [[[NSBundle mainBundle]loadNibNamed:@"StartView" owner:nil options:nil]lastObject];
        _startView.frame = self.view.bounds;
    }
    
    return _startView;
}



-(AnswerView *)answerView {
    
    if (!_answerView) {
        _answerView = [[[NSBundle mainBundle]loadNibNamed:@"AnswerView" owner:nil options:nil]lastObject];
        _answerView.frame = self.view.bounds;
    }
    
    return _answerView;
}

#pragma mark  隐藏或显示某个view

-(void)operateView:(UIView *)view withState:(BOOL)state {
    
    for (UIView *sub in self.viewArr) {
        
        if (sub == view) {
            sub.hidden = state;
        }else{
            sub.hidden = !state;
        }
        
    }
}



-(NSMutableArray *)viewArr{
    
    if (!_viewArr) {
        _viewArr = [NSMutableArray array];
    }
    return _viewArr;
    
}

@end
