---
id: "202610122356"
title: "Operational WeatherBench (Brightband)"
type: literature
status: verified
source: "Brightband, Operational WeatherBench methodology, https://owb.brightband.com/methodology, read 2026-10-12"
tags: [weather, benchmark, marola]
created: 2026-10-12
---
<!-- cite: main="Matheus Hoffmann"; last="Matheus Hoffmann" -->

# Operational WeatherBench (Brightband)

Brightband runs Operational WeatherBench, a live scoreboard of operational weather models. The
scores come from Google Research's WeatherBench-X library.

- **Models:** ECMWF IFS ENS, HRES and AIFS ENS; NOAA GFS, GEFS, AIGFS and AIGEFS; Google DeepMind
  GraphCast, WeatherNext 2 and WeatherNext 3; Microsoft Aurora 1.5; NVIDIA Atlas; a climatology
  baseline.
- **Metrics:** RMSE for every variable, ACC for 500 hPa geopotential, vector RMSE for 850 hPa wind,
  SEEPS for 24 h precipitation; for ensembles CRPS, spread, debiased ensemble-mean RMSE and the
  spread–skill ratio.
- **Truth:** each model against its own analysis (lead 0); WeatherNext and climatology against the
  ECMWF IFS analysis; precipitation always against ERA5.
- **Regions and leads:** global, tropics, the two hemispheres, North America, Europe; 0.25° grid,
  area-weighted; every 6 h to 360 h. The ranking pools RMSE over the 12Z cycles of a window.

The method is the discipline to copy: one scorer, a stated truth per model, fixed leads and
regions, and a ranking rule written down before the scores. Two gaps for Marola: there is no South
Atlantic or Brazil region, and it scores the atmosphere, not ocean waves.

**Citation.** The page asks for no citation and gives no DOI; it says the dashboard and its scores
are CC BY 4.0, and third-party forecast data keep their own terms. Cite it as: Brightband,
*Operational WeatherBench: Methodology*, <https://owb.brightband.com/methodology> (accessed
2026-10-12), CC BY 4.0. The page itself cites the WeatherBench 2 paper and the papers of each model.

Used by [[202610122357-marola-forecaster-contextual-bandit]].
