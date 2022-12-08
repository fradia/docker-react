#build phase
FROM node:19-alpine3.15 as builder

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# after this there will be a folder /app/build

#run phase
FROM nginx
# copy from the builder phase. The destination folder is a setting from ngnix
COPY --from=builder /app/build  /user/share/nginx/html
# this will automatically start the ngnix container (no extra command should be specified)