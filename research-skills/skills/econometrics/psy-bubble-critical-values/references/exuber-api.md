# exuber 함수 사양

exuber 1.1.0의 매뉴얼과 소스 기준이다. 설치된 버전이 다르면 `packageVersion("exuber")`, `args(함수명)`, `?함수명`으로 아래 내용과 대조하고, 달라진 점이 있으면 이 문서를 갱신한다.

## 함수 시그니처

```r
radf(data, minw = NULL, lag = 0L)

radf_mc_cv(n, minw = NULL, nrep = 1000L, seed = NULL)
radf_mc_distr(n, minw = NULL, nrep = 1000L, seed = NULL)

radf_wb_cv(data, minw = NULL, nboot = 500L, dist_rad = FALSE, seed = NULL)
radf_wb_distr(data, minw = NULL, nboot = 500L, dist_rad = FALSE, seed = NULL)

radf_wb_cv2(data, minw = NULL, nboot = 500L, adflag = 0,
            type = c("fixed", "aic", "bic"), tb = NULL, seed = NULL)
radf_wb_distr2(data, minw = NULL, nboot = 500L, adflag = 0,
               type = c("fixed", "aic", "bic"), tb = NULL, seed = NULL)

diagnostics(object, cv = NULL, option = c("gsadf", "sadf"), ...)
datestamp(object, cv = NULL, min_duration = 0L, sig_lvl = 95,
          option = c("gsadf", "sadf"), nonrejected = FALSE, ...)

psy_minw(n)                       # floor((0.01 + 1.8 / sqrt(n)) * n)
psy_ds(n, rule = 1, delta = 1)    # rule 1: round(delta * log(n))
ps_tb(n, freq = c("monthly", "quarterly", "annual", "weekly"), size = 2)
```

- `data`: 벡터, 행렬, data.frame. **NA를 허용하지 않는다.** 여러 열을 넘기면 열마다 따로 계산한다.
- `minw`: `NULL`이면 PSY 규칙으로 계산된다. 이 연구에서는 기록을 위해 항상 명시한다.
- `seed`: 시뮬레이션 전에 `set.seed()`로 쓰이고 결과의 `"seed"` 속성으로 저장된다.

## ps_tb의 반환값

`ps_tb()`는 `minw + size × (월간 12) − 1`을 돌려준다. 월간 `size = 2`이면 `psy_minw(n) + 23`이다.

| T | `psy_minw(T)` | `ps_tb(T, "monthly", 2)` | `psy_ds(T)` |
| --- | --- | --- | --- |
| 490 | 44 | 67 | 6 |
| 478 | 44 | 67 | 6 |
| 370 | 38 | 61 | 6 |

`radf_wb_cv2()`는 `tb`가 `minw`보다 커야 한다. 24를 직접 넣으면 최소창보다 작아 오류가 나거나, 의도와 다른 모의 표본 크기가 된다.

## 반환 구조

| 함수 | 반환 클래스 | 원소 |
| --- | --- | --- |
| `radf()` | `radf_obj` | `adf`, `sadf`, `gsadf`(계열별 통계량), `badf`, `bsadf`(시점별 계열) |
| `radf_mc_cv()` | `radf_cv`, `mc_cv` | `adf_cv`, `sadf_cv`, `gsadf_cv`(90·95·99% 분위수), `badf_cv`, `bsadf_cv`(시점별) |
| `radf_wb_cv()`, `radf_wb_cv2()` | `radf_cv`, `wb_cv` | 같은 이름의 원소. 계열마다 다른 임계값. `badf_cv`, `bsadf_cv`는 시점(`T − minw`) × 계열 × 분위수 배열 |
| `radf_*_distr()` | `radf_distr` | `adf_distr`, `sadf_distr`, `gsadf_distr`(반복별 통계량 원값) |

- `radf_wb_cv2()`에 `tb`를 주면 `badf_cv`, `bsadf_cv`가 시간에 대해 상수로 채워진다. 값은 길이 `tb` 모의 표본의 SADF, GSADF 분위수다. 그래서 같은 결과의 `gsadf_cv`는 전체 표본 요약 판정에 쓰면 안 된다.
- `tidy()`는 통계량·임계값을 표로, `augment()`는 BSADF 계열을 시점별 표로 바꾼다. `augment()`의 `trunc = TRUE`는 최소창 구간을 제거한다.

## 부트스트랩 생성 방식 (소스 기준)

| 함수 | 생성 방식 | 시차 |
| --- | --- | --- |
| `radf_wb_cv()` (HLST) | 1차 차분 Δy_t에 시간 순서대로 가중치 w_t(표준정규, 또는 `dist_rad = TRUE`이면 ±1)를 곱해 누적 | 없음 |
| `radf_wb_cv2()` (PS2020) | 귀무 ADF 회귀의 잔차를 **무작위 위치에서 복원 추출**하고 표준정규 가중치를 곱함 | `adflag`개 시차와 추정 계수로 재귀 생성 |

HLST 방식은 잔차의 시간 위치를 보존하므로 변동성의 시간 패턴이 부트스트랩 표본에 남는다. PS2020 방식은 재추출로 시간 위치가 섞이므로 부트스트랩 오차 분산이 시간에 대해 일정해진다.

## 실행 옵션

패키지 로드 시 다음 옵션이 이미 설정되어 있지 않으면 기본값이 들어간다.

| 옵션 | 기본값 |
| --- | --- |
| `exuber.show_progress` | `TRUE` |
| `exuber.parallel` | `TRUE` |
| `exuber.ncores` | 대화형이면 코어 수 − 1, 비대화형이면 2. 환경변수 `MC_CORES`가 있으면 그 값과 비교해 작은 값 |
| `exuber.global_seed` | `NA` |

`exuber.ncores` 기본값이 실행 방식(RStudio 대화형 / `Rscript`)에 따라 달라지므로, 스크립트에서 명시적으로 설정한다.
