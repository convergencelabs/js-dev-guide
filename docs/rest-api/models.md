# REST API: Real Time Models

One of the most common use cases for the REST API is working with individual [real time models](/models/overview.md) directly.  

All queries must be [authorized](/rest-api/overview.md).


## Creating a RealTimeModel

To create a new model with a system-generated ID: 

```
POST {{convergenceRestUrl}}/domains/{{namespace}}/{{domainId}}/models
{
  "collection": "test-collection",
  "data": {
    "key": "value"
  }
}
```

results in the response:

```
{
    "body": {
        "id": "89d1e6fc-faa2-4304-a341-fd42efa7fd3d"
    },
    "ok": true
}
```

To create a new model with a known ID:

```
PUT {{convergenceRestUrl}}/domains/{{namespace}}/{{domainId}}/models/{{modelId}}
{
  "collection": "test-collection",
  "data": {
    "key": "value"
  }
}
```

Note that it is currently not possible to assign model permissions at the time of creation.  See the [permissions](#Model Permissions) section below to update the model's permissions after it is created.


## Querying a model's contents

```
GET {{convergenceRestUrl}}/domains/{{namespace}}/{{domainId}}/models/{{modelId}}
```

Were `modelId` the ID returned from the previous POST, the result would be:

```
{
    "body": {
        "id": "89d1e6fc-faa2-4304-a341-fd42efa7fd3d",
        "collection": "test-collection",
        "version": 1,
        "createdTime": 1571693445435,
        "modifiedTime": 1571693445435,
        "data": {
            "key": "value"
        }
    },
    "ok": true
}
```

If only the model's metadata is desired, a slightly more performant query is:

```
GET {{convergenceRestUrl}}/domains/{{namespace}}/{{domainId}}/models/{{modelId}}?data=false
```
which would omit the `data` attribute of the previous response.


## Updating a model

```
PUT {{convergenceRestUrl}}/domains/{{namespace}}/{{domainId}}/models/{{modelId}}
{
  "collection": "test-collection",
	"data": {
		"key": "newValue"
	}
}
```
results in the default success response.


## Deleting a model

```
DELETE {{convergenceRestUrl}}/domains/{{namespace}}/{{domainId}}/models/{{modelId}}
```
results in the default success response.


# Model Permissions

Any real-world application will require customized access control.  See [here](/models/permissions.md) for an explanation of the various model permissions that are possible.


## Setting world permissions

```
PUT {{convergenceRestUrl}}/domains/{{namespace}}/{{domainId}}/models/{{modelId}}/permissions/world
{
  "read":true,
  "write":false,
  "remove":false,
  "manage":false
}
```
results in the default success response.


## Overriding the model's collection's permissions

```
PUT {{convergenceRestUrl}}/domains/{{namespace}}/{{domainId}}/models/{{modelId}}/permissions/override
{
  "overrideWorld":true
}
```
results in the default success response.


## Setting per-user model permissions

```
PUT {{convergenceRestUrl}}/domains/{{namespace}}/{{domainId}}/models/{{modelId}}/permissions/user/{{userId}}
{
  "read":true,
  "write":true,
  "remove":false,
  "manage":false
}
```
results in the default success response.


## Getting a model's current permissions

```
GET {{convergenceRestUrl}}/domains/{{namespace}}/{{domainId}}/models/{{modelId}}/permissions
```

which, for the examples above, would return something like

```
{
    "body": {
        "overrideWorld": true,
        "worldPermissions": {
            "read": true,
            "write": false,
            "remove": false,
            "manage": false
        },
        "userPermissions": [{
            "userId": {
              "userType":{},
              "username":"jimbo"
            },
            "permissions": {
                "read":true,
                "write":true,
                "remove":false,
                "manage":false
            }
        }]
    },
    "ok": true
}
```