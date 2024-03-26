
#------- swift -------
# Building using Ubuntu jammy
FROM swift:5.10-jammy as swift-builder

# set up the workspace
WORKDIR /workspace

# copy the source to the docker image
COPY Package.swift .
COPY Package.resolved .

RUN swift package resolve --force-resolved-versions

# copy the sources to the docker image
COPY . /workspace

RUN swift build -c release --static-swift-stdlib

#------- node -------
FROM node:lts-bullseye as node-builder

# set up the workspace
WORKDIR /workspace

# copy the source to the docker image
COPY package.json .
COPY package-lock.json .

RUN npm install

# copy the sources to the docker image
COPY . /workspace

RUN npx tailwindcss -i ./src/input.css -o ./public/output.css -m

#------- runner -------
FROM ubuntu:jammy

RUN mkdir /app
RUN mkdir /app/public
WORKDIR /app/
COPY --from=swift-builder /workspace/.build/release/welcome /app/welcome
COPY --from=node-builder /workspace/public/output.css /app/public/output.css

ENTRYPOINT ["./welcome"]
