1. `cd scripts`
2. `mkdir assets`
3. add collection.json, collection.png, and collection.mp4. Script uses these as templates
4. open assets-generator.sh and edit ITEMS, NAME_PASSED, SYMBOL, DESCRIPTION, ANIMATION, ATTRIBUTES fields
5. run `sh assets-generator`
6. move assets folder one layer out into root sugar folder
7. delete existing config.json and/or cache.json files
8. run `cargo run --bin sugar -- launch`