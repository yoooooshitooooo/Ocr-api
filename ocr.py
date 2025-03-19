import pytesseract
from PIL import Image

# 画像ファイルを指定
image_path = "test.png"  # ここに画像ファイル名を入れる
image = Image.open(image_path)

# OCR実行
text = pytesseract.image_to_string(image, lang="jpn")

# 結果を表示
print("認識結果:")
print(text)
