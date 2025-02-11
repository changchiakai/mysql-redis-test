
# 使用 Node.js 官方映像檔
FROM node:18-alpine

# 設定工作目錄
WORKDIR /app

# 複製 package.json 和 package-lock.json
COPY package*.json ./

# 安裝依賴
RUN npm install

# 複製應用程式程式碼
COPY . .

# 暴露端口
EXPOSE 8080

# 啟動應用程式
CMD ["npm", "start"]
