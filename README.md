# open-research-ANA 🔍

This demo showcases ANA (Agent Native Application), a research canvas app that combines Human-in-the-Loop capabilities with [Tavily's](https://tavily.com/) real-time search and [CopilotKit's](https://copilotkit.ai) agentic interface. 

Powered by [LangGraph](https://www.langchain.com/langgraph), it simplifies complex research tasks, making them more interactive and efficient.

<p align="left">
   <a href="https://docs.copilotkit.ai/coagents" rel="dofollow">
      <strong>Explore the CopilotKit docs »</strong>
   </a>
</p>

![tavily-demo](https://github.com/user-attachments/assets/70c7db1b-de5b-4fb2-b447-09a3a1b78d73)

## Quick Start 🚀

### Option 1: DevContainer (推薦)
使用 DevContainer 可以獲得一致的開發環境：

1. 確保已安裝 [Docker Desktop](https://www.docker.com/products/docker-desktop/) 和 [VS Code Dev Containers 擴展](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
2. 在 VS Code 中打開此專案
3. 點擊 "Reopen in Container" 或使用命令面板搜索 "Dev Containers: Reopen in Container"
4. 等待環境自動設置完成
5. 配置 API keys（詳見 [DEVCONTAINER_README.md](DEVCONTAINER_README.md)）
6. 運行 `./start-dev.sh` 啟動應用程式

📖 詳細的 DevContainer 設置指南請參考 [DEVCONTAINER_README.md](DEVCONTAINER_README.md)

### Option 2: 本地安裝

#### 1. Prerequisites
This projects uses the following tools:

- [pnpm](https://pnpm.io/installation)
- [Docker](https://docs.docker.com/get-docker/)
- [Langgraph CLI](https://langchain-ai.github.io/langgraph/cloud/reference/cli/)

### 2. API Keys Needed
Running locally, you'll need the following API keys:

- [OpenAI](https://platform.openai.com/api-keys)
- [Tavily](https://tavily.com/#pricing)
- [LangSmith](https://docs.smith.langchain.com/administration/how_to_guides/organization_management/create_account_api_key)
- [CopilotKit](https://cloud.copilotkit.ai)

### 3. Start the Agent
There are two main components to this project: the agent and the frontend. First, we'll start the agent.

```bash
cd agent

# Create and populate .env
cat << EOF > .env
OPENAI_API_KEY=your_key
TAVILY_API_KEY=your_key
LANGSMITH_API_KEY=your_key
EOF

## Start the agent
langgraph up

# Note the API URL from the output (e.g., http://localhost:8123)
```

### 4. Open a tunnel to your local agent
Create a tunnel to your local agent:
```bash
npx copilotkit@latest dev --port 8123
```

### 5. Start the Frontend
Next, we'll start the frontend.

```bash
cd frontend
pnpm install

# Create and populate .env
cat << EOF > .env
OPENAI_API_KEY=your_openai_key
LANGSMITH_API_KEY=your_langsmith_key
NEXT_PUBLIC_COPILOT_CLOUD_API_KEY=your_copilot_cloud_key
EOF

# Start the app
pnpm run dev
```

## Documentation 📚
- [CopilotKit Docs](https://docs.copilotkit.ai/coagents)
- [LangGraph Platform Docs](https://langchain-ai.github.io/langgraph/cloud/deployment/cloud/)
