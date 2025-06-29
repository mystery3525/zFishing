xdefm.besti = {}
xdefm.bestb = {}
xdefm.quest = {}
xdefm.langs = {}
xdefm.miscs.Menus = {}
xdefm.miscs.Notes = {}
xdefm.miscs.Marker = nil
xdefm.miscs.AimPan = nil
xdefm.miscs.Craft = nil
xdefm.miscs.Ings = nil
xdefm.miscs.Ing2 = nil
xdefm.miscs.LC = false
xdefm.miscs.CamAng = nil
xdefm.miscs.SeeAng = nil
xdefm.miscs.CrsPos = nil
xdefm.miscs.SkpCool = 0
xdefm.miscs.FOV = 1.5
xdefm.miscs.LFOV = 1.5
xdefm.miscs.KeyEnt = nil
xdefm.miscs.KeyLer = 0
xdefm.miscs.DX = 0
xdefm.miscs.DY = 0
xdefm.miscs.DL = 0
xdefm.miscs.LS = "_"
xdefm.miscs.DS = "_"
local yee, noo, Bck = Material( "icon16/tick.png" ), Material( "icon16/cross.png" ), Material( "gui/gradient_down" )

surface.CreateFont( "xdefm_Font1", { font = "Noto Sans SC", size = 20, weight = 1, antialias = true, bold = true } )
surface.CreateFont( "xdefm_Font2", { font = "Noto Sans SC", size = 15, weight = 1, antialias = true, bold = true } )
surface.CreateFont( "xdefm_Font3", { font = "Noto Sans SC", size = 50, weight = 1, antialias = true, bold = true } )
surface.CreateFont( "xdefm_Font4", { font = "Noto Sans SC", size = 30, weight = 1, antialias = true, bold = true } )
surface.CreateFont( "xdefm_Font5", { font = "Noto Sans SC", size = 25, weight = 1, antialias = true, bold = true } )
surface.CreateFont( "xdefm_Font6", { font = "Noto Sans SC", size = 30, weight = 1, antialias = true, bold = true } )
surface.CreateFont( "xdefm_Font7", { font = "Noto Sans SC", size = 20, weight = 1, antialias = true, bold = true } )

language.Add( "sent_xdefm_trashcan", "#xdefm.TrashCan" )
killicon.Add( "sent_xdefm_trashcan", "HUD/killicons/default", Color( 0, 255, 255, 255 ) )
language.Add( "sent_xdefm_equipment", "#xdefm.Equipment" )
killicon.Add( "sent_xdefm_equipment", "HUD/killicons/default", Color( 0, 255, 255, 255 ) )
killicon.Add( "sent_xdefm_plate", "HUD/killicons/default", Color( 0, 255, 255, 255 ) )
language.Add( "sent_xdefm_plate", "#xdefm.Plate" )
killicon.Add( "sent_xdefm_sonar", "HUD/killicons/default", Color( 0, 255, 255, 255 ) )
language.Add( "sent_xdefm_sonar", "#xdefm.Sonar" )
killicon.Add( "weapon_xdefm_rod", "HUD/killicons/default", Color( 0, 255, 255, 255 ) )
killicon.Add( "weapon_xdefm_builder", "HUD/killicons/default", Color( 0, 255, 255, 255 ) )
killicon.Add( "xdefm_firespot", "HUD/killicons/default", Color( 0, 255, 255, 255 ) )
language.Add( "xdefm_firespot", "#xdefm.FireSpot" )
killicon.Add( "xdefm_rod", "HUD/killicons/default", Color( 0, 255, 255, 255 ) )
killicon.Add( "xdefm_bobber", "HUD/killicons/default", Color( 0, 255, 255, 255 ) )
killicon.Add( "xdefm_hook", "HUD/killicons/default", Color( 0, 255, 255, 255 ) )
killicon.Add( "xdefm_base", "HUD/killicons/default", Color( 0, 255, 255, 255 ) )
language.Add( "xdefm_rod", "" )
language.Add( "xdefm_bobber", "" )
language.Add( "xdefm_hook", "" )
language.Add( "xdefm_base", "" )
language.Add( "xdefm.BaseItem", "" )
killicon.Add( "xdefm_dummy", "HUD/killicons/default", Color( 0, 255, 255, 255 ) )
language.Add( "xdefm_dummy", "" )
language.Add( "SBoxLimit_xdefmod_items", "You've hit the Items limit!" )

local I0, I1, I2 = Material( "vgui/cursors/arrow" ), Material( "icon16/basket_put.png" ), Material( "icon16/basket_go.png" )
local I3, I4, I5, I6 = Material( "icon16/coins.png" ), Material( "icon16/bin_closed.png" ), Material( "icon16/bug_go.png" ), Material( "icon16/script_go.png" )
local Bc1, Bc2 = Material( "gui/gradient_down" ), Material( "gui/gradient_up" )

