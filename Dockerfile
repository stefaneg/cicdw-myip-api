FROM gulli/cloudformation-deployer:0.1-8

ADD package.json .
ADD package-lock.json .

RUN npm ci

ADD ./src ./src

RUN npm run test

RUN npm run build

ADD --chown=deployeruser:deployergroup . .

ENTRYPOINT ["./create-or-update-stack.sh"]

