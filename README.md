# 孟菲斯风科普图提示词生成 Skill

一套 Agent Skill：把一篇完整文章拆成 3–5 张风格统一的 3:4 竖版生图提示词，视觉体系为**孟菲斯扁平插画风**（长春花蓝 + 珊瑚红 + 奶油杏撞色、半调波点、几何装饰元素）。提示词可直接喂给 AI 绘图工具（本地画布 / Midjourney / SD 等）出图，适用于小红书、微信公众号的系列科普配图。

> 本 Skill 只生成「分镜表 + 生图提示词」，不调用任何图像生成工具、不发布内容。

## 风格一览

| 维度 | 设定 |
| --- | --- |
| 配色 | 长春花蓝 `#5C6CBD`（主背景）、奶油杏 `#F8DEC0`（文字区）、珊瑚红 `#F0563A`（小面积强调）、深藏青 `#2E3A87`、白，锁定五色、禁第四色相 |
| 装饰 | 孟菲斯元素（十字星、加号、圆点、斜线、速度线、同心圆）+ 白色半调波点纹理 + 大弧形波浪背景分割 |
| 人物 | 圆润卡通小女孩（齐刘海短发、圆点腮红、条纹上衣） |
| 字体 | 思源黑体 Bold（标题）+ 阿里巴巴普惠体 Regular（正文） |

## 安装

```bash
npx skills add sonia0u/memphis-science-image-prompts
```

重启 agent 后，对 AI 说「帮我把这篇文章做成孟菲斯风科普图提示词」并贴入文章即可使用。

## 怎么用

1. 用上面的命令安装（或手动把本文件夹放入 agent 的 `skills/` 目录）。
2. 对 AI 说：「帮我把这篇文章做成孟菲斯风科普图提示词」，并贴入完整文章（或给出本地 md 路径）。
3. Skill 会输出分镜表 + 每张图的独立提示词，复制提示词到绘图工具即可。

也可在对话中直接触发关键词：孟菲斯科普图、扁平插画科普图、撞色科普图、memphis 科普图。

## 目录结构

仓库根即 skill 文件夹：

```
image-memphis-gzh--prompt-c/
├── SKILL.md               # Skill 定义（name + description + 工作流）
├── meta.yaml              # 展示元数据（Hub 兼容）
├── README.md              # 本文件
├── references/
│   ├── visual-system.md      # 固定视觉系统（配色/字体/人物/构图）
│   ├── prompt-template.md     # 独立提示词模板
│   ├── storyboard-rules.md    # 分镜与文案压缩规则
│   └── quality-checklist.md   # 输出质检清单
├── agents/
│   └── openai.yaml            # 接口默认提示词
└── examples/                # 生成示例（5 张 3:4 成品图）
    ├── 1.png ... 5.png
```

## 效果预览

《精神内耗的尽头，是行动》用本 Skill 生成的 5 张系列图（封面 + 3 张正文 + 收尾），同一套孟菲斯风格保持一致：

![图 1 封面：深夜枕头上的脑中讨论会](examples/1.png)

![图 2 机制：大脑空转＝死踩油门的车](examples/2.png)

![图 3 真相：做了才想清楚（简历→灯泡路径）](examples/3.png)

![图 4 方法：五分钟法则，先换鞋](examples/4.png)

![图 5 收尾：先把鞋穿上，剩下的走着瞧](examples/5.png)

风格来源参考图见 [`examples/style-reference.png`](examples/style-reference.png)。

## 来源

本 Skill 由 `image-blue-gzh--prompt-c`（温柔蓝灰治愈系科普图提示词）派生，仅将视觉体系替换为孟菲斯扁平插画风，工作流、分镜与文案规则保持不变。

## License

MIT —— 可自由使用、修改、再分发，注明出处即可。
