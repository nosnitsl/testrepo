select fq.[Year], 
fq.[Month], 
fq.[Item_Number], 
fq.[Old_Item_Number], 
fq.[Quoted_Unit_Price], 
fq.[Quantity_Quoted], 
fq.[Full_Quote_Number], 
fq.[Last_Order_Number], 
fq.[Line_Number],
fq.Quantity_Ordered,
fq.Quantity_Shipped,
fq.Total_Quantity_Shipped,
fq.[Load_Date]
from (select  [Year], 
[Month], 
[Item_Number], 
[Old_Item_Number], 
[Quoted_Unit_Price], 
[Quantity_Quoted], 
[Full_Quote_Number], 
[Last_Order_Number], 
[Line_Number], 
[Last_Ship_To], 
[Last_Order_Date], 
[Address_Code], 
[Quote_Header_key], 
[Load_Date],
COUNT (*) as amt
FROM [dbo].[Fact_Quote_Detail]
GROUP BY 
  [Year], 
[Month], 
[Item_Number], 
[Old_Item_Number], 
[Quoted_Unit_Price], 
[Quantity_Quoted], 
[Full_Quote_Number], 
[Last_Order_Number], 
[Line_Number], 
[Last_Ship_To], 
[Last_Order_Date], 
[Address_Code], 
[Quote_Header_key], 
[Load_Date]
HAVING COUNT (*) >= 2) as dups, fact_quote_detail fq, Fact_Order_Detail fo
where fq.Full_Quote_Number = dups.Full_Quote_Number
and fq.Line_Number = dups.Line_Number
and fq.Last_Order_Number = dups.Last_Order_Number
and fq.Last_Order_Number = fo.Order_Number
and fq.Line_Number = fo.Line_Number
order by Full_Quote_Number