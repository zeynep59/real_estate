# %%
# Exploratory data analysis and visualisation libraries
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import plotly.express as px
import seaborn as sns

# Data preprocessing and model selection
from sklearn.model_selection import RandomizedSearchCV, GridSearchCV
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.model_selection import KFold, StratifiedKFold, ShuffleSplit
from sklearn.pipeline import Pipeline, make_pipeline
from sklearn.preprocessing import scale, StandardScaler

# Models from Scikit-Learn
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.ensemble import RandomForestRegressor
from sklearn.linear_model import Lasso
from sklearn.linear_model import LinearRegression
from sklearn.linear_model import Ridge
from sklearn.neighbors import KNeighborsRegressor
from sklearn.tree import DecisionTreeRegressor

# Model evaluations 
from sklearn import metrics
from sklearn.metrics import mean_squared_log_error, r2_score, mean_absolute_error
import joblib

# Load and preprocess the dataset
seed = 20
df1 = pd.read_csv("functions\HouseData.csv")
df1

# %%
df1.info()

# %%
df1.shape

# %%
df1.isnull().sum()


# %%
for column in df1.columns:
    print(df1.groupby(column)[column].agg("count"), "\n", 50*"-")

# %%
df1.columns


# %%
df2 = df1.drop(['Unnamed: 0', 'address', 'AdUpdateDate', 'Category', 'UsingStatus','NumberFloorsofBuilding', 'EligibilityForInvestment',
    'BuildStatus', 'TitleStatus', 'NumberOfWCs', 
    'AdCreationDate', 'Type', 'NetSquareMeters', 
    'CreditEligibility', 'StructureType', 'MortgageStatus', 
    'Swap', 'Balcony', 'PriceStatus', 'RentalIncome', 'NumberOfBalconies', 
    'BalconyType', 'HallSquareMeters', 'WCSquareMeters', 'IsItVideoNavigable?',
    'Subscription', 'BathroomSquareMeters', 'BalconySquareMeters'], axis = "columns")
df2

# %%
df2.isnull().sum()


# %%
# Fill missing values by distribution rate
dist_rate = df2.ItemStatus.value_counts(normalize = True)
# Item status distribution rates
print(dist_rate)

# %%
# Missing values on column
missing = df2['ItemStatus'].isnull()


# %%
# Impute missing values by distribution rate
df3 = df2.copy()
df3.loc[missing, 'ItemStatus'] = np.random.choice(dist_rate.index, size = len(df2[missing]), p = dist_rate.values)
df3

# %%
# No more missing values
df3.isnull().sum()

# %%
# Number of rooms
room_types = df3["NumberOfRooms"].value_counts() # Value counts
room_types

# %%
# Adjusts the width and height of the figure
plt.figure(figsize = (15, 5))
# Count plot based on NumberOfRooms
ax = sns.countplot(data = df3, x = "NumberOfRooms")
# Container counts
ax.bar_label(ax.containers[0])
# Rotate 90 Room Types on xlabel
plt.xticks(rotation = 90)
# Title
plt.title("Room/Hall Distribution");

# %%
# Convert number of rooms to room + hall format
def convert_rooms_to_room_hall(x):
    if x == "Stüdyo":
        return "1+0"
    elif x == "8+ Oda":
        return "8+0"
    elif "Oda" in x:
        return x.replace(" Oda", "+0")
    return x

# Number of halls only
def convert_rooms_to_hall(x):
    # Split from "+" and take second part
    token = x.split("+") 
    return float(token[1])

# Number of rooms only
def convert_rooms_to_room(x):
    # Split from "+" and take first part
    token = x.split("+")
    return float(token[0])

# Number of total rooms (room + hall)
def convert_rooms_to_total_room(x):
    # Split from "+" and sum two parts
    token = x.split("+")
    return (float(token[0]) + float(token[1]))
    try:
        return float(x)
    except:
        return None

# %%
df4 = df3.copy()
df4["NumberOfRooms"] = df4["NumberOfRooms"].apply(convert_rooms_to_room_hall)
df4["hall"] = df4["NumberOfRooms"].apply(convert_rooms_to_hall)
df4["total_room"] = df4["NumberOfRooms"].apply(convert_rooms_to_total_room)
df4["NumberOfRooms"] = df4["NumberOfRooms"].apply(convert_rooms_to_room)
df4

# %%
fig, (ax0, ax1) = plt.subplots(nrows = 1, ncols = 2) 
# Adjusts the width and height of the figure
fig.set_size_inches([15, 3]) 
# Count plot based on NumberOfRooms
sns.countplot(data = df4, x = 'NumberOfRooms', color = "lightblue", dodge = False, ax = ax0) 
# Kde plot based on NumberOfRooms
sns.kdeplot(data = df4, x = 'NumberOfRooms', color = "blue", ax = ax1); 

# %%
df4.groupby("price")["price"].agg("count")


# %%
def convert_price_to_num(x):
    # Split for T and take first part
    temp = x.replace(",", "").split("T")
    return float(temp[0])
    try:
        return float(x)
    except:
        return None