xdefm.langs[ "zh-CN" ] = {
    [ "Version" ] = "版本", [ "Weapon_Rod" ] = "钓鱼竿", [ "Author" ] = "作者", [ "Purpos" ] = "目的", [ "Occupy" ] = "被占据: ",
    [ "Instruct" ] = "左键 - 蓄力/投掷鱼钩,投钩后放线\n右键 - 投钩后收线\nShift - 加速蓄力/收线\nAlt - 控制鱼竿方向\n投钩后左键 - 断开鱼线\nR - 断线",
    [ "Purpose" ] = "根据旧版钓鱼模组和地图的重写,仿制与扩充.", [ "NoHook" ] = "请先按左键释放鱼钩!", [ "NoBone" ] = "你选择的玩家模型没有支持的手部骨骼!", [ "Category" ] = "钓鱼", [ "Close" ] = "关闭",
    [ "Money" ] = "渔币", [ "Level" ] = "等级", [ "M1" ] = "背包", [ "M2" ] = "升级", [ "M3" ] = "状态", [ "Progress" ] = "进度",
    [ "M11" ] = "管理你的物品/鱼饵", [ "M22" ] = "使用技能点升级钓鱼能力", [ "M33" ] = "查看你的钓鱼记录", [ "BaseItem" ] = "",
    [ "Creature" ] = "生物", [ "Bait" ] = "鱼饵", [ "Pickup" ] = "捡起物品", [ "NotBait" ] = "该槽位仅限鱼饵,", [ "NotBai2" ] = "不是有效的鱼饵!", [ "Drop" ] = "丢弃",
    [ "Destroy" ] = "销毁", [ "Trashed" ] = "销毁物品", [ "Dropped" ] = "丢弃物品", [ "T1" ] = "普通", [ "T2" ] = "罕见",
    [ "T0" ] = "?", [ "T3" ] = "稀有", [ "T4" ] = "史诗", [ "T5" ] = "传说", [ "Price" ] = "价值", [ "Total" ] = "总数",
    [ "U1" ] = "捡起", [ "Store" ] = "存储", [ "Owner" ] = "物主", [ "Useless" ] = "物品", [ "NotMine" ] = "你没有权限进行该操作!",
    [ "FullInv" ] = "你的背包已满!", [ "Length" ] = "长度", [ "Depth" ] = "深度", [ "Bobber" ] = "浮漂", [ "Hook" ] = "鱼钩",
    [ "Uplevel" ] = "你升级了!", [ "Skp" ] = "技能点", [ "UpdA" ] = "鱼竿大小", [ "UpdB" ] = "鱼线长度", [ "UpdC" ] = "收线速度", [ "UpdG" ] = "额外鱼钩",
    [ "UpdD" ] = "鱼线韧性", [ "UpdE" ] = "钓鱼效率", [ "UpdF" ] = "银行存储", [ "Upgraded" ] = "能力已升级", [ "Downgraded" ] = "能力已降级",
    [ "StillFishing" ] = "无法在钓鱼时进行此操作!", [ "U2" ] = "使用", [ "TCatch" ] = "总钓鱼数", [ "CBait" ] = "你的鱼饵已被消耗", [ "M55" ] = "购买能帮助你钓到更多物品的鱼饵",
    [ "U3" ] = "查看", [ "NoMoney" ] = "你的渔币不够!", [ "NoLevel" ] = "你的等级不够!", [ "M5" ] = "鱼饵商店", [ "Cost" ] = "花费",
    [ "Bought" ] = "购买物品", [ "Sell" ] = "出售", [ "Sold" ] = "出售物品", [ "TExp" ] = "总经验数", [ "TEarn" ] = "总赚钱数",
    [ "TBuy" ] = "总购买数", [ "Weapon_Inventory" ] = "背包", [ "FList" ] = "好友列表", [ "Player" ] = "玩家", [ "FriendAdd" ] = "输入玩家名称或SteamID",
    [ "Instruct3" ] = "左键(指令:xdefmod_openbnk) - 背包和银行\n右键(指令:xdefmod_opencft) - 背包和制作\nE+左键(指令:xdefmod_openbes) - 图鉴\nE+右键(指令:xdefmod_openfri) - 好友列表\n绑定指令键位可以无需该武器进行操作",
    [ "Bank" ] = "银行", [ "Take" ] = "拿走", [ "Buy" ] = "购买", [ "Equip" ] = "装备", [ "Durability" ] = "耐久",
    [ "FullSto" ] = "该容器已满!", [ "Type" ] = "类型", [ "Friend" ] = "好友", [ "FriendAd2" ] = "添加好友", [ "Dequip" ] = "卸下",
    [ "FriendAd3" ] = "未找到指定玩家!", [ "Allow" ] = "允许", [ "Disallow" ] = "禁止", [ "FriendAd4" ] = "添加好友", [ "FriendAd5" ] = "你只能添加16名好友",
    [ "Apply" ] = "确定", [ "FriendAd5" ] = "好友列表已更新", [ "Delete" ] = "删除好友", [ "Reset" ] = "重置", [ "CleanRefund" ] = "清图补偿",
    [ "Consume" ] = "消耗率", [ "GetMoney" ] = "获得渔币", [ "U4" ] = "开关", [ "FireSpot" ] = "火", [ "NotFit" ] = "该物品不能放在这里!",
    [ "Weapon_Trade" ] = "交易", [ "Instruct4" ] = "左键 - 开始/结束交易\n右键(指令:xdefmod_opentrd) - 打开交易界面\nR - 开关交易屏蔽\n你不能与屏蔽交易或者没有交易武器的人交易.",
    [ "Trade1" ] = "没有目标", [ "Trade2" ] = "正在与玩家交易", [ "Trade3" ] = "发送交易请求", [ "Trade4" ] = "接受交易请求", [ "Trade5" ] = "这不是一个玩家",
    [ "Trade6" ] = "没有携带交易武器", [ "Trade7" ] = "屏蔽了交易请求", [ "Trade8" ] = "正在与其他玩家交易", [ "TradeStat" ] = "交易请求",
    [ "Trade9" ] = "请先取消交易屏蔽!", [ "Trade10" ] = "想要与你交易", [ "Trade11" ] = "正在与你交易", [ "Trade12" ] = "等待对方接受交易", [ "Trade13" ] = "按下",
    [ "Trade14" ] = "打开交易菜单", [ "Trade15" ] = "你现在正在与 ", [ "Trade16" ] = " 交易, 打开交易界面来交换物品", [ "Trade17" ] = "没有交易对象...", [ "PutMoney" ] = "输入交易的渔币数量...",
    [ "PutMone2" ] = "按下以确定渔币数值", [ "PutMone3" ] = "按下以取走渔币", [ "NotTrading" ] = "无法在未交易时进行此操作!", [ "ReadyY" ] = "已准备", [ "ReadyN" ] = "未准备",
    [ "Trade18" ] = "交易完成!", [ "ClearP" ] = "重置加点", [ "Confirm" ] = "确定", [ "ClearedP" ] = "你的技能点已被重置.", [ "CopiedID" ] = "已复制该玩家的SteamID.",
    [ "UCat" ] = "钓鱼模组", [ "UMenuS1" ] = "服务端选项", [ "UMenuC1" ] = "客户端选项", [ "UMenuS2" ] = "服务端XDE钓鱼模组选项. 只有服务器创建者有权利更改这些选项.", [ "UMenuC2" ] = "客户端XDE钓鱼模组选项. 仅影响你个人的游戏体验.", [ "UPart1" ] = "全部重置",
    [ "c_nodepth1" ] = "无视钓鱼深度", [ "c_nodepth2" ] = "取消物品的获取深度限制,但不取消深度对钓鱼效率的增益. 适合在浅水地图使用.",
    [ "c_refund1" ] = "清图补偿", [ "c_refund2" ] = "清理地图或服务器正常关闭后自动出售全图物品,可能会造成服务器性能问题. 对炸服无效.", [ "c_drawhalo1" ] = "实体光环效果",
    [ "c_noprophurt1" ] = "伤害保护", [ "c_noprophurt2" ] = "不在你的钓鱼好友列表的玩家无法伤害你的物品或被你的物品伤害.",
    [ "c_thief1" ] = "海鸥袭击率", [ "c_thief2" ] = "出现海鸥叼走物品的几率,不是确切数值.", [ "c_maxxdefmod_items" ] = "钓鱼物品上限",
    [ "c_tagdist1" ] = "标签距离", [ "c_renderdist1" ] = "物品渲染距离", [ "c_showhook1" ] = "显示鱼钩信息", [ "c_printnote1" ] = "保存消息至控制台", [ "ResetSkp" ] = "重置加点",
    [ "c_skpcool1" ] = "重置点数间隔", [ "c_skpcool2" ] = "重置点数多少秒后可以再次重置.", [ "c_salecool1" ] = "商店降价更新间隔", [ "c_salecool2" ] = "鱼饵商店每隔几分钟更新价格,0为保持平价.",
    [ "c_printcmd1" ] = "保存UI指令至控制台", [ "NoEnoughSkp" ] = "你的技能点不够!", [ "c_lbdelay1" ] = "排行榜更新间隔", [ "c_lbdelay2" ] = "每隔几分钟更新排行榜", [ "M4" ] = "排行榜",
    [ "M44" ] = "全服钓鱼等级最高的前十名玩家", [ "Name" ] = "名称", [ "NoInfo" ] = "暂无信息...", [ "Besti1" ] = "未知物品", [ "Sonar" ] = "声呐", [ "Sonar2" ] = "显示上钩的物品",
    [ "Besti2" ] = "未记录", [ "Besti3" ] = "已记录", [ "Besti4" ] = "物品已记录: ", [ "Collection" ] = "图鉴", [ "Plate3" ] = "展示中: ",
    [ "Angle" ] = "角度: ", [ "PageA" ] = "首页", [ "PageB" ] = "上页", [ "PageC" ] = "下页", [ "PageD" ] = "尾页", [ "Page" ] = "页码",
    [ "c_collect1" ] = "图鉴未收集提示", [ "Equipment" ] = "钓具盒", [ "Equipment2" ] = "获取/移除钓鱼模组的所有武器",
    [ "TrashCan" ] = "垃圾桶", [ "TrashCan2" ] = "卖出触碰的物品", [ "c_hurtrod1" ] = "鱼钩碰撞", [ "c_hurtrod2" ] = "玩家可以用鱼钩造成伤害.",
    [ "c_animui1" ] = "动态UI(低帧数会影响体验)", [ "c_quickinv1" ] = "快速打开背包", [ "Plate" ] = "展示盘", [ "Plate2" ] = "展示你的一个物品",
    [ "c_tempmode1" ] = "临时模式", [ "c_tempmode2" ] = "玩家无法捡起除鱼饵以外的物品,只能现场卖掉物品.", [ "c_thiefnerf1" ] = "弱化海鸥", [ "c_thiefnerf2" ] = "降低所有海鸥飞行速度但是你无法再通过击杀海鸥获得经验值.",
    [ "Radar" ] = "物品雷达", [ "Radar2" ] = "显示周围物品的位置", [ "Bucket" ] = "铁桶", [ "Bucket2" ] = "可以临时存储一定数量的物品.", [ "Recipe" ] = "图纸",
    [ "NotRecipe" ] = "该槽位仅限图纸,", [ "NotRecip2" ] = "不是有效的图纸!", [ "Product" ] = "产品", [ "NeedRecipe" ] = "请先放入图纸.",
    [ "Durability" ] = "耐久", [ "Materials" ] = "材料数", [ "NeedMat" ] = "制作所需材料不够!", [ "Crafted" ] = "合成物品", [ "TCraft" ] = "总制作数",
    [ "Bucket" ] = "铁桶", [ "Bucket2" ] = "临时存储16个小物品", [ "Quest" ] = "任务", [ "Quest2" ] = "上交特定物品获得奖励和经验值", [ "TQuest" ] = "任务完成数",
    [ "c_qsttime1" ] = "跳过任务冷却", [ "c_qsttime2" ] = "完成任务不会有冷却时间,单位为分钟.", [ "GetEXP" ] = "获得经验", [ "Require" ] = "需求", [ "Reward" ] = "奖励",
    [ "c_fastreel1" ] = "自动快速收线", [ "State" ] = "状态", [ "State1" ] = "进行中", [ "State2" ] = "未接受", [ "State3" ] = "冷却中",
    [ "Skip" ] = "跳过", [ "Finish" ] = "结算", [ "QuestBoard" ] = "任务板", [ "Deny1" ] = "缺少所需任务物品!", [ "Deny2" ] = "背包不够容纳奖励!", [ "Deny3" ] = "跳过任务冷却中!",
    [ "Complete" ] = "任务已完成!", [ "Skipped" ] = "任务已跳过.", [ "Failed" ] = "你在未完成任务的情况下退出了游戏,请等待一段时间再接受任务.", [ "QuestSt" ] = "任务开始!", [ "Caught" ] = "捕获",
    [ "c_fps1" ] = "第一人称", [ "DarkRP" ] = "货币兑换机", [ "c_darkrp1" ] = "RP模式兑换汇率", [ "c_darkrp2" ] = "汇率 = DarkRP货币 / 钓鱼货币 * 99%", [ "DarkRP2" ] = "相互兑换鱼币和DarkRP货币",
    [ "NotRP" ] = "本服务器未处于DarkRP模式！", [ "FMoney" ] = "钓鱼货币", [ "DMoney" ] = "DarkRP货币", [ "DRate" ] = "兑换汇率", [ "Exchanged" ] = "货币已兑换",
    [ "DEnter" ] = "输入兑换数值...", [ "Conv1" ] = "兑换为DarkRP", [ "Conv2" ] = "兑换为钓鱼", [ "DarkNPC" ] = "渔夫", [ "DarkNPC2" ] = "我能为你做点什么?",
    [ "NPC1" ] = "获取/放回钓鱼装备", [ "NPC2" ] = "卖出背包内全部物品", [ "NPC3" ] = "打开背包和银行", [ "NPC4" ] = "打开背包和合成", [ "NPC5" ] = "打开图鉴", [ "NPC6" ] = "打开任务", [ "NPC7" ] = "打开RP模式货币转换",
    [ "c_bg" ] = "界面背景颜色", [ "c_br" ] = "界面勾线颜色", [ "Weapon_Craft" ] = "合成", [ "Structure" ] = "建筑", [ "Interact" ] = "互动",
    [ "ST0" ] = "其他建筑", [ "ST1" ] = "存储", [ "ST2" ] = "合成台", [ "ST3" ] = "商店", [ "c_nomorehook1" ] = "关闭多钩功能", [ "c_nomorehook2" ] = "有人说多钩卡服,没办法哎.",
    [ "NoMoreHook" ] = "额外鱼钩已被服务器禁止!", [ "NotEmpty" ] = "不是空的!",
}
xdefm.langs[ "en" ] = {
    [ "Version" ] = "Version", [ "Weapon_Rod" ] = "Fishing Rod", [ "Author" ] = "Author", [ "Purpos" ] = "Purpose",
    [ "Instruct" ] = "M1 - Charge/Throw the hook; Reel down after thrown\nM2 - Reel up after thrown\nShift - Speed up charging/reeling\nAlt - Control Rod Direction\nR - Break the reel",
    [ "Purpose" ] = "My own version of the Fishing Mod. Inspired by old fishing mods and maps.", [ "NoHook" ] = "Release the hook first!", [ "NoBone" ] = "Your playermodel doesnt have a proper hand bone!", [ "Category" ] = "Fishing", [ "Close" ] = "Close",
    [ "Money" ] = "Money", [ "Level" ] = "Level", [ "M1" ] = "Inventory", [ "M2" ] = "Upgrade", [ "M3" ] = "Stats", [ "Progress" ] = "Progress",
    [ "M11" ] = "Manage your items and baits", [ "M22" ] = "Upgrade your fishing abilities using skill points", [ "M33" ] = "Check your fishing records", [ "BaseItem" ] = "",
    [ "Creature" ] = "Creature", [ "Bait" ] = "Bait", [ "Pickup" ] = "New Item", [ "NotBait" ] = "This slot is for baits only,", [ "NotBai2" ] = "is not a valid bait!", [ "Drop" ] = "Drop",
    [ "Destroy" ] = "Destroy", [ "Trashed" ] = "Item Trashed", [ "Dropped" ] = "Item Dropped", [ "T1" ] = "Common", [ "T2" ] = "Uncommon",
    [ "T0" ] = "?", [ "T3" ] = "Rare", [ "T4" ] = "Legendary", [ "T5" ] = "Exotic", [ "Price" ] = "Price", [ "Total" ] = "Total",
    [ "U1" ] = "Pick Up", [ "Store" ] = "Store", [ "Owner" ] = "Owner", [ "Useless" ] = "Item", [ "NotMine" ] = "You have no right to do this!",
    [ "FullInv" ] = "Your inventory is full!", [ "Length" ] = "Length", [ "Depth" ] = "Depth", [ "Bobber" ] = "Bobber", [ "Hook" ] = "Hook",
    [ "Uplevel" ] = "Level Up!", [ "Skp" ] = "Skill Points", [ "UpdA" ] = "Rod Size", [ "UpdB" ] = "String Length", [ "UpdC" ] = "Reel Speed", [ "UpdG" ] = "Extra Hooks",
    [ "UpdD" ] = "String Strength", [ "UpdE" ] = "Discovery", [ "UpdF" ] = "Bank Slots", [ "Upgraded" ] = "Ability Upgraded", [ "Downgraded" ] = "Ability Downgraded",
    [ "StillFishing" ] = "Cant do this when fishing!", [ "U2" ] = "Use", [ "TCatch" ] = "Total Catch", [ "CBait" ] = "Your bait has been consumed!", [ "M55" ] = "Buy baits for more stuffs",
    [ "NoMoney" ] = "You don't have enough money!", [ "NoLevel" ] = "Your level is not enough!", [ "M5" ] = "Bait Shop", [ "Cost" ] = "Cost",
    [ "Bought" ] = "Bought Item", [ "Sell" ] = "Sell", [ "Sold" ] = "Item Sold", [ "TExp" ] = "Total Exp", [ "TEarn" ] = "Total Earn",
    [ "TBuy" ] = "Total Buy", [ "Weapon_Inventory" ] = "Inventory", [ "FList" ] = "Friend List", [ "Player" ] = "Player", [ "FriendAdd" ] = "Enter Player Name or SteamID...",
    [ "Instruct3" ] = "M1(Command:xdefmod_openbnk) - Open Inventory and Bank\nM2(Command:xdefmod_opencft) - Open Inventory and Crafting\nE+M1(Command:xdefmod_openbes) - Open Collection\nE+M2(Command:xdefmod_openfri) - Open Friend List\nBind the commands to open menus without the SWEP",
    [ "Bank" ] = "Bank", [ "Take" ] = "Take", [ "Buy" ] = "Buy", [ "Equip" ] = "Equip", [ "Durability" ] = "Durability",
    [ "FullSto" ] = "This storage is full!", [ "Type" ] = "Type", [ "Friend" ] = "Friend", [ "FriendAd2" ] = "Press to add friend",
    [ "FriendAd3" ] = "Player not found!", [ "Allow" ] = "Allow", [ "Disallow" ] = "Disallow", [ "FriendAd4" ] = "Friend Added", [ "FriendAd5" ] = "You can only add 16 friends!",
    [ "Apply" ] = "Apply", [ "FriendAd5" ] = "Friend List Updated!", [ "Delete" ] = "Delete Friend", [ "Reset" ] = "Reset", [ "CleanRefund" ] = "Cleanup Refund",
    [ "Consume" ] = "Consume Rate", [ "GetMoney" ] = "Get Money", [ "U4" ] = "Toggle", [ "FireSpot" ] = "Fire", [ "NotFit" ] = "This item cant be placed here!",
    [ "Weapon_Trade" ] = "Trade", [ "Instruct4" ] = "M1 - Start/Stop Trading\nM2(Command:xdefmod_opentrd) - Open trade menu\nR - Toggle blocking trade offers\nYou cant trade with players who dont have this weapon",
    [ "Trade1" ] = "No Target", [ "Trade2" ] = "Trading with", [ "Trade3" ] = "Send trade offer", [ "Trade4" ] = "Accept trade offer", [ "Trade5" ] = "Invalid Target",
    [ "Trade6" ] = "doesn't have a Trade weapon", [ "Trade7" ] = "has blocked Trade Offers", [ "Trade8" ] = "is trading with others", [ "TradeStat" ] = "Trade Offers",
    [ "Trade9" ] = "Unblock Trade Offers first!", [ "Trade10" ] = "wants to trade with you", [ "Trade11" ] = "is trading with you", [ "Trade12" ] = "Waiting to be accepted", [ "Trade13" ] = "Press",
    [ "Trade14" ] = "to open trade menu", [ "Trade15" ] = "You are now trading with ", [ "Trade16" ] = ". Open Trade Menu to exchange items.", [ "Trade17" ] = "No Trader...", [ "PutMoney" ] = "Insert amount of money to trade...",
    [ "PutMone2" ] = "Press to confirm", [ "PutMone3" ] = "Press to take", [ "NotTrading" ] = "Cant do this while not trading!", [ "ReadyY" ] = "Ready", [ "ReadyN" ] = "Not Ready",
    [ "Trade18" ] = "Trade success!", [ "ClearP" ] = "Clear Points", [ "Confirm" ] = "Confirm", [ "ClearedP" ] = "Your skill points have been reset.",
    [ "CopiedID" ] = "SteamID of the player has been copied.", [ "Dequip" ] = "Dequip",
    [ "UCat" ] = "Fishing", [ "UMenuS1" ] = "Serverside settings", [ "UMenuC1" ] = "Clientside settings", [ "UMenuS2" ] = "Serversize XDE Fishing Mod settings. These can only be changed by server host.", [ "UMenuC2" ] = "Clientside XDE Fishing Mod settings. These only affect your own gaming experience.", [ "UPart1" ] = "Reset everything",
    [ "c_nodepth1" ] = "Ignore fishing depth", [ "c_nodepth2" ] = "Disable depth detection. Useful in maps with shallow water.",
    [ "c_refund1" ] = "Cleanup refund", [ "c_refund2" ] = "Automatically sell all the items before cleanup or manual shutdown, may cause lags.",
    [ "c_thief1" ] = "Thief chance", [ "c_thief2" ] = "The possibility of seagull/crow attack, not the exact chance.",
    [ "c_noprophurt1" ] = "Damage protection", [ "c_noprophurt2" ] = "Players not in your fishing friend list cannot damage your items or be damaged by your items.",
    [ "c_maxxdefmod_items" ] = "Max Items", [ "c_drawhalo1" ] = "Entity halo effect",
    [ "c_tagdist1" ] = "Tag display distance", [ "c_renderdist1" ] = "Item render distance", [ "c_showhook1" ] = "Show hook info", [ "c_printnote1" ] = "Print hints at console",
    [ "ResetSkp" ] = "Reset Skill Points", [ "c_hurtrod1" ] = "Hook Collision", [ "c_hurtrod2" ] = "Allow fishing hooks collide with players/npcs.",
    [ "c_skpcool1" ] = "Skill points reset cooldown", [ "c_skpcool2" ] = "How soon can a player reset skill points again (in second).", [ "c_salecool1" ] = "Shop sale update", [ "c_salecool2" ] = "Update bait shop prices every X minutes, 0 = no sales.",
    [ "c_printcmd1" ] = "Print UI commands at console", [ "NoEnoughSkp" ] = "You dont have enough skill points!", [ "c_lbdelay1" ] = "Leaderboard update", [ "c_lbdelay2" ] = "Update leaderboard every X minutes, 0 = disable leaderboard.", [ "M4" ] = "Leaderboard",
    [ "M44" ] = "Top 10 players of the server", [ "Name" ] = "Name", [ "NoInfo" ] = "No Info...", [ "Besti1" ] = "Invalid Item",
    [ "Besti2" ] = "Not Recorded", [ "Besti3" ] = "Recorded", [ "Besti4" ] = "Item Recorded: ", [ "Sonar" ] = "Sonar", [ "Sonar2" ] = "Display your catches",
    [ "Angle" ] = "Angle: ", [ "PageA" ] = "<<", [ "PageB" ] = "<", [ "PageC" ] = ">", [ "PageD" ] = ">>", [ "Page" ] = "Page",
    [ "c_collect1" ] = "Collection reminder", [ "Equipment" ] = "Equipment Kit", [ "Equipment2" ] = "Get/Strip all the weapons in Fishing Mod",
    [ "TrashCan" ] = "Trashcan", [ "TrashCan2" ] = "Sell items on touch", [ "Collection" ] = "Collection", [ "Plate" ] = "Display Plate", [ "Plate3" ] = "Displaying: ",
    [ "c_animui1" ] = "Animated UI(Sluggish when in low fps)", [ "c_quickinv1" ] = "Quick Inventory", [ "Plate2" ] = "Display one of your item",
    [ "c_tempmode1" ] = "Temp Mode", [ "c_tempmode2" ] = "Players can no longer 'carry' items but only sell them using R+E.", [ "c_thiefnerf1" ] = "Nerfed Theft", [ "c_thiefnerf2" ] = "Slow down seagulls but you can no longer get exps from killing them.",
    [ "Radar" ] = "Item Radar", [ "Radar2" ] = "Show the location of owner's items", [ "Recipe" ] = "Recipe",
    [ "NotRecipe" ] = "This slot is for recipes only,", [ "TCraft" ] = "Total Craft", [ "NotRecip2" ] = "Is not a valid recipe!", [ "Product" ] = "Products", [ "NeedRecipe" ] = "Insert a recipe here.",
    [ "Durability" ] = "Durability", [ "Materials" ] = "Materials", [ "NeedMat" ] = "No enough ingredients!", [ "Crafted" ] = "Item Crafted", [ "GetEXP" ] = "Get EXP",
    [ "Bucket" ] = "Bucket", [ "Bucket2" ] = "Store 16 small items temporarily", [ "Quest" ] = "Quest", [ "Quest2" ] = "Find certain items to gain rewards and exps",
    [ "c_qsttime1" ] = "Skip Quest Cooldown", [ "c_qsttime2" ] = "Cooldown if you skip a quest( in minutes )", [ "TQuest" ] = "Quests Completed",
    [ "c_fastreel1" ] = "Auto fast reel", [ "State" ] = "State", [ "State1" ] = "Ongoing", [ "State2" ] = "Available", [ "State3" ] = "Cooldown",
    [ "Require" ] = "Requires", [ "Reward" ] = "Reward", [ "Skip" ] = "Skip", [ "Finish" ] = "Check", [ "QuestBoard" ] = "Quest Board", [ "QuestSt" ] = "Quest Start!",
    [ "Deny1" ] = "Missing required quest item(s)!", [ "Deny2" ] = "No enough inventory space for reward!", [ "Deny3" ] = "Skipping is in cooldown!", [ "Caught" ] = "Caught",
    [ "Complete" ] = "Mission Complete!", [ "Skipped" ] = "Quest Skipped.", [ "Failed" ] = "You have disconnected before completing the quest, so you cant take another quest for a few minutes.",
    [ "c_fps1" ] = "First person", [ "DarkRP" ] = "Currency Convert", [ "c_darkrp1" ] = "Currency Convert Rate", [ "c_darkrp2" ] = "Rate = DarkRP / Fishing * 99%", [ "DarkRP2" ] = "Convert Fishing Currency and DarkRP Money",
    [ "NotRP" ] = "This server is not running in DarkRP gamemode!", [ "FMoney" ] = "Fishing Money", [ "DMoney" ] = "DarkRP Money", [ "DRate" ] = "Convert Rate", [ "Exchanged" ] = "Currency Converted",
    [ "DEnter" ] = "Enter Convert Value...", [ "Conv1" ] = "To DarkRP", [ "Conv2" ] = "To Fishing", [ "DarkNPC" ] = "Fisherman", [ "DarkNPC2" ] = "What can I do for you?",
    [ "NPC1" ] = "Equip/Unequip Fishing Equipments", [ "NPC2" ] = "Sell Everything", [ "NPC3" ] = "Open Inventory and Bank", [ "NPC4" ] = "Open Inventory and Crafting", [ "NPC5" ] = "Open Collection Menu", [ "NPC6" ] = "Open Quest Eenu", [ "NPC7" ] = "Open Currency Conversion",
    [ "c_bg" ] = "Menu background color", [ "c_br" ] = "Menu outline color", [ "Weapon_Craft" ] = "Crafting", [ "Structure" ] = "Structure", [ "U3" ] = "Interact",
    [ "ST0" ] = "Structure", [ "ST1" ] = "Storage", [ "ST2" ] = "Crafting", [ "ST3" ] = "Shop", [ "c_nomorehook1" ] = "Disable Extra Hooks", [ "c_nomorehook2" ] = "Since some say it causes lags.",
    [ "NoMoreHook" ] = "Extra Hooks is disabled in this server!", [ "NotEmpty" ] = "Is not empty!",
}
local ln, lg, be = GetConVar( "gmod_language" ):GetString(), "en", "xdefishmod/bestiary.txt"
if ln != nil and istable( xdefm.langs[ ln ] ) then
    lg = GetConVar( "gmod_language" ):GetString()
