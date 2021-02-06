Hello there!

This app is my resume as an iOS application and it will soon be available on the appstore.
EDIT: The app has been rejeced "because it seems to be intended for a small, or niche, set of users" and "your app is intended to be like sort of CV and something like that isn’t suitable for the store".

It fetches informations from a remote JSON file so if you want the same application for your resume you can just clone the repository, change the urls to fetch (in API.swift) for the JSON and optionally your CV as PDF.  It is very important that your JSON respects the structure below, juste take it and just replace the informations according to your profile.

# Screenshots
![](https://cv-pool-bucket.s3.eu-west-3.amazonaws.com/arthurkleiber/screenshots/app/1.PNG)  |  ![](https://cv-pool-bucket.s3.eu-west-3.amazonaws.com/arthurkleiber/screenshots/app/2.PNG) | ![](https://cv-pool-bucket.s3.eu-west-3.amazonaws.com/arthurkleiber/screenshots/app/3.PNG)

# How to run
Clone the repository and run at the root of the directory:
```
pod install
```
Ready to run!

# JSON structure

```json
{
    "personal": {
        "firstName": "",
        "lastName": "",
        "jobTitle": "Full Stack Engineer",
        "biography": "your biography",
        "photo": "https://link_to_your_image.jpg",
        "city": "Paris",
        "contact": {
            "phone": "+336 00 00 00 00",
            "email": "arthur.kleiber@epitech.eu"
        },
        "socialNetworks": [
            {
                "name": "linkedin",
                "link": "https://linkedin.com/in/arthurkleiber"
            },
            {
                "name": "github",
                "link": "https://github.com/FakeAK"
            }
        ]
    },
    "experiences": [
        {
            "id": 1,
            "from": "2020-05-12",
            "to": "2021-04-01",
            "jobTitle": "Full Stack Engineer",
            "description": "job description",
            "company": {
                "name": "company name",
                "activity": "IT",
                "website": "https://website.com",
                "logo": "https://company_logo.jpg"
            },
            "tasksDone": [
                "Development from sratch of the Jervis iOS application using Swift 5, Combine (Reactive Programming), Realm (internal database), MVVM & VIPER (architectures), Cocoapods (for depencencies), Firebase Crashlytics (crash analytics) and Fastlane.",
                "Development of new features on the Jervis webapp (ex PlugR) using VueJS.",
                "Development of new microservices as well as new features on those already existing using NodeJS (Typescript), ElasticSearch (search engine), Redis (cache), Puppeteer (data scraping).",
                "Development of data scrapers using Puppeteer (Typescript) to scrap open and non-open data from the French National Assembly and Senate.",
                "Bug fixes on the Jervis webapp.",
                "Bug fixes on the Jervis APIs.",
                "Writing of unit tests on the APIs using Mocha, Chai and Supertest.",
                "Writing of CI/CD pipelines using Bitbucket Pipeline to deploy microservices on AWS (ECS, ECR, EC2 & Lambda).",
                "Adding new microservices (in staging and production environments) using AWS (ECS, ECR, EC2, Lambda, API Gateway, RDS, ELB, S3, IAM, SQS, Elasticsearch Service, Route 53 etc)."
            ],
            "technologiesUsed": [
                "Swift 5",
                "NodeJS",
                "Javascript",
                "Typescript",
                "Express (framework)",
                "AWS",
                "Puppeteer (scraping)",
                "Redis (cache)",
                "ElasticSearch (search engine)"
            ],
            "screenshots": [
                {
                    "axis": "vertical",
                    "links": [
                        "https://vertical-screenshot-link.png"
                    ]
                },
                {
                    "axis": "horizontal",
                    "links": [
                        "https://horizontal-screenshot-link.png"
                    ]
                }
            ]
        }
    ]
}
```
