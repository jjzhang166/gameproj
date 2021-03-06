加载配置脚本文件("通用配置.lua")

------------------------------------------------------------------------------------------------------------------------------
--仓库号当面交易专用脚本默认不会进入每个副本后采集一些东西
--要采集的东西，请去 通用配置.lua 里搜索这几个关键字，那里有详细说明：通用_需要进入副本后采集一些东西、通用_进入副本后采集一些东西
--如果你想进入副本后采集一些东西，你可以在下面这一条指令前面加上注释（注释就是这两个字符：--），即：--通用_需要进入副本后采集一些东西 = 假
通用_需要进入副本后采集一些东西 = 假
------------------------------------------------------------------------------------------------------------------------------
--*******************这里的变量和代码，你不需要管**********************
进入游戏后只执行一次标记 = 假
清空存仓库物品白名单()
------------------------------------------------------------------------------------------------------------------------------
--*******************你想单独定义的函数或变量请在这里搞，想查看定义方式就去看自带的函数或变量的定义，然后复制粘贴，还有不明白的就去看 通用配置.lua开头处的详细说明*******************
--想要使用本文件的号单独去邮寄跟通用配置里不一样的东西的话，就把下面的非注释内容取消掉注释
--定义函数 通用配置_处理一次邮寄()
	--处理所有邮件("米拉德村", "信差艾露秋梨欧")
	--比如：{ { "怪鸟之翼", 1 }, { "护石", 10, 真 }, { "一角龙之翼", -1 } }，
	--其中数字1表示邮寄怪鸟之翼的数量为1，-1表示邮寄所有一角龙之翼。其中护石那一项，第三个参数是个布尔类型，可不填，不填即为假，为真表示护石达到了10个才会去邮寄。
	--[[
	通用_发送邮件(
	{
		{ "怪鸟之翼", 1 }, { "一角龙之翼", -1 },		--邮寄的这两个物品，第三个参数都没填，怪鸟之翼表示有1个就邮寄1个，有两个也邮寄1个。一角龙之翼表示有多少邮寄多少
		{ "护石", 10, 真 }			--第三项为真，表示护石的数量大于等于10才会去邮寄，邮寄的数量是拥有的护石的数量。
	}, 30,	--30这个参数表示要邮寄的金币，为0表示不邮寄金币，可以为负数，比如-2的话，表示身上保留2个金币，其实全邮寄出去。
	"这里填你要邮寄给的角色名")
	--]]

	--这个命令你可以写多个，让它执行多次，但没必要执行过多次。
	--[[
	通用_发送邮件({ { "怪鸟之翼", 1 }, { "一角龙之翼", -1 }, { "护石", 10, 真 } }, 30, "这里填你要邮寄给的角色名")
	--]]

	--邮寄任意物品 与 发送邮件 命令类似，都有五个参数，后四个参数含义一致
	--第一个参数是指定邮寄数量，数字类型，不可为空。当物品的数量达到指定邮寄数量，便会去邮寄。
	--通用_邮寄任意物品(60, 30, "这里填你要邮寄给的角色名")
--结束

通用配置_特殊的配置数据()

--由于使用了当面交易，所以邮寄功能可以不用了
定义函数 通用配置_处理一次邮寄()
	处理所有邮件("米拉德村", "信差艾露秋梨欧")
结束

--如果你想这个脚本文件跟通用里的处理不一样的话，你就可以把下面的注释取消掉，并从 通用配置 里把相关内容复制过来，然后再作针对性的修改
--定义函数 通用_仓库号交易前的处理()
--结束
--服务器线路你可以单独去配置
--设置要选择的第几个服务器线路(4)
---------------------------------------------------------------
--*******************这里的变量，你不需要管**********************
局部变量 打高级副本失败次数 = 0
---------------------------------------------------------------
--想要决定什么时候换角色，请在这里搞，返回 真 就会换号，返回 假 不会换号
定义函数 需要中断处理任务()
	--局部变量 当前的角色等级 = 角色等级()
	--角色不满级的时候，才会去判断剩余单倍经验和剩余双倍经验
	--如果 当前的角色等级 < 50 那么
		--剩余单倍经验和剩余双倍经验同时小于等于0的时候，就会返回 真，就会换号
		--如果 剩余单倍经验() <= 0 且 剩余双倍经验() <= 0 那么
			--返回 真
		--结束
	--结束

	--如果 剩余狩猎券() <= 0 那么
		--返回 真
	--结束

	--此函数用来判断换角色
	--如果 得到当前有效的副本消费模式() < 0 那么
		--返回 真
	--结束

	--如果满级了才能用这个脚本，那么就把下面的注释取消掉
	--如果 角色等级() < 50 那么
		--返回 真
	--结束
	返回 假
结束

定义函数 中断处理任务前的处理()

	通用配置_处理一次邮寄()

	设置疲劳值(0)
	返回 换角色()
结束

定义函数 进入游戏后只执行一次()
	如果 进入游戏后只执行一次标记 == 真 那么
		返回
	结束

	进入游戏后只执行一次标记 = 真
结束

--如果想中止循环就返回假，否则返回真
定义函数 每次循环所做的事()
	如果 需要中断处理任务() 那么
		如果 中断处理任务前的处理() 那么
			返回 假
		否则
			返回 真
		结束
	结束

	购买一些对方阵营的拍卖物品()
	通用_处理拍卖行()
	--想要使用一些物品，就是在 通用_处理礼包 这个函数里添加，请在 通用功能.lua里搜 通用_处理礼包
	通用_处理礼包()
	存放一些背包物品到仓库(100)
	--卖掉仓库和背包的垃圾物品(8, 10, "希美伦山路", "流浪的斯通")

	通用_仓库号进行当面交易()

	返回 真
结束

定义函数 处理循环逻辑()
	--如果想要角色进入游戏后就邮寄一次，请把下面的注释取消掉
	--通用配置_处理一次邮寄()

	-------------------------------------------------------------------------------
	--重置变量
	-------------------------------------------------------------------------------
	通用_处理进入角色后的每次循环(每次循环所做的事)
结束

--第4个参数是要选择第几个角色，默认是第1个角色
通用_主逻辑循环(进入游戏后只执行一次, 处理循环逻辑, 空, 1)
