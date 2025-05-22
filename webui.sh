#!/bin/bash

# 仮想環境と作業ディレクトリのパス
WORKDIR="./volume"
VENV_DIR="$WORKDIR/venv"
PYPROJECT="$WORKDIR/pyproject.toml"

################################################################################################
# pyproject.toml が存在するかチェック
if [ ! -f "$PYPROJECT" ]; then
  echo "Error: $PYPROJECT が見つかりません。"
  exit 1
fi

# 仮想環境がなければ作成
if [ ! -d "$VENV_DIR" ]; then
  echo "仮想環境が見つかりません。作成します..."
  python3 -m venv "$VENV_DIR"
fi

# 仮想環境を有効化
source "$VENV_DIR/bin/activate"

################################################################################################
# pip を毎回アップグレード（任意）
echo "pip をアップグレード中..."
pip install --upgrade pip

# ライブラリのインストールを毎回実行
echo "pyproject.toml に従ってライブラリをインストール中..."

if grep -q "\[tool.poetry\]" "$PYPROJECT"; then
  # poetry が .venv を勝手に使わないよう、現在の仮想環境を明示的に使う
  export POETRY_VIRTUALENVS_CREATE=false
  export POETRY_VIRTUALENVS_IN_PROJECT=false
  pip install poetry
  (cd "$WORKDIR" && poetry install --no-root)
else
  (cd "$WORKDIR" && pip install -e .)
fi

# 作業ディレクトリに移動
cd "$WORKDIR" || exit

poetry run gradio run.py

# 仮想環境を終了（任意）
deactivate