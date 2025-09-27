#!/usr/bin/env bash
set -euo pipefail

: "${VAULT_NAME:=n8n-key-vault}"
FOLDER="/secrets"
mkdir -p "$FOLDER"



# Get all secret names as a JSON array and iterate over them
for secret in $(az keyvault secret list \
    --vault-name "$VAULT_NAME" \
    --query "[].name" \
    -o tsv); do

  value=$(az keyvault secret show \
    --vault-name "$VAULT_NAME" \
    --name "$secret" \
    --query "value" -o tsv)

  safe_name=$(printf '%s' "$secret" | tr '-' '_')
  FILE_PATH="$FOLDER/$safe_name.txt"

  # echo "Writing secret for: $safe_name to $FILE_PATH"

  printf "%s" "$value" > "$FILE_PATH" 
done

