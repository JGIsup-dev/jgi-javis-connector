#!/bin/bash
# Hook script: reads inbox file and outputs messages for Claude to see
INBOX="$HOME/.jgi-javis-connector/inbox.jsonl"

if [ -f "$INBOX" ] && [ -s "$INBOX" ]; then
  echo "📨 新着メッセージ:"
  while IFS= read -r line; do
    from=$(echo "$line" | grep -o '"from_summary":"[^"]*"' | cut -d'"' -f4)
    text=$(echo "$line" | grep -o '"text":"[^"]*"' | cut -d'"' -f4)
    if [ -n "$from" ]; then
      echo "  From $from: $text"
    else
      from_id=$(echo "$line" | grep -o '"from_id":"[^"]*"' | cut -d'"' -f4)
      echo "  From $from_id: $text"
    fi
  done < "$INBOX"
  echo "↑ send_message または talk で返信してください"
  rm -f "$INBOX"
fi
