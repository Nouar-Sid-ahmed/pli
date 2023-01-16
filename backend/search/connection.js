const elasticsearch = require('elasticsearch')

// Core ES variables for this project
const index = 'library'
const type = 'novel'
const port = 9200
const host = process.env.ES_HOST || 'localhost'
const client = new elasticsearch.Client({ host: { host, port } })

async function checkConnection () {
    let isConnected = false
    while (!isConnected) {
        console.log('Connecting to ES')
        try {
            const health = await client.cluster.health({})
            console.log(health)
            isConnected = true
        } catch (err) {
            console.log('Connection Failed, Retrying...', err)
        }
    }
}
async function resetIndex () {
    if (await client.indices.exists({ index })) {
        await client.indices.delete({ index })
    }
    await client.indices.create({ index })
    await putvideoMapping()
}

async function putvideoMapping () {
    const schema = {
        // title: { type: 'keyword' },
        // author: { type: 'keyword' },       mappé nos data
        // location: { type: 'integer' },
        // text: { type: 'text' }
    }
    return client.indices.putMapping({ index, type, body: { properties: schema } })
}
checkConnection()

module.exports = {
    client, index, type, checkConnection, resetIndex
}