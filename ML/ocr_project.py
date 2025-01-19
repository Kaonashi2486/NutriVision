import cv2
import pytesseract
from PIL import Image

pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'

# Load the image

image = cv2.imread(r'C:\Users\saksh\OneDrive\Desktop\stuffs\FoodScanner\ml\nutrient_chart.jpg')

# # Convert to grayscale (reduces noise from colors)
# gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# # Apply adaptive thresholding (for uneven lighting)
# thresh = cv2.adaptiveThreshold(
#     gray, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY, 11, 2
# )

# # Remove noise (optional)
# denoised = cv2.medianBlur(thresh, 3)

# # Save preprocessed image (optional, for debugging)
# cv2.imwrite('preprocessed_image.jpg', denoised)

# # Perform OCR
# text = pytesseract.image_to_string(denoised, lang='eng')

# print("Extracted Text:")
# print(text)




# Function to preprocess image for table extraction
def preprocess_image(image_path):
    # Load the image
    image = cv2.imread(image_path)

    # Convert the image to grayscale
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Apply adaptive thresholding to improve contrast (helps with white table cells)
    thresh = cv2.adaptiveThreshold(
        gray, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY_INV, 11, 2
    )

    # Optional: Apply noise removal techniques
    denoised = cv2.medianBlur(thresh, 3)

    # Optional: Use edge detection or contour detection to highlight table structure
    edges = cv2.Canny(denoised, threshold1=100, threshold2=200)

    # Save the preprocessed image for debugging
    cv2.imwrite('preprocessed_table_image.jpg', edges)

    return denoised

# Function to extract text from the image using OCR
def extract_text_from_image(image):
    # Use Tesseract to do OCR on the preprocessed image
    # Use --psm 6 for uniform block of text (try different modes like --psm 11 for sparse text)
    text = pytesseract.image_to_string(image, config='--psm 6')
    return text

# Function to process the OCR text and extract table data
def extract_table_data(ocr_text):
    lines = ocr_text.split('\n')
    table_data = []

    for line in lines:
        # Split by spaces or tabs, adjust the separator depending on your OCR output
        columns = line.split()
        if columns:
            table_data.append(columns)

    return table_data

# Main function to run the OCR on the image and extract table data
def main(image_path):
    # Preprocess the image
    preprocessed_image = preprocess_image(image_path)

    # Extract text using OCR
    ocr_text = extract_text_from_image(preprocessed_image)

    # Extract table data from the OCR text
    table_data = extract_table_data(ocr_text)

    # Print the extracted table data
    print("Extracted Table Data:")
    for row in table_data:
        print(row)

# Run the main function with your image
image_path = 'nutrient_chart.jpg'  # Make sure to provide the correct path to your image
main(image_path)
