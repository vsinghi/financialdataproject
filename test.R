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
		# Get income by calling the function of finretortr
		inc <- GetIncome(company, year)  # Get income by calling the function of finretortr
		# Make a dataframe and extract the needed rows
		inc_df <- data.frame(inc)  
		inc_df <- (subset(inc_df, Metric == "Revenues" | Metric == "Cost of Goods Sold" | Metric == "Cost of Services" | Metric == "Gross Profit" | Metric == "Research and Development Expense" | Metric == "Selling General And Administrative Expense" | Metric == "Operating Income Loss/ Profit" | Metric == "Earnings Per Share Basic And Diluted" | Metric == "Weighted Average Number Of Share Outstanding Basic And Diluted"))
		str1=year-1 
		str2="-01-01"
		str3=paste(str1,str2,sep="")
		str4="-12-31"
		str5=paste(str1,str4,sep="")
		inc_df <- subset(inc_df, startDate == str3 | endDate == str4)

		#  Check if the dataframe is empty, if yes skip to next iteratio, else add another column named Company and add the name of the company
		if(dim(inc_df)[1] == 0)
		{
			next
		}
		else
		{
			inc_df <- cbind(Company = company,inc_df)
		}
		#  Save the dataframe to .csv file
		write.table(inc_df, "income_statement.csv", sep = ",", col.names = !(file.exists("income_statement.csv")), append = T, row.names=FALSE, quote=FALSE)
	}
}