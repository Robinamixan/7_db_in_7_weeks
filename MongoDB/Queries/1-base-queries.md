# Table of Contents
1. [Base queries](#base-queries)
2. [Notes](#notes)
3. [List of main operators for MongoDB commands](#list-of-main-operators-for-mongodb-commands)

# Base queries
`mongosh` - open mongoDB command shell

`mongosh <name>` - open shell for database

`show dbs` - show all databases

`use <name>` - switch database

    # add new document to "towns" collection
    db.towns.insertOne({
        name: "New York",
        population: 22200000,
        lastCensus: ISODate("2016-07-01"),
        famousFor: [ "the MOMA", "food", "Derek Jeter" ],
        mayor : {
            name : "Bill de Blasio",
            party : "D"
        }
    })

`show collections` - show all collections in database

`db.<collection>.find()` - show all documents in collection

`db.help()` - show all functions available for db

`db.towns.help()` - show all functions available for town collection

    # Insert function for adding document to collection
    function insertCity (name, population, lastCensus, famousFor, mayorInfo) {
        db.towns.insertOne({
            name: name,
            population: population,
            lastCensus: ISODate(lastCensus),
            famousFor: famousFor,
            mayor : mayorInfo
        });
    }

    # execute function for adding new document
    insertCity("Punxsutawney", 6200, '2016-01-31', 
    ["Punxsutawney Phil"], { name : "Richard Alexander" })

`db.<collection>.find({"_id": ObjectId("<id>")})` - find specific document by id

`db.<collection>.find({"_id": ObjectId("64088fdf9f682d9d851d3849")}, {name: 1})` - find specific document by id and return with specific field (1 -> return only that field, 0 -> exclude field from return)

    # Find all towns that start with "P" and have population less than 10000
    db.towns.find(
        { name : /^P/, population : { $lt : 10000 } },
        { _id: 0, name : 1, population : 1 }
    )

    #Search subdocuments. Find towns with mayor party = 'D'
    db.towns.find(
        { 'mayor.party' : 'D' },
        { _id : 0, name : 1, mayor : 1 }
    )

`db.<collection>.countDocuments()` - returns total count for collection

    # $elemMatch specifies that if a document (or nested document) matches all
    # of our criteria, the document counts as a match
    db.countries.find(
        {
            'exports.foods' : {
                $elemMatch : {
                    name : 'bacon',
                    tasty : true
                }
            }
        },
        { _id : 0, name : 1 }
    )

    # $or allow to search by 2 conditions with OR mathing
    db.countries.find(
        {
            $or : [
                { _id : "mx" },
                { name : "United States" }
            ]
        },
        { _id:1 }
    )

## Notes
 - New database do not exist until first document added
 - Documents stored as BSON (Binary JSON)
 - Collection do not exist until first document added
 - The ObjectId is always 12 bytes, composed of a timestamp, client machine ID, client process ID, and a 3-byte incremented counter
 - MongoDB commands based on JavaScript, and it is possible to use some features of JS in shell
 - Conditional operators in Mongo follow the format of "field : { $op : value }", where $op is an operation like $ne (not equal to) or $gt (greater than).
  
## List of main operators for MongoDB commands

| Command | Description                                                                                            |
|---------|--------------------------------------------------------------------------------------------------------|
| $regex  | Match by any PCRE-compliant regular expression string (or just use the // delimiters as shown earlier) |
| $ne     | Not equal to                                                                                           |
| $lt     | Less than                                                                                              |
| $lte    | Less than or equal to                                                                                  |
| $gt     | Greater than                                                                                           |
| $gte    | Greater than or equal to                                                                               |
| $exists | Check for the existence of a field                                                                     |
| $all    | Match all elements in an array                                                                         |
| $in     | Match any elements in an array                                                                         |
| $nin    | Does not match any elements in an array                                                                |
| $elem   | MatchMatch all fields in an array of nested documents                                                  |
| $or     | or                                                                                                     |
| $nor    | Not or                                                                                                 |
| $size   | Match array of given size                                                                              |
| $mod    | Modulus                                                                                                |
| $type   | Match if field is a given datatype                                                                     |
| $not    | Negate the given operator check                                                                        |

    
    
    
   
    
    
   