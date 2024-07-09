#include <iostream>
#include <cmath>
#include <string>
#include <vector>

using namespace std;

int main()
{
    string description,R,connection,space;
    int length;
    double SR,I,PR, x = 0,voltage;
    float resistance;
    cout << "Circuit description: ";
    getline(cin,description);
    cout << "Voltage applied: ";
    cin >> voltage;
    length = description.length();
    space = " ";
    vector <int> indecies(1);
    indecies.clear();
    vector <string> st_resistances(1);
    st_resistances.clear();
    vector <double> resistances (1);
    resistances.clear();
    for (int i = 0; i<= length ; i++)
    {
        if (description[i] == space[0])
        {
            indecies.push_back(i);
        }
    }
    for (int j = 0; j < indecies.size(); j++)
    {
        R = description.substr(indecies[j],indecies[j+1]-indecies[j]);
        st_resistances.push_back(R);
    }
    st_resistances.erase(st_resistances.end());
    for (int k = 0; k < st_resistances.size(); k++)
    {
        resistance = stof(st_resistances[k]);
        resistances.push_back(resistance);
    }
    connection = description[0];
    if (connection == "S")
    {
        for (int m = 0; m < resistances.size(); m++)
        {
            SR = SR + resistances[m];
        }
        cout << "Total resistance is: " << SR <<endl;
        I = voltage / SR;
        cout << "The circuit current is: " << I;
    }
    else if (connection == "P")
    {
        for (int m = 0; m < resistances.size(); m++)
        {
            x += (1/resistances[m]);
            PR = pow(x,-1);
        }
        cout << "Total resistance is: " << PR <<endl;
        I = voltage / PR;
        cout << "The circuit current is: " << I;
    }
    else
        cout << "Wrong Circuit Description";
    return 0;
}
