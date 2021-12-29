
PRIOR = 2
YEAR_MAX = 2030
MULT = 1

.PHONY: all
all: out/fig_forecast_$(PRIOR).tif


out/system_model_$(PRIOR).rds: src/system_model.R \
  ../shared/out/prior_year_$(PRIOR).rds
	Rscript $< --prior=$(PRIOR)

out/model_$(PRIOR).est: src/model.R \
  ../shared/out/nhes_obese_eff.rds \
  ../shared/out/nhes_all_eff.rds \
  out/system_model_$(PRIOR).rds
	Rscript $< --mult=$(MULT) \
                   --prior=$(PRIOR) \

out/model_$(PRIOR).pred: src/forecast.R \
  out/model_$(PRIOR).est \
  ../shared/out/popn.rds
	Rscript $< --prior=$(PRIOR) \
                   --year_max=$(YEAR_MAX) \

out/vals_forecast_$(PRIOR).rds: src/vals_forecast.R \
  out/model_$(PRIOR).est \
  out/model_$(PRIOR).pred \
  ../shared/out/popn.rds
	Rscript $< --prior=$(PRIOR)

out/fig_forecast_$(PRIOR).tif: src/fig_forecast.R \
  out/vals_forecast_$(PRIOR).rds \
  ../shared/out/vals_direct_nhes.rds \
  ../shared/out/plot_theme.rds \
  ../shared/out/palette.rds
	Rscript $< --prior=$(PRIOR)


.PHONY: clean
clean:
	rm -rf out
	mkdir -p out