# %%
df5 = df4.copy()
df5["price"] = df5["price"].apply(convert_price_to_num)
df5

# %%
# Adjusts the width and height of the figure
plt.figure(figsize = (15, 5))
# Count plot based on price
sns.countplot(data = df5, x = 'price', dodge = False); 

# %%
plt.figure(figsize = (15, 5))
# Define xlabel range
plt.xlim(0, 0.001e10)
# Box plot based on price
sns.boxplot(data = df5, x = "price");

# %%
df5.groupby("GrossSquareMeters")["GrossSquareMeters"].agg("count")

# %%
def convert_grosssquaremeters_to_num(x):
    # Split from space and take first part
    temp = x.split(" ")
    return float(temp[0])
    try:
        return float(x)
    except:
        return None

# %%
df6 = df5.copy()
df6["GrossSquareMeters"] = df6["GrossSquareMeters"].apply(convert_grosssquaremeters_to_num)
df6

# %%
df6[(df6.GrossSquareMeters / df6.total_room) > 100]


# %%
df7 = df6.copy()
df7 = df6[~((df6.GrossSquareMeters / df6.total_room) > 100)]
df7

# %%
plt.figure(figsize = (15, 5))
# Box plot based on GrossSquareMeters
sns.boxplot(data = df7, x = "GrossSquareMeters");

# %%
df8 = df7.copy()
df8["price_per_sqmt"] = df8["price"] / df8["GrossSquareMeters"]
df8

# %%
df8.price_per_sqmt.describe()


# %%
plt.figure(figsize = (15, 5))
plt.xlim(-100, 0.01e7)
plt.xticks(np.arange(0, 100000, 10000))
sns.boxplot(data = df8, x = "price_per_sqmt");

# %%
df9 = df8.copy()
df9 = df8[~(df8["price_per_sqmt"] > 35000) & ~(df8["price_per_sqmt"] < 3500)]
df9

# %%
def remove_room_outliers(df):
    exclude_indices = np.array([]) # List for temporary values
    for district, district_df in df.groupby("district"):
        room_stats = {} # Empty dict for stats
        for room, room_df in district_df.groupby("total_room"):
            # Mean, std and count stats 
            room_stats[room] = {
                "mean": np.mean(room_df.price_per_sqmt),
                "std": np.std(room_df.price_per_sqmt),
                "count": room_df.shape[0]
            }
        for room, room_df in district_df.groupby("total_room"):
            stats = room_stats.get(room-1) # Check for previous stat
            if stats and stats["count"] > 5: # Check if previous stat and count > 5
                # Remove whose price per sqmt < mean of price per sqmt
                exclude_indices = np.append(exclude_indices, room_df[room_df.price_per_sqmt < (stats["mean"])].index.values)
    return df.drop(exclude_indices, axis = "index")

# %%
df10 = df9.copy()
df10 = remove_room_outliers(df9)
df10

# %%
plt.figure(figsize = (15, 8))
# Histogram plot based on price_per_sqmt
sns.histplot(data = df10, x = "price", bins = 100, kde = True);

# %%
dummies1 = pd.get_dummies(df10.district)
dummies2 = pd.get_dummies(df10.ItemStatus)

# %%
df11 = df10.copy()
df11 = pd.concat([df10, dummies1], axis = "columns")
df11 = pd.concat([df11, dummies2], axis = "columns")
# Column names
df11.columns

# %%
df12 = df11.copy()
df12 = df11.drop(['district', 'ItemStatus', 'total_room', 'price_per_sqmt'], axis = "columns")
df12.columns

# %%

def categorize_floor_location(floor_location):
    if 'Bodrum' in floor_location or 'Kot' in floor_location: 
        return 'Basement'
    elif 'Dubleks' in floor_location:
        return 'Dubleks'
    elif 'Villa Tipi' in floor_location or 'Müstakil' in floor_location or 'Bahçe' in floor_location:
        return 'Independent'
    elif 'Çatı' in floor_location:
        return 'ÇatıKatı'
    elif 'Düz' or 'Giriş' in floor_location:
        return 'DüzGiriş'
    elif 'Ve Üzeri'.lower() in floor_location.lower():
        return 'High'
    elif 'Kat' in floor_location:
        try:
            floor_num = int(floor_location.split()[0].replace('.', ''))
            if floor_num <= 3:
                return 'Low'
            elif floor_num <= 10:
                return 'Mid'
            else:
                return 'High'
        except ValueError:
            if '1-10' in floor_location:
                return 'Low-Mid'
            elif '10-20' in floor_location or '20-30' in floor_location or '30-40' in floor_location:
                return 'High'
            elif '40+' in floor_location:
                return 'Very High'
    else:
        return 'Other'

df12['FloorLocation'] = df12['FloorLocation'].apply(categorize_floor_location)


df12.columns

# %%
dummies_3 = pd.get_dummies(df12.FloorLocation)
dummies_5 = pd.get_dummies(df12.InsideTheSite)

df13 = df12.copy()
df13 = pd.concat([df13, dummies_3], axis = "columns")
df13 = pd.concat([df13, dummies_5], axis = "columns")

