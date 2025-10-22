# Data Scientist Quick Install

> 🧪 **ML/AI Ready** | ⏱️ **35 minutes** | 📊 **Python + Jupyter + TensorFlow**

## 📋 What Gets Installed

Complete data science and machine learning environment:

- ✅ **Essential System Tools** (curl, wget, git, build tools)
- ✅ **Code-Server** (VS Code in browser with Python extensions)
- ✅ **Python 3.12** (Latest with data science packages)
- ✅ **Jupyter Lab** (Interactive notebooks)
- ✅ **Machine Learning** (TensorFlow, PyTorch, Scikit-learn)
- ✅ **Data Analysis** (Pandas, NumPy, Matplotlib, Seaborn)
- ✅ **Big Data Tools** (Apache Spark, Dask)

## 🚀 Quick Installation

### Option 1: Complete Data Science Setup

```bash
# Full data science environment - everything included
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/quick-install/data-scientist.sh | bash
```

### Option 2: Step-by-Step Installation

```bash
# 1. System Foundation (5 minutes)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/01-system-setup/essential-tools.md | bash

# 2. Code-Server (10 minutes)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/02-code-server/installation.md | bash

# 3. Python Data Science (15 minutes)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/04-programming-languages/python-datascience.md | bash

# 4. Jupyter Lab (5 minutes)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/07-development-tools/jupyter.md | bash
```

## 🧬 Data Science Stack

### Core Python Libraries
- **NumPy 1.24+** - Numerical computing
- **Pandas 2.0+** - Data manipulation
- **Matplotlib 3.7+** - Visualization
- **Seaborn 0.12+** - Statistical plots
- **Plotly 5.15+** - Interactive charts

### Machine Learning
- **Scikit-learn 1.3+** - Traditional ML
- **TensorFlow 2.13+** - Deep learning
- **PyTorch 2.0+** - Neural networks
- **XGBoost 1.7+** - Gradient boosting
- **LightGBM 4.0+** - Fast gradient boosting

### Data Processing
- **Apache Spark** - Big data processing
- **Dask** - Parallel computing
- **Polars** - Fast DataFrames
- **DuckDB** - Analytical database

### Development Environment
- **Jupyter Lab** - Interactive notebooks
- **IPython** - Enhanced Python shell
- **Code-Server** - VS Code with Python extensions

## ✅ Getting Started

### 1. Access Your Environment

```bash
# Get WSL IP address
ip addr show eth0 | grep "inet " | awk '{print $2}' | cut -d/ -f1
```

Access points:
- **Code-Server**: `http://YOUR_WSL_IP:3000`
- **Jupyter Lab**: `http://YOUR_WSL_IP:8888`

### 2. Sample Data Science Projects

#### Quick Data Analysis
```bash
# Create sample project
mkdir data-analysis && cd data-analysis

# Create sample dataset analysis
cat > analysis.py << 'EOF'
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report, confusion_matrix

# Load sample dataset
iris = load_iris()
df = pd.DataFrame(iris.data, columns=iris.feature_names)
df['target'] = iris.target
df['species'] = df['target'].map({0: 'setosa', 1: 'versicolor', 2: 'virginica'})

print("Dataset Overview:")
print(df.head())
print(f"\nDataset shape: {df.shape}")
print(f"\nSpecies distribution:\n{df['species'].value_counts()}")

# Visualization
plt.figure(figsize=(12, 8))

# Pairplot
plt.subplot(2, 2, 1)
sns.boxplot(data=df, x='species', y='sepal length (cm)')
plt.title('Sepal Length by Species')

plt.subplot(2, 2, 2)
sns.scatterplot(data=df, x='sepal length (cm)', y='sepal width (cm)', hue='species')
plt.title('Sepal Length vs Width')

plt.subplot(2, 2, 3)
correlation = df.select_dtypes(include=[np.number]).corr()
sns.heatmap(correlation, annot=True, cmap='coolwarm', center=0)
plt.title('Feature Correlation')

plt.subplot(2, 2, 4)
df['species'].value_counts().plot(kind='pie', autopct='%1.1f%%')
plt.title('Species Distribution')

plt.tight_layout()
plt.savefig('iris_analysis.png', dpi=300, bbox_inches='tight')
plt.show()

# Machine Learning
X = iris.data
y = iris.target
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train model
rf = RandomForestClassifier(n_estimators=100, random_state=42)
rf.fit(X_train, y_train)

# Predictions
y_pred = rf.predict(X_test)

print("\nClassification Report:")
print(classification_report(y_test, y_pred, target_names=iris.target_names))

print("\nFeature Importance:")
feature_importance = pd.DataFrame({
    'feature': iris.feature_names,
    'importance': rf.feature_importances_
}).sort_values('importance', ascending=False)
print(feature_importance)
EOF

# Run the analysis
python analysis.py
```

