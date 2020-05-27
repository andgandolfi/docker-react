FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/www
COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /var/log/app_engine
RUN mkdir -p /usr/share/nginx/www/_ah && \
    echo "healthy" > /usr/share/nginx/www/_ah/health
RUN chmod -R a+r /usr/share/nginx/www
