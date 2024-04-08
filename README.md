# Benchmarks for different real world use-cases

This tests some of my real world usages on Raspberry Pi and cloud servers.

The host system needs `bash` and `podman` to run `./run.sh`.
`docker` might work instead of `podman`.

The general idea of this is not to provide absolute results.
The goal is to compare different systems in relation to each other.

## Factorio Headless Benchmark

You need a save-game for this and save it as `savegame.zip` in this folder.
Podman will bind this file into the container.

I used [flame_Sla 10k](https://factoriobox.1au.us/map/info/4c5f65003d84370f16d6950f639be1d6f92984f24c0240de6335d3e161705504) which is also linked from the [official devs in FFF-371](https://www.factorio.com/blog/post/fff-371).

```bash
wget -O savegame.zip https://factoriobox.1au.us/map/download/4c5f65003d84370f16d6950f639be1d6f92984f24c0240de6335d3e161705504.zip
```
