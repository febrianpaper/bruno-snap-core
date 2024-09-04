echo "Running UAT Tools [Mandiri Pusat]"

ENV="local"
RESULT="mandiri-pusat"

ACTION=$(gum choose --header="Choose Action" "balance-inquiry" "internal-account-inquiry" "external-account-inquiry" "transfer-intrabank" "transfer-interbank" "transfer-rtgs")
MODULE="Mandiri/${ACTION}/"

RESULT="$RESULT-$ACTION-uat.json"

touch result/$RESULT

gum spin --spinner=dot --title="Sending Request, Please wait..." --timeout=0 -- bru run --env $ENV --output result/$RESULT ./UATTool/$MODULE

cat result/$RESULT | jq '.[].results'

echo "You can run this command to run again without TUI:"
gum style --foreground=212 "bru run --env $ENV --output result/$RESULT ./UATTool/$MODULE"