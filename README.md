# Capitalism But...

A Godot project (project feature version 4.6) with a 3D scene, dialogue elements, and an in-world keyboard interface.

## Run

Open this directory in Godot 4.6 or newer and run the configured main scene.

## Export

Export presets are provided for Web, Linux, and Windows. Output paths are repository-relative and land under `build/`, which is intentionally ignored by Git.

## Validation

The project can be scanned headlessly with:

```sh
godot --headless --path . --editor --quit
```

There is currently no automated gameplay test suite.
