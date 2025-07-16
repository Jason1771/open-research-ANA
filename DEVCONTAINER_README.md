# Open Research ANA - DevContainer 設置指南

這個專案已經配置了 DevContainer，讓您可以在一致的開發環境中運行 Open Research ANA。

## 🚀 快速開始

### 1. 先決條件
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers 擴展](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### 2. 啟動 DevContainer
1. 在 VS Code 中打開此專案
2. 當提示出現時，點擊 "Reopen in Container"
3. 或者使用命令面板 (Ctrl+Shift+P) 搜索 "Dev Containers: Reopen in Container"

### 3. 等待環境設置
DevContainer 會自動：
- 安裝 Python 3.11 和 Node.js 20
- 安裝 pnpm、LangGraph CLI 和 CopilotKit CLI
- 安裝所有 Python 和 Node.js 依賴
- 創建環境變數檔案範本

## 🔧 配置 API Keys

### Agent 配置
編輯 `agent/.env` 檔案：
```bash
OPENAI_API_KEY=your_openai_api_key_here
TAVILY_API_KEY=your_tavily_api_key_here
LANGSMITH_API_KEY=your_langsmith_api_key_here
```

### Frontend 配置
編輯 `frontend/.env` 檔案：
```bash
OPENAI_API_KEY=your_openai_api_key_here
LANGSMITH_API_KEY=your_langsmith_api_key_here
NEXT_PUBLIC_COPILOT_CLOUD_API_KEY=your_copilot_cloud_api_key_here
```

## 🎯 啟動應用程式

### 方法 1: 使用啟動腳本（推薦）
```bash
./start-dev.sh
```

### 方法 2: 手動啟動
在三個不同的終端中執行：

1. **啟動 Agent**
```bash
cd agent
langgraph up
```

2. **啟動 CopilotKit Tunnel**
```bash
npx copilotkit@latest dev --port 8123
```

3. **啟動 Frontend**
```bash
cd frontend
pnpm run dev
```

## 🌐 訪問應用程式
- **Frontend**: http://localhost:3000
- **Agent API**: http://localhost:8123

## 📋 API Keys 獲取指南

### OpenAI API Key
1. 訪問 [OpenAI Platform](https://platform.openai.com/api-keys)
2. 登入您的帳戶
3. 創建新的 API key

### Tavily API Key
1. 訪問 [Tavily](https://tavily.com/#pricing)
2. 註冊帳戶
3. 獲取您的 API key

### LangSmith API Key
1. 訪問 [LangSmith](https://docs.smith.langchain.com/administration/how_to_guides/organization_management/create_account_api_key)
2. 按照文檔創建帳戶和 API key

### CopilotKit API Key
1. 訪問 [CopilotKit Cloud](https://cloud.copilotkit.ai)
2. 註冊並獲取您的 API key

## 🛠️ 開發工具

DevContainer 包含以下預安裝的 VS Code 擴展：
- Python 支援
- TypeScript/JavaScript 支援
- Tailwind CSS IntelliSense
- Prettier 代碼格式化
- Black Python 格式化器

## 🔍 故障排除

### 端口衝突
如果端口 3000 或 8123 被佔用：
1. 停止佔用端口的進程
2. 或修改 `.devcontainer/devcontainer.json` 中的 `forwardPorts` 設置

### 依賴安裝問題
如果依賴安裝失敗：
```bash
# 重新安裝 Python 依賴
cd agent
pip install -r requirements.txt

# 重新安裝 Node.js 依賴
cd frontend
pnpm install
```

### 環境變數問題
確保所有必要的 API keys 都已正確設置在 `.env` 檔案中。

## 📚 更多資源
- [CopilotKit 文檔](https://docs.copilotkit.ai/coagents)
- [LangGraph Platform 文檔](https://langchain-ai.github.io/langgraph/cloud/deployment/cloud/)
- [原始專案 README](README.md)
