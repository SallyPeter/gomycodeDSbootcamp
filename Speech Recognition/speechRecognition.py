import streamlit as st

import speech_recognition as sr

def transcribe_speech(api, lang, key=""):

    # Initialize recognizer class

    r = sr.Recognizer()

    # Reading Microphone as source

    with sr.Microphone() as source:

        st.info("Speak now...")

        # listen for speech and store in audio_text variable

        r.pause_threshold = 1
        r.phrase_threshold = 5
        audio_text = r.listen(source)


        st.info("Transcribing...")


        try:
            
            api_ = {"Google":r.recognize_google,"Amazon":r.recognize_amazon,"Azure":r.recognize_azure,
                    "IBM":r.recognize_ibm,"AssemblyAI":r.recognize_assemblyai}
            lang_ = {"English - British":"en-GB", "English - American":"en-US", "French":"fr-FR", 
                     "Germany":"de-DE", "Espanol":"es-ES"}
            # using Google Speech Recognition
            
            # text = r.recognize_google(audio_text)
            # apii = "recognize_" + api.lower()
            # st.write(apii)
            text = api_[api](audio_text, language=lang_[lang])

            return text

        except:
            if api != "Google" and key == "":
                st.write("You do not have the credentials to use this translator! Please use Google.")
            else:
                return "Sorry, I did not get that."



def main():

    st.title("Speech Recognition App")

    st.write("Click on the microphone to start speaking:")

    # Adding different Speech recognition APIs
    with st.sidebar:
        st.write("Please note, only Google transcribe is free. Others would need a key or passcode.")
        st.write("Just use Google")

        api = st.radio("Translator:", ["Google","Amazon","Azure","IBM","AssemblyAI"])
        key = st.text_input("Key/Passcode:")
        lang = st.radio("Language:", ["English - British", "English - American", "French", "Germany", "Espanol"])


    # add a button to trigger speech recognition

    if st.button("Start Recording"):

        text = transcribe_speech(api, lang, key)

        st.write("Transcription: ", text)
        if text != None:
            st.write("Click Save to download your transcribed text.")
            st.download_button("Save", text)
        
            

if __name__ == "__main__":

    main()