#!/usr/bin/env bash

swift build -c release
cp ./.build/release/ObjectCreator /usr/local/bin/codable