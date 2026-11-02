# Codex에 연구 스킬 연결하기

이 저장소의 `skills/` 전체를 현재 PC의 Codex 사용자 전역 스킬 경로에 연결한다. 연결 후에는 R 분석 프로젝트를 포함한 다른 폴더에서도 스킬을 사용할 수 있고, 앞으로 추가하는 카테고리와 스킬도 개별 등록 없이 탐색 대상이 된다.

- **원본:** 이 문서가 있는 디렉토리의 `skills/` 폴더
- **연결 위치:** 현재 사용자의 `~/.agents/skills/research`
- **적용 범위:** 연결한 PC와 사용자 계정. 다른 PC·계정에는 별도로 설정한다.

Codex는 사용자 전역 스킬을 `~/.agents/skills`에서, 저장소 단위 스킬을 작업 폴더부터 저장소 루트까지의 `.agents/skills`에서 찾고, 심볼릭 링크(symbolic link)로 연결된 스킬 폴더를 따라간다. Git clone이나 파일 복사만으로 연결이 만들어지지는 않는다. 경로에 공백이 있을 수 있으므로 명령에서 경로는 따옴표로 감싼다.

## 가장 간단한 방법: Codex에 요청

이 저장소를 연 Codex에 다음과 같이 요청한다.

```text
프로젝트 루트의 SKILLS_SETUP.md를 읽고 이 PC에 연구 스킬 연결을 설정해줘.
현재 저장소의 skills 전체를 사용자 전역 경로에 연결하고,
R 분석 프로젝트에서 기존 스킬과 앞으로 추가할 스킬을 인식하는지도 확인해줘.
```

아래 절차는 사용자가 연결 설정을 요청했을 때 적용한다. 문서를 읽는 것만으로 설정 변경이나 연결 해제를 수행하지 않는다.

## Codex가 수행할 절차

1. **현재 환경 확인**
   - 이 문서가 있는 실제 프로젝트 루트와 그 아래 `skills/`를 찾는다. 다른 PC의 경로를 복사해서 쓰지 않는다.
   - 운영체제와 사용자 홈 경로를 확인한다.
   - `skills/README.md`와 실제 `SKILL.md` 목록을 확인한다. 템플릿 파일(`SKILL.template.md`)을 실행 가능한 스킬로 취급하지 않는다.
2. **기존 연결 확인**
   - `~/.agents/skills/research`가 없으면 상위 경로를 만들고 연결한다.
   - 이미 올바른 원본을 가리키면 그대로 사용한다.
   - 다른 위치를 가리키는 링크는 대상을 사용자에게 보여주고 갱신 여부를 확인한다. 같은 이름의 실제 폴더나 파일은 삭제·덮어쓰지 않고 충돌을 알린다.
   - 다른 스킬의 설치 경로나 전역 지시사항을 바꾸지 않는다.
3. **인벤토리 전체 연결**
   - `~/.agents/skills/research` → `<현재 프로젝트 루트>/skills`로 디렉토리 링크를 만든다.
   - 스킬별 복사나 개별 링크로 대체하지 않는다. 전체 연결이 있어야 새 카테고리와 스킬도 같은 경로에서 발견된다.
4. **실제 인식 확인**
   - 링크의 실제 대상과 원본 파일 접근 가능 여부를 확인한다.
   - R 분석 프로젝트 폴더에서 Codex의 스킬 목록(`/skills`)에 이 인벤토리의 스킬이 보이는지 확인한다.
   - 카테고리 하위 폴더까지 탐색되는지 검증하려면, 기존 폴더와 겹치지 않는 임시 카테고리·스킬을 추가해 목록에 나타나는지 확인한 뒤 제거한다.
   - 실제 인식을 확인할 수 없으면 "파일 연결 확인"과 "Codex 인식 확인"을 구분해 보고한다.