end
for holder, text in pairs( xdefm.langs[ lg ] ) do
    language.Add( "xdefm."..holder, text )
end
if file.Exists( be, "DATA" ) then
    local dat = file.Read( be, "DATA" )
    if isstring( dat ) and istable( util.JSONToTable( dat ) ) then
        xdefm.besti = util.JSONToTable( dat )
    end
end
list.Set( "ContentCategoryIcons", "#xdefm.Category", "icon16/fishing.png" )
function xdefm_BestiarySave()
    if !file.IsDir( "xdefishmod", "DATA" ) then
        file.CreateDir( "xdefishmod" )
    end
    file.Write( "xdefishmod/bestiary.txt", util.TableToJSON( xdefm.besti, true ) )
end
function xdefm_SlotBox( x, y, w, h, slo, ext, ico, con )
    if !isnumber( x ) or !isnumber( y ) or !isnumber( w ) or !isnumber( h ) or !isnumber( slo ) then return end
    local pax = vgui.Create( "DButton" ) pax:SetSize( w, h ) pax:SetPos( x, y )  pax.S_Place = tostring( slo )  pax.B_OnMove = nil
    pax:SetCursor( "blank" ) pax.S_Type = "None"  pax:SetText( "" ) pax.B_OnMove = false  if ico != nil then
    pax.P_Sprite = vgui.Create( "DSprite", pax ) local spr = pax.P_Sprite  spr:SetMaterial( isstring( ico ) and Material( ico ) or ico )
    spr:SetPos( w*0.15, h*0.15 ) spr:SetSize( w*0.15, h*0.15 ) end if !con then pax:Droppable( "XDEFM_MenuDrop" ) end pax.N_Lerp = 1
    pax.T_Item = nil  pax.T_Extra = nil  pax.S_Name = ""  pax.N_Rarity = 0  pax.S_Item = "_" function pax:Paint( w, h ) local col = xdefm.miscs.Rarity[ pax.N_Rarity+1 ]
        if pax.N_Rarity != 0 then draw.RoundedBox( 0, 1, 1, w -2, h -2, Color( col.r*0.4, col.g*0.4, col.b*0.4 ) )
        if xdefm.miscs.AimPan == pax then pax.N_Lerp = Lerp( 0.2, pax.N_Lerp, 4 ) else pax.N_Lerp = Lerp( 0.2, pax.N_Lerp, 1 ) end
        else draw.RoundedBox( 0, 0, 0, w, h, col ) draw.RoundedBox( 0, 1, 1, w -2, h -2, Color( col.r*0.4, col.g*0.4, col.b*0.4 ) ) end
        local alp = math.Clamp( ( pax.N_Lerp -1 )/3, 0, 1 )*255
        surface.SetMaterial( Bc2 ) surface.SetDrawColor( Color( col.r*0.6, col.g*0.6, col.b*0.6, 255 -alp ) ) surface.DrawTexturedRect( 0, 0, w, h )
        surface.SetMaterial( Bc1 ) surface.SetDrawColor( Color( col.r*0.6, col.g*0.6, col.b*0.6, alp ) ) surface.DrawTexturedRect( 0, 0, w, h )
        surface.SetDrawColor( col ) surface.DrawOutlinedRect( 0, 0, w, h, pax.N_Lerp )
        draw.TextShadow( { text = isstring( ext ) and ext or "", pos = { (h-4), 4 },
            font = "xdefm_Font2", xalign = TEXT_ALIGN_RIGHT,
            yalign = TEXT_ALIGN_DOWN, color = Color( 255, 255, 255 ) }, 1, 255 )
    end if !con then
    function pax:DoClick() local ply = LocalPlayer() local typ, men, pro = pax.S_Type, xdefm.miscs.Menus, ply.xdefm_Profile
        if ( input.IsControlDown() or input.IsButtonDown( KEY_LCONTROL ) or input.IsButtonDown( KEY_RCONTROL ) ) and pax.S_Item != "_" then
        if typ == "Inventory" then xdefm_Command( ply, "DestroyInv", pax.S_Place ) end return end
        if ( input.IsShiftDown() or input.IsButtonDown( KEY_LSHIFT ) or input.IsButtonDown( KEY_RSHIFT ) ) and pax.S_Item != "_" then
        if typ == "Inventory" then
            if IsValid( men[ "Bank" ] ) then local num = 0
                for k, v in pairs( pro.Bnk ) do if k > pro.UpdF then break end
                if isstring( v ) and v == "_" then num = k break end end
                if num > 0 then xdefm_Command( ply, "MoveBank", pax.S_Place.."|"..num )
                else xdefm_AddNote( ply, "!V", "resource/warning.wav", "cross", 5 ) end return
            elseif IsValid( men[ "Structure" ] ) and men[ "Structure" ].N_SType == 1 then local num = 0
                for k, v in pairs( men[ "Structure" ].T_Items ) do
                if isstring( v ) and v == "_" then num = k break end end
                if num > 0 then xdefm_Command( ply, "Structure", pax.S_Place.."|"..num )
                else xdefm_AddNote( ply, "!V", "resource/warning.wav", "cross", 5 ) end return
            elseif !IsValid( men[ "Trade" ] ) then
                if pax.T_Item.Type == "Bait" and pax.S_Place != "21" then xdefm_Command( ply, "MoveInv", pax.S_Place.."|21" ) return
                elseif pax.T_Item.Type == "Bait" and pax.S_Place == "21" then
                    local num = 0  for k, v in pairs( pro.Items ) do
                        if isstring( v ) and v == "_" and k != 21 then num = k break end
                    end if num > 0 then xdefm_Command( ply, "MoveInv", pax.S_Place.."|"..num ) end return
                end
            end
            if IsValid( men[ "Craft" ] ) then
                if pax.T_Item.Type == "Recipe" then xdefm_Command( ply, "MoveCraft", pax.S_Place ) end return
            end
            if IsValid( men[ "Trade" ] ) and istable( men[ "Trade" ].T_Slo1 ) then
                local num = 0  for k, v in pairs( men[ "Trade" ].T_Slo1 ) do
                if isstring( v.S_Item ) and v.S_Item == "_" then num = k break end end
                if num > 0 then xdefm_Command( ply, "MoveTrade", pax.S_Place.."|"..num )
                else xdefm_AddNote( ply, "!V", "resource/warning.wav", "cross", 5 ) end return
            elseif pax.T_Item.Type == "Bait" and pax.S_Place != "21" then xdefm_Command( ply, "MoveInv", pax.S_Place.."|21" ) return end
        end
        if typ == "Bank" and men[ "Inventory" ] then
            local num = 0  for k, v in pairs( pro.Items ) do
                if isstring( v ) and v == "_" and ( k != 21 or pax.T_Item.Type == "Bait" ) then num = k break end
            end if num > 0 then xdefm_Command( ply, "MoveBank", num.."|"..pax.S_Place )
            else xdefm_AddNote( ply, "xdefm.FullInv", "resource/warning.wav", "cross", 5 ) end return
        end
        if typ == "Storage" and men[ "Inventory" ] then
            local num = 0  for k, v in pairs( pro.Items ) do
                if isstring( v ) and v == "_" and ( k != 21 or pax.T_Item.Type == "Bait" ) then num = k break end
            end if num > 0 then xdefm_Command( ply, "Structure", num.."|"..pax.S_Place )
            else xdefm_AddNote( ply, "xdefm.FullInv", "resource/warning.wav", "cross", 5 ) end return
        end
        if typ == "Trade" and men[ "Inventory" ] then
            local num = 0  for k, v in pairs( pro.Items ) do
                if isstring( v ) and v == "_" and ( k != 21 or pax.T_Item.Type == "Bait" ) then num = k break end
            end if num > 0 then xdefm_Command( ply, "MoveTrade", num.."|"..pax.S_Place )
            else xdefm_AddNote( ply, "xdefm.FullInv", "resource/warning.wav", "cross", 5 ) end return
        end
        if typ == "Recipe" and men[ "Inventory" ] then
            local num = 0  for k, v in pairs( pro.Items ) do
                if !isstring( v ) or k == 21 then continue end
                if v == "_" then num = k break end local aa, bb = xdefm_ItemGet( v )
            end if num > 0 then xdefm_Command( ply, "MoveCraft", num )
            else xdefm_AddNote( ply, "xdefm.FullInv", "resource/warning.wav", "cross", 5 ) end return
        end
    end end
    pax:Receiver( "XDEFM_MenuDrop", function( own, pan, drp ) --own是B,ppp是A,从A到B
        if ispanel( own ) and ispanel( pan[1] ) and pan[1].B_OnMove and drp then local ppp = pan[1]
            if own.S_Type == ppp.S_Type and own.S_Type == "Inventory" then
                xdefm_Command( LocalPlayer(), "MoveInv", own.S_Place.."|"..ppp.S_Place )
            end
            if own.S_Type != ppp.S_Type then
                if ppp.S_Type == "Inventory" and own.S_Type == "Bank" then
                    xdefm_Command( LocalPlayer(), "MoveBank", ppp.S_Place.."|"..own.S_Place )
                elseif own.S_Type == "Inventory" and ppp.S_Type == "Bank" then
                    xdefm_Command( LocalPlayer(), "MoveBank", own.S_Place.."|"..ppp.S_Place )
                end
                if ppp.S_Type == "Inventory" and own.S_Type == "Storage" then
                    xdefm_Command( LocalPlayer(), "Structure", ppp.S_Place.."|"..own.S_Place )
                elseif own.S_Type == "Inventory" and ppp.S_Type == "Storage" then
                    xdefm_Command( LocalPlayer(), "Structure", own.S_Place.."|"..ppp.S_Place )
                end
                if ppp.S_Type == "Inventory" and own.S_Type == "Trade" then
                    xdefm_Command( LocalPlayer(), "MoveTrade", ppp.S_Place.."|"..own.S_Place )
                elseif own.S_Type == "Inventory" and ppp.S_Type == "Trade" then
                    xdefm_Command( LocalPlayer(), "MoveTrade", own.S_Place.."|"..ppp.S_Place )
                end
                if ppp.S_Type == "Inventory" and own.S_Type == "Recipe" then
                    xdefm_Command( LocalPlayer(), "MoveCraft", ppp.S_Place )
                elseif own.S_Type == "Inventory" and ppp.S_Type == "Recipe" then
                    xdefm_Command( LocalPlayer(), "MoveCraft", own.S_Place )
                end
            end
            if own.S_Type == ppp.S_Type and own.S_Type == "Bank" then
                xdefm_Command( LocalPlayer(), "MoveBankOuter", own.S_Place.."|"..ppp.S_Place )
            end
            if own.S_Type == ppp.S_Type and own.S_Type == "Trade" then
                xdefm_Command( LocalPlayer(), "MoveTradeOuter", own.S_Place.."|"..ppp.S_Place )
            end
            if own.S_Type == ppp.S_Type and own.S_Type == "Storage" then
                xdefm_Command( LocalPlayer(), "StructOuter", own.S_Place.."|"..ppp.S_Place )
            end
        end
    end )
    function pax:Think()
        if isbool( self:IsDragging() ) and self.B_OnMove != self:IsDragging() then self.B_OnMove = self:IsDragging()
        end if xdefm.miscs.AimPan == pax then xdefm.miscs.Marker = pax.S_Item end
    end end
    function pax:OnCursorEntered() xdefm.miscs.AimPan = pax  xdefm.miscs.Marker = pax.S_Item  pax.B_OnMove = true  if pax.S_Item != "_" then xdefm.miscs.LC = false end end
    function pax:OnCursorExited() if xdefm.miscs.AimPan == pax then xdefm.miscs.AimPan = nil  xdefm.miscs.Marker = nil end  pax.B_OnMove = false end
    function pax:F_SetupItem( ite ) if !isstring( ite ) then return end local aa, bb = xdefm_ItemGet( ite )  if IsValid( pax.P_Txt ) then pax.P_Txt:Remove() end
        if !istable( aa ) or !istable( bb ) or ite == "_" or ite == "" then if IsValid( pax.P_Mdl ) then pax.P_Mdl:Remove() end
            pax.T_Item = nil  pax.T_Extra = nil  pax.S_Name = ""  pax.N_Rarity = 0  pax.S_Item = "_"  pax.N_Lerp = 1
        else if !IsValid( pax.P_Mdl ) then pax.P_Mdl = pax:Add( "ModelImage" ) pax.P_Mdl:DockMargin( 5, 5, 5, 5 )
                pax.P_Mdl:Dock( FILL ) pax.P_Mdl:SetModel( bb.Model[ 1 ] ) pax.P_Mdl:SetMouseInputEnabled( false )
            else pax.P_Mdl:SetModel( bb.Model[ 1 ] ) end pax.S_Name = bb.Name  pax.N_Rarity = math.Clamp( bb.Rarity, 0, 5 )
            pax.T_Item = bb  pax.T_Extra = aa  pax.S_Item = ite  local col = xdefm.miscs.Rarity[ pax.N_Rarity+1 ]
            local pap = vgui.Create( "DPanel", pax ) pap:SetSize( w, h*0.25 ) pap:SetPos( 0, h*0.75 ) pap:SetMouseInputEnabled( false )
            function pap:Paint( ww, hh ) if pax.N_Rarity !=0 then draw.RoundedBox( 0, 0, 0, ww, hh, Color( 0, 0, 0, 200 ) )
                surface.SetFont( "xdefm_Font2" )  local nam = ( pax.S_Name != "_" and pax.S_Name or "" ) local size, _ = surface.GetTextSize( nam )
                local xx = 0  if size >= w then xx = math.sin( CurTime()*2 )*size/2 end
                draw.TextShadow( { text = nam, pos = { ww/2 +xx/2, hh/2 }, font = "xdefm_Font2",
                    xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = col
                }, 1, 255 ) surface.SetDrawColor( col )
                surface.DrawOutlinedRect( 0, 0, w, math.ceil( h*0.25 ), 1 ) end
            end pax.P_Txt = pap
        end
    end
    return pax
