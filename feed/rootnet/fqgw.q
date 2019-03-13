.module.fqgw:2016.12.29;

txload "core/fqbase";
txload "feed/rootnet/gwbase";

\d .temp
RDUpd:0b;
\d .

.timer.qgw:{[x]d:.z.D;t:.z.T;if[(5<={x-`week$x}d)|(d in .conf.holiday)|not any t within/:.conf.gw.timerrange;:()];if[(not .temp.RDUpd)&(t>=.conf.gw.rdupdtime);getrd[];.temp.RDUpd:1b];gethq[];};
.roll.qgw:{[x].temp.RDUpd:0b;};

getrd:{[]r:qrygwdp[`20800001;`optId`optPwd`optMode!.conf.gw`optid`optpwd`optmode;`exchId`stkId`stkName`stkStatus`basicExchId`basicStkId`basicStkType`basicPreClosePrice`contractTimes`deliveryType`deliveryYear`deliveryMonth`listDate`firstTrdDate`lastTrdDate`matureDate`lastSettleDate`deliveryDate`stkOrderStatus`orderPriceUnit`maxLimitOrderQty`minLimitOrderQty`maxMarketOrderQty`minMarketOrderQty`maxOrderPrice`minOrderPrice`upPercent`downPercent`newPrice`preSettlementPrice`preClosePrice`PreOpenPosition`openPrice`highestPrice`lowestPrice`exchTotalKnockQty`exchTotalKnockAmt`openPosition`closePrice`settlementPrice`preDelta`delta`strikeStyle`exerciseDate`currMargin`minMargin`maxMargin`optionStkId`stktype];if[3=count r;:()];r:r[0];t:1!select sym:` sv/:(,')[`$stkId;.enum.exmapgw exchId],underlying:` sv/:(,')[`$basicStkId;.enum.exmapgw basicExchId],date:.z.D,name:`$stkName,product:`$basicStkType,optexec:`$strikeStyle,putcall:?[stkName like "*��*";`C;`P],multiplier:"F"$contractTimes,strikepx:1e-3*"F"$(-4#)each stkName,opendate:"D"$firstTrdDate,date1:"D"$lastTrdDate,settledate:"D"$matureDate,lifephase:`$stkStatus,openint:"F"$openPosition,pc:"F"$preClosePrice,rmarginoq:"F"$preSettlementPrice,open:"F"$openPrice,sup:"F"$maxOrderPrice,inf:"F"$minOrderPrice,rmarginl:"F"$maxMargin,rmargins:"F"$minMargin,rmarginmq:"F"$currMargin,isin:`$optionStkId,qtylot:"F"$minLimitOrderQty,qtymax:"F"$maxLimitOrderQty,qtymins:"F"$minMarketOrderQty,qtymaxs:"F"$maxMarketOrderQty,pxunit:"F"$orderPriceUnit,secstatus:`$stkOrderStatus from r;.db.QX:.db.QX uj t;(path:` sv .conf.tempdb,`$"RDGW_",string .conf.me) set t;pubm[`ALL;`RDUpdate;`gw;string path];};

gwfuthq:{[x]r:qrygwdp[`20100010;`optId`optPwd`optMode`exchId!.conf.gw[`optid`optpwd`optmode],x;`exchId`stkId`stkName`settleGrp`settleID`stkOrderStatus`contractTimes`newPrice`preSettlementPrice`preClosePrice`preOpenPosition`openPrice`highestPrice`lowestPrice`exchTotalKnockQty`exchTotalKnockAmt`openPosition`closePrice`settlementPrice`maxOrderPrice`minOrderPrice`preDelta`delta`lastModifyTime`mseconds`buy1`buyAmt1`sell1`sellAmt1`buy2`buyAmt2`sell2`sellAmt2`buy3`buyAmt3`sell3`sellAmt3`buy4`buyAmt4`sell4`sellAmt4`buy5`buyAmt5`sell5`sellAmt5];if[3=count r;:()];select sym:` sv/:(,')[`$stkId;.enum.exmapgw exchId],time:`time$"Z"$lastModifyTime,price:"F"$newPrice,cumqty:"F"$exchTotalKnockQty,vwap:("F"$exchTotalKnockAmt)%("F"$exchTotalKnockQty)*("F"$contractTimes),high:"F"$highestPrice,low:"F"$lowestPrice,o5px:"F"$sell5,o5sz:"F"$sellAmt5,o4px:"F"$sell4,o4sz:"F"$sellAmt4,o3px:"F"$sell3,o3sz:"F"$sellAmt3,o2px:"F"$sell2,o2sz:"F"$sellAmt2,ask:"F"$sell1,asize:"F"$sellAmt1,bid:"F"$buy1,bsize:"F"$buyAmt1,b2px:"F"$buy2,b2sz:"F"$buyAmt2,b3px:"F"$buy3,b3sz:"F"$buyAmt3,b4px:"F"$buy4,b4sz:"F"$buyAmt4,b5px:"F"$buy5,b5sz:"F"$buyAmt5,openint:"F"$openPosition,settlepx:"F"$settlementPrice,pc:"F"$preClosePrice,open:"F"$openPrice,mode:`$stkOrderStatus,name:`$stkName from r[0]}; /[exchid]

gwstkhq:{[x;y]r:{qrygwdp[`00100010;`optId`optPwd`optMode`exchId`stkId!.conf.gw[`optid`optpwd`optmode],x,fs2s y;`exchId`stkId`stkName`stkType`tradeType`stkParValue`maxorderQty`minBuyStkQty`minSellStkQty`maxOrderPrice`minOrderPrice`upPercent`downPercent`orderUnit`qtyPerhand`orderPriceUnit`bsPermit`orderPriceFlag`closePrice`openPrice`newPrice`compositIndex`highPrice`lowPrice`knockQty`knockAmt`buy1`buy2`buy3`buy4`buy5`sell1`sell2`sell3`sell4`sell5`buyAmt1`buyAmt2`buyAmt3`buyAmt4`buyAmt5`sellAmt1`sellAmt2`sellAmt3`sellAmt4`sellAmt5`settlementprice]}[x] each y;if[any 3=/:count each r;:()];select sym:` sv/:(,')[`$stkId;.enum.exmapgw exchId],time:.z.T,price:"F"$newPrice,cumqty:"F"$knockQty,vwap:("F"$knockAmt)%("F"$knockQty),high:"F"$highPrice,low:"F"$lowPrice,o5px:"F"$sell5,o5sz:"F"$sellAmt5,o4px:"F"$sell4,o4sz:"F"$sellAmt4,o3px:"F"$sell3,o3sz:"F"$sellAmt3,o2px:"F"$sell2,o2sz:"F"$sellAmt2,ask:"F"$sell1,asize:"F"$sellAmt1,bid:"F"$buy1,bsize:"F"$buyAmt1,b2px:"F"$buy2,b2sz:"F"$buyAmt2,b3px:"F"$buy3,b3sz:"F"$buyAmt3,b4px:"F"$buy4,b4sz:"F"$buyAmt4,b5px:"F"$buy5,b5sz:"F"$buyAmt5,openint:0n,settlepx:"F"$settlementprice,pc:"F"$closePrice,open:"F"$openPrice,mode:`,name:`$stkName from raze r[;0]}; /[exchid;stkid]

gethq:{[]sz:`SZ~.conf.gw`market;t:gwfuthq[$[sz;`Y;`X]];t,:$[sz;();gwfuthq[`F]],gwstkhq[$[sz;`1;`0];.conf.gw.stklist];t1:(t0:delete time,pc,open,name from t) except .temp.Last;.temp.Last:t0;if[n:count t1;pub[`quote;select sym,bid,ask,bsize,asize,price,high,low,vwap,cumqty,openint,settlepx,mode,extime:.z.D+time,bidQ:flip (bid;b2px;b3px;b4px;b5px),askQ:flip (ask;o2px;o3px;o4px;o5px),bsizeQ:flip (bsize;b2sz;b3sz;b4sz;b5sz),asizeQ:flip (asize;o2sz;o3sz;o4sz;o5sz),quoopt:n#enlist "" from t where sym in exec sym from t1]];d:select sym,pc,open from t;d1:d except .temp.LastRef;.temp.LastRef:d;if[count d1;pub[`quoteref;update refopt:n#enlist"" from d1 lj 1!select sym,inf,sup from .db.QX where sym in exec sym from d1]];}; /LastRef::d
\

r0:callgwdp[`20800001;`optId`optPwd`optMode`maxRowNum!`90021`666666`W5`500;`exchId`stkId`stkName`stkStatus`basicExchId`basicStkId`basicStkType`basicPreClosePrice`contractTimes`deliveryType`deliveryYear`deliveryMonth`listDate`firstTrdDate`lastTrdDate`matureDate`lastSettleDate`deliveryDate`stkOrderStatus`orderPriceUnit`maxLimitOrderQty`minLimitOrderQty`maxMarketOrderQty`minMarketOrderQty`maxOrderPrice`minOrderPrice`upPercent`downPercent`newPrice`preSettlementPrice`preClosePrice`PreOpenPosition`openPrice`highestPrice`lowestPrice`exchTotalKnockQty`exchTotalKnockAmt`openPosition`closePrice`settlementPrice`preDelta`delta`strikeStyle`exerciseDate`currMargin`minMargin`maxMargin`optionStkId`stktype]; /ȡ��Լ������Ϣ
r1:qrygwdp[`20800001;`optId`optPwd`optMode!`000898`666666`W1;`exchId`stkId`stkName`stkStatus`basicExchId`basicStkId`basicStkType`basicPreClosePrice`contractTimes`deliveryType`deliveryYear`deliveryMonth`listDate`firstTrdDate`lastTrdDate`matureDate`lastSettleDate`deliveryDate`stkOrderStatus`orderPriceUnit`maxLimitOrderQty`minLimitOrderQty`maxMarketOrderQty`minMarketOrderQty`maxOrderPrice`minOrderPrice`upPercent`downPercent`newPrice`preSettlementPrice`preClosePrice`PreOpenPosition`openPrice`highestPrice`lowestPrice`exchTotalKnockQty`exchTotalKnockAmt`openPosition`closePrice`settlementPrice`preDelta`delta`strikeStyle`exerciseDate`currMargin`minMargin`maxMargin`optionStkId`stktype]; /ȡ��Լ������Ϣ

r:callgwdp[`20100010;`optId`optPwd`optMode`exchId`maxRowNum!`000898`666666`W1`Y`500;`exchId`stkId`stkName`settleGrp`settleID`stkOrderStatus`contractTimes`newPrice`preSettlementPrice`preClosePrice`preOpenPosition`openPrice`highestPrice`lowestPrice`exchTotalKnockQty`exchTotalKnockAmt`openPosition`closePrice`settlementPrice`maxOrderPrice`minOrderPrice`preDelta`delta`lastModifyTime`mseconds`buy1`buyAmt1`sell1`sellAmt1`buy2`buyAmt2`sell2`sellAmt2`buy3`buyAmt3`sell3`sellAmt3`buy4`buyAmt4`sell4`sellAmt4`buy5`buyAmt5`sell5`sellAmt5]; /ȡ�ڻ���Ϣ��ʵʱ������Ϣ

callgwdp[`00800010;`optId`optPwd`optMode`acctId`tradePwd`sortFlag`queryType`maxRowNum`packNum!`99981`666666`A1`A019700809`666666`0`0`500`1;`contractNum`OrderQty`knockQty`knockPrice];


r0:callgwdp[`00100030;`optId`optPwd`optMode`tradePwd`stkId`exchId`orderType`orderPrice`orderQty`regId`permitMac!`99960`666666`A1`666666`510051`0`KB`0`1`A160000001`90B11C9C7F84;`contractNum`OrderQty];

r1:callgwdp[`00100030;`optId`optPwd`optMode`tradePwd`stkId`exchId`orderType`orderPrice`orderQty`regId`permitMac!`99960`666666`A1`666666`510051`0`KS`0`1`A160000001`90B11C9C7F84;`contractNum`OrderQty];


r1:{qrygwdp[`00100010;`optId`optPwd`optMode`exchId`stkId!`000898`666666`W1`1,fs2s x;`exchId`stkId`stkName`stkType`tradeType`stkParValue`maxorderQty`minBuyStkQty`minSellStkQty`maxOrderPrice`minOrderPrice`upPercent`downPercent`orderUnit`qtyPerhand`orderPriceUnit`bsPermit`orderPriceFlag`closePrice`openPrice`newPrice`compositIndex`highPrice`lowPrice`knockQty`knockAmt`buy1`buy2`buy3`buy4`buy5`sell1`sell2`sell3`sell4`sell5`buyAmt1`buyAmt2`buyAmt3`buyAmt4`buyAmt5`sellAmt1`sellAmt2`sellAmt3`sellAmt4`sellAmt5`accuredInterest`optionType`settlementType`strikeStyle`strikeRate`expirationDate`strikestkid`optionstkid`basicstkid`strikeprice`settlementprice`stklevel`remainTradeDays`tradeCurrencyId`exchRate`str1`price1`str2`price2`str3`price3]} each exec distinct underlying from .db.QX where not null underlying;
