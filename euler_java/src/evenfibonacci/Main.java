package evenfibonacci;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.Map;

public class Main
{
	private static Map<Integer, BigInteger> memo = new HashMap<>();

	public static void main(String[] args)
	{
		final int FOUR = 4000000;
		int sum = 0;

		for (int i = 0; fibo(i) < FOUR; i++)
		{
			if (fibo(i) % 2 == 0)
			{
				sum = sum + fibo(i);
			}
		}

		System.out.println(sum);
	}

	public static int fibo(int n)
	{
		if (n == 0)
			return 0;
		else if (n == 1)
			return 1;
		return fibo(n - 1) + fibo(n - 2);
	}

}
