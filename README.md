
# KNN Classification Project in R

This project implements a K-Nearest Neighbors (KNN) classification model using R. The environment is managed with [`renv`](https://rstudio.github.io/renv/) for reproducible dependency management.

---

## 📁 Project Structure

```
KNN/
├── app.r              # Shiny or main R script
├── knn.r              # Core KNN implementation
├── knn-model.r        # Model training/evaluation
├── settings.json      # Project-specific configuration
├── renv/              # renv-managed environment
│   ├── library/       # Local package library (gitignored)
│   ├── staging/       # Temporary renv files
│   └── .gitignore     # Ignores renv internals
├── renv.lock          # Captures package versions
├── activate.R         # Auto-activation script
├── .Rprofile          # Bootstraps renv on project load
├── .gitignore         # Global ignore rules
```

---

## 🚀 Getting Started

1. **Clone the repo**:
    ```bash
    git clone https://github.com/your-user/knn-r-project.git
    cd knn-r-project
    ```

2. **Open in RStudio**  
   RStudio will auto-activate the `renv` environment via `.Rprofile`.  
   Alternatively, you can manually activate it using:

    ```r
    source("renv/activate.R")
    ```

3. **Restore dependencies**:
    ```r
    renv::restore()
    ```

4. **Run the project**:
    ```r
    source("app.r")
    ```

---

## 🧪 Requirements

- R (>= 4.0.0)
- renv (automatically initialized)
- Required packages (declared in `renv.lock`)

---

## 📦 Managing Dependencies

Use `renv` to manage and snapshot new packages:

```r
install.packages("dplyr")
renv::snapshot()
```

---

## 📝 License

MIT License. See `LICENSE` file for details.
