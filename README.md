# App notification updates from jira by jql

1. tickets from jira
2. search by jql
3. request POST search
4. response contains  id summary date of update
5. vlang
6. console app
7. settings in application.yaml
8. make request search each 3 min and returns list of tickets updated from last check if exists
9. storing last date of update


3.1. POST search
```shell
curl -XPOST 'https://jira.com/rest/api/2/search' \
--header 'Authorization: Bearer XXXXXXXXXXXYYYYYYYYYYYYYYYYYZZZZZZZZZZZZZZ' \
--data '{
    "jql": "project = PROJ AND resolution = Unresolved AND assignee in (user_name) ORDER BY priority DESC, updated DESC",
    "startAt": 0,
    "maxResults": 15,
    "fields": [
        "summary",
        "status",
        "assignee",
        "updated"
    ]
}'
```

7.1. setings application.yaml
1. search group
2. search name, example 'assigned to me'
3. query, fields, maxResults, frequency
4. in fields: `summary`, `updated` madatpry. app adds them automatically
5. maxResults = 15 by default
6. frequency, mesured in sec

Example:
```yaml
search:
  - name: 'Assigned to me'
    frequency: 60s
    query: project = PSUPCLFRM AND resolution = Unresolved AND assignee in (user_id) ORDER BY priority DESC, updated DESC
    fields:
      - summary
      - updated
      - status
      - assignee
    maxResults: 15

```
