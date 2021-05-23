# Queries

Queries allow the user to search for models of interest. Queries are initiated from the [ModelService](model-service.md) via the `query()` method. The method takes a query syntax similar to SQL. Presently only a `SELECT` statement is supported. The `SELECT` statement grammar is as follows:

```sql
SELECT [ * ] 
  [ FROM <Collection> ]
  [ WHERE <Condition>* ]
  [ ORDER BY (<Field> [ ASC|DESC ])* ]
  [ LIMIT <MaxRecords> ]
  [ OFFSET <SkipRecords> ]
```

## API

The `query()` method asynchronously returns the set of models matching the query via a promise.  The result of the query is an array of `ModelResult` objects which contain metadata describing the matching models.  Each object contains the matched model's `collectionId` and `modelId`, allowing you to open if so desired.

```js
const query = modelService
  .query("SELECT * FROM employees WHERE employeeId = '1001'")
  .then(results => {
    results.data.forEach(result => console.log(result));
  });
```

The `ModelResult` class exports several public properties:

```javascript
class ModelResult {
  collectionId: string;
  modelId: string;
  created: Date;
  modified: Date;
  version: number;
  data: {[key: string]: any}
}
```

From the data in ModelResult class models can be opened from the `ModelService` if needed.


## Conditional Expressions

Conditional expressions are used in the `WHERE` clause to narrow the search results. They are made up of fields and operators. Examples are shown below:


### Conditional Operator
| Operator | Name | Example |
| --- | --- | --- |
| = | Equals | length = 5 |
| != | Not Equal | length != 0 |
| > | Greater Than | age > 21 |
| < | Less Than | length < 1 |
| >= | Greater Than or Equal To | age >= 21 |
| <= | Less Than of Equal To | age <= 21 |
| IN | In | firstName IN ["bob", "alice"] |
| LIKE | Like | lastName LIKE '%smith' |

### Logical Operators

| Operator | Name | Example |
| --- | --- | --- |
| AND | And | firstName = 'bob' AND lastName = 'smith' |
| OR | Or | firstName = 'bob' or firstName = 'alice' | 
| NOT | Not | NOT(firstName = 'bob' ) |

### Mathematical Operators
| Operator | Name | Example |
| --- | --- |
| + | Add | height = width * 2 |
| - | Subtract | length = width - 10 |
| * | Multiply | x2 = x * x |
| / | Divide | x = 1 / 2 |
| % | Modulo | remainder = 10 % 2 |


## SELECT Examples

* `SELECT * FROM employees WHERE employeeId = 1 AND NOT(manager = true)`
* `SELECT * FROM customer WHERE lastName LIKE %smith%`
* `SELECT * FROM person WHERE age > 21 ORDER BY lastName DESC`