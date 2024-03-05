
<!-- README.md is generated from README.Rmd. Please edit that file -->

# CellDiv

<!-- badges: start -->
<!-- badges: end -->

The goal of CellDiv is to calculate the Shannon Diversity Index for the
cell types of interest to the user and to allow the identification of
the combination of cell types that best distinguish dichotomous outcomes

## Installation

You can install the development version of CellDiv from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("WenqinXie/CellDiv")
```

## Usage

Generate sample data

``` r
#cdata
set.seed(1)
cdata1 <- matrix(sample(1000:5000, 500, replace = TRUE), 50, 10)
row.names(cdata1) <- paste0("A",1:50)
colnames(cdata1) <- c(paste0("CellType", 1:10))
cdata1 <- as.data.frame(cdata1)

set.seed(1)
cdata2 <- matrix(sample(2000:4000, 400, replace = TRUE), 40, 10)
row.names(cdata2) <- paste0("A",1:40)
colnames(cdata2) <- c(paste0("CellType", 1:10))
cdata2 <- as.data.frame(cdata2)

cdata <- rbind(cdata1, cdata2)
print(cdata)
#>      CellType1 CellType2 CellType3 CellType4 CellType5 CellType6 CellType7
#> A1        2016      4755      4616      2024      2241      4112      4512
#> A2        4907      1536      1556      1028      4681      4034      4365
#> A3        1678      3422      2684      4661      2217      4947      1061
#> A4        3176      1247      1286      2941      1018      4998      1389
#> A5        1929      2221      3661      1837      1272      4956      2667
#> A6        2532      3425      4216      2819      1417      4911      2058
#> A7        1470      3086      3376      2651      2994      2571      1380
#> A8        3346      3482      3534      3280      2566      1304      2890
#> A9        1269      3857      3902      2316      3466      2832      3124
#> A10       2210      2413      3898      1572      1866      3460      2128
#> A11       4378      2303      4701      2965      1685      1980      4768
#> A12       1596      2695      2521      1368      1402      3623      2350
#> A13       2300      1525      1857      3498      4820      1128      3712
#> A14       4945      3689      2839      1085      2610      1308      3078
#> A15       2973      2068      3666      2506      2039      4795      3596
#> A16       4565      2425      1575      3374      2063      3921      3011
#> A17       1329      1021      1989      2645      2800      4049      4838
#> A18       2798      2741      4561      1354      1817      1440      3790
#> A19       4912      2765      4807      2842      3651      3903      2051
#> A20       2614      3240      4070      3859      1633      4188      3109
#> A21       2748      2394      4174      2072      1663      1308      2171
#> A22       1036      3546      1315      1360      4209      1469      1796
#> A23       2128      2127      2074      2339      1718      4685      4198
#> A24       1728      4397      1732      2265      1499      3609      3857
#> A25       1877      1982      2313      4511      4044      2359      2595
#> A26       1484      2790      3697      3805      3808      2821      1960
#> A27       4748      2515      3176      2840      3719      2789      4355
#> A28       2825      4909      1810      3865      3276      1348      1333
#> A29       3921      2639      1954      1246      1422      4969      3078
#> A30       3429      2638      3329      1750      1420      4143      2291
#> A31       4672      1842      2166      1218      1988      1893      3140
#> A32       1974      1464      4513      1134      1139      1589      4407
#> A33       3848      1995      3332      1110      1125      2955      4371
#> A34       3899      2548      4991      1531      4597      1473      3761
#> A35       3978      4879      2705      3424      4579      3215      1609
#> A36       3373      4800      4119      1407      1997      3548      4353
#> A37       3377      2199      1500      4122      4699      1420      2264
#> A38       1553      4416      4787      2588      2039      3887      3080
#> A39       2445      4862      3558      1911      3318      1951      4067
#> A40       3158      2133      4366      3514      2153      1454      4715
#> A41       4475      1083      1535      4427      3624      4699      3484
#> A42       2947      2894      3740      3177      2535      3403      4188
#> A43       3579      4100      1987      2839      4522      4696      1085
#> A44       2529      2164      4285      4136      1503      4305      3264
#> A45       3603      3299      4879      2835      2480      4555      3839
#> A46       3936      4989      3784      1358      1357      4192      3852
#> A47       1342      3780      4410      3152      1784      3120      3155
#> A48       3629      2947      4417      2147      4795      4610      3318
#> A49       4192      3667      4746      3041      3174      2576      2293
#> A50       1039      2327      2066      2100      3692      1014      1750
#> A110      3016      2110      3638      3022      2572      3241      2576
#> A210      3859      3427      2842      3126      3965      3633      3535
#> A310      2678      3947      2464      2315      2368      3217      3474
#> A410      2128      2531      2995      3074      2450      2018      2503
#> A51       2929      3529      3548      2732      2085      2272      3480
#> A61       3532      2555      3831      3313      3506      2417      2357
#> A71       2470      2888      3752      2649      2326      3994      2784
#> A81       2298      2342      3199      2128      3645      3566      3747
#> A91       2269      2581      3368      2810      2354      2418      2126
#> A101      3210      3144      3814      2954      3842      2866      2644
#> A111      3330      2039      3133      2281      2811      2685      3064
#> A121      2596      3707      2083      3166      3072      2402      2986
#> A131      3300      2536      3894      3465      2360      3772      3899
#> A141      3897      2374      3052      2284      3339      3610      3950
#> A151      3973      2247      3164      3943      3265      3039      3908
#> A161      3517      3221      2251      3705      3463      3063      3863
#> A171      2329      2377      3941      3071      2757      3800      3571
#> A181      3798      2038      2732      2500      3840      2817      2304
#> A191      3864      2434      3947      3739      2817      2603      3832
#> A201      3614      2809      2619      2510      2246      2633      2412
#> A211      3748      3413      3327      3318      2750      2663      2980
#> A221      2036      3303      3568      2535      2218      3161      2575
#> A231      3128      3695      2556      2692      2134      2718      2128
#> A241      2728      2525      3684      2987      2110      2499      2308
#> A251      2877      2641      2286      3237      2531      2996      3747
#> A261      2484      3068      2613      3831      2376      2760      2873
#> A271      3700      3425      3168      2736      2407      2671      3001
#> A281      3825      2021      2328      3362      3074      2228      2440
#> A291      2873      3741      2486      3369      3588      2422      2855
#> A301      2381      3765      2854      3698      2911      2420      3140
#> A311      3624      2192      2850      3066      2466      2988      2308
#> A321      3963      3394      3653      3024      3379      2139      2469
#> A331      2974      2498      3521      2028      2129      2125      3637
#> A341      2800      3127      2857      3613      3839      3549      2561
#> A351      2851      3349      3839      3941      3088      3531      3359
#> A361      2930      2982      2618      2837      3835      2997      3821
#> A371      2325      3790      2575      3819      2358      3651      3789
#> A381      2329      3515      2989      3651      2104      3039      2348
#> A391      2553      3861      3513      2232      3147      2270      3921
#> A401      3445      3639      3759      3316      3100      3153      3095
#>      CellType8 CellType9 CellType10
#> A1        3256      4941       1259
#> A2        4054      3812       1716
#> A3        2361      2203       1059
#> A4        2632      3511       2856
#> A5        2759      4745       3495
#> A6        2607      4804       3535
#> A7        2588      1492       1180
#> A8        1567      1674       2533
#> A9        2001      4913       2156
#> A10       1742      1965       2641
#> A11       2734      3491       2451
#> A12       4505      2190       4618
#> A13       3815      3096       4448
#> A14       3248      3016       4350
#> A15       3963      2494       4996
#> A16       2377      4773       4956
#> A17       4428      2696       1290
#> A18       4420      1290       1675
#> A19       4658      4978       2992
#> A20       4585      1652       3422
#> A21       1115      1246       1610
#> A22       3042      3481       2698
#> A23       3690      3788       1147
#> A24       3926      4387       1149
#> A25       4493      4417       1120
#> A26       4069      4417       1168
#> A27       2256      3927       1597
#> A28       4342      3983       2490
#> A29       2691      3721       1107
#> A30       2462      3883       3814
#> A31       2220      1055       3577
#> A32       4291      4096       2579
#> A33       1461      1933       2446
#> A34       2956      4152       4868
#> A35       3346      4543       2114
#> A36       3282      1328       3211
#> A37       3560      1493       4615
#> A38       2497      2757       4550
#> A39       3220      1328       1050
#> A40       4936      4786       3166
#> A41       2106      3965       3512
#> A42       2497      4551       3276
#> A43       1406      3151       3098
#> A44       3371      2026       2782
#> A45       4791      4250       3428
#> A46       3032      3706       1435
#> A47       1730      1160       3136
#> A48       1184      3431       2940
#> A49       4686      3483       1532
#> A50       3942      1126       3638
#> A110      2893      2796       3457
#> A210      2589      3150       2767
#> A310      3955      2809       2200
#> A410      2473      3595       2915
#> A51       2167      2960       3377
#> A61       2500      3307       3380
#> A71       2420      2333       3372
#> A81       2839      2030       3610
#> A91       2951      3291       3537
#> A101      2454      2092       2115
#> A111      3651      3359       2642
#> A121      2355      3323       2878
#> A131      3648      2713       3445
#> A141      3257      2609       3021
#> A151      3507      3305       3256
#> A161      3144      3264       3294
#> A171      2072      2032       3691
#> A181      3562      3019       3462
#> A191      3576      3667       3220
#> A201      2014      2436       3243
#> A211      3464      3140       2461
#> A221      3317      2085       3956
#> A231      2061      2216       2298
#> A241      2389      2791       2234
#> A251      3667      2804       4000
#> A261      3058      2107       2512
#> A271      2380      2270       3497
#> A281      3890      3293       2172
#> A291      2076      2750       3888
#> A301      3128      2208       3106
#> A311      3720      3006       3497
#> A321      3350      3361       2406
#> A331      2664      3632       2323
#> A341      2030      3759       3743
#> A351      2548      3607       2730
#> A361      3790      3588       2184
#> A371      2742      2567       3638
#> A381      3051      3001       2894
#> A391      2061      2742       3893
#> A401      3171      3734       2764
```

``` r
#metadata c("CR/PR", "SD/PD")
set.seed(1)
metadata <- data.frame(sample = row.names(cdata),
condition = c(rep("SD/PD", 50), rep("CR/PR", 40)))
metadata$condition <- as.factor(metadata$condition)
print(metadata)
#>    sample condition
#> 1      A1     SD/PD
#> 2      A2     SD/PD
#> 3      A3     SD/PD
#> 4      A4     SD/PD
#> 5      A5     SD/PD
#> 6      A6     SD/PD
#> 7      A7     SD/PD
#> 8      A8     SD/PD
#> 9      A9     SD/PD
#> 10    A10     SD/PD
#> 11    A11     SD/PD
#> 12    A12     SD/PD
#> 13    A13     SD/PD
#> 14    A14     SD/PD
#> 15    A15     SD/PD
#> 16    A16     SD/PD
#> 17    A17     SD/PD
#> 18    A18     SD/PD
#> 19    A19     SD/PD
#> 20    A20     SD/PD
#> 21    A21     SD/PD
#> 22    A22     SD/PD
#> 23    A23     SD/PD
#> 24    A24     SD/PD
#> 25    A25     SD/PD
#> 26    A26     SD/PD
#> 27    A27     SD/PD
#> 28    A28     SD/PD
#> 29    A29     SD/PD
#> 30    A30     SD/PD
#> 31    A31     SD/PD
#> 32    A32     SD/PD
#> 33    A33     SD/PD
#> 34    A34     SD/PD
#> 35    A35     SD/PD
#> 36    A36     SD/PD
#> 37    A37     SD/PD
#> 38    A38     SD/PD
#> 39    A39     SD/PD
#> 40    A40     SD/PD
#> 41    A41     SD/PD
#> 42    A42     SD/PD
#> 43    A43     SD/PD
#> 44    A44     SD/PD
#> 45    A45     SD/PD
#> 46    A46     SD/PD
#> 47    A47     SD/PD
#> 48    A48     SD/PD
#> 49    A49     SD/PD
#> 50    A50     SD/PD
#> 51   A110     CR/PR
#> 52   A210     CR/PR
#> 53   A310     CR/PR
#> 54   A410     CR/PR
#> 55    A51     CR/PR
#> 56    A61     CR/PR
#> 57    A71     CR/PR
#> 58    A81     CR/PR
#> 59    A91     CR/PR
#> 60   A101     CR/PR
#> 61   A111     CR/PR
#> 62   A121     CR/PR
#> 63   A131     CR/PR
#> 64   A141     CR/PR
#> 65   A151     CR/PR
#> 66   A161     CR/PR
#> 67   A171     CR/PR
#> 68   A181     CR/PR
#> 69   A191     CR/PR
#> 70   A201     CR/PR
#> 71   A211     CR/PR
#> 72   A221     CR/PR
#> 73   A231     CR/PR
#> 74   A241     CR/PR
#> 75   A251     CR/PR
#> 76   A261     CR/PR
#> 77   A271     CR/PR
#> 78   A281     CR/PR
#> 79   A291     CR/PR
#> 80   A301     CR/PR
#> 81   A311     CR/PR
#> 82   A321     CR/PR
#> 83   A331     CR/PR
#> 84   A341     CR/PR
#> 85   A351     CR/PR
#> 86   A361     CR/PR
#> 87   A371     CR/PR
#> 88   A381     CR/PR
#> 89   A391     CR/PR
#> 90   A401     CR/PR
```

Calculate diversity score for each sample

``` r
library(CellDiv)
divscores <- celltdiv(cdata = cdata, cellsets = colnames(cdata)[1:8])
print(divscores)
#>      sample divscore
#> A1       A1 2.023062
#> A2       A2 1.959300
#> A3       A3 1.978922
#> A4       A4 1.937555
#> A5       A5 1.999623
#> A6       A6 2.016300
#> A7       A7 2.039476
#> A8       A8 2.030050
#> A9       A9 2.028579
#> A10     A10 2.030253
#> A11     A11 2.011935
#> A12     A12 1.996532
#> A13     A13 1.982351
#> A14     A14 1.990447
#> A15     A15 2.038612
#> A16     A16 2.028136
#> A17     A17 1.966547
#> A18     A18 1.988861
#> A19     A19 2.041320
#> A20     A20 2.041073
#> A21     A21 2.000931
#> A22     A22 1.957538
#> A23     A23 2.013537
#> A24     A24 2.003029
#> A25     A25 2.019825
#> A26     A26 2.033097
#> A27     A27 2.048245
#> A28     A28 1.980888
#> A29     A29 1.988278
#> A30     A30 2.028558
#> A31     A31 2.001881
#> A32     A32 1.923283
#> A33     A33 1.964553
#> A34     A34 2.001069
#> A35     A35 2.036970
#> A36     A36 2.021986
#> A37     A37 1.999555
#> A38     A38 2.018271
#> A39     A39 2.032684
#> A40     A40 2.007442
#> A41     A41 1.982146
#> A42     A42 2.064826
#> A43     A43 1.975660
#> A44     A44 2.028775
#> A45     A45 2.054143
#> A46     A46 2.000058
#> A47     A47 2.011453
#> A48     A48 2.010722
#> A49     A49 2.048944
#> A50     A50 1.978206
#> A110   A110 2.067839
#> A210   A210 2.070203
#> A310   A310 2.057358
#> A410   A410 2.070198
#> A51     A51 2.057960
#> A61     A61 2.061920
#> A71     A71 2.060160
#> A81     A81 2.057573
#> A91     A91 2.068845
#> A101   A101 2.068156
#> A111   A111 2.063933
#> A121   A121 2.063769
#> A131   A131 2.064682
#> A141   A141 2.062080
#> A151   A151 2.065475
#> A161   A161 2.068724
#> A171   A171 2.054076
#> A181   A181 2.055027
#> A191   A191 2.063634
#> A201   A201 2.065540
#> A211   A211 2.073388
#> A221   A221 2.061504
#> A231   A231 2.060179
#> A241   A241 2.065108
#> A251   A251 2.066066
#> A261   A261 2.068848
#> A271   A271 2.068096
#> A281   A281 2.050976
#> A291   A291 2.061249
#> A301   A301 2.066947
#> A311   A311 2.062636
#> A321   A321 2.062758
#> A331   A331 2.056056
#> A341   A341 2.061604
#> A351   A351 2.070349
#> A361   A361 2.068975
#> A371   A371 2.057984
#> A381   A381 2.062239
#> A391   A391 2.050223
#> A401   A401 2.076905
```

Average AUC values are calculated after multiple samples for all
combinations of cell types of interest

``` r
cdiv <- commroc(cdata = cdata, metadata = metadata, 
        cellsets = colnames(cdata)[1:8], sami = 500, ncores = 10)
