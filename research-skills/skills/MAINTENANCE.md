# 스킬 유지보수 안내

## 무엇을 고치면 되는가

| 바꾸려는 내용 | 수정할 파일 |
| --- | --- |
| 스킬의 이름·적용 조건·작업 절차 | 해당 스킬의 `SKILL.md` |
| 특정 상황에서만 필요한 상세 기준·근거 | 해당 스킬의 `references/` 문서 |
| 시차·최소창·시드·반복 수·임계값 방법 등 검정 사양 | [psy-bubble-critical-values/SKILL.md](econometrics/psy-bubble-critical-values/SKILL.md)의 고정 사양 표 **와** [config 양식](coding/r-readable-analysis-code/assets/config-template.R) |
| 표본 시작월·지역 세트·종속변수 정의·계절조정 방식 | [kb-housing-data-prep/SKILL.md](data/kb-housing-data-prep/SKILL.md) **와** [config 양식](coding/r-readable-analysis-code/assets/config-template.R) |
| KB 엑셀 구조 변화(새 열, 시트 이름 변경) | [kb-sheet-layout.md](data/kb-housing-data-prep/references/kb-sheet-layout.md), [region-map.md](data/kb-housing-data-prep/references/region-map.md) |
| exuber 버전 변경에 따른 함수 사양 | [exuber-api.md](econometrics/psy-bubble-critical-values/references/exuber-api.md) |
| 카테고리의 분류 기준·상태, 스킬 목록 | `README.md` |
| 스킬 추가 방법 | 이 문서 |
| 연결·저장소 위치 이전 | [SKILLS_SETUP.md](../SKILLS_SETUP.md) |

사양값의 원본은 해당 스킬 문서다. `config-template.R`은 그 값을 코드로 옮긴 파생 자산이므로, 사양을 바꾸면 두 곳을 같은 커밋에서 함께 고친다. 목록에는 규칙을 복사하지 않고 선택에 필요한 요약만 둔다.

## 사양 변경의 원칙

이 연구의 비교 결과는 사양이 고정되어 있어야 의미가 있다. 사양을 바꾸는 것은 결과를 바꾸는 결정이다.

- 사양 변경은 사용자가 명시적으로 결정한 경우에만 반영한다. 코드 정리·오류 수정 과정에서 사양을 함께 바꾸지 않는다.
- 결정을 반영할 때는 **무엇을, 왜** 바꾸는지를 해당 스킬의 사양 표나 `references/`에 이유로 적는다. "언제 누가 결정했다"는 경위가 아니라 선택 조건과 근거를 쓴다.
- 강건성 분석용 대안 사양(예: 시차 4, 원계열)은 주 사양을 덮어쓰지 않고 별도 항목으로 둔다.

## 배포 내용과 독립 사용 원칙

판단 기준은 **현재 배포 파일만 받은 사람이 제작 이력을 몰라도 이해·적용·유지보수할 수 있는가**다.

- 최종 파일에는 적용 조건과 범위, 구체적인 규칙과 판단 이유, 필요한 예시·예외, 템플릿만 둔다.
- 개인 이름·이메일·로컬 경로·대화 경위는 스킬·references·공통 안내에 기록하지 않는다. 연구 사양·지역명·자료 출처·논문 인용은 작업에 필요한 기술 정보이므로 유지한다.
- 외부 논문·패키지 문서의 내용이 필요하면 적용할 규칙을 내부에 직접 쓴다. 외부 링크를 필수 읽기 단계로 만들지 않는다.
- 자료 파일(엑셀, 결과 .rds)은 저장소에 넣지 않는다. 구조 설명과 확인 기준만 `references/`에 둔다.

## 스킬 한 개의 구성

배치 경로는 `skills/<카테고리>/<스킬명>/SKILL.md`다. 필수 파일은 `SKILL.md` 하나이며, 맨 위의 `---` 사이에 YAML 식별 정보를 쓴다.

```yaml
---
name: kb-housing-data-prep
description: "KB 월간 주택 시계열 엑셀에서 ... 만들 때 사용한다."
---
```

- `name`: 바로 위 폴더명과 같게. 영문 소문자·숫자·하이픈, 64자 미만, 인벤토리 전체에서 고유.
- `description`: **어떤 작업에서 선택할지**를 한글로, 핵심 작업을 앞에. Codex는 설치된 스킬이 많으면 설명부터 줄여서 보여주므로 첫 문장에 적용 작업을 담는다.
- 본문: 적용 조건, 절차와 판단 이유, 놓치기 쉬운 제약, 결과물과 확인 기준.
- `references/`: 일부 작업에서만 필요한 상세 설명·근거. `SKILL.md`에 읽을 조건과 상대 링크를 적는다.
- `assets/`: 결과물에 쓰는 템플릿(R 스크립트 양식 등). `scripts/`는 실행 도구가 실제로 필요할 때만 만든다.

## 새 스킬 추가

1. 반복할 작업 하나를 정한다. 예: "분산 정상성 검정" 같은 구체 작업이 "계량 분석 전반"보다 적용 시점을 설명하기 쉽다.
2. 주목적에 맞는 카테고리를 고르고 `skills/<카테고리>/<스킬명>/` 폴더를 만든다.
3. [_templates/SKILL.template.md](_templates/SKILL.template.md)를 새 폴더의 `SKILL.md`로 복사한다.
4. 이름·설명과 본문을 실제 지침으로 바꾸고 작성 안내는 지운다. 빈 문서는 목록에 등록하지 않는다.
5. 필요한 자료를 동봉하고 `SKILL.md`에 상대 링크와 읽을 조건을 적는다.
6. `README.md`의 카테고리 상태·스킬 목록·구조를 갱신한다.
7. 아래 확인 항목을 점검하고, 실제 요청 하나로 동작을 확인한다.

## 수정 후 확인

- 폴더명과 `name`이 일치하고 이름이 겹치지 않는가?
- `name`, `description`, 본문이 채워졌고 작성 안내가 남지 않았는가?
- 설명만 보고 적용할 작업과 적용하지 않을 작업을 구별할 수 있는가?
- 링크된 파일이 존재하며, 필요한 상황에서만 읽도록 안내했는가?
- 사양값이 스킬 문서와 `config-template.R`에서 일치하는가?
- 개인 정보와 제작 경위가 본문·참고 자료·파일명에 남아 있지 않은가?
- 실제 요청으로 결과를 확인했는가? 형식 검사와 실제 작업 검증은 별개다.

선택 기준을 점검할 예시:

| 요청 | 기대하는 선택 |
| --- | --- |
| "KB 202610 자료로 지역별 D1을 다시 만들어줘" | `kb-housing-data-prep` + `r-readable-analysis-code` |
| "D1에 X-13 계절조정을 적용해줘" | `kb-housing-data-prep` |
| "16개 지역 GSADF를 세 가지 임계값으로 돌려줘" | `psy-bubble-critical-values` + `r-readable-analysis-code` |
| "시차 4로 강건성 분석을 해줘" | `psy-bubble-critical-values` (강건성 사양으로 별도 저장) |
| "방법별 유의 지역 수 비교표를 만들어줘" | `bubble-results-reporting` |
| "이 스크립트가 무슨 일을 하는지 설명해줘" | `r-readable-analysis-code` |
| "새 발표월 자료로 전체를 갱신해줘" | 자료 준비 → 검정 → 결과 작성 순서로 네 스킬 |
| "서울 아파트 지수의 ARIMA 예측 모형을 만들어줘" | 전용 스킬 없음. R 코드 형식만 `r-readable-analysis-code` |
