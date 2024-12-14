import cv2

import streamlit as st


st.write("How to use this app")


# Step 2: Load the face cascade classifier

face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')

def detect_faces(minN, scaleF, color, filename="pic"):

    # Initialize the webcam

    cap = cv2.VideoCapture(0)

    while True:

        # Read the frames from the webcam

        ret, frame = cap.read()

        # Convert the frames to grayscale

        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

        # Detect the faces using the face cascade classifier

        faces = face_cascade.detectMultiScale(gray, scaleFactor=scaleF, minNeighbors=minN)

        # Draw rectangles around the detected faces

        for (x, y, w, h) in faces:

            cv2.rectangle(frame, (x, y), (x + w, y + h), color, 2)

        # Display the frames

        cv2.imshow('Face Detection using Viola-Jones Algorithm', frame)

        # Saving the detected face

        cv2.imwrite(filename, frame) 

        # Exit the loop when 'q' is pressed

        if cv2.waitKey(1) & 0xFF == ord('q'):

            break

    # Release the webcam and close all windows

    cap.release()

    cv2.destroyAllWindows()


def app():

    st.title("Face Detection using Viola-Jones Algorithm")
    st.markdown("""
        How to use this app:
                1. Ensure you have a webcam connected to this computer
                2. Click on the "Detect Faces" button to detect faces from your webcam.
                3. Enter the file name to save the detected face with
                4. Click on save
""")

    st.write("Press the button below to start detecting faces from your webcam")

    # Add a button to start detecting faces

    if st.button("Detect Faces"):

        # Call the detect_faces function

        # detect_faces()
        
        filename = st.text_input("Filename: ")
        detect_faces(minN, scaleF, color, filename)
    
    with st.sidebar():
        color = st.color_picker("Select a color for the rectangles:")
        st.write("You picked ", color)
        color = tuple(int(color.lstrip("#")[i:i+2], 16) for i in (0, 2, 4))
        st.write("You picked ", color)
        minN = st.slider("minNeighbors", 1, 20)
        scaleF = st.slider("scaleFactor", 1, 10)
    
        

if __name__ == "__main__":

    app()
