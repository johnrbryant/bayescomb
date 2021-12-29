
.PHONY: all
all: obesity.pdf \
     obesitysm.pdf \
     out/fig1.tif \
     out/fig2.tif \
     out/fig3.tif \
     out/fig4.tif \
     out/fig5.tif \
     out/fig6.tif \
     out/fig7.tif

out/fig1.tif: out/fig_direct_nat.tif
	cp $< $@

out/fig2.tif: out/fig_direct_subage_female.tif
	cp $< $@

out/fig3a.tif: ../natnhes/out/fig_forecast_0.tif 
	cp $< $@

out/fig3b.tif: ../natall/out/fig_forecast_0.tif 
	cp $< $@

out/fig3c.tif: ../natall/out/fig_forecast_2.tif 
	cp $< $@

out/fig4.tif: out/fig_dag.tif 
	cp $< $@

out/fig5a.tif: ../subnat/out/fig_forecast_2_base_female_urban.tif
	cp $< $@

out/fig5b.tif: ../subnat/out/fig_forecast_2_rev_female_urban.tif
	cp $< $@

out/fig6.tif: out/fig_compare.tif
	cp $< $@

out/fig7.tif: ../subnat/out/fig_rep_region_2_rev.tif
	cp $< $@

out/figS1.pdf: out/fig_direct_subage_male.pdf
	cp $< $@

out/figS2.pdf: ../natall/out/fig_forecast_noage.pdf
	cp $< $@

out/figS3a.pdf: ../subnat/out/fig_forecast_2_base_male_urban.pdf
	cp $< $@

out/figS3b.pdf: ../subnat/out/fig_forecast_2_rev_male_urban.pdf
	cp $< $@

out/figS4a.pdf: ../subnat/out/fig_forecast_2_base_female_rural.pdf
	cp $< $@

out/figS4b.pdf: ../subnat/out/fig_forecast_2_rev_female_rural.pdf
	cp $< $@

out/figS5a.pdf: ../subnat/out/fig_forecast_2_base_male_rural.pdf
	cp $< $@

out/figS5b.pdf: ../subnat/out/fig_forecast_2_rev_male_rural.pdf
	cp $< $@


out/vals_ratio_schools.rds: src/vals_ratio_schools.R \
    ../shared/out/schools_all.rds \
    ../shared/out/popn.rds
	Rscript $<

out/vals_ratio_schools_overall.rds: src/vals_ratio_schools_overall.R \
    ../shared/out/schools_all.rds \
    ../shared/out/popn.rds
	Rscript $<

out/vals_sdtrend.rds: src/vals_sdtrend.R \
    ../natnhes/out/model_0.est \
    ../natall/out/model_0.est \
    ../natall/out/model_2.est
	Rscript $<

out/vals_sd.rds: src/vals_sd.R \
    ../natall/out/model_2.est \
    ../subnat/out/model_2_base.est \
    ../subnat/out/model_2_rev.est
	Rscript $<

out/var_schools.rds: src/var_schools.R \
    ../shared/out/schools_obese.rds \
    ../shared/out/schools_all.rds
	Rscript $<

out/vals_compare.rds: src/vals_compare.R \
    ../natnhes/out/vals_forecast_0.rds \
    ../natnhes/out/vals_forecast_1.rds \
    ../natnhes/out/vals_forecast_2.rds \
    ../natnhes/out/vals_forecast_4.rds \
    ../natall/out/vals_forecast_0.rds \
    ../natall/out/vals_forecast_1.rds \
    ../natall/out/vals_forecast_2.rds \
    ../natall/out/vals_forecast_4.rds \
    ../subnat/out/vals_forecast_0_base.rds \
    ../subnat/out/vals_forecast_1_base.rds \
    ../subnat/out/vals_forecast_2_base.rds \
    ../subnat/out/vals_forecast_4_base.rds \
    ../subnat/out/vals_forecast_0_rev.rds \
    ../subnat/out/vals_forecast_1_rev.rds \
    ../subnat/out/vals_forecast_2_rev.rds \
    ../subnat/out/vals_forecast_4_rev.rds
	Rscript $<

out/fig_direct_nat.tif: src/fig_direct_nat.R \
    ../shared/out/vals_direct_nhes.rds \
    ../shared/out/vals_direct_dtc.rds \
    ../shared/out/vals_direct_schools.rds \
    ../shared/out/plot_theme.rds
	Rscript $<

out/fig_direct_subage_female.tif: src/fig_direct_subage.R \
    ../shared/out/vals_direct_schools.rds \
    ../shared/out/plot_theme.rds
	Rscript $< --sex=female \
                   --ext=tif

out/fig_direct_subage_male.pdf: src/fig_direct_subage.R \
    ../shared/out/vals_direct_schools.rds \
    ../shared/out/plot_theme.rds
	Rscript $< --sex=male \
                   --ext=pdf

out/fig_dag.pdf: src/fig_dag.tex
	cd src; pdflatex -interaction=batchmode ../src/fig_dag
	mv src/fig_dag.pdf $@
	rm src/fig_dag.aux
	rm src/fig_dag.log

out/fig_dag.tif: out/fig_dag.pdf
	gs -q -dNOPAUSE -r300x300 -sDEVICE=tiff24nc -sOutputFile=out/fig_dag.tif out/fig_dag.pdf -c quit

out/fig3.tif: src/fig3.R \
    out/fig3a.tif \
    out/fig3b.tif \
    out/fig3c.tif
	Rscript $<

out/fig5.tif: src/fig5.R \
    out/fig5a.tif \
    out/fig5b.tif
	Rscript $<

out/fig_compare.tif: src/fig_compare.R \
    out/vals_compare.rds \
    ../shared/out/plot_theme.rds \
    ../shared/out/palette.rds
	Rscript $<

obesity.pdf: obesity.Rmd \
    references.bib \
    ../data/nhes_sample.csv \
    ../data/dtc_sample.csv \
    ../data/schools_sample.csv \
    out/vals_ratio_schools_overall.rds \
    out/vals_ratio_schools.rds \
    out/vals_sdtrend.rds \
    out/vals_sd.rds \
    out/var_schools.rds
	Rscript -e "rmarkdown::render('$<')"

obesitysm.pdf: obesitysm.Rmd \
    out/figS1.pdf \
    out/figS2.pdf \
    out/figS3a.pdf \
    out/figS3b.pdf \
    out/figS4a.pdf \
    out/figS4b.pdf \
    out/figS5a.pdf \
    out/figS5b.pdf
	Rscript -e "rmarkdown::render('$<')"





.PHONY: clean
clean:
	rm -rf out
	mkdir -p out


