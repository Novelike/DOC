#!/bin/bash

# 기본 설정
OPENAI_API_KEY="api_key"
MODEL="${THEHELP_MODEL:-gpt-4.1-nano}"
ERR_FILE="${THEHELP_ERR_FILE:-/home/kjh/kjhbot/kjhbot_err.log}"
OUT_FILE="${THEHELP_OUT_FILE:-/home/kjh/kjhbot/kjhbot_out.log}"
VERBOSE=0

print_help() {
  echo "Usage: kjhbot.sh [options] [command]"
  echo ""
  echo "Options:"
  echo "  -v, --verbose     상세 제안 모드"
  echo "  -h, --help        사용법 출력"
}

# 옵션 파싱
while [[ "$1" == -* ]]; do
  case "$1" in
    -v|--verbose) VERBOSE=1; shift ;;
    -h|--help) print_help; exit 0 ;;
    *) echo "알 수 없는 옵션: $1"; print_help; exit 1 ;;
  esac
done

if [[ -z "$OPENAI_API_KEY" ]]; then
  echo "Error: OPENAI_API_KEY 환경 변수가 설정되지 않았습니다."
  exit 1
fi

# 로그 초기화
> "$ERR_FILE"
> "$OUT_FILE"

if [[ $# -gt 0 ]]; then
  # 사용자가 입력한 명령어 실행 & 로그 적재
  echo "[+] 명령어 실행 중: $*"
  bash -c "$*" >> >(tee "$OUT_FILE") 2>> >(tee "$ERR_FILE" >&2)

  # 분석할 로그 선택
  if [[ -s "$ERR_FILE" ]]; then
    LOG_CONTENT=$(tail -n 30 "$ERR_FILE")
    PROMPT="다음 명령어의 에러 로그를 분석해줘: \"$*\"\n\n$LOG_CONTENT"
  else
    LOG_CONTENT=$(tail -n 30 "$OUT_FILE")
    PROMPT="다음 명령어의 출력 결과를 분석해줘: \"$*\"\n\n$LOG_CONTENT"
  fi
else
  echo "분석할 명령어가 없습니다. 사용법을 확인하세요."
  print_help
  exit 1
fi

if [[ $VERBOSE -eq 1 ]]; then
  PROMPT="$PROMPT\n\n가능한 3가지 해결책을 상세히 제시해줘."
fi

# OpenAI API 호출 (스트리밍)
curl -sS https://api.openai.com/v1/chat/completions \
  -H "Authorization: Bearer ${OPENAI_API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "'"${MODEL}"'",
    "messages": [{"role": "user", "content": "'"${PROMPT}"'"}],
    "stream": true
  }' | while read -r line; do
    # "data:" 로 시작하는 라인만 처리
    if [[ "$line" == data* ]]; then
      # DONE 신호는 무시
      if [[ "$line" == "data: [DONE]" ]]; then
        break
      fi

      # 유효한 JSON만 파싱
      echo "$line" | sed 's/^data: //' | jq -r '.choices[0].delta.content // empty'
    fi
done

