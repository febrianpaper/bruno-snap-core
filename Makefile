app_env=staging

run-local:
	bru run --env local --output result/result.json --

transfer-permata:
	bru run --env ${app_env} --output result/transfer/permata.json Transfer/Permata

tui:
	sh ./run-tui.sh

uat-mandiri:
	sh ./run-uat-mandiri-pusat.sh