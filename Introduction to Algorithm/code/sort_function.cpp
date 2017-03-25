//insertion_sort/merge_sort/quick_sort/heap_sort
#include<iostream>
using namespace std;
int a[1000];
int n = 0;
void enter()
{
	int temp;
	while (cin >> temp)
	{
		if (temp == 0)
			break ;
		a[n++] = temp;
	}
}
//insert_sort
void insert_sort()
{
	int key;
	int j;
	for (int i = 1; i < n; i++)
	{
		key = a[i];
		j = i-1;
		while (a[j]>key && j>=0)
		{
			a[j+1] = a[j];
			j--;
		}
		a[j+1] = key;
	}		
}
//merge_sort
void msort(int begin, int middle, int end)
{
	int i = begin;
	int j = middle + 1;
	int b[1000];
	int m = begin;
	while (i <= middle && j <= end)
	{
		if (a[i] < a[j])
			b[m++] = a[i++];
		else
			b[m++] = a[j++];
	}
	while (i <= middle)
		b[m++] = a[i++];
	while (j <= end)
		b[m++] = a[j++];
	for (int k = begin; k <= end; k++)
		a[k] = b[k];
}
void merge_sort(int begin, int end)
{
	int middle;
	if (begin < end)
	{
		middle = (begin + end) / 2;
		merge_sort(begin, middle);
		merge_sort(middle+1, end);
		msort(begin, middle, end);
	}
}
//heap_sort
int left(int i)
{
	return 2 * i + 1;
}
int right(int i)
{
	return 2 * i + 2;
}
int parent(int i)
{
	return (i - 1) / 2;
}
void max_heap(int i,int len)
{
	int l = left(i);
	int r = right(i);
	int largest;
	int temp;
	if (l < len && a[l] > a[i])
		largest = l;
	else
		largest = i;
	if (r<len && a[r]>a[largest])
		largest = r;
	if (largest != i)
	{
		temp = a[i];
		a[i] = a[largest];
		a[largest] = temp;
		max_heap(largest,len);
	}
}
void build_heap(int len)
{
	for (int i = len / 2; i >= 0; i--)
		max_heap(i, len);
}
void heap_sort()
{
	int temp;
	build_heap(n);
	for (int len = n-1; len > 0; len--)
	{
		temp = a[len];
		a[len] = a[0];
		a[0] = temp;
		max_heap(0,len);
	}
}
//quick_sort
int partition(int begin, int end)
{
	int key = a[end];
	int i = begin - 1;
	int temp;
	for (int j = begin; j < end; j++)
	{
		if (a[j] < key)
		{
			i++;
			temp = a[j];
			a[j] = a[i];
			a[i] = temp;
		}
	}
	a[end] = a[i + 1];
	a[i + 1] = key;
	return (i + 1);
}
void quick_sort(int begin,int end)
{
	int q;
	if (begin < end)
	{
		q = partition(begin, end);
		quick_sort(begin, q - 1);
		quick_sort(q + 1, end);
	}   
}
void main()
{
	int way;
	cout << "enter a column of numbers:\n";
	enter();
	cout << "n = " << n <<endl;
	cout << "enter a number to choose the way you want to sort:\n1. insert_sort\n2.merge_sort\n3.heap_sort\n4.quick_sort\n" << endl;
	cin >> way;
	switch (way)
	{
	case 1:
		insert_sort();
	case 2:
		merge_sort(0,n-1);
	case 3:
		heap_sort();
	case 4: 
		quick_sort();
	default:
		break;
	}
	for (int i = 0; i < n; i++)
	{
		cout << a[i] << ' ';
	}
	cout << '\n';
	system("pause");
}

