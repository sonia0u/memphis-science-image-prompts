# memphis-science-image-prompts

一套 WorkBuddy Skill：**孟菲斯扁平插画风的公众号 / 小红书系列科普图提示词生成器**。把一篇完整文章拆成 3–5 张风格统一的 3:4 竖版生图提示词，配色与装饰元素全部锁定，可直接喂给 AI 绘图工具出图。

## 安装

```bash
curl -fsSL https://raw.githubusercontent.com/sonia0u/memphis-science-image-prompts/main/install.sh | bash
```

重启 agent 后，对 AI 说「帮我把这篇文章做成孟菲斯风科普图提示词」并贴入文章即可使用。

## 怎么用

Skill 本体在 [`image-memphis-gzh--prompt-c/`](./image-memphis-gzh--prompt-c) 文件夹里。安装后对 AI 说「帮我把这篇文章做成孟菲斯风科普图提示词」并贴入文章。

## 目录

- `image-memphis-gzh--prompt-c/` —— Skill 定义、规则文件、示例图
  - `examples/` —— 5 张生成成品图（来自《精神内耗的尽头，是行动》）+ `style-reference.png` 风格来源海报
  - `references/` —— 视觉系统、提示词模板、分镜规则、质检清单

## 效果预览

《精神内耗的尽头，是行动》用本 Skill 生成的 5 张系列图（封面 + 3 张正文 + 收尾），同一套孟菲斯风格保持一致：

![图 1 封面：深夜枕头上的脑中讨论会](image-memphis-gzh--prompt-c/examples/1.png)

![图 2 机制：大脑空转＝死踩油门的车](image-memphis-gzh--prompt-c/examples/2.png)

![图 3 真相：做了才想清楚（简历→灯泡路径）](image-memphis-gzh--prompt-c/examples/3.png)

![图 4 方法：五分钟法则，先换鞋](image-memphis-gzh--prompt-c/examples/4.png)

![图 5 收尾：先把鞋穿上，剩下的走着瞧](image-memphis-gzh--prompt-c/examples/5.png)

风格来源参考图见 [`examples/style-reference.png`](image-memphis-gzh--prompt-c/examples/style-reference.png)。

## 许可

MIT。
