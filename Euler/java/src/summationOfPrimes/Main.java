package summationOfPrimes;

public class Main
{

	public static void main(String[] args)
	{
		long sum = 0;
		int x = 2000000;
		int count = 1;
		for (int i = 2; i < x; i++)
		{
			if (isPrime(i))
			{
				sum += i;
				System.out.println(count + " p: " + i + " s: " + sum);
				count++;

			}
		}
	}

	static boolean isPrime(int n)
	{
		if (n == 2)
		{
			return true;
		}
		if (n % 2 == 0)
			return false;
		for (int i = 3; i * i <= n; i += 2)
		{
			if (n % i == 0)
				return false;
		}
		return true;
	}

}
