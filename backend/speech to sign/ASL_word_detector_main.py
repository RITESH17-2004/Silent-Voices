

# from flask import Flask, request, jsonify
# from flask_cors import CORS
# import cv2
# import numpy as np
# import base64
# from keras.models import model_from_json
# from utilities.holistic_feature_extractor import HolisticFeatureExtractor
# from utilities.holistic_feature_data import HolisticData

# feature_extractor = HolisticFeatureExtractor()
# data = HolisticData(26)

# CLASS_LIST = [    "accident",
#     "africa",
#     "all",
#     "apple",
#     "basketball",
#     "bed",
#     "before",
#     "bird",
#     "birthday",
#     "black",
#     "blue",
#     "book",
#     "bowling",
#     "brown",
#     "but",
#     "can",
#     "candy",
#     "chair",
#     "change",
#     "cheat",
#     "city",
#     "clothes",
#     "color",
#     "computer",
#     "cook",
#     "cool",
#     "corn",
#     "cousin",
#     "cow",
#     "dance",
#     "dark",
#     "deaf",
#     "decide",
#     "doctor",
#     "dog",
#     "drink",
#     "eat",
#     "enjoy",
#     "family",
#     "fine",
#     "finish",
#     "fish",
#     "forget",
#     "full",
#     "give",
#     "go",
#     "graduate",
#     "hat",
#     "hearing",
#     "help",
#     "hot",
#     "how",
#     "jacket",
#     "kiss",
#     "language",
#     "last",
#     "later",
#     "letter",
#     "like",
#     "man",
#     "many",
#     "medicine",
#     "meet",
#     "mother",
#     "need",
#     "no",
#     "now",
#     "orange",
#     "paint",
#     "paper",
#     "pink",
#     "pizza",
#     "play",
#     "pull",
#     "purple",
#     "right",
#     "same",
#     "school",
#     "secretary",
#     "shirt",
#     "short",
#     "son",
#     "study",
#     "table",
#     "tall",
#     "tell",
#     "thanksgiving",
#     "thin",
#     "thursday",
#     "time",
#     "walk",
#     "want",
#     "what",
#     "white",
#     "who",
#     "woman",
#     "work",
#     "wrong",
#     "year",
#     "yes",]  # Use your full CLASS_LIST here

# model_weights_file = "model/model_weights_100_holistic_features_cropped_OOP2.h5"
# model_json_file = "model/model_100_holistic_features_cropped_OOP2.json"

# with open(model_json_file, "r") as json_file:
#     loaded_model_json = json_file.read()
#     loaded_model = model_from_json(loaded_model_json)
#     loaded_model.load_weights(model_weights_file)
#     loaded_model.make_predict_function()

# app = Flask(__name__)
# CORS(app)


    
# @app.route('/predict', methods=['POST'])
# def predict():
#     print("📩 Received frame", flush=True)

#     image_data = base64.b64decode(request.get_json()['image'])
#     frame = cv2.imdecode(np.frombuffer(image_data, np.uint8), cv2.IMREAD_COLOR)

#     frame = feature_extractor.run_feature_extractor_single_frame(frame, data)
#     print(f"👉 Queue tail: {data.get_queue_tail()}", flush=True)

#     if data.get_queue_tail() == 20:
#         print(f"✅ Predicting now", flush=True)

#         frame_features, frame_mask, _ = feature_extractor.process_clip(data)
#         frame_mask2 = frame_mask[np.newaxis, :]
#         frame_features2 = frame_features[np.newaxis, :, :]

#         pred = loaded_model.predict([frame_features2, frame_mask2])[0]
#         confidence = np.max(pred)
#         predicted_class = np.argmax(pred)

#         if confidence > 0.8:
#             predicted_sign = CLASS_LIST[predicted_class]
#         else:
#             predicted_sign = "Nothing"

#         print(f"🧠 Prediction: {predicted_sign} ({confidence:.2f})", flush=True)
#     else:
#         predicted_sign = "Waiting..."

#     return jsonify({'prediction': predicted_sign})


# @app.route('/reset', methods=['POST'])
# def reset():
#     global data
#     data.reset_queue()
#     print("🔁 Queue reset!", flush=True)
#     return jsonify({'status': 'reset'})


