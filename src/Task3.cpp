#include <iostream>
#include <cmath>
#include <string>
using namespace std;

double series (string description)
{
    float R, Rp = 0, Req = 0, PReq = 0;
    int length = 0;

    for (int i = 2; description[i] != 'E'; i++)
    {
        if (description[i] != 'S' && description[i] != 'P' )
        {
            if (description[i] == ' ')
            {
                R = stof(description.substr(i - length, length));
                Req += R;
                length = 0;
            }
            else
                length++;
        }
        else if (description[i] == 'P')
        {
            for ( i = i + 2; description[i] != 'e'; i++)
            {
                if (description[i] == ' ')
                {
                    R = stof(description.substr(i - length, length));
                    Rp += 1 / R;
                    length = 0;
                }
                else
                    length++;
            }
            PReq = pow(Rp, -1);
            Req += PReq;
            Rp = 0;
            PReq = 0;
            i++;
        }
    }
    return Req;
}

double parallel(string description)
{
    float R, Rp = 0, Req = 0, SReq = 0;
    int length = 0;

    for (int i = 2; description[i] != 'E'; i++)
    {
        if (description[i] != 'P' && description[i] != 'S')
        {
            if (description[i] == ' ')
            {
                R = stof(description.substr(i - length, length));
                Rp += 1 / R;
                length = 0;
            }
            else
                length++;
        }
        else if (description[i] == 'S')
        {
            for ( i = i + 2; description[i] != 'e'; i++)
            {
                if (description[i] == ' ')
                {
                    R = stof(description.substr(i - length, length));
                    SReq += R;
                    length = 0;
                }
                else
                    length++;
            }
            Rp += 1 / SReq;
            SReq = 0;
            i++;
        }
    }
    Req = pow(Rp, -1);
    return Req;
}

int main()
{
    string description;
    float voltage, current;

    cout << "Circuit description: ";
    getline(cin, description);
    cout << "Applied voltage: ";
    cin >> voltage;
    char connection = description[0];

    for (int i = 0; i < description.length(); i++)
    {
        if (!(description[i] >= 48 && description[i] <= 59 || description[i] == '.'
                || (description[i] == 'S' || description[i] == 'P') || description[i] == ' ' ||
                description[i]=='e' || description[i]=='E'))
        {
            cout << "Wrong Circuit Description";
            return 1;
        }
    }

    if (connection == 'S')
    {
        current = voltage / series(description);
        cout << "Req = " << series(description) <<endl;
        cout << "Total current = " << current <<endl;
    }
    else if (connection == 'P')
    {
        current = voltage / parallel(description);
        cout << "Req = " << parallel(description) <<endl;
        cout << "Total current = " << current <<endl;
    }
    return 0;
}

