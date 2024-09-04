echo "Choose file to run"

ENV=$(gum choose --header="Choose Environment" "local" "staging" )
MODULE=$(gum choose --header="Choose Module" "Transfer" "VirtualAccount" "UATTool")

FILE=$(gum file $MODULE/)

touch result/result.json

gum spin --spinner=dot --title="Sending Request, Please wait..." --timeout=0 -- bru run --env $ENV --output result/result.json $FILE

cat result/result.json | jq '.[].results'

echo "You can run this command to run again without TUI:"
gum style --foreground=212 "bru run --env $ENV --output result/result.json $FILE"