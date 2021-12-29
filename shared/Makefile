
.PHONY: all
all: out/prior_year_0.rds \
  out/prior_year_1.rds \
  out/prior_year_2.rds \
  out/prior_year_4.rds \
  out/popn.rds \
  out/nhes_obese_eff.rds \
  out/nhes_all_eff.rds \
  out/nhes_obese_pr_mean.rds \
  out/nhes_obese_pr_sd.rds \
  out/nhes_obese_num_mean.rds \
  out/nhes_obese_num_sd.rds \
  out/dtc_obese_pr_mean.rds \
  out/dtc_obese_pr_sd.rds \
  out/dtc_obese_num_mean.rds \
  out/dtc_obese_num_sd.rds \
  out/schools_obese.rds \
  out/schools_all.rds \
  out/schools_obese_adj.rds \
  out/vals_direct_nhes.rds \
  out/vals_direct_dtc.rds \
  out/vals_direct_schools.rds \
  out/data_model_nhes.rds \
  out/data_model_dtc.rds \
  out/constraint_schools.rds \
  out/initial_obese.rds \
  out/plot_theme.rds \
  out/palette.rds


out/prior_year_0.rds: src/prior_year.R
	Rscript $< --mult_var=0

out/prior_year_1.rds: src/prior_year.R \
  ../data/param_hyper_year.csv
	Rscript $< --mult_var=1

out/prior_year_2.rds: src/prior_year.R \
  ../data/param_hyper_year.csv
	Rscript $< --mult_var=2

out/prior_year_4.rds: src/prior_year.R \
  ../data/param_hyper_year.csv
	Rscript $< --mult_var=4

out/popn.rds: src/popn.R \
  ../data/popn.csv
	Rscript $<

out/nhes_obese_eff.rds: src/nhes_obese_eff.R \
  ../data/nhes.csv
	Rscript $<

out/nhes_all_eff.rds: src/nhes_all_eff.R \
  ../data/nhes.csv
	Rscript $<

out/nhes_obese_pr_mean.rds: src/nhes_obese_pr_mean.R \
  ../data/nhes.csv
	Rscript $<

out/nhes_obese_pr_sd.rds: src/nhes_obese_pr_sd.R \
  ../data/nhes.csv
	Rscript $<

out/nhes_obese_num_mean.rds: src/nhes_obese_num_mean.R \
  out/nhes_obese_pr_mean.rds \
  out/popn.rds
	Rscript $<

out/nhes_obese_num_sd.rds: src/nhes_obese_num_sd.R \
  out/nhes_obese_pr_sd.rds \
  out/popn.rds
	Rscript $<

out/dtc_obese_pr_mean.rds: src/dtc_obese_pr_mean.R \
  ../data/dtc.csv
	Rscript $<

out/dtc_obese_pr_sd.rds: src/dtc_obese_pr_sd.R \
  ../data/dtc.csv
	Rscript $<

out/dtc_obese_num_mean.rds: src/dtc_obese_num_mean.R \
  out/dtc_obese_pr_mean.rds \
  out/popn.rds
	Rscript $<

out/dtc_obese_num_sd.rds: src/dtc_obese_num_sd.R \
  out/dtc_obese_pr_sd.rds \
  out/popn.rds
	Rscript $<

out/schools_obese.rds: src/schools_obese.R \
  ../data/schools.csv
	Rscript $<

out/schools_all.rds: src/schools_all.R \
  ../data/schools.csv
	Rscript $<

out/schools_obese_adj.rds: src/schools_obese_adj.R \
  out/schools_obese.rds \
  out/schools_all.rds \
  out/popn.rds
	Rscript $<

out/vals_direct_nhes.rds: src/vals_direct_nhes.R \
  ../data/nhes.csv
	Rscript $<

out/vals_direct_dtc.rds: src/vals_direct_dtc.R \
  ../data/dtc.csv
	Rscript $<

out/vals_direct_schools.rds: src/vals_direct_schools.R \
  out/schools_obese_adj.rds \
  out/popn.rds
	Rscript $<

out/data_model_nhes.rds: src/data_model_nhes.R \
  out/nhes_obese_num_sd.rds
	Rscript $<

out/data_model_dtc.rds: src/data_model_dtc.R \
  out/dtc_obese_num_sd.rds
	Rscript $<

out/constraint_schools.rds: src/constraint_schools.R
	Rscript $<

out/initial_obese.rds: src/initial_obese.R \
  out/schools_obese.rds
	Rscript $<

out/plot_theme.rds: src/plot_theme.R
	Rscript $<

out/palette.rds: src/palette.R
	Rscript $<


.PHONY: clean
clean:
	rm -rf out
	mkdir -p out





