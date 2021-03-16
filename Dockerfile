FROM node:12-alpine AS builder
WORKDIR /app
COPY package.json /app/
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
RUN cnpm install
COPY . /app
RUN npm run build

#指定nginx配置项目，--from=builder 指的是从上一次 build 的结果中提取了编译结果(FROM node:alpine as builder)，即是把刚刚打包生成的dist放进nginx中
FROM nginx
COPY --from=builder app/dist /usr/share/nginx/html/
COPY --from=builder app/nginx.conf /etc/nginx/conf.d/nginx.conf
EXPOSE 80