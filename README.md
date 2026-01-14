# Seed 🌱

Seeds → Projects → Reality

一个极简的想法捕捉和项目管理应用，支持跨设备同步。

## 功能特点

- 💡 **快速想法捕捉** - 随时记录灵感
- 📁 **项目管理** - 将想法整理成项目
- 📅 **日历视图** - 查看所有带日期的事项
- ☁️ **跨设备同步** - 使用 Supabase 云同步
- 👤 **用户账号** - 注册/登录/游客模式
- 📱 **PWA 支持** - 可添加到手机主屏幕

---

## 部署步骤

### 1️⃣ Supabase 数据库配置

**重要：** 你的表结构需要更新，添加 `user_id` 字段和 RLS 策略才能支持多用户。

1. 登录 [Supabase Dashboard](https://supabase.com/dashboard)
2. 打开你的项目 → SQL Editor
3. 运行 `supabase-schema.sql` 中的全部 SQL

**如果你的表已经存在数据：**
```sql
-- 先添加 user_id 列
ALTER TABLE ideas ADD COLUMN IF NOT EXISTS user_id uuid references auth.users on delete cascade;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS user_id uuid references auth.users on delete cascade;
ALTER TABLE project_items ADD COLUMN IF NOT EXISTS user_id uuid references auth.users on delete cascade;

-- 然后运行 schema 文件中的 RLS 策略部分
```

### 2️⃣ 启用匿名登录（可选，用于游客模式）

1. Supabase Dashboard → Authentication → Providers
2. 找到 "Anonymous Sign-Ins" 并开启

### 3️⃣ 生成 PWA 图标

1. 用浏览器打开 `generate-icons.html`
2. 点击 "Download Both Icons"
3. 将下载的 `icon-192.png` 和 `icon-512.png` 放到项目文件夹

### 4️⃣ 部署到 Netlify

**方法一：拖拽部署**
1. 打开 [Netlify Drop](https://app.netlify.com/drop)
2. 将整个 `seed-handoff` 文件夹拖进去
3. 完成！获得你的 URL

**方法二：Git 部署**
1. 将代码推送到 GitHub
2. Netlify → New site from Git → 选择仓库
3. Build settings 留空（静态文件）
4. Deploy!

---

## 文件结构

```
seed-handoff/
├── index.html          # 主应用（包含登录和主界面）
├── manifest.json       # PWA 配置
├── sw.js              # Service Worker
├── netlify.toml       # Netlify 配置
├── supabase-schema.sql # 数据库 Schema + RLS
├── seed-logo.svg      # Logo 源文件
├── generate-icons.html # 图标生成工具
├── icon-192.png       # PWA 图标 (需生成)
├── icon-512.png       # PWA 图标 (需生成)
└── README.md
```

---

## 数据库表结构

### ideas
| 列 | 类型 | 说明 |
|---|---|---|
| id | bigint | 主键 |
| user_id | uuid | 用户 ID (RLS) |
| text | text | 想法内容 |
| notes | text | 详细备注 |
| date | date | 日期 |
| created_at | timestamp | 创建时间 |

### projects
| 列 | 类型 | 说明 |
|---|---|---|
| id | bigint | 主键 |
| user_id | uuid | 用户 ID (RLS) |
| name | text | 项目名称 |
| color | text | 颜色代码 |
| created_at | timestamp | 创建时间 |

### project_items
| 列 | 类型 | 说明 |
|---|---|---|
| id | bigint | 主键 |
| project_id | bigint | 所属项目 |
| user_id | uuid | 用户 ID (RLS) |
| text | text | 事项内容 |
| notes | text | 详细备注 |
| date | date | 日期 |
| done | boolean | 是否完成 |
| created_at | timestamp | 创建时间 |

---

## 技术栈

- React 18 (CDN)
- Tailwind CSS (CDN)
- Supabase (Auth + PostgreSQL)
- PWA (manifest + service worker)

---

## 手机使用

部署后，在手机浏览器访问你的 Netlify URL：

**iOS Safari:**
1. 点击分享按钮 ↑
2. 选择「添加到主屏幕」

**Android Chrome:**
1. 点击菜单 ⋮
2. 选择「添加到主屏幕」

这样就能像原生 App 一样使用了！
