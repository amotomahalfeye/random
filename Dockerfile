FROM docker.io/library/node:26.5.0@sha256:926d6cafec97f338577041890465522f70fe74aa6fe4b021a4fd7f87a5996b25

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

FROM docker.io/library/nginx:1.31.2@sha256:b5a9a3cfc86b81dd6f1458d53f2ad2b559cc255653d2efd6cacee5636bf2066f

WORKDIR /usr/share/nginx/html

RUN rm -rf ./*
COPY --from=0 /home/app/dist .

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 3021
CMD ["nginx", "-g", "daemon off;"]