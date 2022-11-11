from venv import create
from flask import Flask, render_template
import start_attendance
import os
from dotenv import load_dotenv
load_dotenv()

app = Flask(__name__)

df = start_attendance.df_output


@app.route("/home")
@app.route("/")
def home():
    return render_template("home.html")

@app.route('/attendance')
def attendance():
    return render_template("attendance.html",  tables=[df.to_html(classes='data')], titles=df.columns.values)

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/contact')
def contact():
    return render_template('contact.html')


if __name__ =='__main__':
   app.run(debug=True, host='0.0.0.0', port=5000)
