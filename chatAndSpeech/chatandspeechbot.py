import nltk

# nltk.download('punkt')
nltk.download('punkt_tab')
nltk.download('stopwords')
nltk.download('wordnet')

nltk.download('averaged_perceptron_tagger')

from nltk.tokenize import word_tokenize, sent_tokenize

from nltk.corpus import stopwords

from nltk.stem import WordNetLemmatizer

import string

import streamlit as st
import speech_recognition as sr

# Load the text file and preprocess the data

with open('macbeth.txt', 'r', encoding='utf-8') as f:

    data = f.read().replace('\n', ' ')

# Tokenize the text into sentences

sentences = sent_tokenize(data)

# Define a function to preprocess each sentence

def preprocess(sentence):

    # Tokenize the sentence into words

    words = word_tokenize(sentence)

    # Remove stopwords and punctuation

    words = [word.lower() for word in words if word.lower() not in stopwords.words('english') and word not in string.punctuation]

    # Lemmatize the words

    lemmatizer = WordNetLemmatizer()

    words = [lemmatizer.lemmatize(word) for word in words]

    return words



# Preprocess each sentence in the text

corpus = [preprocess(sentence) for sentence in sentences]

# Define a function to find the most relevant sentence given a query

def get_most_relevant_sentence(query):

    # Preprocess the query

    query = preprocess(query)

    # Compute the similarity between the query and each sentence in the text

    max_similarity = 0

    most_relevant_sentence = ""

    for sentence in corpus:

        similarity = len(set(query).intersection(sentence)) / float(len(set(query).union(sentence)))

        if similarity > max_similarity:

            max_similarity = similarity

            most_relevant_sentence = " ".join(sentence)

    return most_relevant_sentence


def chatbot(question):

    # Find the most relevant sentence

    most_relevant_sentence = get_most_relevant_sentence(question)

    # Return the answer

    return most_relevant_sentence



def transcribe_speech():

    # Initialize recognizer class

    r = sr.Recognizer()

    # Reading Microphone as source

    with sr.Microphone() as source:

        st.info("Speak now...")

        # listen for speech and store in audio_text variable

        audio_text = r.listen(source)

        st.info("Transcribing...")

        try:
            
            # api_ = {"Google":r.recognize_google,"Amazon":r.recognize_amazon,"Azure":r.recognize_azure,
            #         "IBM":r.recognize_ibm,"AssemblyAI":r.recognize_assemblyai}
            # lang_ = {"English - British":"en-GB", "English - American":"en-US", "French":"fr-FR", 
            #          "Germany":"de-DE", "Espanol":"es-ES"}

            # using Google Speech Recognition
            
            text = r.recognize_google(audio_text)

            # text = api_[api](audio_text, language=lang_[lang])

            return text

        except:
            return "Sorry, I did not get that."
            


# Create a Streamlit app

def main():

    st.title("Chatbot")

    st.write("Hello! I'm a chatbot. Ask me anything about the topic in the text file.")

    # Get the user's question

    question = st.text_input("You:")
    # Create a button to submit the question

    button_label = "Record Question" if question == "" else "Submit"
    if st.button(button_label):

        # Call the chatbot function with the question and display the response

        if question != "":
            response = chatbot(question)
        else:
            text = transcribe_speech()
            st.write(text)
            response = chatbot(text)

        st.write("Chatbot: " + response)


if __name__ == "__main__":

    main()
