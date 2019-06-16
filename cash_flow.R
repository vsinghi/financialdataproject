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
		blc <- GetCashFlow(company, year)
		# Make a dataframe and extract the needed rows
		cf_df <- data.frame(blc)  
		cf_df <- (subset(cf_df, Metric == "Net Income (Loss) Attributable to Parent" | Metric == "Depreciation and Impairment on Disposition of Property and Equipment" | Metric == "Amortization and Impairment of Intangible and Other Assets" | Metric == "Share-based Compensation" | Metric == "Amortization Of Debt Discount Premium" | Metric == "Increase (Decrease) in Accounts Receivable" | Metric == "Increase Decrease In Inventories And Property Subject To Or Available For Operating Lease" | Metric == "Increase Decrease In Prepaid Revenue Share Expenses And Other Assets" | Metric == "Increase (Decrease) in Accrued Liabilities" | Metric == "Increase (Decrease) in Deferred Revenue" | Metric == "Increase (Decrease) In Deferred Revenue And Customer Advances And Deposits" | Metric == "Net Cash Provided by (Used in) Operating Activities" | Metric == "Payments to Acquire Property, Plant, and Equipment" | Metric =="Net Cash Provided by (Used in) Investing Activities" | Metric == "Repayments Of Long Term Debt" | Metric == "Proceeds From Repayments Of Long Term Debt And Capital Securities" | Metric == "Cash and Cash Equivalents, Period Increase (Decrease)"))
		str1=year-1 
		str2="-01-01"
		str3=paste(str1,str2,sep="")
		str4="-12-31"
		str5=paste(str1,str4,sep="")
		cf_df <- subset(cf_df, startDate == str3 | endDate == str5)

		#  Check if the dataframe is empty, if yes skip to next iteratio, else add another column named Company and add the name of the company
		if(dim(cf_df)[1] == 0)
		{
			next
		}
		else
		{
			cf_df <- cbind(Company = company,cf_df)
		}
		#  Save the dataframe to .csv file
		write.table(cf_df, "cash_flow.csv", sep = ",", col.names = !(file.exists("cash_flow.csv")), append = T, row.names=FALSE, quote=FALSE)
	}
}