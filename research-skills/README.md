# 주택가격 거품 연구 스킬

한국 주택시장의 거품 검정(PSY GSADF/BSADF) 연구를 R로 수행할 때 Codex가 따를 작업 지침을 관리하는 저장소다. 스킬은 `skills/<카테고리>/<스킬명>/`에 두고, 실행에 필요한 참고 문서·자산을 함께 보관한다.

이 저장소의 배포 파일과 현재 작업 입력(데이터 파일, R 프로젝트)만으로 스킬을 이해·적용·유지보수할 수 있도록 구성한다. 스킬 제작에 사용한 대화나 조사 이력은 배포 내용에 포함하지 않는다.

## 처음 사용하기

1. 이 저장소 전체를 원하는 로컬 경로에 clone하거나 복사한다. 폴더 이름과 위치는 자유롭게 정할 수 있다.
2. [스킬 연결 안내](SKILLS_SETUP.md)에 따라 현재 사용자의 Codex에 `skills/` 전체를 연결한다. Git clone만으로 연결이 만들어지지는 않는다.
3. [스킬 목록](skills/README.md)에서 필요한 작업을 확인하고, 새 채팅에서 스킬이 인식되는지 확인한다.

설치를 Codex에 맡기려면 이 저장소를 연 Codex에 다음과 같이 요청한다.

```text
프로젝트 루트의 SKILLS_SETUP.md를 읽고 이 PC에 연구 스킬 연결을 설정해줘.
현재 저장소의 skills 전체를 사용자 전역 경로에 연결하고,
R 분석 프로젝트에서도 스킬이 인식되는지 확인해줘.
```

## 필요한 환경

- **Codex:** 로컬 스킬을 사용할 수 있는 Codex CLI·IDE 확장·앱. 연결은 PC·사용자 계정마다 설정한다.
- **R:** R 4.0 이상. 기본 패키지는 `readxl`, `dplyr`, `tidyr`, `ggplot2`, `exuber`, `seasonal`이다. `seasonal`은 X-13 실행 파일을 제공하는 `x13binary`가 함께 설치되어야 한다. 실제 사용 버전은 실행마다 `sessionInfo()`로 기록한다.
- **입력 자료:** KB 월간 주택 시계열 엑셀, 한국은행 ECOS 회사채(3년, AA-) 월별 수익률. 자료 파일은 이 저장소에 포함하지 않으며 R 분석 프로젝트의 `data_raw/`에 둔다.

## 관리와 배포

| 경로 | 역할 |
| --- | --- |
| [SKILLS_SETUP.md](SKILLS_SETUP.md) | 최초 연결, 확인, 저장소 이동·연결 해제 안내 |
| [skills/README.md](skills/README.md) | AI의 스킬 선택용 목록 |
| [skills/MAINTENANCE.md](skills/MAINTENANCE.md) | 스킬 추가·수정, 사양 변경 시 수정 위치 |
| [backdata/README.md](backdata/README.md) | 스킬 제작용 임시 자료 폴더 안내. README 외 자료는 Git에서 제외 |
| `outputs/` | 로컬 작업 산출물. Git 배포와 스킬 연결 대상에서 제외 |

배포할 때는 `skills/` 아래의 `references/`, `assets/`도 함께 포함한다. 스킬 사이의 상대 참조는 `skills/` 내부 배치를 유지해야 동작한다.

스킬을 추가하거나 수정할 때는 [생성·유지보수 가이드](skills/MAINTENANCE.md)의 독립 사용 원칙과 검증 기준을 적용한다.
