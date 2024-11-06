import joblib
import pandas as pd
import streamlit as st
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import LabelEncoder

tdata = pd.read_csv("Expresso_churn_dataset.csv")

model = joblib.load("RF Model.pkl")

# data = {'REGION': 2,'TENURE': 7,'MONTANT': 4250.0,'FREQUENCE_RECH': 15.0,
#  'REVENUE': 4251.0,'ARPU_SEGMENT': 1417.0,'FREQUENCE': 17.0,'DATA_VOLUME': 4.0,'ON_NET': 388.0,'ORANGE': 46.0,
#  'TIGO': 1.0,'ZONE1': 1.0,'ZONE2': 2.0,'MRG': 0,'REGULARITY': 54,'TOP_PACK': 107,'FREQ_TOP_PACK': 8.0}

# data = pd.DataFrame([data])

# print(model.predict(data))


dat = {'REGION': 0, 'TENURE':0, 'MONTANT':0, 'FREQUENCE_RECH':0, 'REVENUE':0,
       'ARPU_SEGMENT':0, 'FREQUENCE':0, 'DATA_VOLUME':0, 'ON_NET':0, 'ORANGE':0, 'TIGO':0,
       'ZONE1':0, 'ZONE2':0, 'MRG':0, 'REGULARITY':0, 'TOP_PACK':0, 'FREQ_TOP_PACK':0}


toppack = joblib.load("toppack.pkl")
# st.write(toppack)

with st.sidebar:
    for each in dat:
        if each == 'TENURE':
            st.selectbox(each, ['D 3-6 month', 'E 6-9 month', 'F 9-12 month', 'G 12-15 month','H 15-18 month', 
                                'I 18-21 month', 'J 21-24 month', 'K > 24 month'])
        elif each == 'REGION':
            st.selectbox(each, ['FATICK', None, 'DAKAR', 'LOUGA', 'TAMBACOUNDA', 'KAOLACK', 'THIES','SAINT-LOUIS', 
                                'KOLDA', 'KAFFRINE', 'DIOURBEL', 'ZIGUINCHOR','MATAM', 'SEDHIOU', 'KEDOUGOU'])
        elif each == 'TOP_PACK':
            st.selectbox(each, [i for i in toppack])
        elif each == 'MRG':
            st.selectbox(each, ['NO', 'YES'])
        else:
            st.number_input("Please enter " + each, tdata[each].min(), tdata[each].max())


st.header("This is Streamlit for Checkpoint 1")
st.write("""In this checkpoint, I worked on the 'Expresso churn' dataset that was provided as part of Expresso Churn Prediction Challenge hosted by Zindi platform.
         Dataset description: Expresso is an African telecommunications services company that provides telecommunication services in two African markets: Mauritania and Senegal. 
         The data describes 2.5 million Expresso clients with more than 15 behaviour variables in order to predict the clients' churn probability.""")

st.dataframe(tdata.sample(25))

if st.sidebar.button("Predict"):
    user_data = pd.DataFrame([dat])

    st.dataframe(user_data)
    st.write("The churn probability for a user with these values is ", model.predict(user_data)[0])




