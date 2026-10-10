#!/usr/bin/env bash
#
# 一键安装 memphis-science-image-prompts (孟菲斯风科普图提示词 Skill)
# 用法:
#   curl -fsSL https://raw.githubusercontent.com/sonia0u/memphis-science-image-prompts/main/install.sh | bash
#
# 说明:
#   本 Skill 的内容采用 Anthropic Agent Skills 标准格式（SKILL.md + name/description 头），
#   可被 WorkBuddy、Claude Code 等所有遵循该标准的 agent 识别。脚本会自动检测本机已安装的
#   agent，并把 Skill 装进对应的 skills 目录；未检测到任何 agent 时回退到 WorkBuddy 默认路径。
#
# 选项:
#   --target <目录>   只装到指定目录（覆盖自动检测）
#   --all             装到所有已检测到的 agent 目录（默认行为）
#   --list            只列出会安装到的目录，不执行
#   --agent workbuddy|claude|codex|cursor   装到指定 agent 的默认目录
set -euo pipefail

REPO="sonia0u/memphis-science-image-prompts"
SKILL_DIR="image-memphis-gzh--prompt-c"
BRANCH="${BRANCH:-main}"

# 各 agent 的用户级 skills 目录（键名 -> 路径）
agent_path() {
  case "$1" in
    workbuddy) echo "$HOME/.workbuddy/skills" ;;
    claude)    echo "$HOME/.claude/skills" ;;
    codex)     echo "$HOME/.codex/skills" ;;
    cursor)    echo "$HOME/.cursor/skills" ;;
    *)         return 1 ;;
  esac
}

# 检测本机已安装的 agent（目录存在即视为已安装）
detected=()
for a in workbuddy claude codex cursor; do
  p="$(agent_path "$a")"
  # Windows 上的 WorkBuddy 自定义位置
  if [ "$a" = "workbuddy" ] && [ -d "D:/AI-Skills" ]; then
    detected+=("D:/AI-Skills")
  fi
  if [ -d "$p" ]; then
    detected+=("$p")
  fi
done
# 项目级 .claude/skills（在当前目录）
if [ -d ".claude/skills" ]; then
  detected+=("$(pwd)/.claude/skills")
fi

# 去重（从 stdin 读取）
uniq() { awk '!seen[$0]++'; }

TARGET=""
MODE="all"
while [ $# -gt 0 ]; do
  case "$1" in
    --target) TARGET="$2"; MODE="one"; shift 2 ;;
    --all)    MODE="all"; shift ;;
    --list)   MODE="list"; shift ;;
    --agent)  TARGET="$(agent_path "$2")"; MODE="one"; shift 2 ;;
    *) echo "未知参数: $1" >&2; exit 1 ;;
  esac
done

# 解析最终要安装的目录列表
if [ "$MODE" = "list" ]; then
  if [ ${#detected[@]} -gt 0 ]; then
    echo "检测到以下 agent 的 skills 目录:"
    printf '  %s\n' "${detected[@]}" | uniq
  else
    echo "未检测到已知 agent，回退默认: $HOME/.workbuddy/skills"
  fi
  exit 0
fi

if [ "$MODE" = "one" ]; then
  targets=("$TARGET")
else
  if [ ${#detected[@]} -gt 0 ]; then
    targets=($(printf '%s\n' "${detected[@]}" | uniq))
  else
    targets=("$HOME/.workbuddy/skills")
    echo "⚠️  未检测到已知 agent，将装到 WorkBuddy 默认目录: ${targets[0]}"
  fi
fi

# ---- 取得 Skill 源目录 ----
TMP=""
cleanup() { [ -n "$TMP" ] && rm -rf "$TMP"; }
trap cleanup EXIT

SRC=""
if [ -f "$(dirname "$0")/$SKILL_DIR/SKILL.md" ]; then
  SRC="$(cd "$(dirname "$0")" && pwd)"
else
  if ! command -v git >/dev/null 2>&1; then
    echo "❌ 未找到 git，请先安装 git 后重试。" >&2
    exit 1
  fi
  TMP="$(mktemp -d)"
  echo "⬇️  正在从 GitHub 下载 $REPO ..."
  git clone --depth 1 --branch "$BRANCH" "https://github.com/$REPO.git" "$TMP/repo" >/dev/null 2>&1
  SRC="$TMP/repo"
fi

if [ ! -d "$SRC/$SKILL_DIR" ]; then
  echo "❌ 未找到 $SKILL_DIR，下载可能不完整。" >&2
  exit 1
fi

# ---- 安装到每个目标目录 ----
for SKILLS in "${targets[@]}"; do
  mkdir -p "$SKILLS"
  if [ -d "$SKILLS/$SKILL_DIR" ]; then
    echo "🔄  $SKILLS 下已存在 $SKILL_DIR，备份为 .bak"
    rm -rf "$SKILLS/${SKILL_DIR}.bak"
    mv "$SKILLS/$SKILL_DIR" "$SKILLS/${SKILL_DIR}.bak"
  fi
  cp -R "$SRC/$SKILL_DIR" "$SKILLS/"
  echo "✅ 已安装到 $SKILLS/$SKILL_DIR"
done

echo ""
echo "完成。重启对应 agent 后，说「帮我把这篇文章做成孟菲斯风科普图提示词」即可使用。"
echo "（注：agents/openai.yaml 仅 WorkBuddy 使用，其它 agent 会自动忽略该文件，不影响功能。）"
echo ""
