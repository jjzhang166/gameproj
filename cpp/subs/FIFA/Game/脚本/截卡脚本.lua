
加载脚本文件("配置信息.lua");

--参数是EP价格
--表示自己拍卖的球员的价格大于等于这个参数，则普通号收不到这个拍卖信息
设置对方阵营不会接收到拍卖信息的价格(200000);
--球员价值大于这个参数，控制台就会收到提示
设置高价值球员提示(2500001);
--参数是时间，单位小时
--设置拍卖超时下架时间(10)->某球员等待售出的时间不能超过10小时，否则下架
设置拍卖超时下架时间(2);

定义函数 截卡流程()

	--第一个参数是球员ID，第二个参数强化等级，第三个参数是球员价格
	--当这个球员的价格小于等于第三个参数时 就会买下来
	--第一个参数是球员的ID，球员的ID可以这样获取：
	--FIFA Online 3\_cache\externalAssets\players 或 FIFA Online 3\_cache\ob\externalAssets\players
	--在上面两个目录下可以看到类似p10535.png的图片文件
	--把p10535前面的p去掉，在前面加上88，就组合成了球员的ID，即8810535
	--球员ID现在也可以通过控制台来查看了，选择 查看此号球员信息 即可
	对指定的球员进行截卡(88209763, 1, 2000);
结束

定义函数 刷新交易信息()
	自动刷新我的出售列表();
	延迟(500);
	自动刷新教练信息();
	延迟(300);
	自动处理下架();
	延迟(300);
	接收保管箱物品();
	延迟(300);
结束

定义函数 主逻辑循环()
	如果 可以选择教练() 那么
		进入游戏();
	否则如果 进入到游戏() 那么
		关闭每日任务框();

		如果 可以买GP礼包(3) 那么
			买GP礼包(3);
		结束

		选择友谊赛();
		选择经理人模式();
	否则如果 比赛完需要续约() 那么
		关闭每日任务框();
		按ESC键();
		解决卡续约问题()
		延迟(300);
		选择对阵好友();
	否则如果 只是在比赛房间() 那么
		关闭每日任务框();
		延迟(500);
		关闭每日任务框();
		选择对阵好友()
	否则如果 在比赛房间() 那么
		关闭每日任务框();
		如果 没有 选择了对阵电脑() 且 没有 选择了随机对手() 那么
			选择对阵电脑();
			输出脚本信息("第一次选择对阵电脑");
		否则
			如果 选择了随机对手() 那么
				解决有时不能交易问题();
				延迟(200);
				选择对阵电脑();
				输出脚本信息("选择对阵电脑");
			否则如果 选择了对阵电脑() 那么
				解决有时不能交易问题();
				延迟(200);
				选择随机对手();
				输出脚本信息("选择随机对手");
			结束
		结束

		延迟(500);

		--参数是分钟，即到了指定的时间，就会执行下面的 回到选择教练场景()
		--默认的是90分钟，就会回到选择教练场景，用来刷新数据
		如果 到了指定的时间间隔(90) 那么
			回到选择教练场景()
		结束
	结束
	返回 真
结束

循环 主逻辑循环() 执行
	延迟(4000);
	按ESC键();

	如果 可以执行仓库号的交易流程() 那么
		刷新交易信息();
	结束

	--参数是时间间隔，即每隔这段时间会执行下面的东西
	--到了截卡指定的时间间隔 是以分钟为单位。到了截卡指定的时间间隔_秒 是以秒为单位来计时的
	--默认30秒执行一次
	如果 到了截卡指定的时间间隔_秒(30) 那么
		截卡流程()
	结束
结束

