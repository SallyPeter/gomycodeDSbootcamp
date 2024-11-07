import joblib
import pandas as pd
import streamlit as st
from sklearn.neighbors import KNeighborsClassifier
from sklearn.preprocessing import LabelEncoder
# from sklearn.model_selection import train_test_split
# from sklearn.metrics import classification_report, confusion_matrix


tab1, tab2 = st.tabs(["Predictions","Data Overview"])

with tab1:
    data = pd.read_csv("Financial_inclusion_dataset.csv")

    st.dataframe(data.sample(25))

    value_dict = {each:0 for each in data.columns if each not in ["uniqueid", "bank_account"]}

    model = joblib.load("knn_model.pkl")

    st.write("""In this checkpoint, we are going to work on the 'Financial Inclusion in Africa' dataset that was provided as part of the Financial Inclusion in Africa hosted by the Zindi platform.
    Dataset description: The dataset contains demographic information and what financial services are used by approximately 33,600 individuals across East Africa. The ML model role is to predict which individuals are most likely to have or use a bank account.
    The term financial inclusion means:  individuals and businesses have access to useful and affordable financial products and services that meet their needs – transactions, payments, savings, credit and insurance – delivered in a responsible and sustainable way.""")

    le_order = joblib.load("le_order.pkl")

    with st.sidebar:
        st.header("Enter the parameters")
        st.text("Click on query when you are ready")
        for each in value_dict.keys():
            if each == "household_size" or each == "age_of_respondent":
                value_dict[each] = st.slider(each, data[each].min(), data[each].max())
            else:
                value_dict[each] = st.selectbox(each, [i for i in data[each].unique()])

    if st.sidebar.button("Query"):
        st.header("Predicting User Data")
        st.dataframe(pd.DataFrame([value_dict]))
        
        user_data = value_dict
        for k, v in user_data.items():
            if k in le_order.keys():
                user_data[k] = le_order[k].index(v)
        
        user_data = pd.DataFrame([user_data])

        # st.header("Predicting User Data")
        # st.dataframe(pd.DataFrame([value_dict]))

        pred = model.predict(user_data)[0]
        
        if pred == 0:
            st.write("My prediction is this record you entered points to one that would not have a bank account.")
        else:
            st.write("My prediction is this record you entered points to one that would have a bank account.")


with tab2:
    st.html("FID.html")
        
