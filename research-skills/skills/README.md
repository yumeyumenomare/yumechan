# 연구 스킬 인벤토리

주택가격 거품 검정 연구의 R 분석 작업 지침을 관리한다. `카테고리/스킬명/SKILL.md` 구조로 관리하며, 파일명과 스킬 식별자는 영문으로, 설명과 지침은 한글로 작성한다.

배포 파일과 작업 입력만으로 이해·적용·유지보수할 수 있는 인벤토리를 제공한다. 제작에 사용한 대화·조사 이력은 포함하지 않는다. 필요한 규칙·근거·템플릿은 내부에 두고 상대경로로 연결한다.

## AI가 읽는 순서

1. 아래 목록의 **적용할 작업**을 보고 현재 요청에 필요한 스킬만 선택한다. 맞는 스킬이 없으면 억지로 적용하지 않는다.
2. 선택한 스킬의 `SKILL.md`를 읽고 작업한다. R 코드를 작성·수정하는 요청에는 `r-readable-analysis-code`를 함께 적용한다.
3. `references/`, `assets/`는 선택한 스킬이 안내한 조건에 해당할 때만 읽는다. 모든 파일을 미리 읽지 않는다.
4. 스킬을 추가하거나 수정할 때는 [생성·유지보수 가이드](MAINTENANCE.md)와 [생성 템플릿](_templates/SKILL.template.md)을 읽는다.

현재 사용자의 요청과 분석 프로젝트의 `config.R`을 먼저 확인한다. 스킬의 고정 사양과 요청이 충돌하면 임의로 한쪽을 고르지 말고 충돌을 알린 뒤 사용자의 결정을 따른다.

## 카테고리

| 카테고리 | 분류 기준 | 현재 상태 |
| --- | --- | --- |
| `coding` | R 코드의 구성·가독성·재현성 등 언어와 작성 방식의 관례 | 스킬 1개 |
| `data` | 원자료 읽기, 지역 식별, 종속변수 구성, 계절조정 | 스킬 1개 |
| `econometrics` | 검정 통계량, 임계값 산출, 기각 판정, 시점 추정 등 계량 사양 | 스킬 1개 |
| `reporting` | 결과표·그림·서술 문구 등 논문 산출물 | 스킬 1개 |

분류는 스킬의 **주목적**을 기준으로 한다. 계절조정은 계량 기법이지만 검정 전 자료 준비 단계이므로 `data`에 둔다. 새 작업군이 생기면 카테고리를 추가할 수 있다.

## 스킬 목록

| 스킬 | 카테고리 | 적용할 작업 | 진입 파일 |
| --- | --- | --- | --- |
| `r-readable-analysis-code` | `coding` | 연구용 R 스크립트의 신규 작성·수정·설명. 단계별 스크립트, `config.R` 사양 관리, 한글 구간 주석, 검증 출력 | [SKILL.md](coding/r-readable-analysis-code/SKILL.md) |
| `kb-housing-data-prep` | `data` | KB 월간 주택 시계열 엑셀 읽기, 지역 열 식별, D1·D2 구성, X-13 계절조정, 새 발표월 자료 갱신 | [SKILL.md](data/kb-housing-data-prep/SKILL.md) |
| `psy-bubble-critical-values` | `econometrics` | GSADF/BSADF 계산, MC·WB(HLST 2016)·WB2020(Phillips–Shi 2020) 임계값 산출, 판정, 시점 추정, 강건성 재실행 | [SKILL.md](econometrics/psy-bubble-critical-values/SKILL.md) |
| `bubble-results-reporting` | `reporting` | 방법별 판정 비교표, 시점 추정 그림, 변동성 프로파일, 결과 서술 문구 | [SKILL.md](reporting/bubble-results-reporting/SKILL.md) |

R 코드를 작성하는 모든 요청에는 `r-readable-analysis-code`를 함께 적용한다. 이 스킬은 코드의 형식만 정하며, 시차·반복 수·계절조정 같은 사양은 정하지 않는다.

자료를 읽거나 종속변수를 만드는 단계는 `kb-housing-data-prep`, 그 결과로 검정을 돌리는 단계는 `psy-bubble-critical-values`를 선택한다. 검정 결과를 표·그림·문장으로 옮기는 작업은 `bubble-results-reporting`을 선택하며, 해석 근거가 필요하면 검정 스킬의 참고 문서를 연결해 읽는다.

새 발표월 자료로 분석 전체를 갱신하는 요청은 네 스킬을 단계 순서대로 적용한다: 자료 준비 → 검정 → 결과 작성. 각 단계의 확인 기준을 통과한 뒤 다음 단계로 넘어간다.

## 디렉토리 구조

```text
skills/
├── README.md                          # AI의 스킬 선택용 목록
├── MAINTENANCE.md                     # 사람의 유지보수 안내
├── _templates/
│   └── SKILL.template.md              # 새 스킬을 만들 때 복사할 양식
├── coding/
│   └── r-readable-analysis-code/
│       ├── SKILL.md                   # R 코드 구성·가독성 규칙
│       └── assets/
│           ├── script-template.R      # 단계별 스크립트 양식
│           └── config-template.R      # 사양값을 모으는 config.R 양식
├── data/
│   └── kb-housing-data-prep/
│       ├── SKILL.md                   # 자료 준비 절차
│       └── references/
│           ├── kb-sheet-layout.md     # KB 엑셀 시트 구조와 함정
│           └── region-map.md          # KB 열 이름 ↔ 분석 표기, 시작월
├── econometrics/
│   └── psy-bubble-critical-values/
│       ├── SKILL.md                   # 검정·임계값 절차와 고정 사양
│       └── references/
│           ├── exuber-api.md          # exuber 함수 사양과 반환 구조
│           └── critical-value-decisions.md # 방법별 이론·해석 근거
└── reporting/
    └── bubble-results-reporting/
        └── SKILL.md                   # 표·그림·서술 기준
```

## 유지보수

- 규칙 수정·스킬 추가·사양 변경 시 수정 위치: [MAINTENANCE.md](MAINTENANCE.md)
- Codex 연결: [프로젝트 루트의 SKILLS_SETUP.md](../SKILLS_SETUP.md)
- 새 스킬 양식: [_templates/SKILL.template.md](_templates/SKILL.template.md)
- 카테고리는 한 단계만 둔다. 예정 카테고리의 폴더는 실제 스킬을 추가할 때 만든다.

스킬 추가 시 이 목록도 함께 갱신한다. 실행 중인 채팅에 반영되지 않으면 Codex를 다시 시작한다.
