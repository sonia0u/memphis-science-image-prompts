#!/usr/bin/env bash
#
# 一键安装 memphis-science-image-prompts (孟菲斯风科普图提示词 Skill)
# 用法:
#   curl -fsSL https://raw.githubusercontent.com/sonia0u/memphis-science-image-prompts/main/install.sh | bash
#
# 也可手动克隆后用本脚本:  bash install.sh
set -euo pipefail

REPO="sonia0u/memphis-science-image-prompts"
SKILL_DIR="image-memphis-gzh--prompt-c"
BRANCH="${BRANCH:-main}"

# ---- 定位 WorkBuddy 的 skills 目录 ----
if [ -n "${WORKBUDDY_SKILLS:-}" ]; then
  SKILLS="$WORKBUDDY_SKILLS"
elif [ -d "$HOME/.workbuddy/skills" ]; then
  SKILLS="$HOME/.workbuddy/skills"
elif [ -d "D:/AI-Skills" ]; then
  SKILLS="D:/AI-Skills"
elif [ -d "$HOME/Documents/WorkBuddy/skills" ]; then
  SKILLS="$HOME/Documents/WorkBuddy/skills"
else
  SKILLS="$HOME/.workbuddy/skills"
fi

# ---- 下载（优先用已克隆的仓库，否则 git clone）----
TMP=""
cleanup() { [ -n "$TMP" ] && rm -rf "$TMP"; }
trap cleanup EXIT

SRC=""
if [ -f "$(dirname "$0")/$SKILL_DIR/SKILL.md" ]; then
  # 脚本随仓库一起存在
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

# ---- 安装 ----
if [ ! -d "$SRC/$SKILL_DIR" ]; then
  echo "❌ 未找到 $SKILL_DIR，下载可能不完整。" >&2
  exit 1
fi

mkdir -p "$SKILLS"
if [ -d "$SKILLS/$SKILL_DIR" ]; then
  echo "🔄  检测到已存在 $SKILL_DIR，先备份为 ${SKILL_DIR}.bak"
  rm -rf "$SKILLS/${SKILL_DIR}.bak"
  mv "$SKILLS/$SKILL_DIR" "$SKILLS/${SKILL_DIR}.bak"
fi

cp -R "$SRC/$SKILL_DIR" "$SKILLS/"

echo ""
echo "✅ 安装完成：$SKILLS/$SKILL_DIR"
echo "   重启 WorkBuddy 后，对 AI 说「帮我把这篇文章做成孟菲斯风科普图提示词」即可使用。"
echo ""
