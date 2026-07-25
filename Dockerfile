#FROM python:3.15.0b4-slim

FROM dhi.io/python:3-dev

WORKDIR /home/app

COPY requirements.txt .

RUN pip install -r requirements.txt

#COPY app.py .

#RUN useradd --create-home appuser && chown -R appuser:appuser /home/app

USER appuser

CMD ["python", "app.py"]


