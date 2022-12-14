#build phase
FROM node:alpine as builder

WORKDIR /app

COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# after this there will be a folder /app/build

#run phase
FROM nginx
# need to expose port for deployment
EXPOSE 80
# copy from the builder phase. The destination folder is a setting from ngnix
COPY --from=builder /app/build  /usr/share/nginx/html