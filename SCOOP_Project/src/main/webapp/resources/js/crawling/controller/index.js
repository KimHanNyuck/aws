const { request, cheerio, express } = require('../lib/modules')



let controller = {
    start: () => {
        controller.restApi()
        console.log('start')
    },
    getBody: (options, callback) => {
        request(options, (err, res, body) => {
            if(err) {
                console.log(`request own error`)
                console.log(err)
                callback(false)
            }
            else {
                try {
                    callback(body)
                } catch (error) {
                    console.log(`request try/catch error`)
                    console.log(error)
                    callback(false)
                }
            }
        })
    },
    convertCheerio: (body, callback) => {
        let $ = cheerio.load(body)
        let title1 = $('head > meta[property="og:title"]').attr('content')
        let image = $('head > meta[property="og:image"]').attr('content')
        let url = $('head > meta[property="og:url"]').attr('content')
        let title2 = $('head > title').text()
        let gimage = $('head > meta[itemprop="image"]').attr('content')
        
        console.log(title1)
        console.log(image)
        console.log(url)
        console.log(title2)

        if(title1 !== null && title1 !== undefined){
            title = title1
        }else{
            title = title2
        }
        
        if(title == 'YouTube'){
            image = 'http://www.youtube.com/'+image
            url = 'http://www.youtube.com'
        }else if(title.indexOf('Google') != -1){
            image = 'http://www.google.com/'+gimage
        }else if(title == null || title == undefined || title == ''){
            title = '제목 없음'
        }

        let data = {
            title: title,
            img: image,
            url: url
        }
        callback(data)
    },
    restApi: (req, res) => {
        let app = express()
        let getUrl = "";
        app.use(function(req, res, next) {
            res.header("Access-Control-Allow-Origin", "*");
            res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
            next();
        });

        app.listen(8091, () => {
            console.log('Listening on port : 8091')
        })

        app.get('/index', function(req, res){
            
            getUrl = req.param('url')
            let resultData = {
                message: ''
            }
            if(getUrl.indexOf('http') < 0 && getUrl !== null){
                getUrl = 'http://' + getUrl
            }else if(getUrl === null || getUrl === undefined){
                res.status(400).end()
            }
            let options = {
                url: getUrl,
                method: 'GET',
                timeout: 3000
            }
            controller.getBody(options, (result) => {
                controller.convertCheerio(result, (data) => {
                    let resData = data
                    if(getUrl !== null && getUrl !== undefined){
                        resultData.message = resData
                        res.setHeader('Content-Type','application/json')
                        res.json(resultData)
                    }else{
                        res.status(400).end()
                    }
                })
                
            })

            
        })
    }
}

module.exports = controller