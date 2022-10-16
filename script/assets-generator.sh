
CURRENT_DIR=$(pwd)
SCRIPT_DIR=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") &>/dev/null && pwd)
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
ASSETS_DIR=$CURRENT_DIR/assets

    # Creation of the collection. This will generate ITEMS x (json, image)
    # files in the ASSETS_DIR

  echo "[$(date "+%T")] Creating assets"
    if [ ! -d $ASSETS_DIR ]; then
  echo "[$(date "+%T")] Creating assets"
        mkdir $ASSETS_DIR
        # loads the animation asset
        if [ "$ANIMATION" -eq 1 ]; then
            curl -L -s $MP4 >"$ASSETS_DIR/template_animation.mp4"
            SIZE=$(wc -c "$ASSETS_DIR/template_animation.mp4" | grep -oE '[0-9]+' | head -n 1)

            if [ $SIZE -eq 0 ]; then
                RED "[$(date "+%T")] Aborting: could not download sample mp4"
                exit 1
            fi
        fi

        curl -L -s $IMAGE >"$ASSETS_DIR/template_image.$EXT"
        SIZE=$(wc -c "$ASSETS_DIR/template_image.$EXT" | grep -oE '[0-9]+' | head -n 1)

        if [ $SIZE -eq 0 ]; then
            RED "[$(date "+%T")] Aborting: could not download sample image"
            exit 1
        fi

        # initialises the assets - this will be multiple copies of the same
        # image/json pair with a new index
        INDEX="image"
        for ((i = 0; i < $ITEMS; i++)); do
            if [ ! "$TEST_IMAGE" = "Y" ]; then
                INDEX=$i
            fi
            NAME=$(($i + 1))
            MEDIA_NAME="$INDEX.$EXT"
            MEDIA_TYPE="image/$EXT"
            ANIMATION_URL=","
            ANIMATION_FILE="],"
            CATEGORY="image"
            cp "$ASSETS_DIR/template_image.$EXT" "$ASSETS_DIR/$i.$EXT"
            if [ "$ANIMATION" = 1 ]; then
                cp "$ASSETS_DIR/template_animation.mp4" "$ASSETS_DIR/$i.mp4"
                ANIMATION_URL=",\n\t\"animation_url\": \"$i.mp4\","
                ANIMATION_FILE=",\n\t\t{\n\t\t\t\"uri\": \"$i.mp4\",\n\t\t\t\"type\": \"video/mp4\"\n\t\t}],"
                CATEGORY="video"
            fi
            printf "$METADATA" "$NAME" "$NAME" "$MEDIA_NAME" "$ANIMATION_URL" "$MEDIA_NAME" "$MEDIA_TYPE" "$ANIMATION_FILE" "$CATEGORY" > "$ASSETS_DIR/$i.json"
        done
        rm "$ASSETS_DIR/template_image.$EXT"
        # quietly removes the animation template (it might not exist)
        rm -f "$ASSETS_DIR/template_animation.mp4"

        # creates the collection nft assets
        curl -L -s $COLLECTION_PNG >"$ASSETS_DIR/collection.png"
        SIZE=$(wc -c "$ASSETS_DIR/collection.png" | grep -oE '[0-9]+' | head -n 1)

        if [ $SIZE -eq 0 ]; then
            RED "[$(date "+%T")] Aborting: could not download collection sample image"
            exit 1
        fi
        printf "$COLLECTION" > "$ASSETS_DIR/collection.json"
    fi

