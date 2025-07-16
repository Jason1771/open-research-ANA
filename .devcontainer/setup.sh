#!/bin/bash

# 設置腳本執行時出錯就停止
set -e

echo "🚀 開始設置 Open Research ANA 開發環境..."

# 更新系統套件
echo "📦 更新系統套件..."
sudo apt-get update

# 安裝 pnpm
echo "📦 安裝 pnpm..."
npm install -g pnpm

# 安裝 Python 依賴
echo "🐍 安裝 Python 依賴..."
cd /workspaces/open-research-ANA/agent
pip install -r requirements.txt

# 安裝 LangGraph CLI
echo "🔧 安裝 LangGraph CLI..."
pip install langgraph-cli

# 安裝 CopilotKit CLI
echo "🤖 安裝 CopilotKit CLI..."
npm install -g copilotkit@latest

# 安裝 Frontend 依賴
echo "⚛️ 安裝 Frontend 依賴..."
cd /workspaces/open-research-ANA/frontend
pnpm install

# 創建環境變數檔案範本
echo "📝 創建環境變數檔案範本..."

# Agent .env 檔案
cd /workspaces/open-research-ANA/agent
if [ ! -f .env ]; then
    cp .env.example .env
    echo "✅ 已創建 agent/.env 檔案，請填入您的 API keys"
fi

# Frontend .env 檔案
cd /workspaces/open-research-ANA/frontend
if [ ! -f .env ]; then
    cp .env.example .env
    # 添加缺少的 CopilotKit API key 配置
    echo 'NEXT_PUBLIC_COPILOT_CLOUD_API_KEY="Your-API-key"' >> .env
    echo "✅ 已創建 frontend/.env 檔案，請填入您的 API keys"
fi

echo "🎉 開發環境設置完成！"
echo ""
echo "📋 接下來的步驟："
echo "1. 在 agent/.env 中填入您的 API keys："
echo "   - OPENAI_API_KEY"
echo "   - TAVILY_API_KEY"
echo "   - LANGSMITH_API_KEY"
echo ""
echo "2. 在 frontend/.env 中填入您的 API keys："
echo "   - OPENAI_API_KEY"
echo "   - LANGSMITH_API_KEY"
echo "   - NEXT_PUBLIC_COPILOT_CLOUD_API_KEY"
echo ""
echo "3. 啟動服務："
echo "   - 在 agent/ 目錄執行: langgraph up"
echo "   - 在新終端執行: npx copilotkit@latest dev --port 8123"
echo "   - 在 frontend/ 目錄執行: pnpm run dev"
echo ""
echo "🌐 應用程式將在 http://localhost:3000 運行"
