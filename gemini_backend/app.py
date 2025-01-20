from dotenv import load_dotenv
import os
import google.generativeai as genai
from PIL import Image
import sys
import json

# Load environment variables
load_dotenv()

# Configure the Google Gemini API
genai.configure(api_key=os.getenv("GOOGLE_API_KEY"))

# Function to interact with the Google Gemini API and get a response
def get_gemini_response(input, image, prompt):
    # Use the new model, gemini-1.5-flash
    model = genai.GenerativeModel('gemini-1.5-flash')
    response = model.generate_content([input, image[0], prompt])
    return response.text


# Function to prepare the image data for processing
def input_image_setup(uploaded_file_path):
    if uploaded_file_path is not None:
        # Open the file in binary mode and read it into bytes
        with open(uploaded_file_path, 'rb') as file:
            bytes_data = file.read()  # Read the entire file content into bytes

        # Return image data in the expected format
        image_parts = [
            {
                "mime_type": "image/jpeg",  # Adjust MIME type as necessary
                "data": bytes_data
            }
        ]
        return image_parts
    else:
        raise FileNotFoundError("No file uploaded")

# Function to process the request
def process_image(input_prompt, uploaded_file_path, input_text):
    image_data = input_image_setup(uploaded_file_path)
    response = get_gemini_response(input_text, image_data, input_prompt)
    return response


# def scan_image_and_extract_ingredients(uploaded_file_path):
#     try:
#         # Prepare image data
#         image_data = input_image_setup(uploaded_file_path)

#         # Define the prompt for extracting ingredients in the new format
#         ingredient_prompt = (
#             "Extract all the food ingredients from the image and provide the information in the following format: \n\n"
#             "Nutrient Breakdown for the Product:\n\n"
#             "Nutrient | Per 100g/ml | Explanation\n"
#             "Calories | X kcal | Energy from one serving.\n"
#             "Protein | X g | Supports muscle health.\n"
#             "Carbohydrates | X g | Source of energy.\n"
#             "Fats | X g | Provides essential fatty acids.\n"
#             "... and so on for other nutrients. Keep the format consistent and neat."
#         )

#         # Use the gemini-pro-vision model to generate content
#         model = genai.GenerativeModel('gemini-pro-vision')
#         result = model.generate_content([image_data[0], ingredient_prompt], stream=True)
#         result.resolve()

#         # Return the extracted ingredients
#         return result.text

#     except Exception as e:
#         return str(e)
    
    
    
def scan_image_and_extract_ingredients(uploaded_file_path):
    # Define the prompt and include family data
    
    ingredient_prompt = (
        """You are a professional nutritionist tasked with analyzing food items from an image. Your goal is to estimate the food quality of the food label in the image, as well as provide detailed information on how safe is the product for consumption. The information should be structured in the following format:

Calories: [Caloric value of the food item in kcal]
Proteins: [Amount of protein in grams]
Carbohydrates: [Amount of carbohydrates in grams]
Fats: [Amount of fats in grams]
Vitamins: [List of vitamins, if applicable]
How safe is the product for consumption: [provide a brief explanation for a naive user]
"""
    )

    # Process the image
    image_data = input_image_setup(uploaded_file_path)
    
    # Get the response from the model
    response = get_gemini_response("Extract Ingredients from the Data", image_data, ingredient_prompt)
    return response


# input_prompt="""
# You are a professional nutritionist tasked with analyzing the nutritional value information from an image. Your goal is to extract valuable information from the food product label from the image and provide a detailed BUT BRIEF response about the nutritional value of it so that the user is aware of what is contained in it.Format the output properly.
# """
input_prompt="""
You are a professional nutritionist tasked with analyzing food items from an image. Your goal is to estimate the total calorie content of the foods in the image, as well as provide detailed nutritional information for each item. The information should be structured in the following format:

Item Name: [Name of the food item]
Calories: [Caloric value of the food item in kcal]
Proteins: [Amount of protein in grams]
Carbohydrates: [Amount of carbohydrates in grams]
Fats: [Amount of fats in grams]
Vitamins: [List of vitamins, if applicable]

For example:

Apple:

Calories: 95 kcal
Proteins: 0.5 g
Carbohydrates: 25 g
Fats: 0.3 g
Vitamins: Vitamin C, Vitamin A

Chicken Breast:

Calories: 165 kcal
Proteins: 31 g
Carbohydrates: 0 g
Fats: 3.6 g
Vitamins: Vitamin B6, Vitamin B12

"""

# Main function for executing logic
def main():
    sys.stdout.reconfigure(encoding='utf-8')

    if len(sys.argv) < 3:
        print("Error: No arguments provided!")
        sys.exit(1)

    command = sys.argv[1]
    file_path = sys.argv[2]

    if command == 'process_image':
        response = process_image(input_prompt, file_path, "Input prompt text")
        print(response)
    elif command == 'scan_image_for_ingredients':
        ingredients = scan_image_and_extract_ingredients(file_path)
        print(ingredients) 
    else:
        print(f"Unknown command: {command}")
        sys.exit(1)


if __name__ == '__main__':
    main()