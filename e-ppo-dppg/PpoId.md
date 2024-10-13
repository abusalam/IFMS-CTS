## Sample1>

Send JSON Data

```json
{ "dataInfo": { "ppo_no": "ALP/S/S/8841F" } }
```

Response

```json
{
  "result": {
    "ppo_no": "ALP/S/S/8841F",
    "status": "S",
    "penname": "JAYANTI BERA (F)",
    "ppo_type": "F",
    "ppo_id": "1513",
    "int_treasury_code": "03001"
  }
}
```

## Sample 2>

Send JSON Data

```json
{ "dataInfo": { "ppo_no": "ALP/S/S/8841F" } }
```

Response

```json
{
  "result": {
    "ppo_no": "ALP/S/P/13111",
    "status": "S",
    "penname": "KAMALA RANI SEAL",
    "ppo_type": "N",
    "ppo_id": "5364",
    "int_treasury_code": "03004"
  }
}
```

## Sample 3>

Send JSON Data

```json
{ "dataInfo": { "ppo_no": "ALP/S/S/8841F" } }
```

Response

```json
{
  "result": {
    "ppo_no": "ZIL/Z/WMD/K/00007/2016",
    "status": "S",
    "penname": "KUSHADWAJ DAS",
    "ppo_type": "N",
    "ppo_id": "11130",
    "int_treasury_code": "13005"
  }
}
```

## Sample 4>

Send JSON Data

```json
{ "dataInfo": { "ppo_no": "ALP/S/S/8841F" } }
```

> If no record found

Response

```json
{
  "result": {
    "ppo_no": "13010220180031",
    "status": "F",
    "penname": "",
    "ppo_type": "",
    "ppo_id": "",
    "int_treasury_code": ""
  }
}
```
