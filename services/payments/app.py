from flask import Flask, jsonify, request

app = Flask(__name__)

@app.route('/')
def index():
    return jsonify({
        "service": "payments",
        "message": "Payments service responding successfully!"
    })

@app.route('/pay', methods=['POST'])
def pay():
    data = request.get_json()
    amount = data.get("amount")
    method = data.get("method")
    return jsonify({
        "status": "success",
        "payment": {
            "amount": amount,
            "method": method
        }
    })

@app.route('/health')
def health():
    return jsonify({"status": "ok"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
