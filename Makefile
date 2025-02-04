run:
	cmake -S . -B build && \
	cmake --build build --parallel && \
	./build/header-popularity || \
	./build/header-popularity ~/dev/duel-server/core ~/dev/duel-server/embedded ~/dev/duel-server/rest-api

@PHONY: run
