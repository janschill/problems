package fibonacci1000digits;

public class Fibonacci
{
	private int i;
	private long a;

	public Fibonacci(int i)
	{
		this.i = i;

	}

	public long getFibonacci()
	{
		a = fibo(i);
		return a;
	}

	public int fibo(int n)
	{
		if (n == 0)
			return 0;
		else if (n == 1)
			return 1;
		return fibo(n - 1) + fibo(n - 2);
	}

	public int length()
	{
		long b = a;
		int count = 0;
		while (b >= 1)
		{
			b = b / 10;
			count++;
		}
		return count;
	}
}
