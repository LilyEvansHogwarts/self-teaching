//when multiple a series of matrices, what's the best solution
#include<iostream>
using namespace std;
int a[1000];
int n = 0; 
#define INFTY 2147483647;
void enter()
{
	int temp;
	while (cin >> temp)
	{
		if (temp == 0)
			break;
		a[n++] = temp;
	}
}
void main()
{
	cout << "enter a cloumn of numbers:" << endl;
	enter();
	int right;
	int m = n-1 ;//number of matrix
	int c[10][10];
	int d[10][10];
	int temp;
	int g;
	for (int i = 0; i <= m; i++)
	{
		for (int j = 0; j <= m; j++)
		{
			c[i][j] = 0;
			d[i][j] = 0;
		}
		d[i][i] = 0;
	}
		
	for (int k = 1; k < m; k++)
	{
		for (int left = 1; left <= m - k; left++)
		{
			right = left + k;
			c[left][right] = INFTY;
			for (int j = left; j < right; j++)
			{
				g = a[left - 1] * a[j] * a[right];
				temp = c[left][j] + c[j + 1][right] + g;
				cout << g <<" "<< c[left][j]<<" "<<c[j+1][right]<< endl;
				cout << "c[" << left << "][" << right << "]=" << temp << endl;
				if (temp < c[left][right])
				{
					c[left][right] = temp;
					d[left][right] = j;
				}	
			}
		}
	}
	for (int i = 1; i <= m; i++)
	{
		for (int j = i+1; j <= m; j++)
		{
			cout << c[i][j] << " ";
		}
		cout << endl;
	}
	for (int i = 1; i <= m; i++)
	{
		for (int j = i+1; j <= m; j++)
		{
			cout << d[i][j] << " ";
		}
		cout << endl;
	}
	system("pause");
}