5. **결과 안내**
   - 연결 경로·원본 경로·인식된 스킬·확인하지 못한 범위를 알려준다.
   - 새 스킬이 보이지 않으면 Codex를 다시 시작하도록 안내한다.

## 직접 연결하기: macOS / Linux

터미널의 현재 위치를 **이 파일이 있는 프로젝트 루트**로 옮긴 뒤 실행한다.

```sh
skill_source="$(pwd -P)/skills"
skill_link="$HOME/.agents/skills/research"

if [ ! -d "$skill_source" ] || [ ! -f "$skill_source/README.md" ]; then
  printf '이 파일이 있는 프로젝트 루트에서 실행하세요. 원본 확인 실패: %s\n' "$skill_source"
elif [ -e "$skill_link" ] || [ -L "$skill_link" ]; then
  printf '기존 연결 또는 폴더를 먼저 확인하세요: %s\n' "$skill_link"
  ls -ld "$skill_link"
else
  mkdir -p "$HOME/.agents/skills"
  ln -s "$skill_source" "$skill_link"
  ls -ld "$skill_link"
fi
```

이미 연결되어 있으면 기존 항목을 표시하고 끝난다. 표시된 링크 대상이 현재 저장소의 `skills/`인지 확인한다.

## 직접 연결하기: Windows

PowerShell에서 현재 위치를 **이 파일이 있는 프로젝트 루트**로 옮긴 뒤 실행한다. 디렉토리 정션(junction)은 관리자 권한 없이 만들 수 있다.

```powershell
$skillSource = Join-Path (Get-Location).Path "skills"
$skillLink   = Join-Path $HOME ".agents\skills\research"

if (-not (Test-Path (Join-Path $skillSource "README.md"))) {
  Write-Output "이 파일이 있는 프로젝트 루트에서 실행하세요. 원본 확인 실패: $skillSource"
} elseif (Test-Path $skillLink) {
  Write-Output "기존 연결 또는 폴더를 먼저 확인하세요: $skillLink"
  Get-Item $skillLink | Format-List FullName, LinkType, Target
} else {
  New-Item -ItemType Directory -Force -Path (Split-Path $skillLink) | Out-Null
  New-Item -ItemType Junction -Path $skillLink -Target $skillSource
}
```

Codex 문서가 명시하는 것은 심볼릭 링크 지원이다. 정션으로 연결한 뒤에는 위 4단계의 인식 확인을 반드시 수행하고, 인식되지 않으면 개발자 모드(Developer Mode)를 켠 상태에서 `New-Item -ItemType SymbolicLink`로 다시 연결한다. WSL에서 Codex를 실행한다면 WSL의 홈 경로를 기준으로 macOS / Linux 절차를 따른다.

## 대안: R 분석 프로젝트에만 연결

이 스킬을 특정 R 분석 프로젝트에서만 쓰려면 전역 연결 대신 그 프로젝트 루트의 `.agents/skills/research`를 같은 방식으로 이 저장소의 `skills/`에 연결한다. 해당 프로젝트 폴더에서 Codex를 실행할 때만 스킬이 탐색된다. 분석 프로젝트를 Git으로 관리한다면 `.agents/`를 그 프로젝트의 `.gitignore`에 추가해 링크가 커밋되지 않게 한다.

## 연결 후 관리

- 새 스킬은 `skills/<카테고리>/<스킬명>/SKILL.md`로 추가하고 [스킬 목록](skills/README.md)도 함께 갱신한다. 전체 연결을 했다면 스킬별 등록은 필요 없다.
- 이 연결은 **PC 간 동기화 기능이 아니다.** 다른 PC에서는 저장소를 갱신해야 최신 내용이 반영된다.
- 저장소 전체를 이동하면 링크 대상도 새 위치로 갱신한다.
- 연결을 해제하려면 `~/.agents/skills/research`가 링크인지 확인한 뒤 **그 링크만** 제거한다. 원본 `skills/`와 다른 전역 스킬은 유지한다.
