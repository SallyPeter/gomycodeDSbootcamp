import requests as re
import streamlit as st
import pandas as pd
import plotly.express as px


tab1, tab2 = st.tabs(["Satellite Images", "Near Earth Objects"])

with st.sidebar:
        api_key = st.text_input("API key: ")
        start_date = st.date_input('Query start date: ')
        end_date = st.date_input('Query end date: ')
        # distance = st.slider("What distance would you like to view: ")


with tab1:
    
    st.header("This page renders satellite images from Nasa's website.")
    st.text("You can only pull images for the past seven (7) days")

    st.header("Picture of the day")


    url = 'https://api.nasa.gov/planetary/apod'
    if api_key:
        response_api = re.get(''.join([url, f"?api_key={api_key}"]))
    else:
        response_api = re.get(url)

    if response_api.status_code != 200:
        st.write("Please check your input values.")
    else:
        st.image(response_api.json()['url'])


    if st.sidebar.button("Query"):
        response_api = re.get(''.join([url, "?api_key={}&start_date={}&end_date={}".format(api_key, start_date, end_date)]))
        img_df = pd.DataFrame(response_api.json())
        
        st.dataframe(img_df.head())

        # col1, col2 = st.columns([1,2])
        count = 0
        for each in img_df.date:
            st.write(each +" "+ img_df[img_df.date == each]['title'][count])
            # st.write(img_df[img_df.date == each]['title'][count])
            # st.write(img_df[img_df.date == each]['url'])
            st.image(img_df[img_df.date == each]['url'][count])
            # col2.write(img_df[img_df.date == each]['explanation'][count])
            count +=1

with tab2:
    st.header("Near Earth Objects")
    st.text('''This page shows a table of near earth objects such as asteroids, 
their speed, estimated diameter, magnitude and speek in km/s''')

    
    asteroid_url = "https://api.nasa.gov/neo/rest/v1/feed"
    asteroid_api = re.get("{}?api_key={}&start_date={}&end_date={}".format(asteroid_url, api_key,  start_date, end_date))
    asteroid_data = pd.DataFrame(columns=['date', 'id', 'name', 'est_diam_km', 'abs_mag', 'rel_vel(km/s)'])

    if asteroid_api.status_code == 200:
        for date in asteroid_api.json()['near_earth_objects']:         #['2024-10-20']
            for  asteroid in asteroid_api.json()['near_earth_objects'][date]:
                #print(asteroid)
                id = asteroid['id']
                name = asteroid['name']
                est_diam_km = asteroid['estimated_diameter']['kilometers']['estimated_diameter_min']
                abs_mag = asteroid['absolute_magnitude_h']
                rel_vel = asteroid['close_approach_data'][0]['relative_velocity']['kilometers_per_second']
                

                ast_dict = {'date': date, 'name':name, 'id':id, 'est_diam_km':est_diam_km, 'abs_mag':abs_mag, 'rel_vel(km/s)':rel_vel}
                asteroid_data = asteroid_data._append(ast_dict, ignore_index=True)

        st.write(f"Between {start_date} and {end_date}, there have been recorded {asteroid_data.shape[0]} objects nearing earth as seen in the table below.")
        st.dataframe(asteroid_data)
        

        fig = px.scatter(asteroid_data, x="est_diam_km", y="rel_vel(km/s)", color="abs_mag", 
                         size_max=80, hover_name="name", title="Estimated Diameter vs. Relative Velocity of Near Earth Objects")

        st.plotly_chart(fig)



    







