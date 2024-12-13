import cv2
import av
import streamlit as st
from streamlit_webrtc import webrtc_streamer, VideoTransformerBase

# Load the face cascade classifier
face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + "haarcascade_frontalface_default.xml")

# Define a class to process video frames
class FaceDetectionTransformer(VideoTransformerBase):
    def transform(self, frame):
        # Convert the frame to a numpy array
        img = frame.to_ndarray(format="bgr24")

        # Convert the image to grayscale
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

        # Detect faces in the image
        faces = face_cascade.detectMultiScale(gray, scaleFactor=1.3, minNeighbors=5)

        # Draw rectangles around detected faces
        for (x, y, w, h) in faces:
            cv2.rectangle(img, (x, y), (x + w, y + h), (0, 255, 0), 2)

        # Return the processed frame
        return av.VideoFrame.from_ndarray(img, format="bgr24")

def detect_faces():
    st.write("Starting face detection...")
    webrtc_streamer(key="face-detection", video_transformer_factory=FaceDetectionTransformer, media_stream_constraints={
        "video": True,
        "audio": False
    })

def app():
    st.title("Face Detection using Viola-Jones Algorithm")
    st.write("Press the button below to start detecting faces from your webcam")

    # Add a button to start detecting faces
    if st.button("Detect Faces"):
        detect_faces()

if __name__ == "__main__":
    app()
