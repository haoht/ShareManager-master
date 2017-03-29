
第三方分享的封装 (Third-party share wrapper)
===============

Demo:

	ShareManager *manager = [ShareManager sharedInstance];
	   [manager shareWithType:type content:@"content" container:self authViewStyle:0 result:^(int type, int state, id statusInfo, id error, BOOL end) {
	       
	   }];


