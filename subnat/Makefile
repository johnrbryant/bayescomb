
PRIOR = 2
VERSION = base
YEAR_MAX = 2030
MULT = 1
EXT = tif

.PHONY: all
all: out/fig_forecast_$(PRIOR)_$(VERSION)_female_urban.$(EXT) \
     out/fig_forecast_$(PRIOR)_$(VERSION)_male_urban.$(EXT) \
     out/fig_forecast_$(PRIOR)_$(VERSION)_female_rural.$(EXT) \
     out/fig_forecast_$(PRIOR)_$(VERSION)_male_rural.$(EXT) \
     out/fig_rep_region_$(PRIOR)_$(VERSION).$(EXT)


out/structural_zeros.rds: src/structural_zeros.R \
    ../shared/out/schools_all.rds
	Rscript $<

out/system_model_$(PRIOR)_$(VERSION).rds: src/system_model.R \
    out/structural_zeros.rds \
    ../shared/out/prior_year_$(PRIOR).rds
	Rscript $< --prior=$(PRIOR) \
                   --version=$(VERSION)

out/data_model_schools_$(VERSION).rds: src/data_model_schools.R \
    ../shared/out/constraint_schools.rds \
    out/structural_zeros.rds
	Rscript $< --version=$(VERSION)

out/data_models_$(VERSION).rds: src/data_models.R \
    ../shared/out/data_model_nhes.rds \
    ../shared/out/data_model_dtc.rds \
    out/data_model_schools_$(VERSION).rds
	Rscript $< --version=$(VERSION)

out/datasets.rds: src/datasets.R \
  ../shared/out/nhes_obese_num_mean.rds \
  ../shared/out/dtc_obese_num_mean.rds \
  ../shared/out/schools_obese_adj.rds
	Rscript $<

out/model_$(PRIOR)_$(VERSION).est: src/model.R \
    ../shared/out/initial_obese.rds \
    out/system_model_$(PRIOR)_$(VERSION).rds \
    out/data_models_$(VERSION).rds \
    ../shared/out/popn.rds \
    out/datasets.rds
	Rscript $< --prior=$(PRIOR) \
                   --version=$(VERSION) \
                   --mult=$(MULT)

out/model_$(PRIOR)_$(VERSION).pred: src/forecast.R \
    out/model_$(PRIOR)_$(VERSION).est \
    ../shared/out/popn.rds
	Rscript $< --prior=$(PRIOR) \
                   --year_max=$(YEAR_MAX) \
                   --version=$(VERSION)

out/vals_forecast_$(PRIOR)_$(VERSION).rds: src/vals_forecast.R \
    out/model_$(PRIOR)_$(VERSION).est \
    out/model_$(PRIOR)_$(VERSION).pred
	Rscript $< --prior=$(PRIOR) \
                   --version=$(VERSION)

out/replicate_schools_$(PRIOR)_$(VERSION).rds: src/replicate_schools.R \
    out/model_$(PRIOR)_$(VERSION).est
	Rscript $< --prior=$(PRIOR) \
                   --version=$(VERSION)

out/vals_rep_region_$(PRIOR)_$(VERSION).rds: src/vals_rep_region.R \
  out/replicate_schools_$(PRIOR)_$(VERSION).rds
	Rscript $< --prior=$(PRIOR) \
                   --version=$(VERSION)

out/fig_forecast_$(PRIOR)_$(VERSION)_female_urban.$(EXT): src/fig_forecast.R \
  out/vals_forecast_$(PRIOR)_$(VERSION).rds \
  ../shared/out/vals_direct_schools.rds \
  ../shared/out/plot_theme.rds \
  ../shared/out/palette.rds
	Rscript $< --prior=$(PRIOR) \
                   --version=$(VERSION) \
                   --sex=female \
                   --area=urban \
                   --ext=$(EXT)

out/fig_forecast_$(PRIOR)_$(VERSION)_male_urban.$(EXT): src/fig_forecast.R \
  out/vals_forecast_$(PRIOR)_$(VERSION).rds \
  ../shared/out/vals_direct_schools.rds \
  ../shared/out/plot_theme.rds \
  ../shared/out/palette.rds
	Rscript $< --prior=$(PRIOR) \
                   --version=$(VERSION) \
                   --sex=male \
                   --area=urban \
                   --ext=$(EXT)

out/fig_forecast_$(PRIOR)_$(VERSION)_female_rural.$(EXT): src/fig_forecast.R \
  out/vals_forecast_$(PRIOR)_$(VERSION).rds \
  ../shared/out/vals_direct_schools.rds \
  ../shared/out/plot_theme.rds \
  ../shared/out/palette.rds
	Rscript $< --prior=$(PRIOR) \
                   --version=$(VERSION) \
                   --sex=female \
                   --area=rural \
                   --ext=$(EXT)

out/fig_forecast_$(PRIOR)_$(VERSION)_male_rural.$(EXT): src/fig_forecast.R \
  out/vals_forecast_$(PRIOR)_$(VERSION).rds \
  ../shared/out/vals_direct_schools.rds \
  ../shared/out/plot_theme.rds \
  ../shared/out/palette.rds
	Rscript $< --prior=$(PRIOR) \
                   --version=$(VERSION) \
                   --sex=male \
                   --area=rural \
                   --ext=$(EXT)

out/fig_rep_region_$(PRIOR)_$(VERSION).$(EXT): src/fig_rep_region.R \
  out/vals_rep_region_$(PRIOR)_$(VERSION).rds \
  ../shared/out/plot_theme.rds
	Rscript $< --prior=$(PRIOR) \
                   --version=$(VERSION) \
                   --ext=$(EXT)


.PHONY: clean
clean:
	rm -rf out
	mkdir -p out




