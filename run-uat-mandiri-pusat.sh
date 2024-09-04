echo "Running UAT Tools [Mandiri Pusat]"

ENV="local"
RESULT="mandiri-pusat-uat.json"

ACTION=$(gum choose --header="Choose Action" "balance-inquiry" "internal-account-inquiry")
MODULE="Mandiri/${ACTION}/"

touch result/$RESULT

gum spin --spinner=dot --title="Sending Request, Please wait..." --timeout=0 -- bru run --env $ENV --output result/$RESULT ./UATTool/$MODULE

cat result/$RESULT | jq '.[].results'

echo "You can run this command to run again without TUI:"
gum style --foreground=212 "bru run --env $ENV --output result/$RESULT ./UATTool/$MODULE"