run:
	cmake -S . -B build
	cmake --build build --parallel
	./build/HeaderPopularity ~/dev/duel-server/

@PHONY: run
