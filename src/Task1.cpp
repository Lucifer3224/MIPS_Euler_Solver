#include <iostream>
#include <cmath>

using namespace std;

int main()
{
    string connection,description,R1,R2,R3;
    int voltage,SR;
    double PR,x,I;
    cout << "Circuit description: ";
    getline(cin,description);
    R1 = description[2];
    R2 = description[4];
    R3 = description[6];
    cout << "Voltage applied: ";
    cin >> voltage;
    SR = stof(R1) + stof(R2) + stof(R3);
    x = (1/stof(R1))+(1/stof(R2))+(1/stof(R3));
    PR = pow(x,-1);
    connection = description[0];
    if (connection == "S")
    {
        cout << "Total resistance is: " << SR <<endl;
        I = double(voltage) / SR;
        cout << "The circuit current is: " << I;
    }
    else if (connection == "P")
    {
        cout << "Total resistance is: " << PR <<endl;
        I = voltage / PR;
        cout << "The circuit current is: " << I;
    }
    else
    {
        cout << "wrong connection";
    }
    return 0;
}

