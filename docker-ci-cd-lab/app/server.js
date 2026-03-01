// import required modules
const express = require('express')
// create the express app
const app = express()

app.get('/', (req, res) => {
    res.send('Hello from Express')
})
// start listening on a port
app.listen(3000, () => {
    console.log('The server is running')
})