
PRIOR = 2
YEAR_MAX = 2030
MULT = 1

.PHONY: all
all: out/fig_forecast_$(PRIOR).tif out/fig_forecast_noage.pdf


out/system_model_$(PRIOR).rds: src/system_model.R \
  ../shared/out/prior_year_$(PRIOR).rds
	Rscript $< --prior=$(PRIOR)

out/data_model_schools.rds: src/data_model_schools.R \
  ../shared/out/constraint_schools.rds
	Rscript $<

out/data_models.rds: src/data_models.R \
  ../shared/out/data_model_nhes.rds \
  ../shared/out/data_model_dtc.rds \
  out/data_model_schools.rds
	Rscript $<

out/datasets.rds: src/datasets.R \
  ../shared/out/nhes_obese_num_mean.rds \
  ../shared/out/dtc_obese_num_mean.rds \
  ../shared/out/schools_obese_adj.rds
	Rscript $<

out/model_$(PRIOR).est: src/model.R \
  ../shared/out/initial_obese.rds \
  out/system_model_$(PRIOR).rds \
  out/data_models.rds \
  ../shared/out/popn.rds \
  out/datasets.rds
	Rscript $< --prior=$(PRIOR) \
                   --mult=$(MULT)

out/model_$(PRIOR).pred: src/forecast.R \
  out/model_$(PRIOR).est \
  ../shared/out/popn.rds
	Rscript $< --prior=$(PRIOR) \
                   --year_max=$(YEAR_MAX)

out/vals_forecast_$(PRIOR).rds: src/vals_forecast.R \
  out/model_$(PRIOR).est \
  out/model_$(PRIOR).pred
	Rscript $< --prior=$(PRIOR)

out/fig_forecast_$(PRIOR).tif: src/fig_forecast.R \
  out/vals_forecast_$(PRIOR).rds \
  ../shared/out/vals_direct_nhes.rds \
  ../shared/out/vals_direct_dtc.rds \
  ../shared/out/vals_direct_schools.rds \
  ../shared/out/plot_theme.rds \
  ../shared/out/palette.rds
	Rscript $< --prior=$(PRIOR)


## sensitivity test

out/data_model_schools_noage.rds: src/data_model_schools_noage.R
	Rscript $<

out/data_models_noage.rds: src/data_models_noage.R \
  ../shared/out/data_model_nhes.rds \
  ../shared/out/data_model_dtc.rds \
  out/data_model_schools_noage.rds
	Rscript $<

out/model_noage.est: src/model_noage.R \
  ../shared/out/initial_obese.rds \
  out/system_model_2.rds \
  out/data_models_noage.rds \
  ../shared/out/popn.rds \
  out/datasets.rds
	Rscript $< --mult=$(MULT)

out/model_noage.pred: src/forecast_noage.R \
  out/model_noage.est \
  ../shared/out/popn.rds
	Rscript $< --year_max=$(YEAR_MAX)

out/vals_forecast_noage.rds: src/vals_forecast_noage.R \
  out/model_noage.est \
  out/model_noage.pred
	Rscript $<

out/fig_forecast_noage.pdf: src/fig_forecast_noage.R \
  out/vals_forecast_noage.rds \
  ../shared/out/vals_direct_nhes.rds \
  ../shared/out/vals_direct_dtc.rds \
  ../shared/out/vals_direct_schools.rds \
  ../shared/out/plot_theme.rds \
  ../shared/out/palette.rds
	Rscript $<






.PHONY: clean
clean:
	rm -rf out
	mkdir -p out