#### Jupyter Notebook Template
```bash
# Start Jupyter Lab
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root

# Create sample notebook content
cat > sample_notebook.ipynb << 'EOF'
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Data Science Template\n",
    "\n",
    "Complete workflow for data analysis and machine learning."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Import libraries\n",
    "import pandas as pd\n",
    "import numpy as np\n",
    "import matplotlib.pyplot as plt\n",
    "import seaborn as sns\n",
    "from sklearn.model_selection import train_test_split\n",
    "from sklearn.preprocessing import StandardScaler\n",
    "from sklearn.ensemble import RandomForestClassifier\n",
    "from sklearn.metrics import classification_report, confusion_matrix\n",
    "\n",
    "# Configure plotting\n",
    "plt.style.use('seaborn-v0_8')\n",
    "sns.set_palette('husl')\n",
    "%matplotlib inline"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Load and explore data\n",
    "# Replace with your dataset\n",
    "from sklearn.datasets import load_wine\n",
    "\n",
    "wine = load_wine()\n",
    "df = pd.DataFrame(wine.data, columns=wine.feature_names)\n",
    "df['target'] = wine.target\n",
    "\n",
    "print(f\"Dataset shape: {df.shape}\")\n",
    "print(f\"Features: {list(df.columns)}\")\n",
    "print(f\"Target classes: {wine.target_names}\")\n",
    "\n",
    "df.head()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Data visualization\n",
    "fig, axes = plt.subplots(2, 2, figsize=(15, 10))\n",
    "\n",
    "# Distribution of target\n",
    "axes[0,0].pie(df['target'].value_counts(), labels=wine.target_names, autopct='%1.1f%%')\n",
    "axes[0,0].set_title('Target Distribution')\n",
    "\n",
    "# Feature correlations\n",
    "corr = df.select_dtypes(include=[np.number]).corr()\n",
    "sns.heatmap(corr.iloc[:10, :10], annot=True, ax=axes[0,1], cmap='coolwarm')\n",
    "axes[0,1].set_title('Feature Correlations (Top 10)')\n",
    "\n",
    "# Feature distributions\n",
    "df.iloc[:, :4].hist(ax=axes[1,0], bins=20)\n",
    "axes[1,0].set_title('Feature Distributions')\n",
    "\n",
    "# Box plots\n",
    "df.boxplot(column=df.columns[0], by='target', ax=axes[1,1])\n",
    "axes[1,1].set_title('Feature by Target')\n",
    "\n",
    "plt.tight_layout()\n",
    "plt.show()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Machine learning pipeline\n",
    "X = df.drop('target', axis=1)\n",
    "y = df['target']\n",
    "\n",
    "# Split data\n",
    "X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)\n",
    "\n",
    "# Scale features\n",
    "scaler = StandardScaler()\n",
    "X_train_scaled = scaler.fit_transform(X_train)\n",
    "X_test_scaled = scaler.transform(X_test)\n",
    "\n",
    "# Train model\n",
    "model = RandomForestClassifier(n_estimators=100, random_state=42)\n",
    "model.fit(X_train_scaled, y_train)\n",
    "\n",
    "# Evaluate\n",
    "y_pred = model.predict(X_test_scaled)\n",
    "print(\"Classification Report:\")\n",
    "print(classification_report(y_test, y_pred, target_names=wine.target_names))\n",
    "\n",
    "# Feature importance\n",
    "importance_df = pd.DataFrame({\n",
    "    'feature': X.columns,\n",
    "    'importance': model.feature_importances_\n",
    "}).sort_values('importance', ascending=False)\n",
    "\n",
    "plt.figure(figsize=(10, 6))\n",
    "sns.barplot(data=importance_df.head(10), x='importance', y='feature')\n",
    "plt.title('Top 10 Feature Importances')\n",
    "plt.show()"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.12.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
EOF
```

