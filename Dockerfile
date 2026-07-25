FROM dhi.io/python:3-dev AS builder

WORKDIR /home/app

COPY requirements.txt .

RUN pip install -r requirements.txt

FROM dhi.io/python:3

WORKDIR /home/app

COPY --from=builder /home/app /home/app

COPY app.py .

USER appuser

CMD ["python", "app.py"]


