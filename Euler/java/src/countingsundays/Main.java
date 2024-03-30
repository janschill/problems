package countingsundays;

/**
 * How many Sundays fell on the first of the month during the twentieth century
 * (1 Jan 1901 to 31 Dec 2000)?
 * 
 * 1 Jan 1900 was a Monday.
 * 
 * 30 days has September, April, June, November.
 * 
 * 31 days has January, March, May, July, August, October, December.
 * 
 * 28 days February.
 * 
 * 29 days February on a leap year.
 * 
 * Leap year occurs on any year evenly divisible by 4, but not on a century
 * unless it is divisible by 400.
 * 
 * @author janschill
 */

public class Main
{

	public static void main(String[] args)
	{
		int count = 0, days_in_month, days_passed = 1;

		for (int i = 1901; i <= 2000; i++)
		{
			for (int j = 1; j <= 12; j++)
			{
				if (j == 4 || j == 6 || j == 9 || j == 11)
				{
					days_in_month = 30;
				} else if (j == 2)
				{
					if (i % 400 == 0 || (i % 4 == 0 && i % 100 != 0))
					{
						days_in_month = 29;
					} else
					{
						days_in_month = 28;
					}
				} else
				{
					days_in_month = 31;
				}
				if (days_passed % 7 == 0)
				{
					count++;
				}
				days_passed += days_in_month;
			}
		}
		System.out.println(count-1);
	}
}
