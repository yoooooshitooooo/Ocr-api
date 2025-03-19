# Python 3.9 の公式 Docker イメージを使用
FROM python:3.9

# 必要なパッケージをインストール（Tesseract OCR を含む）
RUN apt-get update && apt-get install -y tesseract-ocr

# 作業ディレクトリを設定
WORKDIR /app

# 必要なファイルをコンテナにコピー
COPY . /app

# 必要な Python ライブラリをインストール
RUN pip install --no-cache-dir -r requirements.txt

# サーバーを起動
CMD ["python", "ocr.py"]
