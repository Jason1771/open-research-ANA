#!/bin/bash

# Open Research ANA 開發環境啟動腳本
echo "🚀 啟動 Open Research ANA 開發環境..."

# 檢查是否在 devcontainer 中
if [ ! -d "/workspaces" ]; then
    echo "⚠️  請在 devcontainer 中執行此腳本"
    exit 1
fi

# 檢查環境變數檔案
if [ ! -f "agent/.env" ]; then
    echo "❌ 找不到 agent/.env 檔案，請先設置 API keys"
    echo "💡 提示：複製 agent/.env.example 到 agent/.env 並填入您的 API keys"
    exit 1
fi

if [ ! -f "frontend/.env" ]; then
    echo "❌ 找不到 frontend/.env 檔案，請先設置 API keys"
    echo "💡 提示：複製 frontend/.env.example 到 frontend/.env 並填入您的 API keys"
    exit 1
fi

echo "📋 啟動順序："
echo "1. 啟動 LangGraph Agent (port 8123)"
echo "2. 啟動 CopilotKit tunnel"
echo "3. 啟動 Frontend (port 3000)"
echo ""

# 函數：啟動 agent
start_agent() {
    echo "🤖 啟動 LangGraph Agent..."
    cd agent
    langgraph up &
    AGENT_PID=$!
    cd ..
    echo "Agent PID: $AGENT_PID"
    sleep 5
}

# 函數：啟動 copilotkit tunnel
start_tunnel() {
    echo "🌐 啟動 CopilotKit tunnel..."
    npx copilotkit@latest dev --port 8123 &
    TUNNEL_PID=$!
    echo "Tunnel PID: $TUNNEL_PID"
    sleep 3
}

# 函數：啟動 frontend
start_frontend() {
    echo "⚛️ 啟動 Frontend..."
    cd frontend
    pnpm run dev &
    FRONTEND_PID=$!
    cd ..
    echo "Frontend PID: $FRONTEND_PID"
}

# 清理函數
cleanup() {
    echo ""
    echo "🛑 正在停止所有服務..."
    if [ ! -z "$AGENT_PID" ]; then
        kill $AGENT_PID 2>/dev/null || true
    fi
    if [ ! -z "$TUNNEL_PID" ]; then
        kill $TUNNEL_PID 2>/dev/null || true
    fi
    if [ ! -z "$FRONTEND_PID" ]; then
        kill $FRONTEND_PID 2>/dev/null || true
    fi
    echo "✅ 所有服務已停止"
    exit 0
}

# 設置信號處理
trap cleanup SIGINT SIGTERM

# 啟動所有服務
start_agent
start_tunnel
start_frontend

echo ""
echo "🎉 所有服務已啟動！"
echo "🌐 Frontend: http://localhost:3000"
echo "🤖 Agent API: http://localhost:8123"
echo ""
echo "按 Ctrl+C 停止所有服務"

# 等待
wait
