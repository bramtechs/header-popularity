run:
	cmake -S . -B build && \
	cmake --build build --parallel && \
	./build/HeaderPopularity ~/dev/duel-server/core ~/dev/duel-server/embedded ~/dev/duel-server/rest-api --verbose

@PHONY: run
