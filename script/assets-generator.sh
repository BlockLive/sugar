#!/bin/bash
CURRENT_DIR=$(pwd)
ASSETS_DIR="$CURRENT_DIR/assets"
COLLECTION="$ASSETS_DIR/collection"

# preparing the assets metadata
# preparing the assets metadata
read -r -d $'\0' METADATA <<-EOM
{
    "name": "%s",
    "symbol": "%s",
    "description": "%s",
    "seller_fee_basis_points": 500,
    "image": "%s"%b
    "attributes": %s
    "properties": {
        "files": [
        {
            "uri": "%s",
            "type": "%s"
        }%b
        "category": "%s"
    }
}
EOM

ITEMS="30"
NAME_PASSED="Saga Launch"
SYMBOL="SAGA"
DESCRIPTION="Saga launch event"
ANIMATION="1"
ATTRIBUTES="[{\"trait_type\": \"Orientation\", \"value\": \"Spinning\"}],"
EXT="png"
for ((i = 0; i < $ITEMS; i++));
do
    J=$(($i + 1))
    NAME="$NAME_PASSED #$J"
    MEDIA_NAME="$i.$EXT"
    MEDIA_TYPE="image/$EXT"
    ANIMATION_URL=","
    ANIMATION_FILE="],"
    CATEGORY="image"
    cp "$ASSETS_DIR/collection.$EXT" "$ASSETS_DIR/$i.$EXT"
    if [ "$ANIMATION" = 1 ]; then
        cp "$ASSETS_DIR/collection.mp4" "$ASSETS_DIR/$i.mp4"
        ANIMATION_URL=",\n\t\"animation_url\": \"$i.mp4\","
        ANIMATION_FILE=",\n\t\t{\n\t\t\t\"uri\": \"$i.mp4\",\n\t\t\t\"type\": \"video/mp4\"\n\t\t}],"
        CATEGORY="video"
    fi
    printf "$METADATA" "$NAME" "$SYMBOL" "$DESCRIPTION" "$MEDIA_NAME" "$ANIMATION_URL" "$ATTRIBUTES" "$MEDIA_NAME" "$MEDIA_TYPE" "$ANIMATION_FILE" "$CATEGORY" > "$ASSETS_DIR/$i.json"
done