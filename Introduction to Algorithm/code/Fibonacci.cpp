//a good way to get Fibonacci sequence
#include<iostream>
using namespace std;
void main()
{
	int N;
	cout << "enter a number:"<<endl;
	cin >> N;
	int a[50];
	a[0] = 1;
	a[1] = 1;
	for (int i = 2; i <= N; i++)
	{
		a[i] = a[i - 1] + a[i - 2];
	}
	cout << a[N] << endl;
	system("pause");
}
