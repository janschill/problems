package fibonacci1000digits;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.Map;

public class Main
{
	static long longA;
	static BigInteger bigA;
	private static Map<Integer, BigInteger> memo = new HashMap<>();
	static final int DIGITS = 4782;

	public static void main(String[] args)
	{
		// Fibonacci fibo = new Fibonacci(50);
		// System.out.println(fibo.getFibonacci());
		// System.out.println(fibo.length());

		double startTime = System.currentTimeMillis();
		
		int a = 10000;
		// longA = fibo(a);
		bigA = fibo2(a);
		

		double endTime = System.currentTimeMillis();
		double totalTime = endTime - startTime;

		System.out.println(totalTime / 1000 + "s");
		System.out.println("Fibonacci(" + a + ") = " + bigA);
		System.out.println("Number of digits: " + bigA.toString().length());

	}

	public static BigInteger fibo2(int n)
	{
		if (n == 0 || n == 1)
		{
			return BigInteger.ONE;
		}
		if (memo.containsKey(n))
		{
			return memo.get(n);
		}
		BigInteger v = fibo2(n - 2).add(fibo2(n - 1));
		memo.put(n, v);
		return v;
	}

	public static long fibo(int n)
	{
		if (n == 0)
			return 0;
		else if (n == 1)
			return 1;
		return fibo(n - 1) + fibo(n - 2);
	}

	public static int length()
	{
		long c = longA;
		int count = 0;
		while (c >= 1)
		{
			c = c / 10;
			count++;
		}
		return count;
	}

}
