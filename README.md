# 📦 ERD 작성 과제 제출

> 📅 제출일: 2025-04-17

## ✅ 문제 1. 배달의민족 (음식 배달 서비스)

해당 과제는 배달의민족 서비스의 ERD를 설계하고, 관계형 데이터베이스 구조를 정의하는 작업입니다.

자세한 ERD 설계 문서는 아래 링크에서 확인할 수 있습니다:

🔗 [baemin.md](https://github.com/Novelike/DOC/tree/master/diagram/erd/baemin/baemin.md)

---

### 📝 과제 개요

-   사용자(User), 음식점(Restaurant), 메뉴(Menu), 주문(Order), 주문 상세(OrderItem), 결제(Payment), 라이더(Rider) 등 주요 엔티티 식별
-   각 테이블의 속성 정의 및 제약 조건(PK, FK, UNIQUE 등) 명시
-   엔티티 간 관계 유형 (1:N, N:1, 1:1) 및 식별/비식별 관계 정리
-   VSCode ERD Editor extention을 사용하여 ERD 시각화

---

### 📎 참고 사항

-   본 과제는 `MySQL` 기준으로 작성되었으며, `VSCode ERD Editor extention`을 통해 ERD 다이어그램을 작성하였습니다.
-   다이어그램, 관계 설명, 테이블 정의는 모두 Markdown 문서 내에 표 형식으로 정리되어 있습니다.