print(cdiv)
#>       roc.auc
#> 1   0.6805325
#> 2   0.7290725
#> 3   0.7409187
#> 4   0.7989425
#> 5   0.7774863
#> 6   0.6933512
#> 7   0.8014600
#> 8   0.6034650
#> 9   0.7615325
#> 10  0.6999112
#> 11  0.7289275
#> 12  0.6882287
#> 13  0.6801738
#> 14  0.7846937
#> 15  0.7537650
#> 16  0.6934425
#> 17  0.6527937
#> 18  0.6676325
#> 19  0.6421938
#> 20  0.7270513
#> 21  0.8036313
#> 22  0.7050200
#> 23  0.8185900
#> 24  0.8432338
#> 25  0.7253075
#> 26  0.7740900
#> 27  0.7423100
#> 28  0.6814438
#> 29  0.8110213
#> 30  0.8202075
#> 31  0.8391087
#> 32  0.8501612
#> 33  0.7713700
#> 34  0.8323125
#> 35  0.8739575
#> 36  0.8769788
#> 37  0.8379712
#> 38  0.7955087
#> 39  0.8458638
#> 40  0.8200688
#> 41  0.8946200
#> 42  0.8545462
#> 43  0.8703850
#> 44  0.9031337
#> 45  0.8921325
#> 46  0.8710350
#> 47  0.8653250
#> 48  0.8835662
#> 49  0.8408100
#> 50  0.8362487
#> 51  0.8002238
#> 52  0.7500700
#> 53  0.7298613
#> 54  0.7531150
#> 55  0.8047688
#> 56  0.8454438
#> 57  0.8472662
#> 58  0.8327525
#> 59  0.8333763
#> 60  0.8792237
#> 61  0.8027838
#> 62  0.8381400
#> 63  0.8189563
#> 64  0.7920550
#> 65  0.8799400
#> 66  0.8570325
#> 67  0.8783975
#> 68  0.8675363
#> 69  0.8837800
#> 70  0.8817238
#> 71  0.8433688
#> 72  0.8090700
#> 73  0.8010650
#> 74  0.7753550
#> 75  0.8699375
#> 76  0.8910413
#> 77  0.8188375
#> 78  0.8799475
#> 79  0.8665363
#> 80  0.8643762
#> 81  0.9274400
#> 82  0.8832863
#> 83  0.8880088
#> 84  0.8458813
#> 85  0.8998662
#> 86  0.9178175
#> 87  0.8783387
#> 88  0.8510188
#> 89  0.8891163
#> 90  0.8634500
#> 91  0.9309200
#> 92  0.8801037
#> 93  0.8963762
#> 94  0.9206513
#> 95  0.9208063
#> 96  0.9255450
#> 97  0.8995912
#> 98  0.9193925
#> 99  0.8626413
#> 100 0.9271650
#> 101 0.9374613
#> 102 0.9162875
#> 103 0.9319213
#> 104 0.9472050
#> 105 0.9307125
#> 106 0.9260312
#> 107 0.8736287
#> 108 0.8868350
#> 109 0.8785750
#> 110 0.9389400
#> 111 0.9255875
#> 112 0.9132887
#> 113 0.9396912
#> 114 0.9483712
#> 115 0.9216675
#> 116 0.9458550
#> 117 0.9359388
#> 118 0.9419900
#> 119 0.9137275
#> 120 0.8851737
#> 121 0.8930212
#> 122 0.9136488
#> 123 0.8882550
#> 124 0.8883050
#> 125 0.8968850
#> 126 0.8488163
#> 127 0.8339950
#> 128 0.8340825
#> 129 0.8391525
#> 130 0.8763625
#> 131 0.9145813
#> 132 0.8797675
#> 133 0.9241288
#> 134 0.8863787
#> 135 0.9204562
#> 136 0.9585613
#> 137 0.8997350
#> 138 0.9272812
#> 139 0.9001175
#> 140 0.9256412
#> 141 0.9598900
#> 142 0.9229937
#> 143 0.9187737
#> 144 0.8758312
#> 145 0.9308637
#> 146 0.9545100
#> 147 0.9081425
#> 148 0.9411025
#> 149 0.8874713
#> 150 0.9442750
#> 151 0.9234575
#> 152 0.9363037
#> 153 0.9365587
#> 154 0.9599412
#> 155 0.9279287
#> 156 0.9562575
#> 157 0.9399825
#> 158 0.9411588
#> 159 0.9601112
#> 160 0.9536587
#> 161 0.9505225
#> 162 0.8966425
#> 163 0.9104638
#> 164 0.9102725
#> 165 0.9404113
#> 166 0.9281287
#> 167 0.9350987
#> 168 0.9548100
#> 169 0.9502050
#> 170 0.9309850
#> 171 0.9698562
#> 172 0.9550525
#> 173 0.9619612
#> 174 0.9388000
#> 175 0.9709138
#> 176 0.9673588
#> 177 0.9652213
#> 178 0.9581312
#> 179 0.9401763
#> 180 0.9523500
#> 181 0.9709800
#> 182 0.9579937
#> 183 0.9727537
#> 184 0.9210825
#> 185 0.9678237
#> 186 0.9611475
#> 187 0.9744300
#> 188 0.9702875
#> 189 0.9723450
#> 190 0.9179925
#> 191 0.9583012
#> 192 0.9162238
#> 193 0.9389637
#> 194 0.8987350
#> 195 0.9581287
#> 196 0.9570338
#> 197 0.9094113
#> 198 0.9467638
#> 199 0.9037888
#> 200 0.9580338
#> 201 0.9092500
#> 202 0.9601925
#> 203 0.9515012
#> 204 0.9771225
#> 205 0.9726512
#> 206 0.9250287
#> 207 0.9903838
#> 208 0.9462525
#> 209 0.9797913
#> 210 0.9822550
#> 211 0.9722800
#> 212 0.9642238
#> 213 0.9635362
#> 214 0.9639175
#> 215 0.9516950
#> 216 0.9652213
#> 217 0.9754000
#> 218 0.9637537
#> 219 0.9813563
#> 220 0.9301512
#> 221 0.9759300
#> 222 0.9590038
#> 223 0.9682238
#> 224 0.9660863
#> 225 0.9841237
#> 226 0.9872062
#> 227 0.9667712
#> 228 0.9932912
#> 229 0.9661575
#> 230 0.9897925
#> 231 0.9917475
#> 232 0.9690838
#> 233 0.9173550
#> 234 0.9882550
#> 235 0.9573962
#> 236 0.9756525
#> 237 0.9846512
#> 238 0.9893013
#> 239 0.9840437
#> 240 0.9681962
#> 241 0.9876800
#> 242 0.9670750
#> 243 0.9861363
#> 244 0.9845500
#> 245 0.9912313
#> 246 0.9826512
#> 247 0.9866000
#>                                                                                   cellsets
#> 1                                                                     CellType1; CellType2
#> 2                                                                     CellType1; CellType3
#> 3                                                                     CellType1; CellType4
#> 4                                                                     CellType1; CellType5
#> 5                                                                     CellType1; CellType6
#> 6                                                                     CellType1; CellType7
#> 7                                                                     CellType1; CellType8
#> 8                                                                     CellType2; CellType3
#> 9                                                                     CellType2; CellType4
#> 10                                                                    CellType2; CellType5
#> 11                                                                    CellType2; CellType6
#> 12                                                                    CellType2; CellType7
#> 13                                                                    CellType2; CellType8
#> 14                                                                    CellType3; CellType4
#> 15                                                                    CellType3; CellType5
#> 16                                                                    CellType3; CellType6
#> 17                                                                    CellType3; CellType7
#> 18                                                                    CellType3; CellType8
#> 19                                                                    CellType4; CellType5
#> 20                                                                    CellType4; CellType6
#> 21                                                                    CellType4; CellType7
#> 22                                                                    CellType4; CellType8
#> 23                                                                    CellType5; CellType6
#> 24                                                                    CellType5; CellType7
#> 25                                                                    CellType5; CellType8
#> 26                                                                    CellType6; CellType7
#> 27                                                                    CellType6; CellType8
#> 28                                                                    CellType7; CellType8
#> 29                                                         CellType1; CellType2; CellType3
#> 30                                                         CellType1; CellType2; CellType4
#> 31                                                         CellType1; CellType2; CellType5
#> 32                                                         CellType1; CellType2; CellType6
#> 33                                                         CellType1; CellType2; CellType7
#> 34                                                         CellType1; CellType2; CellType8
#> 35                                                         CellType1; CellType3; CellType4
#> 36                                                         CellType1; CellType3; CellType5
#> 37                                                         CellType1; CellType3; CellType6
#> 38                                                         CellType1; CellType3; CellType7
#> 39                                                         CellType1; CellType3; CellType8
#> 40                                                         CellType1; CellType4; CellType5
#> 41                                                         CellType1; CellType4; CellType6
#> 42                                                         CellType1; CellType4; CellType7
#> 43                                                         CellType1; CellType4; CellType8
#> 44                                                         CellType1; CellType5; CellType6
#> 45                                                         CellType1; CellType5; CellType7
#> 46                                                         CellType1; CellType5; CellType8
#> 47                                                         CellType1; CellType6; CellType7
#> 48                                                         CellType1; CellType6; CellType8
#> 49                                                         CellType1; CellType7; CellType8
#> 50                                                         CellType2; CellType3; CellType4
#> 51                                                         CellType2; CellType3; CellType5
#> 52                                                         CellType2; CellType3; CellType6
#> 53                                                         CellType2; CellType3; CellType7
#> 54                                                         CellType2; CellType3; CellType8
#> 55                                                         CellType2; CellType4; CellType5
#> 56                                                         CellType2; CellType4; CellType6
#> 57                                                         CellType2; CellType4; CellType7
#> 58                                                         CellType2; CellType4; CellType8
#> 59                                                         CellType2; CellType5; CellType6
#> 60                                                         CellType2; CellType5; CellType7
#> 61                                                         CellType2; CellType5; CellType8
#> 62                                                         CellType2; CellType6; CellType7
#> 63                                                         CellType2; CellType6; CellType8
#> 64                                                         CellType2; CellType7; CellType8
#> 65                                                         CellType3; CellType4; CellType5
#> 66                                                         CellType3; CellType4; CellType6
#> 67                                                         CellType3; CellType4; CellType7
#> 68                                                         CellType3; CellType4; CellType8
#> 69                                                         CellType3; CellType5; CellType6
#> 70                                                         CellType3; CellType5; CellType7
#> 71                                                         CellType3; CellType5; CellType8
#> 72                                                         CellType3; CellType6; CellType7
#> 73                                                         CellType3; CellType6; CellType8
#> 74                                                         CellType3; CellType7; CellType8
#> 75                                                         CellType4; CellType5; CellType6
#> 76                                                         CellType4; CellType5; CellType7
#> 77                                                         CellType4; CellType5; CellType8
#> 78                                                         CellType4; CellType6; CellType7
#> 79                                                         CellType4; CellType6; CellType8
#> 80                                                         CellType4; CellType7; CellType8
#> 81                                                         CellType5; CellType6; CellType7
#> 82                                                         CellType5; CellType6; CellType8
#> 83                                                         CellType5; CellType7; CellType8
#> 84                                                         CellType6; CellType7; CellType8
#> 85                                              CellType1; CellType2; CellType3; CellType4
#> 86                                              CellType1; CellType2; CellType3; CellType5
#> 87                                              CellType1; CellType2; CellType3; CellType6
#> 88                                              CellType1; CellType2; CellType3; CellType7
#> 89                                              CellType1; CellType2; CellType3; CellType8
#> 90                                              CellType1; CellType2; CellType4; CellType5
#> 91                                              CellType1; CellType2; CellType4; CellType6
#> 92                                              CellType1; CellType2; CellType4; CellType7
#> 93                                              CellType1; CellType2; CellType4; CellType8
#> 94                                              CellType1; CellType2; CellType5; CellType6
#> 95                                              CellType1; CellType2; CellType5; CellType7
#> 96                                              CellType1; CellType2; CellType5; CellType8
#> 97                                              CellType1; CellType2; CellType6; CellType7
#> 98                                              CellType1; CellType2; CellType6; CellType8
#> 99                                              CellType1; CellType2; CellType7; CellType8
#> 100                                             CellType1; CellType3; CellType4; CellType5
#> 101                                             CellType1; CellType3; CellType4; CellType6
#> 102                                             CellType1; CellType3; CellType4; CellType7
#> 103                                             CellType1; CellType3; CellType4; CellType8
#> 104                                             CellType1; CellType3; CellType5; CellType6
#> 105                                             CellType1; CellType3; CellType5; CellType7
#> 106                                             CellType1; CellType3; CellType5; CellType8
#> 107                                             CellType1; CellType3; CellType6; CellType7
#> 108                                             CellType1; CellType3; CellType6; CellType8
#> 109                                             CellType1; CellType3; CellType7; CellType8
#> 110                                             CellType1; CellType4; CellType5; CellType6
#> 111                                             CellType1; CellType4; CellType5; CellType7
#> 112                                             CellType1; CellType4; CellType5; CellType8
#> 113                                             CellType1; CellType4; CellType6; CellType7
#> 114                                             CellType1; CellType4; CellType6; CellType8
#> 115                                             CellType1; CellType4; CellType7; CellType8
#> 116                                             CellType1; CellType5; CellType6; CellType7
#> 117                                             CellType1; CellType5; CellType6; CellType8
#> 118                                             CellType1; CellType5; CellType7; CellType8
#> 119                                             CellType1; CellType6; CellType7; CellType8
#> 120                                             CellType2; CellType3; CellType4; CellType5
#> 121                                             CellType2; CellType3; CellType4; CellType6
#> 122                                             CellType2; CellType3; CellType4; CellType7
#> 123                                             CellType2; CellType3; CellType4; CellType8
#> 124                                             CellType2; CellType3; CellType5; CellType6
#> 125                                             CellType2; CellType3; CellType5; CellType7
#> 126                                             CellType2; CellType3; CellType5; CellType8
#> 127                                             CellType2; CellType3; CellType6; CellType7
#> 128                                             CellType2; CellType3; CellType6; CellType8
#> 129                                             CellType2; CellType3; CellType7; CellType8
#> 130                                             CellType2; CellType4; CellType5; CellType6
#> 131                                             CellType2; CellType4; CellType5; CellType7
#> 132                                             CellType2; CellType4; CellType5; CellType8
#> 133                                             CellType2; CellType4; CellType6; CellType7
#> 134                                             CellType2; CellType4; CellType6; CellType8
#> 135                                             CellType2; CellType4; CellType7; CellType8
#> 136                                             CellType2; CellType5; CellType6; CellType7
#> 137                                             CellType2; CellType5; CellType6; CellType8
#> 138                                             CellType2; CellType5; CellType7; CellType8
#> 139                                             CellType2; CellType6; CellType7; CellType8
#> 140                                             CellType3; CellType4; CellType5; CellType6
#> 141                                             CellType3; CellType4; CellType5; CellType7
#> 142                                             CellType3; CellType4; CellType5; CellType8
#> 143                                             CellType3; CellType4; CellType6; CellType7
#> 144                                             CellType3; CellType4; CellType6; CellType8
#> 145                                             CellType3; CellType4; CellType7; CellType8
#> 146                                             CellType3; CellType5; CellType6; CellType7
#> 147                                             CellType3; CellType5; CellType6; CellType8
#> 148                                             CellType3; CellType5; CellType7; CellType8
#> 149                                             CellType3; CellType6; CellType7; CellType8
#> 150                                             CellType4; CellType5; CellType6; CellType7
#> 151                                             CellType4; CellType5; CellType6; CellType8
#> 152                                             CellType4; CellType5; CellType7; CellType8
#> 153                                             CellType4; CellType6; CellType7; CellType8
#> 154                                             CellType5; CellType6; CellType7; CellType8
#> 155                                  CellType1; CellType2; CellType3; CellType4; CellType5
#> 156                                  CellType1; CellType2; CellType3; CellType4; CellType6
#> 157                                  CellType1; CellType2; CellType3; CellType4; CellType7
#> 158                                  CellType1; CellType2; CellType3; CellType4; CellType8
#> 159                                  CellType1; CellType2; CellType3; CellType5; CellType6
#> 160                                  CellType1; CellType2; CellType3; CellType5; CellType7
#> 161                                  CellType1; CellType2; CellType3; CellType5; CellType8
#> 162                                  CellType1; CellType2; CellType3; CellType6; CellType7
#> 163                                  CellType1; CellType2; CellType3; CellType6; CellType8
#> 164                                  CellType1; CellType2; CellType3; CellType7; CellType8
#> 165                                  CellType1; CellType2; CellType4; CellType5; CellType6
#> 166                                  CellType1; CellType2; CellType4; CellType5; CellType7
#> 167                                  CellType1; CellType2; CellType4; CellType5; CellType8
#> 168                                  CellType1; CellType2; CellType4; CellType6; CellType7
#> 169                                  CellType1; CellType2; CellType4; CellType6; CellType8
#> 170                                  CellType1; CellType2; CellType4; CellType7; CellType8
#> 171                                  CellType1; CellType2; CellType5; CellType6; CellType7
#> 172                                  CellType1; CellType2; CellType5; CellType6; CellType8
#> 173                                  CellType1; CellType2; CellType5; CellType7; CellType8
#> 174                                  CellType1; CellType2; CellType6; CellType7; CellType8
#> 175                                  CellType1; CellType3; CellType4; CellType5; CellType6
#> 176                                  CellType1; CellType3; CellType4; CellType5; CellType7
#> 177                                  CellType1; CellType3; CellType4; CellType5; CellType8
#> 178                                  CellType1; CellType3; CellType4; CellType6; CellType7
#> 179                                  CellType1; CellType3; CellType4; CellType6; CellType8
#> 180                                  CellType1; CellType3; CellType4; CellType7; CellType8
#> 181                                  CellType1; CellType3; CellType5; CellType6; CellType7
#> 182                                  CellType1; CellType3; CellType5; CellType6; CellType8
#> 183                                  CellType1; CellType3; CellType5; CellType7; CellType8
#> 184                                  CellType1; CellType3; CellType6; CellType7; CellType8
#> 185                                  CellType1; CellType4; CellType5; CellType6; CellType7
#> 186                                  CellType1; CellType4; CellType5; CellType6; CellType8
#> 187                                  CellType1; CellType4; CellType5; CellType7; CellType8
#> 188                                  CellType1; CellType4; CellType6; CellType7; CellType8
#> 189                                  CellType1; CellType5; CellType6; CellType7; CellType8
#> 190                                  CellType2; CellType3; CellType4; CellType5; CellType6
#> 191                                  CellType2; CellType3; CellType4; CellType5; CellType7
#> 192                                  CellType2; CellType3; CellType4; CellType5; CellType8
#> 193                                  CellType2; CellType3; CellType4; CellType6; CellType7
#> 194                                  CellType2; CellType3; CellType4; CellType6; CellType8
#> 195                                  CellType2; CellType3; CellType4; CellType7; CellType8
#> 196                                  CellType2; CellType3; CellType5; CellType6; CellType7
#> 197                                  CellType2; CellType3; CellType5; CellType6; CellType8
#> 198                                  CellType2; CellType3; CellType5; CellType7; CellType8
#> 199                                  CellType2; CellType3; CellType6; CellType7; CellType8
#> 200                                  CellType2; CellType4; CellType5; CellType6; CellType7
#> 201                                  CellType2; CellType4; CellType5; CellType6; CellType8
#> 202                                  CellType2; CellType4; CellType5; CellType7; CellType8
#> 203                                  CellType2; CellType4; CellType6; CellType7; CellType8
#> 204                                  CellType2; CellType5; CellType6; CellType7; CellType8
#> 205                                  CellType3; CellType4; CellType5; CellType6; CellType7
#> 206                                  CellType3; CellType4; CellType5; CellType6; CellType8
#> 207                                  CellType3; CellType4; CellType5; CellType7; CellType8
#> 208                                  CellType3; CellType4; CellType6; CellType7; CellType8
#> 209                                  CellType3; CellType5; CellType6; CellType7; CellType8
#> 210                                  CellType4; CellType5; CellType6; CellType7; CellType8
#> 211                       CellType1; CellType2; CellType3; CellType4; CellType5; CellType6
#> 212                       CellType1; CellType2; CellType3; CellType4; CellType5; CellType7
#> 213                       CellType1; CellType2; CellType3; CellType4; CellType5; CellType8
#> 214                       CellType1; CellType2; CellType3; CellType4; CellType6; CellType7
#> 215                       CellType1; CellType2; CellType3; CellType4; CellType6; CellType8
#> 216                       CellType1; CellType2; CellType3; CellType4; CellType7; CellType8
#> 217                       CellType1; CellType2; CellType3; CellType5; CellType6; CellType7
#> 218                       CellType1; CellType2; CellType3; CellType5; CellType6; CellType8
#> 219                       CellType1; CellType2; CellType3; CellType5; CellType7; CellType8
#> 220                       CellType1; CellType2; CellType3; CellType6; CellType7; CellType8
#> 221                       CellType1; CellType2; CellType4; CellType5; CellType6; CellType7
#> 222                       CellType1; CellType2; CellType4; CellType5; CellType6; CellType8
#> 223                       CellType1; CellType2; CellType4; CellType5; CellType7; CellType8
#> 224                       CellType1; CellType2; CellType4; CellType6; CellType7; CellType8
#> 225                       CellType1; CellType2; CellType5; CellType6; CellType7; CellType8
#> 226                       CellType1; CellType3; CellType4; CellType5; CellType6; CellType7
#> 227                       CellType1; CellType3; CellType4; CellType5; CellType6; CellType8
#> 228                       CellType1; CellType3; CellType4; CellType5; CellType7; CellType8
#> 229                       CellType1; CellType3; CellType4; CellType6; CellType7; CellType8
#> 230                       CellType1; CellType3; CellType5; CellType6; CellType7; CellType8
#> 231                       CellType1; CellType4; CellType5; CellType6; CellType7; CellType8
#> 232                       CellType2; CellType3; CellType4; CellType5; CellType6; CellType7
#> 233                       CellType2; CellType3; CellType4; CellType5; CellType6; CellType8
#> 234                       CellType2; CellType3; CellType4; CellType5; CellType7; CellType8
#> 235                       CellType2; CellType3; CellType4; CellType6; CellType7; CellType8
#> 236                       CellType2; CellType3; CellType5; CellType6; CellType7; CellType8
#> 237                       CellType2; CellType4; CellType5; CellType6; CellType7; CellType8
#> 238                       CellType3; CellType4; CellType5; CellType6; CellType7; CellType8
#> 239            CellType1; CellType2; CellType3; CellType4; CellType5; CellType6; CellType7
#> 240            CellType1; CellType2; CellType3; CellType4; CellType5; CellType6; CellType8
#> 241            CellType1; CellType2; CellType3; CellType4; CellType5; CellType7; CellType8
#> 242            CellType1; CellType2; CellType3; CellType4; CellType6; CellType7; CellType8
#> 243            CellType1; CellType2; CellType3; CellType5; CellType6; CellType7; CellType8
#> 244            CellType1; CellType2; CellType4; CellType5; CellType6; CellType7; CellType8
#> 245            CellType1; CellType3; CellType4; CellType5; CellType6; CellType7; CellType8
#> 246            CellType2; CellType3; CellType4; CellType5; CellType6; CellType7; CellType8
#> 247 CellType1; CellType2; CellType3; CellType4; CellType5; CellType6; CellType7; CellType8
```

The combination of cell types corresponding to the maximum AUC value was
selected

``` r
cellsets <- maxroc(acroc = cdiv)
print(cellsets)
#>       roc.auc                                                         cellsets
#> 228 0.9932912 CellType1; CellType3; CellType4; CellType5; CellType7; CellType8
```