heating_dummies = pd.get_dummies(df13['HeatingType'], prefix='Heating')

# Dummy dataframe'i orijinal dataframe ile birleştirme
df13 = pd.concat([df13, heating_dummies], axis=1)
drop_columns = ['FloorLocation','InsideTheSite','HeatingType']
df13.drop(drop_columns, axis=1, inplace=True)

#df13 = df12.drop(['FloorLocation','FloorCategory'], axis = "columns")
df13.columns

# %%
df14 = df13.copy()
df14.columns

# %%
def standardize_building_age(age):
    age_str = str(age)
    if age_str == "0 (Yeni)":
        return 0
    elif '-' in age_str:
        range_vals = age_str.split('-')
        try:
            return sum(int(val) for val in range_vals) / len(range_vals)
        except ValueError:
            return None
    elif "21" or "Ve" or "Üzeri" in age_str:
        return 22
    else:
        try:
            return int(age_str)
        except ValueError:
            return None
df14['BuildingAge'] = df14['BuildingAge'].apply(standardize_building_age).astype(float)

# %%
def bathroom(num):
    str_num = str(num)
    if str_num.lower() == 'yok':
        return 0
    elif '+' in str_num:
        return int(str_num.split('+')[0]) + 1
    else:
        try:
            return float(num)
        except ValueError:
            return 0

df14['NumberOfBathrooms'] = df14['NumberOfBathrooms'].apply(bathroom).astype(float)



# %%
X = df14.drop("price", axis = "columns")
X

# %%
y = df14.price
y

# %%
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = seed)

# %%
# Model selection
scoresCV = []
regressors = [Ridge(),
            LinearRegression(),
            KNeighborsRegressor(),
            DecisionTreeRegressor(),
            GradientBoostingRegressor(),
            RandomForestRegressor(), 
            ]

for regressor in regressors:
    scoreCV = cross_val_score(regressor,
                            X_train,
                            y_train,
                            cv = ShuffleSplit(n_splits = 5, 
                                                test_size = 0.2,
                                                random_state = seed))
    scoresCV.append([regressor, np.mean(scoreCV)])

# %%
c_val = pd.DataFrame(scoresCV, columns = ["Regressor", "Score"])
c_val_sort = c_val.sort_values(by = "Score", ignore_index = True)
c_val_sort

# %%
# Creating model
reg = RandomForestRegressor()
# Searching parameters
params = {"n_estimators": [100, 200, 300, 400, 500],
        "max_features": [1, 2, 3, 4, 5],
        "max_depth": [1, 2, 3, 4, 5],
        "max_samples": [1000, 2000, 3000, 4000, 5000],
        "min_samples_split": [10, 20, 30, 40, 50]
        }
# Creating grid
rf_reg_grid = RandomizedSearchCV(estimator = reg, 
                                param_distributions = params,
                                cv = ShuffleSplit(n_splits = 5, 
                                                test_size = 0.2,
                                                random_state = seed),
                                n_iter = 10,
                                verbose = 2, 
                                n_jobs = -1)
# Fit the model
rf_model = rf_reg_grid.fit(X_train, y_train)

# Get best parameters
print("Best parameters for Random Forest model: ", rf_model.best_params_)

# %%
rf_best = pd.DataFrame.from_dict(rf_model.best_params_, orient = "index").rename(columns = {0: "Best"})
rf_best

# %%
rf_reg = RandomForestRegressor(n_estimators = int(rf_best.iloc[0,0]),
                            min_samples_split = int(rf_best.iloc[1,0]),
                            max_samples = int(rf_best.iloc[2,0]),
                            max_features = int(rf_best.iloc[3,0]),
                            max_depth = int(rf_best.iloc[4,0]),
                            random_state = seed)
# Fit the model
rf_reg.fit(X_train, y_train)

# %%
rf_pred = rf_reg.predict(X_test)
rf_reg.score(X_test, y_test)

# %%
rf_reg = RandomForestRegressor()
rf_reg.fit(X_train, y_train)
rf_reg.score(X_test, y_test)
joblib.dump(rf_reg, 'rf_model.pkl')

# %%
df10.columns

def predict_price(district, item,floor,heating,site, sqmt, room, hall,age,wc):
    dist_index = np.where(X.columns == district)[0][0] # District indices
    item_index = np.where(X.columns == item)[0][0] # Item indices
    floor_index = np.where(X.columns == item)[0][0] # Item indices
    heating_index = np.where(X.columns == item)[0][0] # Item indices
    site_index = np.where(X.columns == item)[0][0] # Item indices
    # Variables and indices on columns
    x = np.zeros(len(X.columns))
    x[0] = sqmt
    x[1] = room
    x[2] = hall
    x[3] = age
    x[4] = wc
    if dist_index >= 0:
        x[dist_index] = 1
        x[item_index] = 1
        x[floor_index] = 1
        x[heating_index] = 1
        x[site_index] = 1
    return "Estimated Price: " + str(round(rf_reg.predict([x])[0])) + " TL"

predict_price("izkent", "Boş","ÇatıKatı","Heating_Klimalı","Hayır",120, 2, 1,10,1)
