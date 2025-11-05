from flask import Flask, jsonify, request

app = Flask(__name__)

@app.route('/')
def index():
    return jsonify({
        "service": "orders",
        "message": "Orders service responding successfully!"
    })

@app.route('/order', methods=['POST'])
def create_order():
    data = request.get_json()
    product = data.get("product")
    quantity = data.get("quantity")
    return jsonify({
        "status": "success",
        "order": {
            "product": product,
            "quantity": quantity
        }
    })

@app.route('/health')
def health():
    return jsonify({"status": "ok"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