### 3. Big Data Processing (Apache Spark)

```bash
# Create Spark project
mkdir spark-demo && cd spark-demo

cat > spark_analysis.py << 'EOF'
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, count, avg, max, min
from pyspark.ml.feature import VectorAssembler
from pyspark.ml.classification import RandomForestClassifier
from pyspark.ml.evaluation import MulticlassClassificationEvaluator

# Initialize Spark
spark = SparkSession.builder \
    .appName("DataScienceDemo") \
    .config("spark.sql.adaptive.enabled", "true") \
    .getOrCreate()

# Create sample dataset
data = [(1.0, 2.0, 3.0, 0),
        (2.0, 3.0, 4.0, 1),
        (3.0, 4.0, 5.0, 0),
        (4.0, 5.0, 6.0, 1),
        (5.0, 6.0, 7.0, 0)]

columns = ["feature1", "feature2", "feature3", "label"]
df = spark.createDataFrame(data, columns)

# Data exploration
print("Dataset Overview:")
df.show()
df.describe().show()

# Feature engineering
assembler = VectorAssembler(inputCols=["feature1", "feature2", "feature3"], outputCol="features")
df_features = assembler.transform(df)

# Split data
train_df, test_df = df_features.randomSplit([0.8, 0.2], seed=42)

# Train model
rf = RandomForestClassifier(featuresCol="features", labelCol="label")
model = rf.fit(train_df)

# Predictions
predictions = model.transform(test_df)
predictions.select("features", "label", "prediction").show()

# Evaluation
evaluator = MulticlassClassificationEvaluator(labelCol="label", predictionCol="prediction", metricName="accuracy")
accuracy = evaluator.evaluate(predictions)
print(f"Accuracy: {accuracy}")

spark.stop()
EOF

# Run Spark analysis
python spark_analysis.py
```

## 📊 Performance & Resources

| Component | RAM Usage | CPU | Disk | Purpose |
|-----------|-----------|-----|------|---------|
| Python + NumPy | 200MB | Med | 500MB | Base environment |
| Pandas | 300MB | Med | 200MB | Data manipulation |
| TensorFlow | 1GB | High | 2GB | Deep learning |
| Jupyter Lab | 150MB | Low | 300MB | Interactive development |
| Spark | 500MB | High | 1GB | Big data processing |
| **Total** | **~2.1GB** | **High** | **~4GB** | |

## 🧪 Verification & Testing

```bash
# Run data science verification
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/08-troubleshooting/datascience-verification.md | bash
```

## 🎯 Common Workflows

1. **Exploratory Data Analysis**: Pandas + Matplotlib + Seaborn
2. **Machine Learning**: Scikit-learn + XGBoost + evaluation
3. **Deep Learning**: TensorFlow/PyTorch + GPU acceleration
4. **Big Data**: Apache Spark + distributed computing
5. **Visualization**: Plotly + interactive dashboards

## 🔗 Extend Your Environment

Add more tools:

- **[Database Tools](../07-development-tools/database-tools.md)** - Data storage & retrieval
- **[Docker Support](../03-containers/docker.md)** - Containerized ML workflows
- **[Cloud Tools](../06-cloud-tools/aws-cli.md)** - Cloud ML services
- **[API Tools](../07-development-tools/api-testing.md)** - Model deployment testing

---

**🎉 Data science environment ready in 35 minutes!**

> Perfect for: Machine learning, data analysis, research, AI development, statistical modeling