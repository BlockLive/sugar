1. pull sugar repo, checkout and pull usingUses2. Make sure you pull into the same directory that custom-candy-machine lives
2. cd into sugar and run `cargo build`
3. follow instructions on custom-candy-machine repo to deploy successfully
4. run `sh script/sugar-cli-test.sh` and select devnet option (should be 3) and hit enter. Verify test runs correctly.
5. Make sure all files created by the test (ex. config.json, cache.json, /assets) was deleted at the end of the test
6. to run our custom sugar, make sure you are in the root of the repo and run `cargo run --quiet --bin sugar -- launch`