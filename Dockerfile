FROM docker.io/library/node:26.13.1@sha256:f8e5d4bb28fa55c74f1345166a082a10b7c68f22304350c1ce0d18358ae94996

RUN mkdir -p /home/app

WORKDIR /home/app
COPY package.json /home/app
COPY package-lock.json /home/app
RUN npm install

COPY vite.config.ts /home/app
COPY tsconfig.json /home/app
COPY tsconfig.node.json /home/app
COPY tsconfig.app.json /home/app
COPY index.html /home/app
COPY env.d.ts /home/app
COPY src /home/app/src
RUN npm run build

FROM docker.io/library/nginx:1.31.4@sha256:b34848eff6db786b6b1282d3a9c3fd0b5563dfb6d261df4923378b419e0d24f0

WORKDIR /usr/share/nginx/html

RUN rm -rf ./*
COPY --from=0 /home/app/dist .

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 3021
CMD ["nginx", "-g", "daemon off;"]