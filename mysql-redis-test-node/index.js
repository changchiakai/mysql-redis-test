require('dotenv').config();
const express = require('express');
const Redis = require('ioredis');
const { Sequelize, DataTypes } = require('sequelize');

// 從環境變數讀取 MySQL 設定
const MYSQL_HOST = process.env.MYSQL_HOST;
const MYSQL_USER = process.env.MYSQL_USER;
const MYSQL_PASSWORD = process.env.MYSQL_PASSWORD;
const MYSQL_DATABASE = process.env.MYSQL_DATABASE;

// 建立 Sequelize 連線
const sequelize = new Sequelize(MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD, {
  host: MYSQL_HOST,
  dialect: 'mysql',
});

// 定義 User 模型
const User = sequelize.define('User', {
  name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  email: {
    type: DataTypes.STRING,
    unique: true,
    allowNull: false,
  },
});

// 同步資料庫
sequelize.sync().then(() => {
  console.log('資料庫同步完成');
});

const app = express();
const port = process.env.PORT || 8080;

// 從環境變數讀取 Redis 設定
const REDIS_HOST = process.env.REDIS_HOST;
const REDIS_PORT = process.env.REDIS_PORT;
const REDIS_PASSWD = process.env.REDIS_PASSWD;

// 連線到 Redis
const redisClient = new Redis(
  {
    port: REDIS_PORT,
    host: REDIS_HOST,
    password: REDIS_PASSWD
  }
);

redisClient.on('connect', () => {
  console.log('Connected to Redis');
});

redisClient.on('error', (err) => {
  console.error('Redis error:', err);
});

// 測試 API：取得所有使用者
app.get('/users', async (req, res) => {
  try {
    const users = await User.findAll();
    res.json(users);
  } catch (error) {
    res.status(500).send(error);
  }
});

app.get('/', (req, res) => {
  res.send('Hello from Cloud Run with Redis!');
});

app.get('/set', async (req, res) => {
  const { key, value } = req.query;
  if (!key || !value) {
    return res.status(400).send('Please provide both key and value');
  }
  try {
    await redisClient.set(key, value);
    res.send(`Key "${key}" set with value "${value}"`);
  } catch (err) {
    res.status(500).send('Redis error');
  }
});

app.get('/get', async (req, res) => {
  const { key } = req.query;
  if (!key) {
    return res.status(400).send('Please provide a key');
  }
  try {
    const reply = await redisClient.get(key);
    res.send(`Value for key "${key}": ${reply}`);
  } catch (err) {
    res.status(500).send('Redis error');
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
