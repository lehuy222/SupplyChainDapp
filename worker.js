// Listen for messages from the main thread
self.onmessage = async function(event) {
    const { difficulty, action } = event.data;
    let nonce = 0;
    let hash = '';
    const target = Array(difficulty + 1).join('0'); // String with required leading zeros

    // Function to calculate the SHA-256 hash
    async function calculateHash(nonce) {
        const encoder = new TextEncoder();
        const data = encoder.encode(nonce.toString());
        const buffer = await crypto.subtle.digest('SHA-256', data);
        const hashArray = Array.from(new Uint8Array(buffer));
        return hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
    }

    // Perform Proof of Work
    while (hash.substring(0, difficulty) !== target) {
        nonce++;
        hash = await calculateHash(nonce);
    }

    // Post result back to main thread with action
    self.postMessage({ nonce: nonce, action: action });
};
