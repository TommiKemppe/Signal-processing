#include "mbed.h"
#include "rtos.h"
//include <aani.h>
#include <hairio.h>
#include <kertoimet.h>

#define TS 0.000125


DigitalOut led1(LED1);
Ticker kello;
AnalogIn AnalogToDigital(A0);
AnalogOut DigitalToAnalog(A2);

int indeksi = 0;

float suodatin(float);

float muisti[pituus] = {0};

void kellonpalvelija() {

	indeksi = (indeksi + 1)%80000;
	//DigitalToAnalog = taulukko[indeksi];
	DigitalToAnalog = suodatin(taulukko[indeksi]);
		
}



int main() {
	// Tehtävä: aani.h tiedostossa olevat aaninaytteet on 
	// nauhoitettu näytetaajuudella Fs = 8000 Hz
	// Millä näytevälillä ne on soitettava, jotta ääni kuulostaa samalta
	// kuin nauhoitettaessa? => korvaa ??? -merkit oikealla arvolla
	kello.attach(&kellonpalvelija, TS);
    while (true) {
        led1 = !led1;
        wait(1.5);
    }
}

float suodatin(float nayte)
{
	float tulos = 0.0;
	for (int i = pituus -1; i>0; i--)
	{
		muisti[i] = muisti [i-1];
	}
	
	muisti[0] = nayte;
	
	for (int index = 0; index < pituus; index ++)
	{
		tulos = tulos + muisti[index]*kertoimet[index];
	}
	return tulos;
	
}



