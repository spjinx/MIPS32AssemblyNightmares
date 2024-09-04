#include <iostream>
using namespace std;

void ReverseIt(char* o, char* r) {
    char* first = o;
    char* fSpace = nullptr;
    char* sSpace = nullptr;

    while (*first != '\0') {
        if (*first == ' ' && 
            fSpace == nullptr) {
            fSpace = first;
        } else if (*first == ' ' && 
                   fSpace != nullptr && 
                   sSpace == nullptr) {
            sSpace = first;
        }
        first++;
    }

    first = sSpace + 1;
    
    while (*first != '\0') {
        *r++ = *first++;
    }

    *r++ = ',';
    *r++ = ' ';

    first = o;

    while (first != sSpace) {
        *r++ = *first++;
    }

    *r = '\0';
}

// Calling for a function "reverseit"
int main() {
    char original[] = "Conan The Barbarian";
    char reversed[100];

    ReverseIt(original, reversed);

    cout << original << " reversed is " << reversed << endl;
}