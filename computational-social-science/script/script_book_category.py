from bs4 import BeautifulSoup, Tag
from pathlib import Path
import re


def book_list_from_category_page():
    content = Path('/categories/508811031_page_2.txt').read_text()
    #print(content)
    soup = BeautifulSoup(content, "html.parser")
    info_box = soup.find_all("div", attrs={"class": "zg-grid-general-faceout"})  # Classe può variare kp-wholepage
    book_data = {
    "title": [],
    "author": [],
    "review_link": [],
    "product_id": []
    }
    
    #print(info_box)
    if info_box:
        print(len(info_box))
        for book_grid in info_box:
            book_grid: Tag  # Type annotation
            print(book_grid)
            book_details = book_grid.find_all("div", attrs={"class": re.compile(r'_cDEzb_p13n-sc-css-line-clamp')})
            #book_details: Tag
            print(len(book_details))
            if (len(book_details) > 1):
                book_data["title"].append(book_details[0].get_text(strip=True))
                book_data["author"].append(book_details[1].get_text(strip=True))
            
                book_product_reviews_href = book_grid.find_all("a", attrs={"class": re.compile(r'a-link-normal')})
                print(book_product_reviews_href)
                print(len(book_product_reviews_href))
                print(book_product_reviews_href[0]['href'])
                book_data["review_link"].append(book_product_reviews_href[0]['href'])
                book_data["product_id"].append(str(book_product_reviews_href[0]['href']).split('/')[3])
            # book_product_reviews_href = book_grid.find_all("a", attrs={"href": re.compile(r'product-reviews')})

    for i in range(len(book_data["author"])):
        print(str(i) + ' ' + book_data["author"][i] + ' - ' + book_data["title"][i] + ' ' + book_data["review_link"][i] + ' ' + book_data["product_id"][i])
        csv_row = book_data["author"][i] + '|' + book_data["title"][i] + '|' + book_data["review_link"][i] + '|' + book_data["product_id"][i] + "\n"
        with open('book_category_508811031' + '.csv', 'a', newline='') as file:
            file.write(csv_row)
            file.close()

print(book_list_from_category_page())