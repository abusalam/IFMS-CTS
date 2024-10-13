# Data transfer process for e-Pension to IFMS

Authentication Process in Web-Service:

URL details :

> (Use for PPO data sending process)\
> https://wbifms.gov.in/gws/oauth2/api/auth/token/eppo/dppg/{#}/{##}

> (Use for PPO withdrawal process)\
> https://wbifms.gov.in/gws/oauth2/api/auth/token/dppg/dppg/{#}/{##}

{#}: Unique request id generated at client end\
{##} : Current millisecond

> Send JSON (From ePension):

```json
{
  "uId": "dppg",
  "typeId": "10",
  "key": "#"
}
```

> key value should be encrypted use SHA512

Method Type : POST\
Received JSON structure (From IFMS):

```json
{
  "resp": {
    "data": {
      "access_token": "##",
      "client_id": "##",
      "client_type": "##",
      "created_at": 1676030881367,
      "created_rt": 1676030881367,
      "expires_in": 1676032081367,
      "refresh_token": "u29288",
      "token_type": "bearer"
    },
    "genTime": "Fri Feb 10 17:38:01 IST 2023|1676030881626",
    "status": "#"
  }
}
```

> Status value : S - success Or F – Fail\
> both typeId and client_type value are same

# Data Send Process in Web-Service:
Add Api-Client-Id and Api-Access-Token at header part
Value of Api-Client-Id is client_id and Api-Access-Token is access_token.\
When data send occurs Api-Access-Token value should be encrypted use SHA512

## 1 >> Fresh ePPO :
URL:
> Send JSON (From ePension):\
https://wbifms.gov.in/gws/eppo/api/json/eppoapp/dppg/{#}/{##}

Please check the sample data with name “[FreshePPO.txt](Fresh.md)”.

Method Type : POST\
Response JSON (From IFMS):

```json
{
  "result": {
    "application_no": "####",
    "status": "#",
    "error_code": "#"
  }
}
```

> Status value : S - success Or F – Fail

## 2 >> Provisional for Revision ePPO :
URL:
> Send JSON (From ePension):\
https://wbifms.gov.in/gws/eppo/api/json/eppoprov/dppg/{#}/{##}

Please check the sample data with name “[ProvisionalForRevisionePPO.txt](ProvisionalForRevision.md)”.

Method Type : POST\
Response JSON (From IFMS):

```json
{
  "result": {
    "application_no": "####",
    "status": "#",
    "error_code": "#"
  }
}
```

> Status value : S - success Or F – Fail

## 3 >> Final authority for Revision ePPO :
URL:
> Send JSON (From ePension):\
https://wbifms.gov.in/gws/eppo/api/json/eppodppgauth/dppg/{#}/{##}

Please check the sample data with name “[FinalAuthorityForRevisionePPO.txt](FinalAuthorityForRevision.md)”.

Method Type : POST\
Response JSON (From IFMS):

```json
{
  "result": {
    "application_no": "####",
    "status": "#",
    "error_code": "#"
  }
}
```

> Status value : S - success Or F – Fail

## 4 >> Acknowledgement request:
URL:
> Send JSON (From ePension):\
https://wbifms.gov.in/gws/eppo/api/json/eppoack_n/dppg/{#}/{##}

```json
{
  "dataInfo": {
    "application_no": "#####",
    "flag": "#"
  }
}
```

> flag value F (Fresh)/ P (Provisional for Revision)/ R (Final authority for Revision)

Method Type : POST\
Response JSON (From IFMS):

```json
{
  "result": {
    "application_no": "####",
    "status": "#",
    "error_code": "#"
  }
}
```

> Status value : S - success Or F – Fail

## 5 >> PPO ID Details:
URL:
> Send JSON (From ePension):\
https://wbifms.gov.in/gws/eppo/api/json/eppoppoid/dppg/{#}/{##}

```json
{
  "dataInfo": {
    "ppo_no": "#####"
  }
}
```

Method Type : POST\
Response JSON (From IFMS):

```json
{
  "result": {
    "ppo_no": "###",
    "status": "##",
    "penname": "",
    "ppo_type": "",
    "ppo_id": "",
    "int_treasury_code": ""
  }
}
```

> Status value : S - success Or F – Fail

> Sample data with name “[PPOID.txt](PpoId.md)”

## 6 >> eppo withdrawal:

URL:
https://wbifms.gov.in/gws/api/json/eppo.withdrawal/dppg/{#}/{##}

Send JSON (From ePension):

```json
{
  "dataInfo": {
    "application_no": "#####",
    "flag": "#",
    "reason": "####"
  }
}
```

> flag value F (Fresh)/ P (Provisional for Revision)/ R (Final authority for Revision)

> Method Type : POST\
> Response JSON (From IFMS):

```json
{
  "result": {
    "application_no": "####",
    "status": "#",
    "error_code": "#"
  }
}
```

> Status value : E - success Or F – Fail\
> error_code value : -1 = success

> Sample data with name “[eppoWithdrawal.txt](Withdrawl.md)”
