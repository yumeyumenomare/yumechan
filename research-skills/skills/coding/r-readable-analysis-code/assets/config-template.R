# =============================================================================
# config.R — 연구 사양을 모아두는 유일한 파일
# 값의 근거는 스킬 문서에 있다.
#   자료·지역·종속변수·계절조정 : kb-housing-data-prep
#   검정·임계값·반복 수         : psy-bubble-critical-values
# 값을 바꾸면 결과가 바뀐다. 사양 변경은 의도적으로만 한다.
# NA 로 둔 항목은 분석 전에 확정해야 한다. 각 단계는 NA 를 만나면 멈춘다.
# =============================================================================

cfg <- list()

# 1. 경로 ----
cfg$paths <- list(
  kb_file   = "data_raw/<YYYYMM>_월간 주택 시계열.xlsx",
  rate_file = "data_raw/<회사채 3년 AA- 월별 수익률 파일>",
  outputs   = "outputs"
)

# 2. 자료 시점과 표본 블록 ----
cfg$release <- "<YYYY-MM>"            # KB 발표본의 마지막 관측월
cfg$sample_start <- list(
  main = "1986-01",                   # 주표본
  d2   = "1987-01",                   # D2: 회사채 수익률이 1987.01부터
  supp = "1996-01"                    # 보조표본: 1996.01 시작 지역
)

# 3. 분석 지역 (분석 표기) ----
# KB 열 이름과의 대응은 kb-housing-data-prep/references/region-map.md 를 따른다.
cfg$index_type   <- "comp"            # "comp" = 종합 지수, "apt" = 아파트 지수
cfg$regions_main <- NA_character_     # 확정 필요: 1986.01 시작 주표본 지역
cfg$regions_supp <- c("고양", "군포") # 1996.01 시작 보조표본 지역

# 4. 종속변수와 계절조정 ----
cfg$dep_vars     <- c("D1", "D2")
cfg$adj_main     <- "SA"              # 주분석: X-13 계절조정 계열
cfg$adj_robust   <- "NSA"             # 강건성: 원계열
cfg$sa_target    <- NA_character_     # 확정 필요: "index" (P·J 각각 조정 후 구성) 또는 "dep_var" (D1 직접 조정)

# 5. 검정 사양 ----
cfg$lag_main     <- 1L                # 고정 시차 (주분석)
cfg$lag_robust   <- 4L                # 고정 시차 (강건성)
cfg$seed         <- 42L               # 모든 시뮬레이션·부트스트랩
cfg$sig_level    <- 95                # 판정 유의수준 (90·99 함께 보고)
cfg$wb2_tb_size  <- 2                 # ps_tb(T, "monthly", size) 의 size: 시점 추정용 tb
cfg$min_duration <- NA_integer_       # 확정 필요: 시점 추정의 최소 지속기간(개월)

# 6. 반복 수 ----
cfg$n_rep <- list(
  mc_prelim   = 999L,                 # 잠정 결과용
  boot_prelim = 199L,
  mc_final    = NA_integer_,          # 확정 필요: 최종 결과용
  boot_final  = NA_integer_
)
cfg$run_mode <- "prelim"              # "prelim" 또는 "final"

# 7. exuber 실행 옵션 ----
# 병렬 여부가 바뀌면 같은 시드라도 결과가 달라진다. 최종 결과는 한 설정으로 만든다.
cfg$exuber_parallel <- TRUE
cfg$exuber_ncores   <- 4L