# if __name__ == '__main__':
#     print("✅ Flask server starting on 0.0.0.0:5000", flush=True)
#     app.run(host='0.0.0.0', port=5000)

from flask import Flask, Response
from flask_cors import CORS
import cv2
import numpy as np
from keras.models import model_from_json
from utilities.holistic_feature_extractor import HolisticFeatureExtractor
from utilities.holistic_feature_data import HolisticData
import time
import threading

app = Flask(__name__)
CORS(app)

# Load model
model_weights_file = "model/model_weights_100_holistic_features_cropped_OOP2.h5"
model_json_file = "model/model_100_holistic_features_cropped_OOP2.json"

with open(model_json_file, "r") as json_file:
    loaded_model_json = json_file.read()
    loaded_model = model_from_json(loaded_model_json)
    loaded_model.load_weights(model_weights_file)
    loaded_model.make_predict_function()

# Load classifier labels
CLASS_LIST = ["accident", "africa", "all", "apple", "basketball", "bed", "before", "bird",
              "birthday", "black", "blue", "book", "bowling", "brown", "but", "can", "candy",
              "chair", "change", "cheat", "city", "clothes", "color", "computer", "cook", "cool",
              "corn", "cousin", "cow", "dance", "dark", "deaf", "decide", "doctor", "dog", "drink",
              "eat", "enjoy", "family", "fine", "finish", "fish", "forget", "full", "give", "go",
              "graduate", "hat", "hearing", "help", "hot", "how", "jacket", "kiss", "language",
              "last", "later", "letter", "like", "man", "many", "medicine", "meet", "mother",
              "need", "no", "now", "orange", "paint", "paper", "pink", "pizza", "play", "pull",
              "purple", "right", "same", "school", "secretary", "shirt", "short", "son", "study",
              "table", "tall", "tell", "thanksgiving", "thin", "thursday", "time", "walk", "want",
              "what", "white", "who", "woman", "work", "wrong", "year", "yes"]

# Init extractor and queue
feature_extractor = HolisticFeatureExtractor()
data = HolisticData(26)

camera = None
latest_prediction = "Nothing"
running = False

def prediction_loop():
    global camera, data, latest_prediction, running
    running = True
    if camera is None:
        camera = cv2.VideoCapture(0)

    while running:
        success, frame = camera.read()
        if not success:
            continue

        frame = feature_extractor.run_feature_extractor_single_frame(frame, data)

        if data.get_queue_tail() == 25:
            frame_features, frame_mask, _ = feature_extractor.process_clip(data)
            frame_mask2 = frame_mask[np.newaxis, :]
            frame_features2 = frame_features[np.newaxis, :, :]
            pred = loaded_model.predict([frame_features2, frame_mask2])[0]
            confidence = np.max(pred)
            predicted_class = np.argmax(pred)

            if confidence > 0.8:
                latest_prediction = CLASS_LIST[predicted_class]
            else:
                latest_prediction = "Nothing"

        # ✅ Show preview
        # cv2.putText(frame, latest_prediction, (25, 25), cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 255, 0), 2)
        cv2.imshow("ASL Sign Detection", frame)

        # Close on pressing Q
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    print("🛑 Stopping preview...")
    camera.release()
    cv2.destroyAllWindows()


@app.route("/start", methods=["GET"])
def start_prediction():
    # Start background thread once
    global running
    if not running:
        threading.Thread(target=prediction_loop, daemon=True).start()

    # Now stream predictions to Flutter
    def stream_predictions():
        while True:
            yield f"data: {latest_prediction}\n\n"
            time.sleep(0.1)

    return Response(stream_predictions(), mimetype='text/event-stream')

@app.route('/reset', methods=['POST'])
def reset():
    global data
    data.reset_queue()
    print("🔁 Queue reset!", flush=True)
    return {'status': 'reset'}

@app.route('/stop', methods=['POST'])
def stop_prediction():
    global running
    running = False
    print("🛑 Prediction stopped by Flutter")
    return {'status': 'stopped'}

if __name__ == "__main__":
    print("✅ Flask server running on http://0.0.0.0:5000", flush=True)
    app.run(host="0.0.0.0", port=5000, threaded=True)
