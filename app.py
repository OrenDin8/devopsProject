from flask import Flask, render_template
from dotenv import load_dotenv
import start_attendance
app = Flask(__name__)

df = start_attendance.df_output
load_dotenv()

@app.route("/home")
@app.route("/")
def home():
    return render_template("home.html")

@app.route('/attentdance')
def attendance():
    return render_template("attendance.html",  tables=[df.to_html(classes='data')], titles=df.columns.values)

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/contact')
def contact():
    return render_template('contact.html')


if __name__ =='__main__':
   app.run(debug=True)
