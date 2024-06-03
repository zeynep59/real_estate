import pandas as pd
import numpy as np
from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import train_test_split, RandomizedSearchCV
import joblib

# Load and preprocess the dataset
df = pd.read_csv("functions/HouseData.csv")
# Perform necessary preprocessing (as shown in your previous code)

# Assuming 'df' is already preprocessed and ready
X = df.drop("price", axis="columns")
y = df["price"]

# Split the data
seed = 20
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=seed)

# Train the model
reg = RandomForestRegressor()
params = {
    "n_estimators": [100, 200, 300, 400, 500],
    "max_features": [1, 2, 3, 4, 5],
    "max_depth": [1, 2, 3, 4, 5],
    "max_samples": [1000, 2000, 3000, 4000, 5000],
    "min_samples_split": [10, 20, 30, 40, 50]
}
rf_reg_grid = RandomizedSearchCV(
    estimator=reg,
    param_distributions=params,
    cv=5,
    n_iter=10,
    verbose=2,
    n_jobs=-1
)
rf_model = rf_reg_grid.fit(X_train, y_train)

# Save the best model
joblib.dump(rf_model, 'rf_model.pkl')
