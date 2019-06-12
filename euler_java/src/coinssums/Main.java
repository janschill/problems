package coinssums;

public class Main
{
	static int target = 200;
	static int ways = 0;

	public static void main(String[] args)
	{

		System.out.println(bruteforce());
		System.out.println(array()[array().length - 1]);

	}

	public static int bruteforce()
	{
		for (int a = target; a >= 0; a -= 200)
		{
			for (int b = a; b >= 0; b -= 100)
			{
				for (int c = b; c >= 0; c -= 50)
				{
					for (int d = c; d >= 0; d -= 20)
					{
						for (int e = d; e >= 0; e -= 10)
						{
							for (int f = e; f >= 0; f -= 5)
							{
								for (int g = f; g >= 0; g -= 2)
								{
									ways++;
								}
							}
						}
					}
				}
			}
		}
		return ways;
	}

	public static int[] array()
	{
		int[] coinSizes =
		{ 1, 2, 5, 10, 20, 50, 100, 200 };
		int[] ways = new int[target + 1];
		ways[0] = 1;

		for (int i = 0; i < coinSizes.length; i++)
		{
			for (int j = coinSizes[i]; j <= target; j++)
			{
				ways[j] += ways[j - coinSizes[i]];
			}
		}
		return ways;
	}
}
