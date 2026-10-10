# memphis-science-image-prompts

一套 WorkBuddy Skill：**孟菲斯扁平插画风的公众号 / 小红书系列科普图提示词生成器**。把一篇完整文章拆成 3–5 张风格统一的 3:4 竖版生图提示词，配色与装饰元素全部锁定，可直接喂给 AI 绘图工具出图。

## 一键安装

Skill 内容采用 **Anthropic Agent Skills 标准格式**（`SKILL.md` + `name`/`description` 头），因此不止 WorkBuddy 能用——Claude Code、Codex、Cursor 等所有遵循该标准的 agent 都能识别。安装脚本会**自动检测本机已安装的 agent**，把 Skill 同时装进它们各自的 `skills/` 目录。

**方式 A · 一条命令（推荐，自动适配所有 agent）**

```bash
curl -fsSL https://raw.githubusercontent.com/sonia0u/memphis-science-image-prompts/main/install.sh | bash
```

- 自动识别并安装到：`~/.workbuddy/skills`（WorkBuddy，含 Windows `D:/AI-Skills`）、`~/.claude/skills`（Claude Code）、`~/.codex/skills`（Codex）、`~/.cursor/skills`（Cursor）；若当前目录有 `.claude/skills` 也会装。
- 未检测到任何已知 agent 时，回退装到 WorkBuddy 默认目录。
- 已存在同名 Skill 时自动备份为 `.bak` 再覆盖，安全可重跑。
- 可选参数：`--list`（只列出会安装到哪）、`--agent claude`（只装某个 agent）、`--target <目录>`（装到指定目录）。

**方式 B · 让 Agent 帮你装**

在 WorkBuddy / Claude Code / 任意 AI 助手对话里直接说：

> 帮我把这个 skill 装上：https://github.com/sonia0u/memphis-science-image-prompts

Agent 会自行克隆仓库、把 `image-memphis-gzh--prompt-c/` 放进对应 `skills/` 目录，装完重启即可用。

**方式 C · 手动**

把 [`image-memphis-gzh--prompt-c/`](./image-memphis-gzh--prompt-c) 整个文件夹拖进目标 agent 的 `skills/` 目录即可。

> 注：`agents/openai.yaml` 是 WorkBuddy 专用扩展，其它 agent 会自动忽略该文件，不影响功能。

## 怎么用

Skill 本体在 [`image-memphis-gzh--prompt-c/`](./image-memphis-gzh--prompt-c) 文件夹里。安装后（方式 A/B/C 任一）对 AI 说「帮我把这篇文章做成孟菲斯风科普图提示词」并贴入文章。

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
