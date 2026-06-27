from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello from my End-to-End DevOps CI/CD Pipeline!"

@app.route("/health")
def health():
    return {
        "status": "UP",
        "application": "Flask DevOps Demo"
    }

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)