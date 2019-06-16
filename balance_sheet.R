library("finreportr")

# Get Companies from the csv file
csv <- read.csv("constituents_csv.csv", header=TRUE)
constituents_df <- as.data.frame(csv)
# Make vector of all ymbols
constituents_vector = as.vector(constituents_df[,1])  

# Iterate through all companies in the vector
for (company in constituents_vector)  
{	
	print(company)
	# Iterate through the last 5 yeras
	for (year in c(2014,2015,2016,2017,2018))  
	{
		print(year)
		# Get blcome by calling the function of finretortr
		blc <- GetBalanceSheet(company, year)
		# Make a dataframe and extract the needed rows
		blc_df <- data.frame(blc)  
		blc_df <- (subset(blc_df, Metric == "Cash and Cash Equivalents, at Carrying Value" | Metric == "Accounts Receivable, Net, Current" | Metric == "Inventory Net" | Metric == "Assets Current" | Metric == "Property Plant And Equipment" | Metric == "Assets" | Metric == "Accounts Payable, Current" | Metric == "Accrued Liabilities, Current" | Metric == "Deferred Revenue, Current" | Metric == "Deferred Revenue, Current" | Metric == "Liabilities, Current" | Metric == "Convertible Notes Payable" | Metric == "Convertible Long Term Notes Payable" | Metric =="Liabilities" | Metric == "Retained Earnings Accumulated Deficit" | Metric == "Stockholders' Equity Attributable to Parent"))
		str1=year-1 
		str4="-12-31"
		str5=paste(str1,str4,sep="")
		blc_df <- subset(blc_df, endDate == str5)

		#  Check if the dataframe is empty, if yes skip to next iteratio, else add another column named Company and add the name of the company
		if(dim(blc_df)[1] == 0)
		{
			next
		}
		else
		{
			blc_df <- cbind(Company = company,blc_df)
		}
		#  Save the dataframe to .csv file
		write.table(blc_df, "balance_sheets.csv", sep = ",", col.names = !(file.exists("balance_sheets.csv")), append = T, row.names=FALSE, quote=FALSE)
	}
}