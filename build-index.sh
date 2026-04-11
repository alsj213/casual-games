#!/bin/bash
# Rebuild correct index.html with all 50 games

cat > index.html << 'ENDOFINDEX'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>小游戏门户 - 50个休闲小游戏集合</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        
        * {
            font-family: 'Inter', sans-serif;
        }
        
        .game-card {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .game-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        
        .game-card:hover .game-preview {
            transform: scale(1.05);
        }
        
        .game-preview {
            transition: transform 0.3s ease;
        }
        
        .gradient-bg {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        .btn-play {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            transition: all 0.3s ease;
        }
        
        .btn-play:hover {
            background: linear-gradient(135deg, #5568d3 0%, #65398a 100%);
            box-shadow: 0 10px 15px -3px rgba(102, 126, 234, 0.4);
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">
    <!-- Header -->
    <header class="gradient-bg text-white py-12 px-4">
        <div class="max-w-7xl mx-auto">
            <div class="text-center">
                <h1 class="text-4xl md:text-5xl font-bold mb-4">小游戏门户</h1>
                <p class="text-lg md:text-xl opacity-90 font-light">精选 50 个休闲小游戏，随时随地轻松娱乐</p>
                <p class="text-md opacity-80 mt-2">支持桌面和移动端，即点即玩</p>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="max-w-7xl mx-auto py-12 px-4">
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
ENDOFINDEX

count=1
games=$(ls -1 *.html | grep -v "^index" | sort)

emoji_list=(
"✈️" "🎲" "🚀" "⚖️" "⭕" "🃏" "🧱" "🎈" "🫧" "🏎️" "♟️" 
"🌈" "🎨" "🔗" "📝" "🎯" "🦘" "🏎️" "🧩" "🎣" "🐦" 
"🔯" "💡" "🧩" "🃏" "🌀" "🃏" "💣" "💣" "🔢" "🏓" 
"🔍" "💥" "🏓" "🎵" "☁️" "🧩" "🐍" "🐍" "🧩" "⚽" 
"📦" "👾" "🧱" "🔵" "🔲" "🛡️" "🏗️" "💧" "🔨" "🔤"
)

desc_list=(
"竖版射击经典打飞机，躲避敌机击落得分越高越好。"
"滑动方块相同数字合并，目标合成 2048。" 
"移动飞船躲避小行星，坚持越久得分越高。" 
"在天平两侧放置不同重量物品，使天平保持平衡。" 
"蓄力投掷小球落入杯子得分，不同杯子分值不同。" 
"经典二十一点，不超过21点比大小，对战庄家。" 
"用挡板反弹小球击碎所有砖块，经典街机游戏。" 
"点击飞起的气球爆破，考验你的反应速度。" 
"发射泡泡三个相同消除，经典街机游戏。" 
"车道上躲避其他车辆，行驶越远得分越高。" 
"8x8棋盘对角线移动，跳过对方吃掉，吃光获胜。" 
"记住颜色出现顺序，依次点击重复序列，挑战记忆力。" 
"跳跃前进，小球必须穿过对应颜色的障碍。" 
"按顺序连接点完成图形绘制，多关卡挑战。" 
"根据提示填写词语，多个小关卡挑战。" 
"轮流投掷飞镖，标准靶旋转靶移动靶多模式累计得分。" 
"不断向上跳跃，踩破敌人加分，掉下去游戏结束。" 
"敲击键盘加速赛车，连击更快跟 AI 比赛先到终点获胜。" 
"方块下落三色相同消除，Tetris 消除模式累积得分。" 
"抛钩等待咬钩收线，不同鱼种分值不同，稀有鱼加分。" 
"点击让小鸟飞过管道，考验你的时机掌控。" 
"六边形网格 2048，不同形状合并得分更高。" 
"旋转镜子反射光线，点亮目标过关。" 
"滑动方块还原完整图片，多种难度挑战你的智慧。" 
"翻开相同图案配对消除，测试你的记忆力。" 
"随机生成迷宫，找到出口完成挑战。" 
"翻开相同的卡片消除成对，测试你的记忆力。" 
"经典扫雷游戏，点击方块揭开数字，标记所有地雷位置。" 
"三角网格变体扫雷，多种难度挑战你的推理能力。" 
"滑动方格将数字按顺序排列，支持多种尺寸。" 
"控制挡板接住下落的球，球越快得分越高。" 
"在网格中寻找从起点到终点的最短路径，避开障碍物。" 
"点击相连同色像素消除，越多得分越高。" 
"经典双人乒乓球，左右挡板击球，先到11分获胜。" 
"多个彩色圆点从屏幕上方慢慢下落，点击越准时得分越高。" 
"天空风格经典俄罗斯方块，清新背景消除行得分更高。" 
"不同长度方块下落左右滑动，完美对齐堆叠挑战高分。" 
"滑动方块还原完整图片，多种难度挑战你的智慧。" 
"经典贪吃蛇游戏，控制蛇吃食物变长，避免撞墙和咬到自己。" 
"掷骰子走步数，梯子爬升蛇下滑，先到终点获胜。" 
"拼接蛇身吃到所有食物，益智拼图玩法。" 
"调整角度力度射门，考验你的射门技巧。" 
"把箱子推到目标位置，经典益智推箱游戏。" 
"底部飞船左右移动射击，消灭从上下来的外星人，经典射击游戏。" 
"经典俄罗斯方块，移动和旋转方块，消除完整行获得高分。" 
"经典双人对战，率先连成一线即可获胜，简单又有趣。" 
"每个格子里面都是小井字棋，赢格子占格子，连成三个获胜。" 
"直线路径放置炮塔，阻止敌人到达终点。" 
"方块从上落下，玩家左右移动对齐堆叠考验精准度。" 
"将不同颜色的液体倒入同一个试管，益智休闲。" 
"地鼠冒出来时点击得分，考验你的反应速度。" 
"打乱字母拼回正确单词，动物水果食物多类别挑战。"
)

display_list=(
"打飞机"
"经典 2048"
"躲避小行星"
"天平配重"
"套圈"
"21点纸牌"
"打砖块"
"气球爆破"
"泡泡龙射击"
"简易赛车"
"西洋跳棋"
"颜色记忆"
"颜色切换"
"连线点点"
"猜词游戏"
"飞镖射击"
"跳跃闯关"
"拖拽赛车"
"三连消除"
"钓鱼游戏"
"像素鸟"
"六边形 2048"
"反光镜解谜"
"图片拼图"
"配对记忆"
"迷宫寻路"
"翻牌配对"
"经典扫雷"
"三角扫雷"
"数字拼图"
"反弹球"
"寻路"
"像素消除"
"乒乓球"
"音乐点击"
"天空俄罗斯方块"
"完美堆叠"
"滑动拼图"
"贪吃蛇"
"蛇梯棋"
"贪吃蛇拼图"
"足球射门"
"推箱子"
"太空射击"
"俄罗斯方块"
"井字棋"
"终极井字棋"
"塔防"
"方块堆叠"
"倒水分类"
"打地鼠"
"单词拼写"
)

for file in $games; do
    name=$(echo "$file" | sed 's/\.html$//')
    index=$((count - 1))
    emoji=${emoji_list[$index]}
    desc=${desc_list[$index]}
    display=${display_list[$index]}
    
    cat >> index.html << 'ENDOFGAME'
            <!-- COUNT. DISPLAY -->
            <a href="FILE" class="game-card block bg-white rounded-xl overflow-hidden shadow-lg">
                <div class="aspect-video overflow-hidden bg-gray-100">
                    <div class="game-preview w-full h-full bg-gradient-to-br from-green-400 to-green-600 flex items-center justify-center">
                        <div class="text-white text-center">
                            <span class="text-5xl mb-2 block">EMOJI</span>
                            <span class="text-xl font-semibold">DISPLAY</span>
                        </div>
                    </div>
                </div>
                <div class="p-6">
                    <h3 class="text-xl font-semibold text-gray-900 mb-2">DISPLAY</h3>
                    <p class="text-gray-600 text-sm mb-4">DESC</p>
                    <button class="btn-play w-full text-white py-3 px-4 rounded-lg font-medium">开始游戏</button>
                </div>
            </a>
ENDOFGAME

    sed -i "s/COUNT/$count/; s/FILE/$file/; s/EMOJI/$emoji/; s/DISPLAY/$display/; s/DESC/$desc/" index.html

    count=$((count + 1))
done

cat >> index.html << 'ENDOFFOOTER'
        </div>

        <!-- Features Section -->
        <div class="mt-16 bg-white rounded-2xl p-8 shadow-sm">
            <h2 class="text-2xl font-bold text-gray-900 mb-6 text-center">游戏特色</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="text-center">
                    <div class="w-12 h-12 gradient-bg rounded-full flex items-center justify-center mx-auto mb-4">
                        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7h-7z"></path>
                        </svg>
                    </div>
                    <h3 class="font-semibold text-gray-900 mb-2">即点即玩</h3>
                    <p class="text-gray-600 text-sm">无需下载，打开网页即可开始游戏</p>
                </div>
                <div class="text-center">
                    <div class="w-12 h-12 gradient-bg rounded-full flex items-center justify-center mx-auto mb-4">
                        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2 2H6a2 2 0 00-2 2z"></path>
                        </svg>
                    </div>
                    <h3 class="font-semibold text-gray-900 mb-2">完全免费</h3>
                    <p class="text-gray-600 text-sm">所有游戏免费开放，无内购无广告</p>
                </div>
                <div class="text-center">
                    <div class="w-12 h-12 gradient-bg rounded-full flex items-center justify-center mx-auto mb-4">
                        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.75 17L9 20l-1 1h8l-1-1 .75-3M3 13h18"></path>
                        </svg>
                    </div>
                    <h3 class="font-semibold text-gray-900 mb-2">响应式设计</h3>
                    <p class="text-gray-600 text-sm">支持电脑、手机、平板，任何设备都能玩</p>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-gray-100 py-8 mt-12">
        <div class="max-w-7xl mx-auto px-4 text-center text-gray-600">
            <p class="text-sm">© 2026 小游戏门户 · 闲暇时光，轻松一玩</p>
        </div>
    </footer>
</body>
</html>
ENDOFFOOTER
