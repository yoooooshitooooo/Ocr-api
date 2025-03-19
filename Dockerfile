# Python 3.9 の公式 Docker イメージを使用
FROM python:3.9

# 必要なパッケージをインストール（Tesseract OCR ＆ 日本語データ）
RUN apt-get update && apt-get install -y tesseract-ocr \
    && apt-get install -y tesseract-ocr-jpn tesseract-ocr-eng \
    && apt-get clean

# 環境変数を設定（TESSDATAのフォルダを指定）
ENV TESSDATA_PREFIX=/usr/share/tesseract-ocr/4.00/tessdata/

# 作業ディレクトリを設定
WORKDIR /app

# 必要なファイルをコンテナにコピー
COPY . /app

# 必要な Python ライブラリをインストール
RUN pip install --no-cache-dir -r requirements.txt

# サーバーを起動
CMD ["python", "ocr.py"]
