# Flutter-WMS
Ware House Management System with Flutter.
You can create store, shelf , products.

UsedTech : MVVM, Riverpod, Mobx, Firebase...

Store Properties:
  storeName (String)
  capacity (int)
  machines => TCP/IP MODBUS CLIENT COMMUNICATION
    - YOUR PLC MACHINE 
      - IP ADDRESS (String)
      - PORT (String)
      - PLC NAME (String)
  shelfs

Shelf Properties
  isUseable(bool) =sometimes shelf hast to be locked.
  sheflName (String)
  capacity (int)
  products
  shelfBarcode (String)

Product Properties
  Brand (String)
  Type (String)
  Barcode (String) for query
  Name (String)
  Quanity (int)
  Category (String)
  
  

