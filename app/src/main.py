from fastapi import FastAPI, HTTPException, Request
from fastapi.responses import RedirectResponse, HTMLResponse
import os, hashlib, time
from ddb import put_mapping, get_mapping

app = FastAPI()

@app.get("/", response_class=HTMLResponse)
def home():
    return """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>URL Shortener</title>
        <style>
            body { font-family: sans-serif; padding: 2rem; text-align: center; background: #f9fafb; }
            input, button { padding: 0.6rem; margin: 0.5rem; width: 300px; font-size: 1rem; }
            button { cursor: pointer; background: #2563eb; color: white; border: none; border-radius: 6px; }
            button:hover { background: #1d4ed8; }
            #result { margin-top: 1rem; font-weight: bold; color: #111827; }
        </style>
    </head>
    <body>
        <h1>URL Shortener</h1>
        <input type="url" id="urlInput" placeholder="Enter URL to shorten" />
        <button onclick="shortenUrl()">Shorten</button>
        <div id="result"></div>

        <script>
            async function shortenUrl() {
                const url = document.getElementById('urlInput').value;
                const resultDiv = document.getElementById('result');
                resultDiv.textContent = "Processing...";
                try {
                    const response = await fetch("/shorten", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({ url })
                    });
                    const data = await response.json();
                    if (response.ok) {
                        const shortUrl = `${window.location.origin}/${data.short}`;
                        resultDiv.innerHTML = `Short URL: <a href="${shortUrl}" target="_blank">${shortUrl}</a>`;
                    } else {
                        resultDiv.textContent = data.detail || "Error shortening URL";
                    }
                } catch (err) {
                    resultDiv.textContent = "Failed to contact server.";
                }
            }
        </script>
    </body>
    </html>
    """




@app.get("/healthz")
def health():
    return {"status": "ok", "ts": int(time.time())}

@app.post("/shorten")
async def shorten(req: Request):
    body = await req.json()
    url = body.get("url")
    if not url:
        raise HTTPException(400, "url required")
    short = hashlib.sha256(url.encode()).hexdigest()[:8]
    put_mapping(short, url)
    return {"short": short, "url": url}

@app.get("/{short_id}")
def resolve(short_id: str):
    item = get_mapping(short_id)
    if not item:
        raise HTTPException(404, "not found")
    return RedirectResponse(item["url"])
