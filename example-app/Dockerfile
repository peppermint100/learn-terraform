FROM python:3.9
RUN pip install pipenv
COPY . .
RUN pipenv requirements > requirements.txt
RUN pip install -r requirements.txt
EXPOSE 5000
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "5000"]
