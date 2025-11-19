from bs4 import BeautifulSoup, Tag
from pathlib import Path
import re
import os
import pandas as pd

def book_list_from_category_page():
# Specify the directory path
    directory_path = '/product-reviews/'

    # List all files and directories in the specified path
    all_items = os.listdir(directory_path)

    # Filter out directories, keeping only files
    file_names = [item for item in all_items if os.path.isfile(os.path.join(directory_path, item))]

# Print the file names
    for file_name in file_names:
        print("start! --> file_name")
        print(file_name)
        product_review_id = file_name.split('_')[0]
        content = Path(directory_path+ file_name).read_text()
        #print(content)
        soup = BeautifulSoup(content, "html.parser")
        # Trova il riquadro informativo (Knowledge Panel)
        info_box = soup.find_all("span", attrs={"class": re.compile(r'review-text-content')})  # Classe può variare kp-wholepage

        # Note <a> tag -> class="a-profile" IMPORTANTE PER L'HREF DEL PROFILO IN CASO
        # Note <a> tag -> review-title-content 
        if info_box:
            #print(info_box)
            #print(len(info_box))
            for book_span in info_box:
                book_span: Tag  # Type annotation
                # print('book grid')
                nested_spans = book_span.find_all(lambda tag: tag.name == "span" and not tag.has_attr("class"))
                for nested_span in nested_spans:
                    nested_span: Tag
                    print(nested_span.get_text(strip=True))

        info_box_review_title = soup.find_all("a", attrs={"class": re.compile(r'review-title-content')})  # Classe può variare kp-wholepage
        if info_box_review_title:
            #print(len(info_box_review_title))
            for book_title_a in info_box_review_title:
                book_title_a: Tag  # Type annotation
                # print('book grid')
                nested_spans = book_title_a.find_all(lambda tag: tag.name == "span" and not tag.has_attr("class"))
                for nested_span in nested_spans:
                    nested_span: Tag
 
        info_box_review = soup.find_all("li", attrs={"data-hook": re.compile(r'review')})  # Classe può variare kp-wholepage
        if info_box_review:
            print('Entro nel loop info_box_review')
            for review in info_box_review:
                print('Review!!')
                content_review = ''
                span_text_content = review.find("span", attrs={"class": re.compile(r'review-text-content')})  # Classe può variare kp-wholepage
                print(span_text_content)
                text_content_lists = span_text_content.find_all(lambda tag: tag.name == "span" and not tag.has_attr("class"))
                # text_content_span: Tag
                print(text_content_lists)
                if (text_content_lists != []):
                    print("text_content_lists is null!!!")

                    if (len(text_content_lists) == 0):
                        text_content_lists = span_text_content.find("span", attrs={"class": re.compile(r'cr-original-review-content')})
                    print(len(text_content_lists))
                    print('OK1')
                    for  text in text_content_lists:
                        print(text)
                        print(re.sub(r' +', ' ', text.get_text(strip=True).replace("\n", " ")))
                        content_review += re.sub(r' +', ' ', text.get_text(strip=True).replace("\n", " "))
                print('OK2')

                a_title_content: Tag = review.find("a", attrs={"class": re.compile(r'review-title-content')})  # Classe può variare kp-wholepage
                print('OK3')
                print(a_title_content)
                # cr-original-review-content
                if (pd.isna( a_title_content)):
                    a_title_content: Tag = review.find("span", attrs={"class": re.compile(r'review-title-content')})  # Classe può variare kp-wholepage
                
                print(a_title_content)
                title_content: Tag = a_title_content.find(lambda tag: tag.name == "span" and not tag.has_attr("class"))
                print('OK4')

                # print(title_content.get_text(strip=True))
                # Controllo per recensioni lingua estere
                if (pd.isna(title_content)):
                    title_content: Tag = a_title_content.find("span", attrs={"class": re.compile(r'cr-original-review-content')})
                title_review = re.sub(r' +', ' ', title_content.get_text(strip=True).replace("\n", " "))
                # cr-original-review-content
                print('OK5')                
                # content_review = re.sub(r' +', ' ', text_content_span.get_text(strip=True).replace("\n", " "))
                # span data-hook="helpful-vote-statement" DA AGGIUNGERE
                helpful_vote = ''
                span_helpful_vote_content: Tag = review.find("span", attrs={"data-hook": re.compile(r'helpful-vote-statement')})  # Classe può variare kp-wholepage
                print('OK6')
                print(span_helpful_vote_content)
                # cr-original-review-content
                print("pd.isna(span_helpful_vote_content) == False")
                print(pd.isna(span_helpful_vote_content) == False)
                if (pd.isna(span_helpful_vote_content) == False):
                    helpful_vote = re.sub(r' +', ' ', span_helpful_vote_content.get_text(strip=True).replace("\n", " "))
                print(product_review_id + "|" + title_review + "|" + content_review + '|' + helpful_vote)

                csv_row = product_review_id + "|" + title_review + "|" + content_review + '|' + helpful_vote + "\n"
                with open('product_reviews_comments' + '.csv', 'a', newline='') as file:
                    file.write(csv_row)
                    print("file.write ok!!")
                    file.close()

print(book_list_from_category_page())