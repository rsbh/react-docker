FROM node:14-alpine AS builder
WORKDIR /app
COPY package.json ./
COPY yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .

RUN yarn build
FROM nginx:alpine
COPY --from=builder ./app/build /usr/share/nginx/html
ENTRYPOINT ["nginx", "-g", "daemon off;"]
