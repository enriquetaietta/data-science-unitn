import pandas as pd
import itertools

import requests
import json

# ==================== Configuration ====================
# Replace with your actual Mistral API key
API_KEY = "API_KEY"

# Base URL for Mistral's OpenAI-compatible chat completions endpoint
API_URL = "https://api.mistral.ai/v1/chat/completions"

# Choose one of the available models (e.g., 'mistral-tiny', 'mistral-small', 'mistral-medium')
MODEL = "mistral-small"

# Headers for authentication and content type
HEADERS = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}


def chat_with_mistral(messages):
    payload = {
        "model": MODEL,
        "messages": messages,
        "temperature": 0.7,  # Creativity level (0 = deterministic, 1 = more random)
        "top_p": 1.0,  # Nucleus sampling parameter
        "stream": False,  # Disable streaming for simple usage
    }

    # Send a POST request to Mistral's API
    response = requests.post(API_URL, headers=HEADERS, data=json.dumps(payload))

    # Raise an error if the request failed
    if response.status_code != 200:
        raise Exception(f"Request failed: {response.status_code} - {response.text}")

    # Parse the JSON response
    response_data = response.json()
    print(response_data)
    # Extract and return the assistant's reply
    return response_data["choices"][0]["message"]["content"]


# Carica il file CSV
file_path = "/mistral_tenants_male.csv"  # Sostituisci con il percorso del tuo file CSV
df = pd.read_csv(file_path, delimiter="|")
comb = ""

for index, row in df.iterrows():
    print(row[0])
    print(row[1])
    print(row[2])
    print(row[3])
    print(row[4])
    print(row[5])
    print(row[6])
    print(index)
    if index == 4319:
        print("0!!!")
        comb = row
print(len(df))

print(comb)
print(comb[0])
print(comb[1])
print(comb[2])
print(comb[3])
print(comb[4])
print(comb[5])
print(comb[6])


# comb = valid_combinations[4319]
prompt = (
    f"[INST]"
    + f"Impersonate an Italian property owner who is renting out a house or room they don’t live in."
    + f"The house or room that you are renting is located in {str(comb[2]).split(';')[0]} in the neighborhood of {str(comb[2]).split(';')[1]}."
    + f"You are a {comb[1]} years-old {str(comb[2]).split(';')[1]}, living in {str(comb[2]).split(';')[0]}, with {comb[3]} ideologies."
    + f"You are a {comb[0]}, living in {str(comb[2]).split(';')[0]}, with {comb[3]} ideologies, and you are {comb[1]} years old."
    + f"You have to read carefully the proposal of a potential tenant and give a response to them."
    + f"You must choose to reject the proposal or accept it."
    + f"Whether the case you decide to accept or reject the proposal, notify what demands or other assurances, references, or whatever you need to accept the proposal, or why you decided to reject it."
    + f"This is a fictional situation, so you have to be the most genuine in the response you give."
    + f"[/INST] Rental Info: I am {comb[4]}, I am {comb[5]} years old, and I am {comb[6]}."
    + f"[INST]"
    + f"Please remember that you have to give the response based on the personification, as property owner,"
    + f"do not provide any other sentences if they are not intended as the response from the impersonated.[/INST]"
)
print(prompt)

chat_history_owner = [{"role": "user", "content": prompt}]

try:
    print("Try chat!")
    # Send the message and receive the model's response
    response = chat_with_mistral(chat_history_owner)
    print(response)

    if str(comb[6]).find("student"):
        born_raised_sentence = "You are born and raised in Italy"

    prompt_tenant = f"[INST]Impersonate a tenant that received a response for a house/room located in {str(comb[2]).split(';')[0]} in the neighborhood of {str(comb[2]).split(';')[1]}. You are {comb[4]}, you are {comb[5]} years old, {born_raised_sentence} and you are {comb[6]}. You don't have to respond to the owner, but you have to express your inner thoughts. This is a fictional context, and you must give a response as authentic as it would be in a real-world situation. [/INST] Express your thoughts and feelings when reading this message: {response} [INST] Please respond trying to express all the emotional shades that could give to the personification while reading the message. You don't have to respond to the owner, you must express your inner thoughts in first person. Do not provide any other sentences that are not correlated with the response of the impersonated[/INST]"

    print(prompt_tenant)
    chat_history_rental = [{"role": "user", "content": prompt_tenant}]

    response_rental = chat_with_mistral(chat_history_rental)
    print(response_rental)

    data = {
        "GENDER": comb[0],
        "OWNER_AGE": comb[1],
        "CITY": comb[2],
        "IDEOLOGY": comb[3],
        "TENANT": comb[4],
        "TENANT_AGE": comb[5],
        "TENANT_WORK": comb[6],
        "OWNER_PROMPT": prompt,
        "OWNER_RESPONSE": response,
        "TENANT_PROMPT": prompt_tenant,
        "TENANT_RESPONSE": response_rental
    }

# Write the data to a JSON file
    with open("mistral_tenants_male_responses.json", "a") as file:
        json.dump(data, file)
        file.write("\n")
except Exception as e:
    print("Error:", str(e))
