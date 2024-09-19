INSERT INTO "cts-bank-master".banks (
  id, bank_code, bank_name, is_active) VALUES
  (1, 2, 'State Bank of India', true),
  (2, 3, 'Malda District Central Co-operative Bank', true);
INSERT INTO "cts-bank-master".branchs (
  id, city_code, bank_code, branch_code, micr_code, branch_name, address, city_name, pincode, state, is_active) VALUES
  (2, 732, 2, 531, '732002531', 'PUKURIA MORE', 'VILLAGE, PUKHURIA MORE PS: PUKHURIA, POST OFFICE: ARAIDANGA, PO & DISTRICT MALDA', 'MALDA', '732204', 'West Bengal', true),
  (3, 700, 2, 746, '700002746', 'sbiINTOUCH SARAT BOSE ROAD', '88A, SARAT BOSE ROAD KOLKATA, PIN-700026', 'KOLKATA', '700026', 'West Bengal', true),
  (4, 732, 3, 531, '732002531', 'PUKURIA MORE', 'VILLAGE, PUKHURIA MORE PS: PUKHURIA, POST OFFICE: ARAIDANGA, PO & DISTRICT MALDA', 'MALDA', '732204', 'West Bengal', true),
  (5, 700, 3, 746, '700002746', 'MDCCB INTOUCH SARAT BOSE ROAD', '88A, SARAT BOSE ROAD KOLKATA, PIN-700026', 'KOLKATA', '700026', 'West Bengal', true);