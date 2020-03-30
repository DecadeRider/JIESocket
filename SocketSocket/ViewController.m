//
//  ViewController.m
//  SocketSocket
//
//  Created by 黎永杰 on 2020/3/24.
//  Copyright © 2020 黎永杰. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h" // for TCP
#import "IQKeyboardManager.h"

@interface ViewController () <GCDAsyncSocketDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@property (weak, nonatomic) IBOutlet UITextView *receiveTextView;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property (weak, nonatomic) IBOutlet UIButton *connectButton;

@property (weak, nonatomic) IBOutlet UIButton *disConnectButton;


@property (nonatomic, strong) GCDAsyncSocket *clientSocket;

@property (nonatomic, assign) BOOL isConnect;

// 计时器
@property (nonatomic, strong) NSTimer *connectTimer;

//@property (nonatomic, strong) gcdcon\

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.receiveTextView.layer.masksToBounds = YES;
    self.receiveTextView.layer.cornerRadius = 10;
    self.receiveTextView.layer.borderWidth = 1.f;
    self.receiveTextView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.sendButton.layer.cornerRadius = 25.f;
    self.sendButton.layer.borderWidth = 3.f;
    self.sendButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    self.connectButton.layer.cornerRadius = 10.f;
    self.connectButton.layer.borderWidth = 1.f;
    self.connectButton.layer.borderColor = [UIColor purpleColor].CGColor;
    
    
    self.disConnectButton.layer.cornerRadius = 10;
    self.disConnectButton.layer.borderWidth = 1.f;
    self.disConnectButton.layer.borderColor = [UIColor purpleColor].CGColor;

    [[IQKeyboardManager sharedManager] setEnable:YES];
    
}

- (GCDAsyncSocket *)clientSocket {
    
    if (!_clientSocket) {
        _clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return _clientSocket;
}


- (IBAction)sendMessageAction:(id)sender {
    
    NSData *data = [self.inputTextField.text dataUsingEncoding:NSUTF8StringEncoding];
    // withTimeout -1 : 无穷大,一直等
    // tag : 消息标记
    [self.clientSocket writeData:data withTimeout:- 1 tag:0];
}


- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
//    NSLog(@"连接主机对应端口%@", sock);
    
    NSLog(@"链接成功");
//    [self showMessageWithStr:@"链接成功"];
    NSLog(@"%@",[NSString stringWithFormat:@"服务器IP: %@-------端口: %d", host,port]);
//    [self showMessageWithStr:[NSString stringWithFormat:@"服务器IP: %@-------端口: %d", host,port]];

    // 连接成功开启定时器
    [self addTimer];
    // 连接后,可读取服务端的数据
    [self.clientSocket readDataWithTimeout:- 1 tag:0];
    self.isConnect = YES;
}

/**
 读取数据

 @param sock 客户端socket
 @param data 读取到的数据
 @param tag 本次读取的标记
 */
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    [self showMessageWithStr:text];
    self.receiveTextView.text = text;
    // 读取到服务端数据值后,能再次读取
    [self.clientSocket readDataWithTimeout:- 1 tag:0];
}

// 添加定时器
- (void)addTimer
{
     // 长连接定时器
    self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];
     // 把定时器添加到当前运行循环,并且调为通用模式
    [[NSRunLoop currentRunLoop] addTimer:self.connectTimer forMode:NSRunLoopCommonModes];
}

// 心跳连接
- (void)longConnectToSocket
{
    // 发送固定格式的数据,指令@"longConnect"
    float version = [[UIDevice currentDevice] systemVersion].floatValue;
    NSString *longConnect = [NSString stringWithFormat:@"123%f",version];

    NSData  *data = [longConnect dataUsingEncoding:NSUTF8StringEncoding];

    [self.clientSocket writeData:data withTimeout:- 1 tag:0];
}


- (IBAction)connectAction:(id)sender {
    
    NSError *error = nil;
    [_clientSocket connectToHost:@"" onPort:8080 error:&error];
    
}

- (IBAction)disConnectAction:(id)sender {
    [_clientSocket disconnect];
    
}

@end
