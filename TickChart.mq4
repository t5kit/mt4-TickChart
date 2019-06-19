//+------------------------------------------------------------------+
//|                                                    TickChart.mq4 |
//|                                                                  |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright ""
#property link      ""
#property version   "1.00"
#property strict
#property indicator_separate_window
#property indicator_buffers 2
#property indicator_color1 clrDodgerBlue
#property indicator_color2 clrFireBrick

#define ARRAY_SIZE 300

double BufAsk[];
double BufBid[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit() {
//--- indicator buffers mapping
    IndicatorBuffers(2);
    IndicatorDigits(Digits);
   
    ArrayResize(BufAsk, ARRAY_SIZE);
    ArrayResize(BufBid, ARRAY_SIZE);
    ArrayInitialize(BufAsk, 0.0);
    ArrayInitialize(BufBid, 0.0);
    
    SetIndexStyle(0, DRAW_LINE);
    SetIndexStyle(1, DRAW_LINE);
    SetIndexBuffer(0, BufAsk);
    SetIndexBuffer(1, BufBid);
//---
    return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[]) {
//---
    int i;
    for(i = ARRAY_SIZE; i >= 0; i--){
        BufAsk[i + 1] = BufAsk[i];
        BufBid[i + 1] = BufBid[i];
    }
    
    BufAsk[0] = Ask;
    BufBid[0] = Bid;
    
//--- return value of prev_calculated for next call
    return(rates_total);
}
//+------------------------------------------------------------------+
