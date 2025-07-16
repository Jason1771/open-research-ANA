#!/bin/bash

# Open Research ANA 設置檢查腳本
echo "🔍 檢查 Open Research ANA 開發環境設置..."

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 檢查函數
check_command() {
    if command -v $1 &> /dev/null; then
        echo -e "${GREEN}✅ $1 已安裝${NC}"
        return 0
    else
        echo -e "${RED}❌ $1 未安裝${NC}"
        return 1
    fi
}

check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✅ $1 存在${NC}"
        return 0
    else
        echo -e "${RED}❌ $1 不存在${NC}"
        return 1
    fi
}

check_env_var() {
    local file=$1
    local var=$2
    if [ -f "$file" ] && grep -q "^$var=" "$file" && ! grep -q "^$var=\"Your-API-key\"" "$file" && ! grep -q "^$var='Your-API-key'" "$file"; then
        echo -e "${GREEN}✅ $var 已設置在 $file${NC}"
        return 0
    else
        echo -e "${YELLOW}⚠️  $var 需要在 $file 中設置${NC}"
        return 1
    fi
}

echo ""
echo "📋 檢查必要工具..."

# 檢查基本工具
check_command "python3"
check_command "pip"
check_command "node"
check_command "npm"
check_command "pnpm"

echo ""
echo "📋 檢查 CLI 工具..."

# 檢查 CLI 工具
check_command "langgraph"

echo ""
echo "📋 檢查專案檔案..."

# 檢查重要檔案
check_file "agent/requirements.txt"
check_file "frontend/package.json"
check_file ".devcontainer/devcontainer.json"
check_file ".devcontainer/setup.sh"

echo ""
echo "📋 檢查環境變數檔案..."

# 檢查環境變數檔案
check_file "agent/.env"
check_file "frontend/.env"

echo ""
echo "📋 檢查 API Keys 設置..."

# 檢查 Agent API Keys
if [ -f "agent/.env" ]; then
    check_env_var "agent/.env" "OPENAI_API_KEY"
    check_env_var "agent/.env" "TAVILY_API_KEY"
    check_env_var "agent/.env" "LANGSMITH_API_KEY"
fi

# 檢查 Frontend API Keys
if [ -f "frontend/.env" ]; then
    check_env_var "frontend/.env" "OPENAI_API_KEY"
    check_env_var "frontend/.env" "LANGSMITH_API_KEY"
    check_env_var "frontend/.env" "NEXT_PUBLIC_COPILOT_CLOUD_API_KEY"
fi

echo ""
echo "📋 檢查依賴安裝..."

# 檢查 Python 依賴
if [ -d "agent" ]; then
    cd agent
    if python3 -c "import langchain, langgraph, tavily" 2>/dev/null; then
        echo -e "${GREEN}✅ Python 依賴已安裝${NC}"
    else
        echo -e "${RED}❌ Python 依賴未完全安裝${NC}"
    fi
    cd ..
fi

# 檢查 Node.js 依賴
if [ -d "frontend/node_modules" ]; then
    echo -e "${GREEN}✅ Node.js 依賴已安裝${NC}"
else
    echo -e "${RED}❌ Node.js 依賴未安裝${NC}"
fi

echo ""
echo "📋 檢查端口可用性..."

# 檢查端口
if ! lsof -i:3000 &>/dev/null; then
    echo -e "${GREEN}✅ 端口 3000 可用${NC}"
else
    echo -e "${YELLOW}⚠️  端口 3000 被佔用${NC}"
fi

if ! lsof -i:8123 &>/dev/null; then
    echo -e "${GREEN}✅ 端口 8123 可用${NC}"
else
    echo -e "${YELLOW}⚠️  端口 8123 被佔用${NC}"
fi

echo ""
echo "🎯 設置建議："
echo "1. 如果有 API keys 未設置，請編輯對應的 .env 檔案"
echo "2. 如果依賴未安裝，請運行："
echo "   - cd agent && pip install -r requirements.txt"
echo "   - cd frontend && pnpm install"
echo "3. 如果端口被佔用，請停止佔用的進程或修改配置"
echo ""
echo "✨ 設置完成後，運行 ./start-dev.sh 啟動應用程式"
