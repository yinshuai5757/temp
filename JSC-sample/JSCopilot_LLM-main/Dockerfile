FROM python:3.11

WORKDIR /usr/src/app
COPY requirements.txt /usr/src/app
COPY ./llm.py /usr/src/app

RUN pip3 install --no-cache-dir -U pip && \
    pip3 install --no-cache-dir -r requirements.txt

RUN pip install mysql-connector-python
RUN pip install python-dotenv
RUN pip install openai==0.28
RUN pip install async-timeout

#CMD ["python", "llm.py"]
CMD ["sh", "-c", "sleep 10 && python llm.py"]