end
function xdefm_CutBox( per, x, y, w, h, lu, ru, rd, ld )
    per = isnumber( per ) and per or 1
    local box = {}
    table.insert( box, { x = x, y = y +per } )
    if lu then
        table.insert( box, { x = x +per, y = y } )
    else
        table.insert( box, { x = x, y = y } )
    end
    if ru then
        table.insert( box, { x = x +w -per, y = y } )
        table.insert( box, { x = x +w, y = y +per } )
    else
        table.insert( box, { x = x +w, y = y } )
    end
    if rd then
        table.insert( box, { x = x +w, y = y +h -per } )
        table.insert( box, { x = x +w -per, y = y +h } )
    else
        table.insert( box, { x = x +w, y = y +h } )
    end
    if ld then
        table.insert( box, { x = x +per, y = y +h } )
        table.insert( box, { x = x, y = y +h -per } )
    else
        table.insert( box, { x = x, y = y +h } )
    end
    surface.DrawPoly( box )
end

hook.Add( "AddToolMenuCategories", "xdefm_UCat", function()
    spawnmenu.AddToolCategory( "Utilities", "XDEFMod", "#xdefm.UCat" )
end )
hook.Add( "InitPostEntity", "xdefm_LoadProfile", function()
    net.Start( "NET_xdefm_NeedProfile" )
    net.SendToServer()
end )
hook.Add( "PopulateToolMenu", "xdefm_UMenus", function()
    spawnmenu.AddToolMenuOption( "Utilities", "XDEFMod", "XDEFModSV", "#xdefm.UMenuS1", "", "", function( panel )
        panel:ClearControls() panel:Help( "#xdefm.UMenuS2" )
        local button = panel:Button( "#xdefm.UPart1" )
        function button:DoClick()
            RunConsoleCommand( "xdefmod_tempmode", 0 )
            RunConsoleCommand( "xdefmod_nodepth", 0 )
            RunConsoleCommand( "xdefmod_refund", 1 )
            RunConsoleCommand( "xdefmod_lbdelay", 10 )
            RunConsoleCommand( "xdefmod_thief", 10 )
            RunConsoleCommand( "sbox_maxxdefmod_items", 30 )
            RunConsoleCommand( "xdefmod_noprophurt", 1 )
            RunConsoleCommand( "xdefmod_hurtrod", 0 )
            RunConsoleCommand( "xdefmod_skpcool", 5 )
            RunConsoleCommand( "xdefmod_salecool", 5 )
            RunConsoleCommand( "xdefmod_thiefnerf", 0 )
            RunConsoleCommand( "xdefmod_qsttime", 10 )
            RunConsoleCommand( "xdefmod_darkrp", 0.05 )
            RunConsoleCommand( "xdefmod_nomorehook", 0 )
        end
        panel:CheckBox( "#xdefm.c_tempmode1", "xdefmod_tempmode" ) panel:ControlHelp( "#xdefm.c_tempmode2" )
        panel:CheckBox( "#xdefm.c_nodepth1", "xdefmod_nodepth" ) panel:ControlHelp( "#xdefm.c_nodepth2" )
        panel:CheckBox( "#xdefm.c_refund1", "xdefmod_refund" ) panel:ControlHelp( "#xdefm.c_refund2" )
        panel:CheckBox( "#xdefm.c_noprophurt1", "xdefmod_noprophurt" ) panel:ControlHelp( "#xdefm.c_noprophurt2" )
        panel:CheckBox( "#xdefm.c_hurtrod1", "xdefmod_hurtrod" ) panel:ControlHelp( "#xdefm.c_hurtrod2" )
        panel:CheckBox( "#xdefm.c_thiefnerf1", "xdefmod_thiefnerf" ) panel:ControlHelp( "#xdefm.c_thiefnerf2" )
        panel:CheckBox( "#xdefm.c_nomorehook1", "xdefmod_nomorehook" ) panel:ControlHelp( "#xdefm.c_nomorehook2" )
        panel:NumSlider( "#xdefm.c_thief1", "xdefmod_thief", 0, 100, 0 ) panel:ControlHelp( "#xdefm.c_thief2" )
        panel:NumSlider( "#xdefm.c_skpcool1", "xdefmod_skpcool", 0, 600, 0 ) panel:ControlHelp( "#xdefm.c_skpcool2" )
        panel:NumSlider( "#xdefm.c_salecool1", "xdefmod_salecool", 0, 60, 0 ) panel:ControlHelp( "#xdefm.c_salecool2" )
        panel:NumSlider( "#xdefm.c_lbdelay1", "xdefmod_lbdelay", 0, 60, 0 ) panel:ControlHelp( "#xdefm.c_lbdelay2" )
        panel:NumSlider( "#xdefm.c_qsttime1", "xdefmod_qsttime", 0, 60, 0 ) panel:ControlHelp( "#xdefm.c_qsttime2" )
        panel:NumSlider( "#xdefm.c_darkrp1", "xdefmod_darkrp", 0.01, 10, 2 ) panel:ControlHelp( "#xdefm.c_darkrp2" )
        panel:NumSlider( "#xdefm.c_maxxdefmod_items", "sbox_maxxdefmod_items", 0, 200, 0 )
    end )
    spawnmenu.AddToolMenuOption( "Utilities", "XDEFMod", "XDEFModCL", "#xdefm.UMenuC1", "", "", function( panel )
        panel:ClearControls()
        panel:Help( "#xdefm.UMenuC2" )
        local button = panel:Button( "#xdefm.UPart1" )
        function button:DoClick()
            RunConsoleCommand( "xdefmod_collect", 0 )
            RunConsoleCommand( "xdefmod_animui", 1 )
            RunConsoleCommand( "xdefmod_quickinv", -1 )
            RunConsoleCommand( "xdefmod_tagdist", 256 )
            RunConsoleCommand( "xdefmod_renderdist", 2048 )
            RunConsoleCommand( "xdefmod_showhook", 1 )
            RunConsoleCommand( "xdefmod_printnote", 0 )
            RunConsoleCommand( "xdefmod_drawhalo", 1 )
            RunConsoleCommand( "xdefmod_printcmd", 0 )
            RunConsoleCommand( "xdefmod_fastreel", 0 )
            RunConsoleCommand( "xdefmod_fps", 0 )
            RunConsoleCommand( "xdefmod_sonar", 1 )
            RunConsoleCommand( "xdefmod_collection", "11111111111" )
            RunConsoleCommand( "xdefmod_bgr", 28 )
            RunConsoleCommand( "xdefmod_bgg", 25 )
            RunConsoleCommand( "xdefmod_bgb", 72 )
            RunConsoleCommand( "xdefmod_bga", 255 )
            RunConsoleCommand( "xdefmod_brr", 0 )
            RunConsoleCommand( "xdefmod_brg", 206 )
            RunConsoleCommand( "xdefmod_brb", 209 )
            RunConsoleCommand( "xdefmod_bra", 255 )
        end
        panel:CheckBox( "#xdefm.c_fps1", "xdefmod_fps" )
        panel:CheckBox( "#xdefm.Sonar2", "xdefmod_sonar" )
        panel:CheckBox( "#xdefm.c_fastreel1", "xdefmod_fastreel" )
        panel:CheckBox( "#xdefm.c_showhook1", "xdefmod_showhook" )
        panel:CheckBox( "#xdefm.c_drawhalo1", "xdefmod_drawhalo" )
        panel:CheckBox( "#xdefm.c_animui1", "xdefmod_animui" )
        panel:CheckBox( "#xdefm.c_collect1", "xdefmod_collect" )
        panel:CheckBox( "#xdefm.c_printnote1", "xdefmod_printnote" )
        panel:CheckBox( "#xdefm.c_printcmd1", "xdefmod_printcmd" )
        panel:NumSlider( "#xdefm.c_tagdist1", "xdefmod_tagdist", 0, 10000, 0 )
        panel:NumSlider( "#xdefm.c_renderdist1", "xdefmod_renderdist", 0, 100000, 0 )
        panel:KeyBinder( "#xdefm.c_quickinv1", "xdefmod_quickinv" )
        panel:ColorPicker( "#xdefm.c_bg", "xdefmod_bgr", "xdefmod_bgg", "xdefmod_bgb", "xdefmod_bga" )
        panel:ColorPicker( "#xdefm.c_br", "xdefmod_brr", "xdefmod_brg", "xdefmod_brb", "xdefmod_bra" )
    end )
end )
hook.Add( "ShouldDrawLocalPlayer", "xdefm_DrawPly", function( ply )
    local wep = ply:GetActiveWeapon()
    if IsValid( wep ) and wep:GetClass() == "weapon_xdefm_rod" and GetConVar( "xdefmod_fps" ):GetInt() != 1 then
        return true
    end
end )
hook.Add( "CalcView", "xdefm_Cam", function( ply, pos, ang, fov )
    local wep = ply:GetActiveWeapon()
    if IsValid( wep ) and wep:GetClass() == "weapon_xdefm_rod" then
        if GetConVar( "xdefmod_fps" ):GetInt() != 1 then
            local siz = ply:OBBMins():Distance( ply:OBBMaxs() )
            local LPos, LAng = Vector( -40, 0, 10 ), ang
            if xdefm.miscs.SeeAng then
                LAng = Angle( xdefm.miscs.SeeAng.pitch, xdefm.miscs.SeeAng.yaw, 0 )
            end
            local NPos, NAng = LocalToWorld( LPos, LAng, pos, ang )
            local tr = util.TraceLine( {
                start = ply:EyePos(),
                endpos = ply:EyePos() -LAng:Forward()*siz*xdefm.miscs.FOV,
                filter = ply,
                mask = MASK_SHOT_HULL
            } )
            local view = {
                origin = tr.HitPos +tr.HitNormal,
                angles = LAng,
                fov = fov,
                drawviewer = true
            }
            return view
        else
            local view = {
                origin = pos,
                angles = ang,
                fov = fov,
                drawviewer = false
            }
            return view
        end
    end
end )
hook.Add( "CreateMove", "xdefm_MoveCL", function( cmd )
    local ply, wep = LocalPlayer(), LocalPlayer():GetActiveWeapon()
    if cmd:KeyDown( IN_USE ) and !xdefm.miscs.Reloaded then
        xdefm.miscs.Reloaded = true
        if ply:KeyDown( IN_RELOAD ) then
            net.Start( "NET_xdefm_Pickup" )
            net.WriteEntity( ply )
            net.SendToServer()
        end
    elseif xdefm.miscs.Reloaded and !cmd:KeyDown( IN_USE ) then
        xdefm.miscs.Reloaded = false
    end
    if IsValid( wep ) and wep:GetClass() == "weapon_xdefm_rod" and GetConVar( "xdefmod_fps" ):GetInt() != 1 then
        if !xdefm.miscs.SeeAng then
            xdefm.miscs.SeeAng = Angle( 0, cmd:GetViewAngles().yaw, 0 )
            cmd:SetViewAngles( xdefm.miscs.SeeAng )
        else
            xdefm.miscs.SeeAng = xdefm.miscs.SeeAng +Angle( cmd:GetMouseY()/50, -cmd:GetMouseX()/50, 0 )
            xdefm.miscs.SeeAng = Angle( math.Clamp( xdefm.miscs.SeeAng.pitch, -90, 90 ), xdefm.miscs.SeeAng.yaw, 0 )
        end
    else
        if xdefm.miscs.SeeAng then xdefm.miscs.SeeAng = nil end
        if xdefm.miscs.CamAng then xdefm.miscs.CamAng = nil end
    end
    if cmd:KeyDown( IN_WALK ) or cmd:KeyDown( IN_FORWARD ) or cmd:KeyDown( IN_BACK ) or cmd:KeyDown( IN_MOVELEFT ) or cmd:KeyDown( IN_MOVERIGHT ) then
        if xdefm.miscs.CamAng then
            xdefm.miscs.CamAng = nil
        end
        if xdefm.miscs.SeeAng and IsValid( wep ) and wep:GetClass() == "weapon_xdefm_rod" then
            cmd:SetViewAngles( Angle( math.Clamp( xdefm.miscs.SeeAng.pitch, -45, 45 ), xdefm.miscs.SeeAng.yaw, 0 ) )
        end
    elseif IsValid( wep ) and wep:GetClass() == "weapon_xdefm_rod" then
        if !xdefm.miscs.CamAng then
            xdefm.miscs.CamAng = cmd:GetViewAngles()
        else
            cmd:SetViewAngles( xdefm.miscs.CamAng )
        end
    end
end )
hook.Add( "RenderScene", "xdefm_MoveRod", function()
    for k, v in pairs( ents.FindByClass( "xdefm_*" ) ) do
        if !IsValid( v ) or v:GetClass() == "xdefm_firespot" or !IsValid( v:GetFMod_OW() ) then continue end
        if isfunction( v.xdefm_Move ) then
            v:xdefm_Move()
        end
    end
end )
hook.Add( "HUDPaint", "xdefm_Notes", function()
    local ply = LocalPlayer()
    if istable( xdefm.miscs.Notes ) and #xdefm.miscs.Notes > 0 then
        local hei = 0
        for k, v in pairs( xdefm.miscs.Notes ) do
            if !istable( v ) or #v != 4 or ( v[ 1 ] < SysTime() and math.Round( v[ 4 ], 2 ) == 0 ) then continue end
            local aaa = math.Clamp( math.Round( v[ 4 ]*255 ), 1, 254 )
            surface.SetFont( "xdefm_Font1" )
            local size, _ = surface.GetTextSize( v[ 2 ] )
            size = math.Clamp( size, 15, 200 )
            local mark = markup.Parse( "<color=255,255,255,255><font=xdefm_Font1>"..v[ 2 ].."</color></font>", size*2 )
            local posx, posy, ler = math.Round( ScrW() -10, 2 ), math.Round( ScrH()/2 +hei, 2 ), v[ 4 ]
            draw.RoundedBox( 0, posx -mark:GetWidth()*ler -5 -35, posy +1, mark:GetWidth() +20 +20, mark:GetHeight() +10, Color( xdefm.lin_col.r, xdefm.lin_col.g, xdefm.lin_col.b, aaa ) )
            draw.RoundedBox( 0, posx -mark:GetWidth()*ler -4 -35, posy +2, mark:GetWidth() +18 +20, mark:GetHeight() +8, Color( xdefm.ext_col.r, xdefm.ext_col.g, xdefm.ext_col.b, aaa ) )
            draw.RoundedBox( 0, posx -mark:GetWidth()*ler -3 -35, posy +3, mark:GetWidth() +16 +20, mark:GetHeight() +6, Color( xdefm.bck_col.r, xdefm.bck_col.g, xdefm.bck_col.b, aaa ) )
            draw.RoundedBoxEx( 0, posx -mark:GetWidth()*ler -38, posy +3, 22, mark:GetHeight() +6, Color( xdefm.ext_col.r*0.5, xdefm.ext_col.g*0.5, xdefm.ext_col.b*0.5, aaa ), true, false, true, false )
            mark:Draw( posx -mark:GetWidth()*ler +mark:GetWidth()*0.5 -10, posy +6, TEXT_ALIGN_CENTER, nil, aaa )
            surface.SetMaterial( v[ 3 ] )
            surface.SetDrawColor( 255, 255, 255, aaa )
            surface.DrawTexturedRect( posx -mark:GetWidth()*ler -36, posy +mark:GetHeight()*0.5 -1, 16, 16 )
            hei = hei +math.Round( ( mark:GetHeight() +15 )*math.Clamp( ler, 0.01, 1 ), 3 )
        end
    end
    if IsValid( ply ) and IsValid( ply:GetWeapon( "weapon_xdefm_trade" ) ) and !ply:GetNWBool( "XDEFMod_BTD" ) then
        local tax = ply:GetNWEntity( "XDEFMod_TPL" )
        for k, v in pairs( player.GetAll() ) do
            if !IsValid( v ) or !v:Alive() or v:WorldSpaceCenter():DistToSqr( ply:WorldSpaceCenter() ) > 70000 then continue end
            local tar = v:GetNWEntity( "XDEFMod_TPL" )
            if tar:IsPlayer() and tar == ply and tax != v then
                local col, scr = Color( 255, 255, 0 ), v:WorldSpaceCenter():ToScreen()
                scr.x = math.Round( scr.x )
                scr.y = math.Round( scr.y )
                draw.TextShadow( {
                    text = v:Nick(),
                    pos = { scr.x, scr.y },
                    font = "xdefm_Font5",
                    xalign = TEXT_ALIGN_CENTER,
                    yalign = TEXT_ALIGN_CENTER,
                    color = col
                }, 1, 255 )
                draw.TextShadow( {
                    text = language.GetPhrase( "xdefm.Trade10" ),
                    pos = { scr.x, scr.y +20 },
                    font = "xdefm_Font1",
                    xalign = TEXT_ALIGN_CENTER,
                    yalign = TEXT_ALIGN_CENTER,
                    color = col
                }, 1, 255 )
            end
        end
    end
end )
hook.Add( "DrawOverlay", "xdefm_Info", function()
    local ply, dat = LocalPlayer(), "_"
    if !IsValid( xdefm.miscs.AimPan ) and xdefm.miscs.Marker != nil then
        xdefm.miscs.Marker = nil
    end 
    if IsValid( xdefm.miscs.AimPan ) and xdefm.miscs.Marker != nil and vgui.CursorVisible() then
        local pan = xdefm.miscs.AimPan
        local mat, typ, ite, use, man = I0, pan.S_Type, pan.S_Item, false, xdefm.miscs.Menus 
        local k1 = ite != "_" and ( input.IsControlDown() or input.IsButtonDown( KEY_LCONTROL ) or input.IsButtonDown( KEY_RCONTROL ) )
        local k2 = ite != "_" and !k1 and ( input.IsShiftDown() or input.IsButtonDown( KEY_LSHIFT ) or input.IsButtonDown( KEY_RSHIFT ) )
        if k1 and typ == "Inventory" then
            use = true
            mat = ( xdefm_GetPrice( ite ) > 0 and I3 or I4 )
        elseif k2 then
            if typ == "Inventory" then
                local aa, bb = xdefm_ItemGet( ite )
                if istable( bb ) then
                    use = true
                    if IsValid( man[ "Bank" ] ) then
                        mat = I5
                    elseif bb.Type == "Recipe" and IsValid( man[ "Craft" ] ) then
                        mat = I6
                    elseif bb.Type == "Bait" then
                        mat = I5
                    end
                end
            end
            if typ == "Inventory" and ( IsValid( man[ "Bank" ] ) or IsValid( man[ "Trade" ] ) or ( IsValid( man[ "Structure" ] ) and man[ "Structure" ].N_SType == 1 ) ) then
                use = true
                mat = I2
            elseif typ == "Bank" and IsValid( man[ "Inventory" ] ) then
                use = true
                mat = I1
            elseif typ == "Storage" and IsValid( man[ "Inventory" ] ) then
                use = true
                mat = I1
            elseif typ == "Recipe" and IsValid( man[ "Inventory" ] ) then
                use = true
                mat = I1
            end
        end
        local xx, yy = input.GetCursorPos()
        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.SetMaterial( mat )
        if use then
            surface.DrawTexturedRect( xx, yy, 16, 16 )
        else
            surface.DrawTexturedRect( xx, yy, 24, 24 )
        end
    end
    if IsValid( ply ) and !vgui.CursorVisible() and ply:GetEyeTrace() != nil and IsValid( ply:GetEyeTrace().Entity ) and ply:GetEyeTrace().Entity.xdefm_OnLook
    and isstring( ply:GetEyeTrace().Entity:GetFMod_DT() ) then
        dat = ply:GetEyeTrace().Entity:GetFMod_DT()
    elseif IsValid( ply ) and isstring( xdefm.miscs.Marker ) and !dragndrop.IsDragging() then
        dat = xdefm.miscs.Marker
    end
    local dl = ( dat == "_" )
    if GetConVar( "xdefmod_animui" ):GetInt() > 0 then
        local ttt = string.Explode( "|", dat )
        if xdefm.miscs.LS != ttt[ 1 ] then
            xdefm.miscs.LS = ttt[ 1 ]
            if dat != "_" then xdefm.miscs.DS = dat end
            xdefm.miscs.DL = SysTime() +0.25
        end
    end
    if IsValid( ply ) and ( xdefm.miscs.DS != "_" or xdefm.miscs.DL > SysTime() ) then
    dat = xdefm.miscs.DS
    local aa, bb = xdefm_ItemGet( dat )
    if istable( aa ) and istable( bb ) then
        local xx, yy = 0, 0
        local ent = ply:GetEyeTrace().Entity
        if xdefm.miscs.KeyEnt != ent then
            xdefm.miscs.KeyEnt = ent
            xdefm.miscs.KeyLer = 0
        end
        if IsValid( ent ) and ent:GetClass() == "xdefm_base" and !vgui.CursorVisible() then
            xx = ent:GetPos():ToScreen().x
            yy = ent:GetPos():ToScreen().y
        else
            xx, yy = input.GetCursorPos()
            if xx == 0 and yy == 0 then
                xx, yy = ScrW()/2, ScrH()/2
            end
        end
        if !dl then
            xdefm.miscs.DX, xdefm.miscs.DY = xx, yy
            if xdefm.miscs.DS != dat then
                xdefm.miscs.KeyLer = 0
            end
            xdefm.miscs.DS = dat
        else
            xx, yy = xdefm.miscs.DX, xdefm.miscs.DY
        end
        xx, yy = math.Round( xx +28, 1 ), math.Round( yy +28, 1 )
        if istable( xdefm.miscs.Craft ) and xdefm.miscs.LC and !( input.IsShiftDown() or input.IsButtonDown( KEY_LSHIFT ) or input.IsButtonDown( KEY_RSHIFT ) ) then
            local cft = xdefm.miscs.Craft  local ite = ply.xdefm_Profile.Items
            local per = ( GetConVar( "xdefmod_animui" ):GetInt() > 0 and math.Clamp( ( xdefm.miscs.DL -SysTime() )/0.25, 0, 1 ) or 1 )
            if !dl then per = 1-per end
            xx, yy = input.GetCursorPos()  xx, yy = math.Round( xx, 1 ), math.Round( yy, 1 )
            if !istable( xdefm.miscs.Ings ) then xdefm.miscs.Ings = {}  xdefm.miscs.Ing2 = {} else
                local itt, yes = cft[ #xdefm.miscs.Ings +1 ], false
                if isstring( itt ) and #xdefm.miscs.Ings +1 != #cft then
                    for m, n in pairs( ite ) do if n == "_" or m == 21 then continue end
                        if xdefm_GetClass( n ) == itt and !isbool( xdefm.miscs.Ing2[ m ] ) then yes = true  xdefm.miscs.Ing2[ m ] = true break end
                end table.insert( xdefm.miscs.Ings, yes ) end local upp = false  local x2, y2 = xx, yy
                render.SetScissorRect( xx +16, yy, xx +48 +150, yy +( ( #cft )*24 +48 )*per, true )
                for k, v in pairs( xdefm.miscs.Ings ) do if !isbool( v ) or !isstring( cft[ k ] ) then continue end
                    local aa, bb = xdefm_ItemGet( cft[ k ] ) if !istable( bb ) then continue end
                    local col = ( v and Color( 0, 255, 0 ) or Color( 255, 0, 0 ) )
                    local bck = ( v and Color( 100, 100, 100 ) or Color( 55, 55, 55 ) )
                    x2, y2 = xx +20, yy +k*25
                    surface.SetDrawColor( bck ) surface.DrawRect( x2 -4, y2 -4, 28 +150, 26 )
                    surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( x2 -4, y2 -4, 28 +150, 26, 2 )
                    surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( x2 -4, y2 -4, 28 +150, 26, 1 )
                    surface.SetDrawColor( 255, 255, 255, 255 ) surface.SetMaterial( xdefm.miscs.Icons[ bb.Type ] )
                    surface.DrawTexturedRect( x2 +2, y2 +1, 16, 16 ) draw.TextShadow( {
                        text = xdefm_ItemMark( cft[ k ], true ), pos = { x2 +4 +19, y2 +2 },
                        font = "xdefm_Font2", xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_TOP, color = col
                    }, 1, 255 ) if !upp then upp = true  local ye2 = true
                        for k, v in pairs( xdefm.miscs.Ings ) do if v == false then ye2 = false break end end
                        x2, y2 = x2 +146, y2 +#cft*25
                        draw.RoundedBoxEx( 0, x2 -4, y2 -27, 32, 25, xdefm.lin_col, true, true, false, false )
                        draw.RoundedBoxEx( 0, x2 -4 +1, y2 -27 +1, 32 -2, 25 -2, xdefm.ext_col, true, true, false, false )
                        draw.RoundedBoxEx( 0, x2 -4 +2, y2 -27 +2, 32 -4, 25 -4, ye2 and Color( 0, 100, 0 ) or Color( 100, 0, 0 ), true, true, false, false )
                        surface.SetDrawColor( 255, 255, 255, 255 ) surface.SetMaterial( ye2 and yee or noo )
                        surface.DrawTexturedRect( x2 +4, y2 -22, 16, 16 )
                    end
                end
                render.SetScissorRect( 0, 0, 0, 0, false )
            end
        else
            if istable( xdefm.miscs.Ings ) then xdefm.miscs.Ings = nil  xdefm.miscs.Ing2 = nil end
            local rar = ( bb.Rarity + 1 )
            local col = xdefm.miscs.Rarity[ rar ]
            local txt = xdefm_ItemMark( dat )
            if string.find( string.lower( txt ), "&" ) != nil then
                local tab = string.Explode( "&", txt )
                for k, v in pairs( tab ) do
                    if v != "" and v != " " and string.find( string.lower( v ), "xdefm." ) != nil then
                        tab[ k ] = language.GetPhrase( v )
                    end
                end
                txt = table.concat( tab, "" )
            elseif string.find( string.lower( txt ), "xdefm." ) then
                txt = language.GetPhrase( txt )
            end
            local str = "<font=xdefm_Font1>"..string.Replace( txt, "&", "" ).."</font>\n"
            if GetConVar( "developer" ):GetInt() > 0 then
                str = str.."<font=xdefm_Font2><color=155,155,155,255>["..dat.."]</color></font>\n"
            end
            str = str.."<font=xdefm_Font2><color=155,155,155,255>"..language.GetPhrase( xdefm.miscs.Rarit2[ rar ] ).." "..language.GetPhrase( "xdefm."..bb.Type ).."</color></font>\n\n"
            if language.GetPhrase( bb.Helper ) != "" then
                str = str.."<font=xdefm_Font2><color=255,255,255,255>"..language.GetPhrase( bb.Helper ).."</color></font>\n\n"
            end
            local prc = xdefm_GetPrice( dat )
            if bb.Type == "Bait" and isnumber( bb.Consume ) then
                local per = tostring( math.Round( ( 1/bb.Consume )*100 ) ).."%"
                str = str.."<font=xdefm_Font2><color=155,155,155,255>"..language.GetPhrase( "xdefm.Consume" )..": "..per.."</color></font>\n"
                str = str.."<font=xdefm_Font2><color=155,155,155,255>"..language.GetPhrase( "xdefm.Level" )..": "..bb.Level.."</color></font>\n"
            elseif bb.Type == "Recipe" and isnumber( bb.Durability ) then
                if aa[ 2 ] then
                    str = str.."<font=xdefm_Font2><color=155,155,155,255>"..language.GetPhrase( "xdefm.Durability" )..": "..aa[ 2 ].."/"..bb.Durability.."</color></font>\n"
                else
                    str = str.."<font=xdefm_Font2><color=155,155,155,255>"..language.GetPhrase( "xdefm.Durability" )..": "..bb.Durability.."</color></font>\n"
                end
            end
            if IsValid( ent ) and ent:GetClass() == "xdefm_base" and !vgui.CursorVisible() then
                local own = ""
                if IsValid( ent:GetFMod_OW() ) and ent:GetFMod_OW():IsPlayer() then
                    own = ent:GetFMod_OW():Nick()
                elseif isstring( ent:GetFMod_OI() ) and ent:GetFMod_OI() != "" then
                    own = ent:GetFMod_OI()
                end
                if own != "" then
                    str = str.."<font=xdefm_Font2><color=155,155,155,255>"..language.GetPhrase( "xdefm.Owner" )..": "..own.."</color></font>\n"
                end
            end
            if prc > 0 then
                str = str.."<font=xdefm_Font2><color=155,155,155,255>"..language.GetPhrase( "xdefm.Price" )..": "..prc.."</color></font>"
            end
            local mark = markup.Parse( str, 250 )
            local ww, hh = mark:GetWidth(), mark:GetHeight()
            local per = ( GetConVar( "xdefmod_animui" ):GetInt() > 0 and math.Clamp( ( xdefm.miscs.DL -SysTime() )/0.25, 0, 1 ) or 1 )
            if !dl then per = 1-per end  local aaa = per*255
            if GetConVar( "xdefmod_collect" ):GetInt() > 0 and !isnumber( xdefm.besti[ xdefm_GetClass( dat ) ] ) then
                draw.TextShadow( {
                    text = language.GetPhrase( "xdefm.Besti2" ),
                    pos = { xx +256, yy +hh*per +20 },
                    font = "xdefm_Font1",
                    xalign = TEXT_ALIGN_RIGHT,
                    yalign = TEXT_ALIGN_CENTER,
                    color = Color( 0, 255, 255, aaa )
                }, 1, aaa )
            end
            local x2, y2, w2, h2 = xx -7.5, yy -7.5, 265, hh +15
            render.SetScissorRect( x2 -4, y2 -4, x2 +( w2 +4 )*per, y2 +( h2 +4 )*per, true )
            draw.NoTexture()
            surface.SetDrawColor( Color( col.r*2, col.g*2, col.b*2, aaa ) )
            xdefm_CutBox( w2/10, x2 -2, y2 -2, w2 +4, h2 +4, false, false, true, false )
            surface.SetDrawColor( Color( col.r*0.15, col.g*0.15, col.b*0.15, aaa ) )
            xdefm_CutBox( w2/10, x2 -1, y2 -1, w2 +2, h2 +2, false, false, true, false )
            surface.SetDrawColor( col.r*0.25*aaa/255, col.g*0.25*aaa/255, col.b*0.25*aaa/255, aaa )
            surface.SetMaterial( Bck )
            surface.DrawTexturedRect( xx -7.5, yy -7.5, 265, math.min( 50, hh ) )
            mark:Draw( xx, yy, nil, nil, aaa )
            render.SetScissorRect( 0, 0, 0, 0, false )
            if IsValid( ent ) and dat != "_" and ent:GetClass() == "xdefm_base" and !vgui.CursorVisible() and per > 0
            and ( xdefm_CanInteract( LocalPlayer(), ent ) or ( GetConVar( "xdefmod_animui" ):GetInt() > 0 and xdefm.miscs.KeyLer > 0 ) ) then
                local hei = mark:GetHeight()*per +15
                xdefm.miscs.KeyLer = Lerp( 0.1, xdefm.miscs.KeyLer, xdefm_CanInteract( LocalPlayer(), ent ) and 1 or 0 )
                local alp = GetConVar( "xdefmod_animui" ):GetInt() > 0 and math.Clamp( xdefm.miscs.KeyLer/1*255, 0, 255 ) or 255
                local k1 = input.LookupBinding( "+use", true )
                if isstring( bb.HelperUse ) and isstring( k1 ) and bb.HelperUse != "" then
                    local kk = string.Explode( "", k1 )
                    if !istable( kk ) then
                        k1 = string.upper( k1 )
                    else
                        kk[ 1 ] = string.upper( kk[ 1 ] )
                        k1 = table.concat( kk, "" )
                    end
                    surface.SetFont( "xdefm_Font5" )
                    local x1, y1 = surface.GetTextSize( k1 )
                    xx, yy = math.Round( xx ), math.Round( yy )
                    draw.RoundedBox( 0, xx -4, yy +hei, x1 +8, y1, ply:KeyDown( IN_USE ) and Color( 155, 155, 155, alp ) or Color( 55, 55, 55, alp ) )
                    surface.SetDrawColor( Color( 255, 255, 255, alp ) )
                    surface.DrawOutlinedRect( xx -4, yy +hei, x1 +8, y1, 2 )
                    surface.SetDrawColor( Color( 0, 0, 0, alp ) )
                    surface.DrawOutlinedRect( xx -4, yy +hei, x1 +8, y1, 1 )
                    draw.TextShadow( {
                        text = k1,
                        pos = { xx +x1/2 -2, yy+hei +y1/2 },
                        font = "xdefm_Font1",
                        xalign = TEXT_ALIGN_CENTER,
                        yalign = TEXT_ALIGN_CENTER,
                        color = ply:KeyDown( IN_USE ) and Color( 255, 255, 0, alp ) or Color( 255, 255, 255, alp )
                    }, 1, alp )
                    draw.TextShadow( {
                        text = language.GetPhrase( bb.HelperUse ),
                        pos = { xx +x1 +12, yy+hei +y1/2 },
                        font = "xdefm_Font2",
                        xalign = TEXT_ALIGN_LEFT,
                        yalign = TEXT_ALIGN_CENTER,
                        color = Color( 255, 255, 255, alp )
                    }, 1, alp )
                    hei = hei +y1 +5
                end
                local k2 = input.LookupBinding( "+reload", true )
                if isstring( k1 ) and isstring( k2 ) then
                    local kk1 = string.Explode( "", k1 )
                    if !istable( kk1 ) then
                        k1 = string.upper( k1 )
                    else
                        kk1[ 1 ] = string.upper( kk1[ 1 ] )
                        k1 = table.concat( kk1, "" )
                    end
                    local kk2 = string.Explode( "", k2 )
                    if !istable( kk2 ) then
                        k2 = string.upper( k2 )
                    else
                        kk2[ 1 ] = string.upper( kk2[ 1 ] )
                        k2 = table.concat( kk2, "" )
                    end
                    surface.SetFont( "xdefm_Font5" )
                    local x1, y1 = surface.GetTextSize( k2 )
                    local x2, y2 = surface.GetTextSize( k1 )
                    draw.RoundedBox( 0, xx -4, yy +hei, x1 +8, y1, ply:KeyDown( IN_RELOAD ) and Color( 155, 155, 155, alp ) or Color( 55, 55, 55, alp ) )
                    surface.SetDrawColor( Color( 255, 255, 255, alp ) )
                    surface.DrawOutlinedRect( xx -4, yy +hei, x1 +8, y1, 2 )
                    surface.SetDrawColor( Color( 0, 0, 0, alp ) )
                    surface.DrawOutlinedRect( xx -4, yy +hei, x1 +8, y1, 1 )
                    draw.RoundedBox( 0, xx -4 +x1 +28, yy +hei, x2 +8, y2, ply:KeyDown( IN_USE ) and Color( 155, 155, 155, alp ) or Color( 55, 55, 55, alp ) )
                    surface.SetDrawColor( Color( 255, 255, 255, alp ) )
                    surface.DrawOutlinedRect( xx -4 +x1 +28, yy +hei, x2 +8, y2, 2 )
                    surface.SetDrawColor( Color( 0, 0, 0, alp ) )
                    surface.DrawOutlinedRect( xx -4 +x1 +28, yy +hei, x2 +8, y2, 1 )
                    local dst = ( bb.Price > 0 and "xdefm.Sell" or "xdefm.Destroy" )
                    if bb.Carryable and ( ( bb.Type == "Bait" or bb.Type == "Recipe" ) or GetConVar( "xdefmod_tempmode" ):GetInt() <= 0 ) then
                        dst = "xdefm.Store"
                    end
                    draw.TextShadow( {
                        text = k2,
                        pos = { xx +x1/2 -2, yy+hei +y1/2 },
                        font = "xdefm_Font1",
                        xalign = TEXT_ALIGN_CENTER,
                        yalign = TEXT_ALIGN_CENTER,
                        color = ply:KeyDown( IN_RELOAD ) and Color( 255, 255, 0, alp ) or Color( 255, 255, 255, alp )
                    }, 1, alp )
                    draw.TextShadow( {
                        text = k1,
                        pos = { xx +x1 +x2/2 +28 -2, yy+hei +y1/2 },
                        font = "xdefm_Font1",
                        xalign = TEXT_ALIGN_CENTER,
                        yalign = TEXT_ALIGN_CENTER,
                        color = ply:KeyDown( IN_USE ) and Color( 255, 255, 0, alp ) or Color( 255, 255, 255, alp )
                    }, 1, alp )
                    draw.TextShadow( {
                        text = "+",
                        pos = { xx +x1 +14, yy+hei +y1/2 },
                        font = "xdefm_Font4",
                        xalign = TEXT_ALIGN_CENTER,
                        yalign = TEXT_ALIGN_CENTER,
                        color = Color( 255, 255, 255, alp )
                    }, 1, alp )
                    draw.TextShadow( {
                        text = language.GetPhrase( dst ),
                        pos = { xx +x1 +x2 +40, yy+hei +y1/2 },
                        font = "xdefm_Font2",
                        xalign = TEXT_ALIGN_LEFT,
                        yalign = TEXT_ALIGN_CENTER,
                        color = Color( 255, 255, 255, alp )
                    }, 1, alp )
                end
            elseif xdefm.miscs.KeyLer != 0 then
                    xdefm.miscs.KeyLer = 0
                end
            end
        end
    end
end )
hook.Add( "Think", "xdefm_TKCL", function()
    local ply = LocalPlayer()
    if xdefm.miscs.FOV != xdefm.miscs.LFOV then
        xdefm.miscs.FOV = Lerp( 0.1, xdefm.miscs.FOV, xdefm.miscs.LFOV )
    end
    if IsValid( ply ) and istable( xdefm.miscs.Notes ) and #xdefm.miscs.Notes > 0 then
        local hei = 0 
        for k, v in pairs( xdefm.miscs.Notes ) do
            if !istable( v ) or #v != 4 or ( v[ 1 ] < SysTime() and math.Round( v[ 4 ], 2 ) == 0 ) then
                table.remove( xdefm.miscs.Notes, k )
                continue
            end
            if v[ 1 ] >= SysTime() and k >= #xdefm.miscs.Notes -6 then
                v[ 4 ] = Lerp( 0.2, v[ 4 ], 1 )
            else
                v[ 4 ] = Lerp( 0.1, v[ 4 ], 0 )
            end
        end
    end
end )
hook.Add( "HUDDrawTargetID", "xdefm_Info", function()
    local ply = LocalPlayer()
    if IsValid( ply ) and IsValid( ply:GetActiveWeapon() ) and ply:GetActiveWeapon():GetClass() == "weapon_xdefm_trade" then
        return false
    end
end )
hook.Add( "PlayerBindPress", "xdefm_WheelView", function( ply, bind, pressed )
    local wep = ply:GetActiveWeapon()
    if IsValid( wep ) and wep:GetClass() == "weapon_xdefm_rod" and GetConVar( "xdefmod_fps" ):GetInt() != 1
    and ( string.find( bind, "invprev" ) or string.find( bind, "invnext" ) ) then
        return true
    end
end )

net.Receive( "NET_xdefm_Menu", function()
    local ply, typ, tab = LocalPlayer(), tonumber( net.ReadString() ), util.JSONToTable( net.ReadString() )
    if typ != nil and tab != nil then
        xdefm_OpenMenu( ply, typ, tab )
    end
end )
net.Receive( "NET_xdefm_Anim", function()
    local ply, act = net.ReadEntity(), net.ReadFloat()
    if IsValid( ply ) and isnumber( act ) and ply:IsPlayer() then
        ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, math.Round( act ), true )
    end
end )
net.Receive( "NET_xdefm_Profile", function()
    local dat = net.ReadString()
    if !isstring( dat ) or dat == "" then return end
    local tab = util.JSONToTable( dat )
    if !istable( tab ) then return end
    LocalPlayer().xdefm_Profile = tab
end )
net.Receive( "NET_xdefm_SendNote", function()
    local txt, snd, dur, ico = net.ReadString(), net.ReadString(), net.ReadFloat(), net.ReadString()
    xdefm_AddNote( LocalPlayer(), txt, snd, ico, dur )
end )
net.Receive( "NET_xdefm_SendSnd", function()
    local ply, snd = LocalPlayer(), net.ReadString()
    if isstring( snd ) and snd != "" and snd != "!V" then
        surface.PlaySound( snd )
    end
end )
net.Receive( "NET_xdefm_BreakEF", function()
    local ent, typ = net.ReadEntity(), net.ReadFloat()
    if IsEntity( ent ) and isnumber( typ ) then
        xdefm_BreakEffect( ent, typ )
    end
end )
net.Receive( "NET_xdefm_MenuUpdate", function()
    local typ, dat = net.ReadFloat(), net.ReadString()
    if !isnumber( typ ) or !isstring( dat ) or dat == "" then return end
    typ = math.Round( typ )
    local tab = util.JSONToTable( dat )
    if !istable( tab ) then return end
    if istable( xdefm.miscs.Menus ) then
        for k, v in pairs( xdefm.miscs.Menus ) do
            if ispanel( v ) and isfunction( v.XDEFM_Update ) then
                v:XDEFM_Update( typ, tab )
            end
        end
    end
end )
net.Receive( "NET_xdefm_CLEffect", function()
    local nam, dat = net.ReadString(), util.JSONToTable( net.ReadString() )
    if !istable( dat ) then return end
    xdefm_BroadEffect( nam, dat )
end )
net.Receive( "NET_xdefm_Leaderboard", function()
    local str = net.ReadString()
    local tab = util.JSONToTable( str )
    if !istable( tab ) then return end
    xdefm.leader = tab
    if IsValid( xdefm.miscs.Menus[ "Inventory" ] ) then
        xdefm.miscs.Menus[ "Inventory" ]:XDEFM_Update( 7, tab )
    end
    file.Write( "xdefishmod/leaderboard.txt", str )
end )
net.Receive( "NET_xdefm_BestiaryRecord", function()
    local str, ply = net.ReadString(), LocalPlayer()
    if !IsValid( ply ) or !istable( ply.xdefm_Profile ) or !isnumber( ply.xdefm_Profile.UpdA ) then
        return
    end
    if istable( xdefm.besti ) and !isnumber( xdefm.besti[ str ] ) then
        xdefm_AddNote( ply, "xdefm.Besti4&"..xdefm_ItemMark( str ), "npc/scanner/scanner_photo1.wav", "camera_add", 5 )
        xdefm.besti[ str ] = 0
        xdefm_BestiarySave()
    end
end )
net.Receive( "NET_xdefm_BestiaryAll", function()
    local int = math.Round( net.ReadFloat() )
    xdefm.besti = {}
    if int == 1 then
        for k, v in pairs( xdefm.items ) do
            xdefm.besti[ k ] = 0
        end
    end
    xdefm_BestiarySave()
end )
net.Receive( "NET_xdefm_UpdateShop", function()
    local tab = util.JSONToTable( net.ReadString() )
    if !istable( tab ) then return end
    for k, v in pairs( tab ) do
        if istable( xdefm.shop[ k ] ) then
            xdefm.shop[ k ][ 1 ] = v
        end
    end
end )
net.Receive( "NET_xdefm_Quest", function()
    xdefm.quest = util.JSONToTable( net.ReadString() )
    if IsValid( xdefm.miscs.Menus[ "Quest" ] ) then
        xdefm.miscs.Menus[ "Quest" ]:XDEFM_Update( 10, xdefm.quest )
    end
end )
net.Receive( "NET_xdefm_MenuClose", function()
    xdefm_CloseMenu( LocalPlayer(), net.ReadString() )
end )