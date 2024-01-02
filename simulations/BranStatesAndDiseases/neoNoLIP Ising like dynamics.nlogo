extensions [array table vid]


;; Global variables (partly really global, partly just temporary variables)
globals [
   ;; Temporary variables
   i                                  ;; Iterator
   activationexchange                 ;; Variable to exchange activation0 and activation0a
   minimummargin                      ;; Variable necessary to calculate the minimum

   ;; Clustering (clusters created lesions)
   lesionsize                         ;; defiens how big each lesion is
   lesionnumber                       ;; stores the number of lesions
   lesionall
   normalneighbors                    ;; differs between different kind of neighbours
   lesionneighbors
   clusterlistxcor                    ;; stores the coordinates of clusterered patches
   clusterlistycor
   toobigcount                        ;; decides when lesions are to big ( not fitting to the treshold size of lesions)
   toobig
   extensor                           ;; used to extend lesions

   ;; Output parameteres
   slope_vector_of_patch
   slope_old_of_patch
   activation0_of_patch
   activation1_of_patch
   sum_of_patch

   sum_of_slopes
   sum_of_patches
   slope_of_all

   ;; spontaneous activity
   sponact                           ;; utilized to estimate the probability of spontaneous activity

   ;; coloring
   colornormal                       ;; The normal base-color
   colormargin                       ;; The margin color


   ;; Instruction
   current-instruction               ;; counter for keeping track of which instruction is displayed in output window
   show-instrcution

   ;; others
   tickcounter                       ;; counts every tick
   margin                            ;; Size of the margin to extinguish reflections
   counter-k-complex                 ;; used for size of k-komplex
   counter-sleep-spindel             ;; used for pattern of sleep-spindel
   period-counter                    ;; defines in which period the sleep spindel is fireing
   output_hash                       ;; hash to store output coordinates
   ratio_inhibition_activation2

   prime_numbers                     ;; list of prime number
   x1 x2 x3 x4 x5 x6
   y1 y2

   ;; input variables
   counter1 counter2 counter3 counter4 counter5 counter6 counter7 counter8 counter9 counter10 counter11 counter12 counter13 counter14 counter15 counter16 counter17 counter18 counter19 counter20 counter21 counterca counterca2 counterp

   ;; set onset of bursts
   burst1 burst2 burst3 burst4 burst5 burst6 burst7 burst8 burst9 burst10 burst11 burst12 burst13 burst14 burst15 burst16 burst17 burst18 burst19 burst20 burst21 burstca burstca2 burstp

   ;; set length of bursts
   length_bursts

   ;; set length of bursts for individual inputs
   burst1_length burst2_length burst3_length burst4_length burst5_length burst6_length burst7_length burst8_length burst9_length burst10_length
   burst11_length burst12_length burst13_length burst14_length burst15_length burst16_length burst17_length burst18_length burst19_length burst20_length
   burst21_length burstca_length burstca2_length burstp_length

   ;; set signal coordinates
   axcor1 aycor1 bxcor1 bycor1 cxcor1 cycor1 dxcor1 dycor1 excor1 eycor1 fxcor1 fycor1 gxcor1 gycor1 hxcor1 hycor1 ixcor1 iycor1 jxcor1 jycor1 kxcor1 kycor1 lxcor1 lycor1 mxcor1 mycor1 nxcor1 nycor1
   oxcor1 oycor1 qxcor1 qycor1 rxcor1 rycor1 sxcor1 sycor1 txcor1 tycor1 uxcor1 uycor1 vxcor1 vycor1 ersxcor1 ersycor1

   ;; set coordinates for random walk of signal
   random_loc
   loc1 loc2 loc3 loc4 loc5 loc6 loc7 loc8 loc9 loc10 loc11 loc12 loc13 loc14 loc15 loc16 loc17 loc18 loc19 loc20 loc21 locca locca2 locp

   ;; set signal frequency
   sl1 sl2 sl3 sl4 sl5 sl6 sl7 sl8 sl9 sl10 sl11 sl12 sl13 sl14 sl15 sl16 sl17 sl18 sl19 sl20 sl21
   slca1 slca2 slca3 slca4 slca5 slca6 slca7 slca8 slca9 slca10 slca11 slca12 slca13 slca14 slca15 slca16 slca17 slca18 slca19 slca20 slca21 ca1

   ;; set active carrier signals
   rm1 rm2 rm3 rm4 rm5 rm6 rm7 rm8 rm9 rm10 rm11 rm12 rm13 rm14 rm15 rm16 rm17 rm18 rm19 rm20 rm21

   ;; set signal strength
   st1 st2 st3 st4 st5 st6 st7 st8 st9 st10 st11 st12 st13 st14 st15 st16 st17 st18 st19 st20 st21
   st1ca st2ca st3ca st4ca st5ca st6ca st7ca st8ca st9ca st10ca st11ca st12ca st13ca st14ca st15ca st16ca st17ca st18ca st19ca st20ca st21ca

   ;; set phase
   ph1 ph2 ph3 ph4 ph5 ph6 ph7 ph8 ph9 ph10
   ph11 ph12 ph13 ph14 ph15 ph16 ph17 ph18 ph19 ph20 ph21
   phca1 phca2 phca3 phca4 phca5 phca6 phca7 phca8 phca9 phca10
   phca11 phca12 phca13 phca14 phca15 phca16 phca17 phca18 phca19 phca20 phca21
]



;; Variables of the patches
patches-own [
  activation0                        ;; Actual activation level
  activation00
  activation1                        ;; Activation level the tick before
  activation1.1


  slope_old                          ;; Activation change of actual act
  slope_new
  slope_modulation                   ;; Inhibitories can alter the slope dynamically
  slope_vector                       ;; sum or mean of all slopes
  NI_slopevdynamic

  aktivierung-oben  aktivierung-unten  aktivierung-rechts  aktivierung-links
  aktivierung-obenrechts  aktivierung-obenlinks  aktivierung-untenrechts  aktivierung-untenlinks
  aktivierung-obenoben  aktivierung-untenunten  aktivierung-rechtsrechts  aktivierung-linkslinks
  aktivierung-orr  aktivierung-oll  aktivierung-urr  aktivierung-ull
  aktivierung-oor  aktivierung-ool  aktivierung-uur  aktivierung-uul
  aktivierung-ooo  aktivierung-uuu  aktivierung-rrr  aktivierung-lll
  aktivierung-oorr  aktivierung-ooll  aktivierung-uurr  aktivierung-uull
  aktivierung-oooo  aktivierung-uuuu  aktivierung-rrrr  aktivierung-llll
  aktivierung-ooor  aktivierung-oool  aktivierung-uuur  aktivierung-uuul
  aktivierung-orrr  aktivierung-olll  aktivierung-urrr  aktivierung-ulll
  aktivierung-ooooo  aktivierung-uuuuu  aktivierung-rrrrr  aktivierung-lllll
  aktivierung-oooor  aktivierung-ooool  aktivierung-uuuur  aktivierung-uuuul
  aktivierung-orrrr  aktivierung-ollll  aktivierung-urrrr  aktivierung-ullll
  aktivierung-oorrr  aktivierung-oolll  aktivierung-uurrr  aktivierung-uulll
  aktivierung-ooorr  aktivierung-oooll  aktivierung-uuurr  aktivierung-uuull
                                     ;; Activation of the neighbours

  neighbourcount                     ;; temporary Variable to calculate the number of neighbours (currently not used)

  ;; Flags to characterise cells
  input?                             ;; Input cell?
  output?                            ;; Output cell?
  inaktiv?                           ;; inactive (or defect) cell?
  istRand?                           ;; is the cell inside the margin?
  lesion?                            ;; is this a starting point of lesion in brainslide
  lesioncluster?                     ;; is it a cluster of inaktiv neurons
  cluster?                           ;; is clustering allowed:: this should enfatsen the algorithm
  isEEG?
]


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Initializing the patches......................................................................................................................................................................
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to initialize
  clear-all

  ;; Clustering the Patches (Alzheimers)
  set clusterlistxcor []
  set clusterlistycor []
  set lesionsize 0
  set lesionnumber 0
  set lesionall 0
  set toobigcount 0
  set toobig 0
  set extensor 0

  ;; Output parameter
  set slope_vector_of_patch 0
  set slope_old_of_patch 0
  set activation0_of_patch 0
  set activation1_of_patch 0
  set sum_of_patch 0

  set sum_of_patches 0
  set sum_of_slopes 0
  set slope_of_all 0

  ;; spontaneous activity
  set sponact random-float 2 - 1

  ;; other global variables
  set colornormal ( backgroundcolors * 10 ) + 8
  ;set colornormal blue
  set colormargin margincolor
  set margin margin_size
  set counter-k-complex 0
  set counter-sleep-spindel 0
  set period-counter 0
  set tickcounter 0
  set output_hash table:make

  ;; set burst onset, burst length and random woalk of input
  ifelse bursts_on
  [
    set burst1 random 1003 set burst2 random 1003 set burst3 random 1003 set burst4 random 1003 set burst5 random 1003
    set burst6 random 1003 set burst7 random 1003 set burst8 random 1003  set burst9 random 1003  set burst10 random 1003
    set burst11 random 1003  set burst12 random 1003  set burst13 random 1003   set burst14 random 1003  set burst15 random 1003
    set burst16 random 1003  set burst17 random 1003 set burst18 random 1003  set burst19 random 1003  set burst20 random 1003
    set burst21 random 1003  set burstca random 1003 set burstca2 random 1003  set burstp random 1003

    set counter1 0   set counter2 0   set counter3 0    set counter4 0   set counter5 0  set counter6 0   set counter7 0   set counter8 0   set counter9 0   set counter10 0
    set counter11 0  set counter12 0  set counter13 0   set counter14 0  set counter15 0 set counter16 0  set counter17 0  set counter18 0  set counter19 0  set counter20 0
    set counter21 0  set counterca 0  set counterca2 0  set counterp 0

    set loc1 0  set loc2 0   set loc3 0    set loc4 0   set loc5 0   set loc6 0   set loc7 0   set loc8 0   set loc9 0   set loc10 0
    set loc11 0  set loc12 0  set loc13 0   set loc14 0  set loc15 0 set loc16 0  set loc17 0  set loc18 0  set loc19 0  set loc20 0
    set loc21 0  set locca 0  set locca2 0  set locp 0

    set random_loc 1

    set length_bursts 200

    set burst1_length random 107  set burst2_length random 107  set burst3_length random 107  set burst4_length random 107  set burst5_length random 107  set burst6_length random 107  set burst7_length random 107  set burst8_length random 107  set burst9_length random 107  set burst10_length random 107
    set burst11_length random 107  set burst12_length random 107  set burst13_length random 107  set burst14_length random 107  set burst15_length random 107  set burst16_length random 107  set burst17_length random 107  set burst18_length random 107 set burst19_length random 107  set burst20_length random 107
    set burst21_length random 107  set burstca_length random 107  set burstca2_length random 107 set burstp_length random 107
  ]
  [
    set burst1 1     set burst2 1     set burst3 1      set burst4 1     set burst5 1    set burst6 1     set burst7 1     set burst8 1     set burst9 1     set burst10 1
    set burst11 1    set burst12 1    set burst13 1     set burst14 1    set burst15 1   set burst16 1    set burst17 1    set burst18 1    set burst19 1    set burst20 1
    set burst21 1    set burstca 1    set burstca2 1    set burstp 1

    set counter1 0   set counter2 0   set counter3 0    set counter4 0   set counter5 0  set counter6 0   set counter7 0   set counter8 0   set counter9 0   set counter10 0
    set counter11 0  set counter12 0  set counter13 0   set counter14 0  set counter15 0 set counter16 0  set counter17 0  set counter18 0  set counter19 0  set counter20 0
    set counter21 0  set counterca 0  set counterca2 0  set counterp 0

    set loc1 0   set loc2 0   set loc3 0    set loc4 0   set loc5 0   set loc6 0   set loc7 0   set loc8 0   set loc9 0   set loc10 0
    set loc11 0  set loc12 0  set loc13 0   set loc14 0  set loc15 0  set loc16 0  set loc17 0  set loc18 0  set loc19 0  set loc20 0
    set loc21 0  set locca 0  set locca2 0  set locp 0

    set random_loc 0

    set length_bursts finish

    set burst1_length length_bursts  set burst2_length length_bursts  set burst3_length length_bursts  set burst4_length length_bursts  set burst5_length length_bursts  set burst6_length length_bursts  set burst7_length length_bursts  set burst8_length length_bursts  set burst9_length length_bursts  set burst10_length length_bursts
    set burst11_length length_bursts  set burst12_length length_bursts  set burst13_length length_bursts  set burst14_length length_bursts  set burst15_length length_bursts  set burst16_length length_bursts  set burst17_length length_bursts  set burst18_length length_bursts set burst19_length length_bursts  set burst20_length length_bursts
    set burst21_length length_bursts  set burstca_length length_bursts  set burstca2_length length_bursts set burstp_length length_bursts
  ]

  ;; set location of input,frequency, strength and phase
  ifelse 1 = 0
  [
    ;; coordinates
    set axcor1 axcor set aycor1 aycor set bxcor1 bxcor set bycor1 bycor set cxcor1 cxcor set cycor1 cycor
    set dxcor1 dxcor set dycor1 dycor set excor1 excor set eycor1 eycor set fxcor1 fxcor set fycor1 fycor
    set gxcor1 gxcor set gycor1 gycor set hxcor1 hxcor set hycor1 hycor set ixcor1 ixcor set iycor1 iycor
    set jxcor1 jxcor set jycor1 jycor set kxcor1 kxcor set kycor1 kycor set lxcor1 lxcor set lycor1 lycor
    set mxcor1 mxcor set mycor1 mycor set nxcor1 nxcor set nycor1 hycor set oxcor1 oxcor set oycor1 oycor
    set qxcor1 qxcor set qycor1 qycor set rxcor1 rxcor set rycor1 rycor set sxcor1 sxcor set sycor1 sycor
    set txcor1 txcor set tycor1 tycor set uxcor1 uxcor set uycor1 uycor set vxcor1 vxcor set vycor1 vycor

    ;; frequency
    set sl1 signal1 set sl2 signal2 set sl3 signal3 set sl4 signal4 set sl5 signal5 set sl6 signal6 set sl7 signal7 set sl8 signal8 set sl9 signal9 set sl10 signal10
    set sl11 signal11 set sl12 signal12 set sl13 signal13 set sl14 signal14 set sl15 signal15 set sl16 signal16 set sl17 signal17 set sl18 signal18 set sl19 signal19 set sl20 signal20 set sl21 signal21
    set slca1 carriersignal  set slca2 carriersignal + 4 set slca3 carriersignal + 8 set slca4 carriersignal + 12 set slca5 carriersignal + 16 set slca6 carriersignal + 20 set slca7 carriersignal + 24 set slca8 carriersignal + 28 set slca9 carriersignal + 32 set slca10 carriersignal + 36
    set slca11 carriersignal + 40 set slca12 carriersignal + 44 set slca13 carriersignal + 48 set slca14 carriersignal + 52 set slca15 carriersignal + 56 set slca16 carriersignal + 60 set slca17 carriersignal + 64 set slca18 carriersignal + 68 set slca19 carriersignal + 72 set slca20 carriersignal + 76 set slca21 carriersignal + 80

    ;; signal strength
    set st1 1 set st2 1 set st3 1 set st4 1 set st5 1 set st6 1 set st7 1 set st8 1 set st9 1 set st10 1
    set st11 1 set st12 1 set st13 1 set st14 1 set st15 1 set st16 1 set st17 1 set st18 1 set st19 1 set st20 1
    set st21 1
    set st1ca 1 set st2ca 1 set st3ca 1 set st4ca 1 set st5ca 1 set st6ca 1 set st7ca 1 set st8ca 1 set st9ca 1 set st10ca 1
    set st11ca 1 set st12ca 1 set st13ca 1 set st14ca 1 set st15ca 1 set st16ca 1 set st17ca 1 set st18ca 1 set st19ca 1 set st20ca 1
    set st21ca 1

    ;; phase
    set ph1 random 360 set ph2 random 360 set ph3 random 360 set ph4 random 360 set ph5 random 360 set ph6 random 360 set ph7 random 360 set ph8 random 360 set ph9 random 360 set ph10 random 360
    set ph11 random 360 set ph12 random 360 set ph13 random 360 set ph14 random 360 set ph15 random 360 set ph16 random 360 set ph17 random 360 set ph18 random 360 set ph19 random 360 set ph20 random 360 set ph21 random 360
    set phca1 random 360 set phca2 random 360 set phca3 random 360 set phca4 random 360 set phca5 random 360 set phca6 random 360 set phca7 random 360 set phca8 random 360 set phca9 random 360 set phca10 random 360
    set phca11 random 360 set phca12 random 360 set phca13 random 360 set phca14 random 360 set phca15 random 360 set phca16 random 360 set phca17 random 360 set phca18 random 360 set phca19 random 360 set phca20 random 360 set phca21 random 360
  ]
  [
    ;; coordinates
    set axcor1 ( random 40 ) - 20 set aycor1 ( random 40 ) - 20 set bxcor1 ( random 40 ) - 20 set bycor1 ( random 40 ) - 20 set cxcor1 ( random 40 ) - 20 set cycor1 ( random 40 ) - 20
    set dxcor1 ( random 40 ) - 20 set dycor1 ( random 40 ) - 20 set excor1 ( random 40 ) - 20 set eycor1 ( random 40 ) - 20 set fxcor1 ( random 40 ) - 20 set fycor1 ( random 40 ) - 20
    set gxcor1 ( random 40 ) - 20 set gycor1 ( random 40 ) - 20 set hxcor1 ( random 40 ) - 20 set hycor1 ( random 40 ) - 20 set ixcor1 ( random 40 ) - 20 set iycor1 ( random 40 ) - 20
    set jxcor1 ( random 40 ) - 20 set jycor1 ( random 40 ) - 20 set kxcor1 ( random 40 ) - 20 set kycor1 ( random 40 ) - 20 set lxcor1 ( random 40 ) - 20 set lycor1 ( random 40 ) - 20
    set mxcor1 ( random 40 ) - 20 set mycor1 ( random 40 ) - 20 set nxcor1 ( random 40 ) - 20 set nycor1 ( random 40 ) - 20 set oxcor1 ( random 40 ) - 20 set oycor1 ( random 40 ) - 20
    set qxcor1 ( random 40 ) - 20 set qycor1 ( random 40 ) - 20 set rxcor1 ( random 40 ) - 20 set rycor1 ( random 40 ) - 20 set sxcor1 ( random 40 ) - 20 set sycor1 ( random 40 ) - 20
    set txcor1 ( random 40 ) - 20 set tycor1 ( random 40 ) - 20 set uxcor1 ( random 40 ) - 20 set uycor1 ( random 40 ) - 20 set vxcor1 ( random 40 ) - 20 set vycor1 ( random 40 ) - 20
    set ersxcor1 ( random 40 ) - 20 set ersycor1 ( random 40 ) - 20

    ;; frequency
    set sl1 random-float ( 100 ) + 400 set sl2 random-float ( 100 ) + 400 set sl3 random-float ( 100 ) + 400 set sl4 random-float ( 100 ) + 400 set sl5 random-float ( 100 ) + 400 set sl6 random-float ( 100 ) + 400 set sl7 random-float ( 100 ) + 400 set sl8 random-float ( 100 ) + 400 set sl9 random-float ( 100 ) + 400 set sl10 random-float ( 100 ) + 400
    set sl11 random-float ( 100 ) + 400 set sl12 random-float ( 100 ) + 400 set sl13 random-float ( 100 ) + 400 set sl14 random-float ( 100 ) + 400 set sl15 random-float ( 100 ) + 400 set sl16 random-float ( 100 ) + 400 set sl17 random-float ( 100 ) + 400 set sl18 random-float ( 100 ) + 400 set sl19 random-float ( 100 ) + 400 set sl20 random-float ( 100 ) + 400 set sl21 random-float ( 100 ) + 400
    set slca1 random-float 103 set slca2 random-float 103 set slca3 random-float 103 set slca4 random-float 103 set slca5 random-float 103 set slca6 random-float 103 set slca7 random-float 103 set slca8 random-float 103 set slca9 random-float 103 set slca10 random-float 103
    set slca11 random-float 103 set slca12 random-float 103 set slca13 random-float 103 set slca14 random-float 103 set slca15 random-float 103 set slca16 random-float 103 set slca17 random-float 103 set slca18 random-float 103 set slca19 random-float 103 set slca20 random-float 103 set slca21 random-float 103
    set ca1 random-float 103

    ;; signal strength
    set st1 random-float 2 set st2 random-float 2 set st3 random-float 2 set st4 random-float 2 set st5 random-float 2 set st6 random-float 2 set st7 random-float 2 set st8 random-float 2 set st9 random-float 2 set st10 random-float 2
    set st11 random-float 2 set st12 random-float 2 set st13 random-float 2 set st14 random-float 2 set st15 random-float 2 set st16 random-float 2 set st17 random-float 2 set st18 random-float 2 set st19 random-float 2 set st20 random-float 2
    set st21 random-float 2
    set st1ca random-float 2 set st2ca random-float 2 set st3ca random-float 2 set st4ca random-float 2 set st5ca random-float 2 set st6ca random-float 2 set st7ca random-float 2 set st8ca random-float 2 set st9ca random-float 2 set st10ca random-float 2
    set st11ca random-float 2 set st12ca random-float 2 set st13ca random-float 2 set st14ca random-float 2 set st15ca random-float 2 set st16ca random-float 2 set st17ca random-float 2 set st18ca random-float 2 set st19ca random-float 2 set st20ca random-float 2
    set st21ca random-float 2

    ;; phase
    set ph1 random 360 set ph2 random 360 set ph3 random 360 set ph4 random 360 set ph5 random 360 set ph6 random 360 set ph7 random 360 set ph8 random 360 set ph9 random 360 set ph10 random 360
    set ph11 random 360 set ph12 random 360 set ph13 random 360 set ph14 random 360 set ph15 random 360 set ph16 random 360 set ph17 random 360 set ph18 random 360 set ph19 random 360 set ph20 random 360 set ph21 random 360
    set phca1 random 360 set phca2 random 360 set phca3 random 360 set phca4 random 360 set phca5 random 360 set phca6 random 360 set phca7 random 360 set phca8 random 360 set phca9 random 360 set phca10 random 360
    set phca11 random 360 set phca12 random 360 set phca13 random 360 set phca14 random 360 set phca15 random 360 set phca16 random 360 set phca17 random 360 set phca18 random 360 set phca19 random 360 set phca20 random 360 set phca21 random 360
  ]

  ;; set active carrier sigmals
  set rm1 random 5 set rm2 random 5 set rm3 random 5 set rm4 random 5 set rm5 random 5 set rm6 random 5 set rm7 random 5 set rm8 random 5 set rm9 random 5 set rm10 random 5
  set rm11 random 5 set rm12 random 5 set rm13 random 5 set rm14 random 5 set rm15 random 5 set rm16 random 5 set rm17 random 5 set rm18 random 5 set rm19 random 5 set rm20 random 5 set rm21 random 5



  ;; set the prime numbers
  ;set prime_numbers [ 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 79 83 89 101 109 131 139 163 193 239 ]
  set prime_numbers [ 2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97 101 103 107 109 113 127 131 137 139 149 151 157 163 167 173 179 181 191 193 197 199 211 223 227 229 233 239 241 251 257 263 269 271 277 281 283 293 307 311 313 317 331 337 347 349 353 359 367 373 379 383 389 397 401 409 419 421 431 433 439 443 449 457 461 463 467 479 487 491 499 ]
  ;; set prime_numbers [ 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 79 83 89 101 109 131 139 163 ]
  ;;set prime_numbers [ 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 79 ]
  ;;set prime_numbers [ 0.5 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 ]
  ;;set prime_numbers [ 7 50 ]
  ;;set prime_numbers [ 234 423 397 193 472 274 389 192 116 210 321 ]

  ;; initialize inputs (neccessary to avoid resonancy problems with inputs and inactive patches in the neighbourhood)
  ask patches
  [
    ifelse (  pxcor = axcor AND pycor = aycor OR pxcor = bxcor AND pycor = bycor OR pxcor = cxcor AND pycor = cycor OR pxcor = dxcor AND pycor = dycor OR
              pxcor = excor AND pycor = eycor OR pxcor = fxcor AND pycor = fycor OR pxcor = gxcor AND pycor = gycor OR pxcor = hxcor AND pycor = hycor OR
              pxcor = ixcor AND pycor = iycor OR pxcor = jxcor AND pycor = jycor OR pxcor = ersxcor AND pycor = ersycor ); OR pxcor = xdir AND pycor = ydir )
    [ set input? true ]
    [ set input? false ]
  ]

  ;; initialize all neuronal columns
  ask patches
  [
    ;set slope_old random-float 100
    set lesioncluster? false
    set lesion? false
    set output? false
    set inaktiv? false
    set cluster? false
    set isEEG? false
    ;; Check if the neuronal column is on the margin or not. If not, define them as normal and active
    ifelse ( pxcor > ( min-pxcor + margin ) ) AND ( pxcor < ( max-pxcor - margin ) ) AND ( pycor > ( min-pycor + margin ) ) AND ( pycor < ( max-pycor - margin ) )
    [
      set pcolor colornormal            ;; Normal, active columns are colored normal
      set cluster? true                 ;; Neuronal columns own the ability to be affected by lesions
      set istRand? false
      ;; initialize outputs and set coordinates for the MEA plot
      let maxx abs(max-pxcor) + abs(min-pxcor)
      let maxy abs(max-pycor) + abs(min-pycor)
      set x1 -3
      set x2 0
      set x3 3
      set x4 -3
      set x5 0
      set x6 3
      set y1 -3
      set y2 3


      ifelse  ( pxcor = x1 AND pycor = y1 ) OR ( pxcor = x4 AND pycor = y2 ) OR
              ( pxcor = x2 AND pycor = y1 ) OR ( pxcor = x5 AND pycor = y2 ) OR
              ( pxcor = x3 AND pycor = y1 ) OR ( pxcor = x6 AND pycor = y2 )
      [
        ;; initialize output (coloring, clustering, labeling, coordinates)
        initializeOutput pxcor pycor maxx maxy
      ]
      [
        ;; Initialize inactive patches (lesions), if the percentage is > 0. Then check if they should be arranged regularely or randomly. Neighbours to input neurons can't be
        ;; inactive, because this would cause resonancy phenomenons
        ifelse ( lesions / 100 > 0 ) AND ( ( regular AND ( ( pxcor + pycor ) mod ( round ( 1 / lesions ) ) = 0 ) ) OR ( ( NOT regular ) AND ( random-float 1.0 < ( lesions / 100 ) ) ) ) AND
               ( NOT input? ) AND ( NOT [input?] of patch-at -1 -1 ) AND ( NOT [input?] of patch-at -1 0 ) AND ( NOT [input?] of patch-at -1 1 ) AND ( NOT [input?] of patch-at 0 -1 ) AND
               ( NOT [input?] of patch-at 0 1 ) AND ( NOT [input?] of patch-at 1 -1 ) AND ( NOT [input?] of patch-at 1 0 ) AND ( NOT [input?] of patch-at 1 1 )
        [
          set inaktiv? true
          set lesion? true
          set lesionnumber lesionnumber + 1
          set pcolor white
          set cluster? false
        ]
        [ set inaktiv? false ]
        ;;prevent lesions from setting up to close to the inputs
        if ( input? ) OR ( [input?] of patch-at -1 -1 ) OR ( [input?] of patch-at -1 0 ) OR ( [input?] of patch-at -1 1 ) OR ( [input?] of patch-at 0 -1 ) OR
           ( [input?] of patch-at 0 1 ) OR ( [input?] of patch-at 1 -1 ) OR ( [input?] of patch-at 1 0 ) OR ( [input?] of patch-at 1 1 )
        [
          set cluster? false
          set lesion? false
          set inaktiv? false
        ]
        ;; set corpus collosum
        ;if ( pycor < corpusoben AND pxcor > 0 AND pycor > corpusunten and pxcor < corpuslinks) OR ( pycor < corpusoben AND pxcor > corpusrechts AND pycor > corpusunten and pxcor < 100)
        ;[
        ;  set inaktiv? true
        ;  set pcolor white
        ;]
      ]
    ]
    [ ;; initialize margin
      set pcolor colormargin
      set istRand? true
      set cluster? false
      ;if ( pycor < corpusoben AND pycor > corpusunten and pxcor < corpuslinks) OR ( pycor < corpusoben AND pycor > corpusunten AND pxcor > corpusrechts )
      ;[ set inaktiv? true set pcolor white]
    ]
  ]
  print word "Number of lesions is: " lesionnumber
  ;; initialize plots
  do-plots

  reset-ticks
  tick
end
;; end of Initializing
;;...............................................................................................................................................................................................................


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Initialize the output patches (coloring, active, clustering, coordinates)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to initializeOutput [ x-co y-co maxx maxy ]
  set output? true
  set inaktiv? false
  set cluster? false
  if ( NOT istRand? ) AND showMEAelectrode AND ( NOT inaktiv? )
  [ set pcolor colornormal + 26 ]
  let my_key ( word x-co "_" y-co )
  let MEAx 0
  if ( x-co = x1 AND y-co = y1 ) [ set MEAx "01" ]
  if ( x-co = x2 AND y-co = y1 ) [ set MEAx "02" ]
  if ( x-co = x3 AND y-co = y1 ) [ set MEAx "03" ]
  if ( x-co = x4 AND y-co = y2 ) [ set MEAx "04" ]
  if ( x-co = x5 AND y-co = y2 ) [ set MEAx "05" ]
  if ( x-co = x6 AND y-co = y2 ) [ set MEAx "06" ]
  table:put output_hash my_key MEAx
end
;; end of initalisiere output
;;.......................................................................................

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Labeling output
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to labeling_output [ x-co y-co ]
  if output?
  [
    ifelse showLabels
    [
      let my_key ( word x-co "_" y-co )
      let MEAx table:get output_hash my_key
      set plabel ( word "MEA" " " "0" MEAx )
    ]
    [ set plabel ""]
  ]
end
;; end labeling
;;.................................................

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; lesion clustering algorithm...............................................................................................................................................
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Grow: Loop structure that runs until the treshold size of a cluster is reached
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to grow
  if ( lesioncluster? AND lesionsize < tresholdsizelesions AND (lesionall  < ((tresholdsizelesions * lesionnumber) - lesionnumber)) )
  [ ask one-of neighbors
    [ ifelse ( NOT cluster? )
      [ grow ]
      [
        set pcolor grey
        set inaktiv? true
        set lesioncluster? true
        set lesionsize lesionsize + 1
        set lesionall lesionall + 1
        set clusterlistxcor fput pxcor clusterlistxcor
        set clusterlistycor fput pycor clusterlistycor
        grow
      ]
    ]
  ]
end
;; Cluster is to modulize the lesions. There can be many small lesions or few clustered defected neurons, dependend on treshold value and ratio of lesions.
;; let lesions grow until size is bigger than treshold2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to cluster
 ask patches
 [
   if (lesion?)
   [
     set lesionsize 0
     while [ lesionsize < tresholdsizelesions AND (lesionall < ((tresholdsizelesions * lesionnumber) - lesionnumber)) ]
     [
       ask one-of neighbors                 ;; Initialize growing by setting first neighbour of each lesion grey and lesionscluster. Than grow algorithm can start!
       [ ifelse ( NOT cluster? )
         [ grow ]
         [
           set pcolor grey
           set inaktiv? true
           set lesioncluster? true
           set lesionsize lesionsize + 1
           set lesionall lesionall + 1
           set clusterlistxcor fput pxcor clusterlistxcor         ; postion of lesions are stored in row in an array for xdirection
           set clusterlistycor fput pycor clusterlistycor         ; and y direction
          ; print word "the number of clustered lesions is: " length clusterlistxcor
           grow
         ]
       ]
     ]
   ]
  set toobigcount 0
  set extensor 0

  ;; if treshold is smaller than the current lesionssize the positions of the lesions are taken from the arrays and the last created lesions of each lesion are changed to aktive state
  ;; as long as treshold and lesionsize are equal again
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   while [ lesionall > tresholdsizelesions * lesionnumber ]
   [
     ask patch ( item toobigcount clusterlistxcor ) ( item toobigcount clusterlistycor )
     [
       set pcolor colornormal
       set inaktiv? false
       set lesion? false
       set lesionall lesionall - 1
       set clusterlistxcor remove-item toobigcount clusterlistxcor
       set clusterlistycor remove-item toobigcount clusterlistycor
       set toobigcount toobigcount + 0
       if ( toobigcount = (( lesionall / lesionnumber - tresholdsizelesions ) + extensor ) )
       [ set toobig toobigcount
         set toobigcount ( toobigcount + tresholdsizelesions - toobig )
         set extensor extensor + tresholdsizelesions
         set toobig 0
       ]
       ;print word "the number of clustered lesions is: " length clusterlistxcor
     ]
   ]
 ]
 tick
end
;; end of cluster algorithm
;;.......................................................................................................................................................................................


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Definition of various types of activation..............................
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; code kann noch vereinfacht werden mit 2 foreach schleifen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ob activation0 oder activation1 entscheidet sich je nach dem welche procedure als erstes ausgeführt wird. das geht wohl einfach nach zeile im code !?!?!

to activatestrongly [ signalmodulation ]                   ;; Used for the carrier frequency
  set activation0 activation0 + carriersignalstrength * ( signalmodulation / 100 )
  ask patch-at -1 -1 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour1 / 100 ]     ;; think about this factor. is it important? important:: is it really ok?? maybe another slider
  ask patch-at -1 0 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour1 / 100 ]      ;; discuss the sense of it and make suggestions for improvement
  ask patch-at -1 1 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour1 / 100 ]
  ask patch-at 0 -1 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour1 / 100 ]
  ask patch-at 0 1 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour1 / 100 ]
  ask patch-at 1 -1 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour1 / 100 ]
  ask patch-at 1 0 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour1 / 100 ]
  ask patch-at 1 1 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour1 / 100 ]

  ask patch-at 0 2 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour2 / 100 ]
  ask patch-at 0 -2 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour2 / 100 ]
  ask patch-at 2 0 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour2 / 100 ]
  ask patch-at -2 0 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour2 / 100 ]
  ask patch-at 1 2 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour2 / 100 ]
  ask patch-at 1 -2 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour2 / 100 ]
  ask patch-at 2 1 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour2 / 100 ]
  ask patch-at -2 1 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour2 / 100 ]
  ask patch-at -1 2 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour2 / 100 ]
  ask patch-at -1 -2 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour2 / 100 ]
  ask patch-at 2 -1 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour2 / 100 ]
  ask patch-at -2 -1 [ set activation0 activation0 + carriersignalstrength * carrier_neighbour2 / 100 ]

  ;; ask patches in-radius 3  [ set activation0 activation0 + carriersignalstrength * input_neighbour_activation / 100 ]  ;; auch eine Möglichkeit die Aktivierung der Nachbarn zu berechnen
end


to activate [ signalmodulation ]     ;; Used for the signals
  set activation0 activation0 + inputsignalstrength * ( signalmodulation / 100 )
  ask patch-at -1 -1 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation / 100 ]
  ask patch-at -1 0 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation / 100 ]
  ask patch-at -1 1 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation / 100 ]
  ask patch-at 0 -1 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation / 100 ]
  ask patch-at 0 1 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation / 100 ]
  ask patch-at 1 -1 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation / 100 ]
  ask patch-at 1 0 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation / 100 ]
  ask patch-at 1 1 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation / 100 ]

  ask patch-at 0 2 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation2 / 100 ]
  ask patch-at 0 -2 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation2 / 100 ]
  ask patch-at 2 0 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation2 / 100 ]
  ask patch-at -2 0 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation2 / 100 ]
  ask patch-at 1 2 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation2 / 100 ]
  ask patch-at 1 -2 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation2 / 100 ]
  ask patch-at 2 1 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation2 / 100 ]
  ask patch-at -2 1 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation2 / 100 ]
  ask patch-at -1 2 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation2 / 100 ]
  ask patch-at -1 -2 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation2 / 100 ]
  ask patch-at 2 -1 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation2 / 100 ]
  ask patch-at -2 -1 [ set activation0 activation0 + inputsignalstrength * input_neighbour_activation2 / 100 ]
end



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Input definition
;; Definition of the input patches/neurons/colums/axons by an own method for each
;; Every signalX ticks inputX gets activated
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to e-input
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
        ask patch (axcor) (aycor)
        [
          ;;activatestrongly casignalstrength
          ;set activation0 activation0 + ticks ^ 2
          set activation0 activation0 + ticks        ]
  ]
end


to input1
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst1 ) = 0
    [
      set burst1 ticks + 1
      set counter1 counter1 + 1

      if ( counter1 >= burst1_length )
      [
        set counter1 0
        set loc1 random random_loc - random_loc / 2
        set axcor1 ( random 40 ) - 20
        set aycor1 ( random 40 ) - 20
        set sl1 random-float ( 100 ) + 400
        set slca1 random-float 103
        set ph1 random 360
        set phca1 random 360
        set rm1 random 5
        set st1 random-float 2
        set st1ca random-float 2
        set burst1_length random 107
        set burst1 random 1003 + 1  ;; non repeating input
      ]

      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal1 ) ) = 0
        [
          ask patch (axcor1 + loc1) (aycor1 + loc1)
          [
            activate asignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (axcor1 + loc1) (aycor1 + loc1)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (axcor1 + loc1) (aycor1 + loc1)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st1 * ( asignalstrength / 100 ) ) * sin ( ph1 + sl1 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st1 * ( asignalstrength / 100 ) ) * sin ( ph1 + sl1 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm1
      [
        ask patch (axcor1 + loc1) (aycor1 + loc1)
        [
          ;;activatestrongly casignalstrength
          set activation0 activation0 + ( carriersignalstrength * st1ca * ( casignalstrength / 100 ) ) * sin ( phca1 + slca1 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input2
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst2 ) = 0
    [
      set burst2 ticks + 1
      set counter2 counter2 + 1

      if ( counter2 >= burst2_length )
      [
        set counter2 0
        set loc2 random random_loc - random_loc / 2
        set bxcor1 ( random 40 ) - 20
        set bycor1 ( random 40 ) - 20
        set sl2 random-float ( 100 ) + 400
        set slca2 random-float 103
        set ph2 random 360
        set phca2 random 360
        set rm2 random 5
        set st2 random-float 2
        set st2ca random-float 2
        set burst2_length random 107
        set burst2 random 1003 + 1
      ]

      ifelse  NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal2 ) ) = 0
        [
          ask patch (bxcor1 + loc2) (bycor1 + loc2)
          [
            activate bsignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (bxcor1 + loc2) (bycor1 + loc2)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (bxcor1 + loc2) (bycor1 + loc2)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st2 * ( bsignalstrength / 100 ) ) * sin ( ph2 + sl2 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st2 * ( bsignalstrength / 100 ) ) * sin ( ph2 + sl2 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm2
      [
        ask patch (bxcor1 + loc2) (bycor1 + loc2)
        [
          set activation0 activation0 + ( carriersignalstrength * st2ca * ( casignalstrength / 100 ) ) * sin ( phca2 + slca2 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input3
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst3 ) = 0
    [
      set burst3 ticks + 1
      set counter3 counter3 + 1

      if ( counter3 >= burst3_length )
      [
        set counter3 0
        set loc3 random random_loc - random_loc / 2
        set cxcor1 ( random 40 ) - 20
        set cycor1 ( random 40 ) - 20
        set sl3 random-float ( 100 ) + 400
        set slca3 random-float 103
        set ph3 random 360
        set phca3 random 360
        set rm3 random 5
        set st3 random-float 2
        set st3ca random-float 2
        set burst3_length random 107
        set burst3 random 1003 + 1
      ]

      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal3 ) ) = 0
        [
          ask patch (cxcor1 + loc3) (cycor1 + loc3)
          [
            activate csignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (cxcor1 + loc3) (cycor1 + loc3)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (cxcor1 + loc3) (cycor1 + loc3)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st3 * ( csignalstrength / 100 ) ) * sin ( ph3 + sl3 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st3 * ( csignalstrength / 100 ) ) * sin ( ph3 + sl3 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm3
      [
        ask patch (cxcor1 + loc3) (cycor1 + loc3)
        [
          set activation0 activation0 + ( carriersignalstrength * st3ca * ( casignalstrength / 100 ) ) * sin ( phca3 + slca3 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input4
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst4 ) = 0
    [
      set burst4 ticks + 1
      set counter4 counter4 + 1

      if ( counter4 >= burst4_length )
      [
        set counter4 0
        set loc4 random random_loc - random_loc / 2
        set dxcor1 ( random 40 ) - 20
        set dycor1 ( random 40 ) - 20
        set sl4 random-float ( 100 ) + 400
        set slca4 random-float 103
        set ph4 150 + 50
        set phca4 150 + 50
        set rm4 random 5
        set st4 random-float 2
        set st4ca random-float 2
        set burst4_length 150 + 50
        set burst4 random 1003 + 1
      ]

      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal4 ) ) = 0
        [
          ask patch (dxcor1 + loc4) (dycor1 + loc4)
          [
            activate dsignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (dxcor1 + loc4) (dycor1 + loc4)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (dxcor1 + loc4) (dycor1 + loc4)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st4 * ( dsignalstrength / 100 ) ) * sin ( ph4 + sl4 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st4 * ( dsignalstrength / 100 ) ) * sin ( ph4 + sl4 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm4
      [
        ask patch (dxcor1 + loc4) (dycor1 + loc4)
        [
          set activation0 activation0 + ( carriersignalstrength * st4ca * ( casignalstrength / 100 ) ) * sin ( phca4 + slca4 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input5
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst5 ) = 0
    [
      set burst5 ticks + 1
      set counter5 counter5 + 1

      if ( counter5 >= burst5_length )
      [
        set counter5 0
        set loc5 random random_loc - random_loc / 2
        set excor1 ( random 40 ) - 20
        set eycor1 ( random 40 ) - 20
        set sl5 random-float ( 100 ) + 400
        set slca5 random-float 103
        set ph5 random 360
        set phca5 random 360
        set rm5 random 5
        set st5 random-float 2
        set st5ca random-float 2
        set burst5_length 53
        set burst5 random 1003 + 1
      ]

      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal5 ) ) = 0
        [
          ask patch (excor1 + loc5) (eycor1 + loc5)
          [
            activate esignalstrength
            show esignalstrength
            show ticks
            set pcolor red
          ]
        ]
        [
          ask patch (excor1 + loc5) (eycor1 + loc5)
          [
           set pcolor white
          ]
        ]
      ]
      [
        ask patch (excor1 + loc5) (eycor1 + loc5)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st5 * ( esignalstrength / 100 ) ) * sin ( ph5 + sl5 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st5 * ( esignalstrength / 100 ) ) * sin ( ph5 + sl5 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm5
      [
        ask patch (excor1 + loc5) (eycor1 + loc5)
        [
          set activation0 activation0 + ( carriersignalstrength * st5ca * ( casignalstrength / 100 ) ) * sin ( phca5 + slca5 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input6
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst6 ) = 0
    [
      set burst6 ticks + 1
      set counter6 counter6 + 1

      if ( counter6 >= burst6_length )
      [
        set counter6 0
        set loc6 random random_loc - random_loc / 2
        set fxcor1 ( random 40 ) - 20
        set fycor1 ( random 40 ) - 20
        set sl6 random-float ( 100 ) + 400
        set slca6 random-float 103
        set ph6 random 360
        set phca6 random 360
        set rm6 random 5
        set st6 random-float 2
        set st6ca random-float 2
        set burst6_length random 107
        set burst6 random 1003 + 1
      ]

      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal6 ) ) = 0
        [
          ask patch (fxcor1 + loc6) (fycor1 + loc6)
          [
            activate fsignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (fxcor1 + loc6) (fycor1 + loc6)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (fxcor1 + loc6) (fycor1 + loc6)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st6 * ( fsignalstrength / 100 ) ) * sin ( ph6 + sl6 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st6 * ( fsignalstrength / 100 ) ) * sin ( ph6 + sl6 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm6
      [
        ask patch (fxcor1 + loc6) (fycor1 + loc6)
        [
          set activation0 activation0 + ( carriersignalstrength * st6ca * ( casignalstrength / 100 ) ) * sin ( phca6 + slca6 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input7
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst7 ) = 0
    [
      set burst7 ticks + 1
      set counter7 counter7 + 1

      if ( counter7 >= burst7_length )
      [
        set counter7 0
        set loc7 random random_loc - random_loc / 2
        set gxcor1 ( random 40 ) - 20
        set gycor1 ( random 40 ) - 20
        set sl7 random-float ( 100 ) + 400
        set slca7 random-float 103
        set ph7 random 360
        set phca7 random 360
        set rm7 random 5
        set st7 random-float 2
        set st7ca random-float 2
        set burst7_length random 107
        set burst7 random 1003 + 1
      ]

      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal7 ) ) = 0
        [
          ask patch (gxcor1 + loc7) (gycor1 + loc7)
          [
            activate gsignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (gxcor1 + loc7) (gycor1 + loc7)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (gxcor1 + loc7) (gycor1 + loc7)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st7 * ( gsignalstrength / 100 ) ) * sin ( ph7 + sl7 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st7 * ( gsignalstrength / 100 ) ) * sin ( ph7 + sl7 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm7
      [
        ask patch (gxcor1 + loc7) (gycor1 + loc7)
        [
          set activation0 activation0 + ( carriersignalstrength * st7ca * ( casignalstrength / 100 ) ) * sin ( phca7 + slca7 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input8
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst8 ) = 0
    [
      set burst8 ticks + 1
      set counter8 counter8 + 1

      if ( counter8 >= burst8_length )
      [
        set counter8 0
        set loc8 random random_loc - random_loc / 2
        set hxcor1 ( random 40 ) - 20
        set hycor1 ( random 40 ) - 20
        set sl8 random-float ( 100 ) + 400
        set slca8 random-float 103
        set ph8 random 360
        set phca8 random 360
        set rm8 random 5
        set st8 random-float 2
        set st8ca random-float 2
        set burst8_length random 107
        set burst8 random 1003 + 1
      ]

      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal8 ) ) = 0
        [
          ask patch (hxcor1 + loc8) (hycor1 + loc8)
          [
            activate hsignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (hxcor1 + loc8) (hycor1 + loc8)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (hxcor1 + loc8) (hycor1 + loc8)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st8 * ( hsignalstrength / 100 ) ) * sin ( ph8 + sl8 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st8 * ( hsignalstrength / 100 ) ) * sin ( ph8 + sl8 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm8
      [
        ask patch (hxcor1 + loc8) (hycor1 + loc8)
        [
          set activation0 activation0 + ( carriersignalstrength * st8ca * ( casignalstrength / 100 ) ) * sin ( phca8 + slca8 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input9
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst9 ) = 0
    [
      set burst9 ticks + 1
      set counter9 counter9 + 1

      if ( counter9 >= burst9_length )
      [
        set counter9 0
        set loc9 random random_loc - random_loc / 2
        set ixcor1 ( random 40 ) - 20
        set iycor1 ( random 40 ) - 20
        set sl9 random-float ( 100 ) + 400
        set slca9 random-float 103
        set ph9 360
        set phca9 360
        set rm9 random 5
        set st9 random-float 2
        set st9ca random-float 2
        set burst9_length random 107
        set burst9 random 1003 + 1
      ]

      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal9 ) ) = 0
        [
          ask patch (ixcor1 + loc9) (iycor1 + loc9)
          [
            activate isignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (ixcor1 + loc9) (iycor1 + loc9)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (ixcor1 + loc9) (iycor1 + loc9)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st9 * ( isignalstrength / 100 ) ) * sin ( ph9 + sl9 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st9ca * ( isignalstrength / 100 ) ) * sin ( ph9 + sl9 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm9
      [
        ask patch (ixcor1 + loc9) (iycor1 + loc9)
        [
          set activation0 activation0 + ( carriersignalstrength * 0.5 * ( casignalstrength / 100 ) ) * sin ( phca9 + slca9 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input10
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst10 ) = 0
    [
      set burst10 ticks + 1
      set counter10 counter10 + 1

      if ( counter10 >= burst10_length )
      [
        set counter10 0
        set loc10 random random_loc - random_loc / 2
        set jxcor1 ( random 40 ) - 20
        set jycor1 ( random 40 ) - 20
        set sl10 random-float ( 100 ) + 400
        set slca10 random-float 103
        set ph10 360
        set phca10 360
        set rm10 random 5
        set st10 random-float 2
        set st10ca random-float 2
        set burst10_length random 107
        set burst10 random 1003 + 1
      ]

      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal10 ) ) = 0
        [
          ask patch (jxcor1 + loc10) (jycor1 + loc10)
          [
            activate jsignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (jxcor1 + loc10) (jycor1 + loc10)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (jxcor1 + loc10) (jycor1 + loc10)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st10 * ( jsignalstrength / 100 ) ) * sin ( ph10 + sl10 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st10 * ( jsignalstrength / 100 ) ) * sin ( ph10 + sl10 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm10
      [
        ask patch (jxcor1 + loc10) (jycor1 + loc10)
        [
          set activation0 activation0 + ( carriersignalstrength * st10ca * ( casignalstrength / 100 ) ) * sin ( phca10 + slca10 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input11
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst11 ) = 0
    [
      set burst11 ticks + 1
      set counter11 counter11 + 1

      if ( counter11 >= burst11_length )
      [
        set counter11 0
        set loc11 random random_loc - random_loc / 2
        set kxcor1 ( random 40 ) - 20
        set kycor1 ( random 40 ) - 20
        set sl11 random-float ( 100 ) + 400
        set slca11 random-float 103
        set ph11 random 360
        set phca11 random 360
        set rm11 random 5
        set st11 random-float 2
        set st11ca random-float 2
        set burst11_length random 107
        set burst11 random 1003 + 1
      ]

      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal11 ) ) = 0
        [
          ask patch (kxcor1 + loc11) (kycor1 + loc11)
          [
            activate ksignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (kxcor1 + loc11) (kycor1 + loc11)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (kxcor1 + loc11) (kycor1 + loc11)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st11 * ( ksignalstrength / 100 ) ) * sin ( ph11 + sl11 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st11 * ( ksignalstrength / 100 ) ) * sin ( ph11 + sl11 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm11
      [
        ask patch (kxcor1 + loc11) (kycor1 + loc11)
        [
          set activation0 activation0 + ( carriersignalstrength * st11ca * ( casignalstrength / 100 ) ) * sin ( phca11 + slca11 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input12
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst12 ) = 0
    [
      set burst12 ticks + 1
      set counter12 counter12 + 1

      if ( counter12 >= burst12_length )
      [
        set counter12 0
        set loc12 random random_loc - random_loc / 2
        set lxcor1 ( random 40 ) - 20
        set lycor1 ( random 40 ) - 20
        set sl12 random-float ( 100 ) + 400
        set slca12 random-float 103
        set ph12 random 360
        set phca12 random 360
        set rm12 random 5
        set st12 random-float 2
        set st12ca random-float 2
        set burst12_length random 107
        set burst12 random 1003 + 1
      ]

      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal12 ) ) = 0
        [
          ask patch (lxcor1 + loc12) (lycor1 + loc12)
          [
            activate lsignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (lxcor1 + loc12) (lycor1 + loc12)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (lxcor1 + loc12) (lycor1 + loc12)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st12 * ( lsignalstrength / 100 ) ) * sin ( ph12 + sl12 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st12 * ( lsignalstrength / 100 ) ) * sin ( ph12 + sl12 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm12
      [
        ask patch (lxcor1 + loc12) (lycor1 + loc12)
        [
          set activation0 activation0 + ( carriersignalstrength * st12ca * ( casignalstrength / 100 ) ) * sin ( phca12 + slca12 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input13
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst13 ) = 0
    [
      set burst13 ticks + 1
      set counter13 counter13 + 1

      if ( counter13 >= burst13_length )
      [
        set counter13 0
        set loc13 random random_loc - random_loc / 2
        set mxcor1 ( random 40 ) - 20
        set mycor1 ( random 40 ) - 20
        set sl13 random-float ( 100 ) + 400
        set slca13 random-float 103
        set ph13 360
        set phca13 360
        set rm13 random 5
        set st13 random-float 2
        set st13ca random-float 2
        set burst13_length random 107
        set burst13 random 1003 + 1
      ]


      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal13 ) ) = 0
        [
          ask patch (mxcor1 + loc13) (mycor1 + loc13)
          [
            activate msignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (mxcor1 + loc13) (mycor1 + loc13)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (mxcor1 + loc13) (mycor1 + loc13)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st13 * ( msignalstrength / 100 ) ) * sin ( ph13 + sl13 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st13 * ( msignalstrength / 100 ) ) * sin ( ph13 + sl13 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm13
      [
        ask patch (mxcor1 + loc13) (mycor1 + loc13)
        [
          set activation0 activation0 + ( carriersignalstrength * st13ca * ( casignalstrength / 100 ) ) * sin ( phca13 + slca13 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input14
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst14 ) = 0
    [
      set burst14 ticks + 1
      set counter14 counter14 + 1

      if ( counter14 >= burst14_length )
      [
        set counter14 0
        set loc14 random random_loc - random_loc / 2
        set nxcor1 ( random 40 ) - 20
        set nycor1 ( random 40 ) - 20
        set sl14 random-float ( 100 ) + 400
        set slca14 random-float 103
        set ph14 360
        set phca14 360
        set rm14 random 5
        set st14 random-float 2
        set st14ca random-float 2
        set burst14_length random 107
        set burst14 random 1003 + 1
      ]

      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal14 ) ) = 0
        [
          ask patch (nxcor1 + loc14) (nycor1 + loc14)
          [
            activate nsignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (nxcor1 + loc14) (nycor1 + loc14)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (nxcor1 + loc14) (nycor1 + loc14)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st14 * ( nsignalstrength / 100 ) ) * sin ( ph14 + sl14 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st14 * ( nsignalstrength / 100 ) ) * sin ( ph14 + sl14 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm14
      [
        ask patch (nxcor1 + loc14) (nycor1 + loc14)
        [
          set activation0 activation0 + ( carriersignalstrength * st14ca * ( casignalstrength / 100 ) ) * sin ( phca14 + slca14 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input15
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst15 ) = 0
    [
      set burst15 ticks + 1
      set counter15 counter15 + 1

      if ( counter15 >= burst15_length )
      [
        set counter15 0
        set loc15 random random_loc - random_loc / 2
        set oxcor1 ( random 40 ) - 20
        set oycor1 ( random 40 ) - 20
        set sl15 random-float ( 100 ) + 400
        set slca15 random-float 103
        set ph15 random 360
        set phca15 random 360
        set rm15 random 5
        set st15 random-float 2
        set st15ca random-float 2
        set burst15_length random 107
        set burst15 random 1003 + 1
      ]

      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal15 ) ) = 0
        [
          ask patch (oxcor1 + loc15) (oycor1 + loc15)
          [
            activate osignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (oxcor1 + loc15) (oycor1 + loc15)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (oxcor1 + loc15) (oycor1 + loc15)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st15 * ( osignalstrength / 100 ) ) * sin ( ph15 + sl15 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st15 * ( osignalstrength / 100 ) ) * sin ( ph15 + sl15 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm15
      [
        ask patch (oxcor1 + loc15) (oycor1 + loc15)
        [
          set activation0 activation0 + ( carriersignalstrength * st15ca * ( casignalstrength / 100 ) ) * sin ( phca15 * slca15 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input16
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst16 ) = 0
    [
      set burst16 ticks + 1
      set counter16 counter16 + 1

      if ( counter16 >= burst16_length )
      [
        set counter16 0
        set loc16 random random_loc - random_loc / 2
        set qxcor1 ( random 40 ) - 20
        set qycor1 ( random 40 ) - 20
        set sl16 random-float ( 100 ) + 400
        set slca16 random-float 103
        set ph16 random 360
        set phca16 random 360
        set rm16 random 5
        set st16 random-float 2
        set st16ca random-float 2
        set burst16_length random 107
        set burst16 random 1003 + 1
      ]

      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal16 ) ) = 0
        [
          ask patch (qxcor1 + loc16) (qycor1 + loc16)
          [
            activate qsignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (qxcor1 + loc16) (qycor1 + loc16)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (qxcor1 + loc16) (qycor1 + loc16)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st16 * ( qsignalstrength / 100 ) ) * sin ( ph16 + sl16 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st16 * ( qsignalstrength / 100 ) ) * sin ( ph16 + sl16 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm16
      [
        ask patch (qxcor1 + loc16) (qycor1 + loc16)
        [
          set activation0 activation0 + ( carriersignalstrength * st16ca * ( casignalstrength / 100 ) ) * sin ( phca16 + slca16 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input17
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst17 ) = 0
    [
      set burst17 ticks + 1
      set counter17 counter17 + 1

      if ( counter17 >= burst17_length )
      [
        set counter17 0
        set loc17 random random_loc - random_loc / 2
        set rxcor1 ( random 40 ) - 20
        set rycor1 ( random 40 ) - 20
        set sl17 random-float ( 100 ) + 400
        set slca17 random-float 103
        set ph17 random 360
        set phca17 random 360
        set rm17 random 5
        set st17 random-float 2
        set st17ca random-float 2
        set burst17_length random 107
        set burst17 random 1003 + 1
      ]

      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal17 ) ) = 0
        [
          ask patch (rxcor1 + loc17) (rycor1 + loc17)
          [
            activate rsignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (rxcor1 + loc17) (rycor1 + loc17)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (rxcor1 + loc17) (rycor1 + loc17)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st17 * ( rsignalstrength / 100 ) ) * sin ( ph17 + sl17 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st17 * ( rsignalstrength / 100 ) ) * sin ( ph17 + sl17 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm17
      [
        ask patch (rxcor1 + loc17) (rycor1 + loc17)
        [
          set activation0 activation0 + ( carriersignalstrength * st17ca * ( casignalstrength / 100 ) ) * sin ( phca17 + slca17 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input18
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst18 ) = 0
    [
      set burst18 ticks + 1
      set counter18 counter18 + 1

      if ( counter18 >= burst18_length )
      [
        set counter18 0
        set loc18 random random_loc - random_loc / 2
        set sxcor1 ( random 40 ) - 20
        set sycor1 ( random 40 ) - 20
        set sl18 random-float ( 100 ) + 400
        set slca18 random-float 103
        set ph18 random 360
        set phca18 random 360
        set rm18 random 5
        set st18 random-float 2
        set st18ca random-float 2
        set burst18_length random 107
        set burst18 random 1003 + 1
      ]

      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal18 ) ) = 0
        [
          ask patch (sxcor1 + loc18) (sycor1 + loc18)
          [
            activate ssignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (sxcor1 + loc18) (sycor1 + loc18)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (sxcor1 + loc18) (sycor1 + loc18)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st18 * ( ssignalstrength / 100 ) ) * sin ( ph18 + sl18 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st18 * ( ssignalstrength / 100 ) ) * sin ( ph18 + sl18 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm18
      [
        ask patch (sxcor1 + loc18) (sycor1 + loc18)
        [
          set activation0 activation0 + ( carriersignalstrength * st18ca * ( casignalstrength / 100 ) ) * sin ( phca18 + slca18 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input19
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst19 ) = 0
    [
      set burst19 ticks + 1
      set counter19 counter19 + 1

      if ( counter19 >= burst19_length )
      [
        set counter19 0
        set loc19 random random_loc - random_loc / 2
        set txcor1 ( random 40 ) - 20
        set tycor1 ( random 40 ) - 20
        set sl19 random-float ( 100 ) + 400
        set slca19 random-float 103
        set ph19 random 360
        set phca19 random 360
        set rm19 random 5
        set st19 random-float 2
        set st19ca random-float 2
        set burst19_length random 107
        set burst19 random 1003 + 1
      ]

      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal19 ) ) = 0
        [
          ask patch (txcor1 + loc19) (tycor1 + loc19)
          [
            activate tsignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (txcor1 + loc19) (tycor1 + loc19)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (txcor1 + loc19) (tycor1 + loc19)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st19 * ( tsignalstrength / 100 ) ) * sin ( ph19 + sl19 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st19 * ( tsignalstrength / 100 ) ) * sin ( ph19 + sl19 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm19
      [
        ask patch (txcor1 + loc19) (tycor1 + loc19)
        [
          set activation0 activation0 + ( carriersignalstrength * st19ca * ( casignalstrength / 100 ) ) * sin ( phca19 + slca19 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input20
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst20 ) = 0
    [
      set burst20 ticks + 1
      set counter20 counter20 + 1

      if ( counter20 >= burst20_length )
      [
        set counter20 0
        set loc20 random random_loc - random_loc / 2
        set uxcor1 ( random 40 ) - 20
        set uycor1 ( random 40 ) - 20
        set sl20 random-float ( 100 ) + 400
        set slca20 random-float 103
        set ph20 random 360
        set phca20 random 360
        set rm20 random 5
        set st20 random-float 2
        set st20ca random-float 2
        set burst20_length random 107
        set burst20 random 1003 + 1
      ]

      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal20 ) ) = 0
        [
          ask patch (uxcor1 + loc20) (uycor1 + loc20)
          [
            activate usignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (uxcor1 + loc20) (uycor1 + loc20)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (uxcor1 + loc20) (uycor1 + loc20)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st20 * ( usignalstrength / 100 ) ) * sin ( ph20 + sl20 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st20 * ( usignalstrength / 100 ) ) * sin ( ph20 + sl20 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm20
      [
        ask patch (uxcor1 + loc20) (uycor1 + loc20)
        [
          set activation0 activation0 + ( carriersignalstrength * st20ca * ( casignalstrength / 100 ) ) * sin ( phca20 + slca20 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to input21
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burst21 ) = 0
    [
      set burst21 ticks + 1
      set counter21 counter21 + 1

      if ( counter21 >= burst21_length )
      [
        set counter21 0
        set loc21 random random_loc - random_loc / 2
        set vxcor1 ( random 40 ) - 20
        set vycor1 ( random 40 ) - 20
        set sl21 random-float ( 100 ) + 400
        set slca21 random-float 103
        set ph21 random 360
        set phca21 random 360
        set rm21 random 5
        set st21 random-float 2
        set st21ca random-float 2
        set burst21_length random 107
        set burst21 random 1003 + 1
      ]

      ifelse NOT sine
      [
        ifelse ( ticks mod round ( 1000 / signal21 ) ) = 0
        [
          ask patch (vxcor1 + loc21) (vycor1 + loc21)
          [
            activate vsignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (vxcor1 + loc21) (vycor1 + loc21)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (vxcor1 + loc21) (vycor1 + loc21)
        [
          ifelse random-float 100 < uncorrelated_input
          [
            set activation0 activation0 + ( inputsignalstrength * st21 * ( vsignalstrength / 100 ) ) * sin ( ph21 + sl21 * 360 * ( ticks / 1000 ) + 0 ) * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]
          [
            set activation0 activation0 + ( inputsignalstrength * st21 * ( vsignalstrength / 100 ) ) * sin ( ph21 + sl21 * 360 * ( ticks / 1000 ) + 0 )
          ]
        ]
      ]

      if carrier_for_all_input AND 1 = rm21
      [
        ask patch (vxcor1 + loc21) (vycor1 + loc21)
        [
          set activation0 activation0 + ( carriersignalstrength * st21ca * ( casignalstrength / 100 ) ) * sin ( phca21 + slca21 * 360 * ( ticks / 1000 ) )
        ]
      ]
    ]
  ]
end

to Carrier
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burstca ) = 0
    [
      set burstca ticks + 1

      set counterca counterca + 1
      if ( counterca >= length_bursts )
      [
        set counterca 0
        set locca random random_loc - random_loc / 2
        set ersxcor1 ( random 40 ) - 20
        set ersycor1 ( random 40 ) - 20
        set ca1 random-float 103
        set burstca random 1003 + 1
        set burstca_length random 107
      ]

      ifelse NOT sine_carrier
      [
        ifelse ( ticks mod round ( 1000 / ( slca21 ) ) ) = 0
        [
          ask patch (ersxcor + locca) (ersycor + locca)
          [
            activatestrongly casignalstrength
            set pcolor red
          ]
        ]
        [
          ask patch (ersxcor + locca) (ersycor + locca)
          [
            set pcolor white
          ]
        ]
      ]
      [
        ask patch (ersxcor1 + locca) (ersycor1 + locca)
        [
          set activation0 activation0 + ( carriersignalstrength * ( casignalstrength / 100 ) ) * sin ( ca1 * 360 * ( ticks / 1000 ) )
          set pcolor red
        ]
      ]
    ]
  ]
end

to Carrier2
;; Alpha-ERS (the carrier signal)
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    ifelse NOT sine_carrier
    [
      ;;ifelse ticks mod round (1000 / (carriersignal2)) = 0 OR ticks mod round (1000 / (carriersignal2 + 9)) = 0 OR ticks mod round (1000 / (carriersignal2 + 9 + 13)) = 0
      ifelse ticks mod round (1000 / (carriersignal2)) = 0
      [
        ask patch ersxcor2 ersycor2
        [
          activatestrongly casignalstrength2
          set pcolor red
        ]
      ]
      [
        ask patch ersxcor2 ersycor2
        [
          set pcolor white
        ]
      ]
    ]
    [
      ask patch ersxcor2 ersycor2
      [
        set activation0 activation0 + ( carriersignalstrength * ( casignalstrength2 / 100 ) ) * sin ( carriersignal2 * 360 * ( ticks / 1000 ) )
        set pcolor red
      ]
    ]
  ]
end

to Fire
  ask patch xdir ydir
  [
    activate firesignalstrength
    ; set pcolor red
  ]
end

to stimuli_prime
  ;let prime_x -10
  ;let prime_y 10
  let prime_x 50
  let prime_y 50


  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
    if ( ticks mod burstp ) = 0
    [
      set burstp ticks + 1
      set counterp counterp + 1

      if ( counterp >= burstp_length )
      [
        set counterp 0
        ;set locp random random_loc - random_loc / 2
        ;;set burstp random ( ( finish - 1000 ) - ticks ) + ticks
        set burstp random 1003 + 1  ;; random repeating input
        ;;set burstp burstp_store  ;; regular repeating input
        ;;set burstp 1000000  ;; non repeating input
      ]

      foreach prime_numbers
      [
        ?1 ->
        ;set prime_x prime_x + 2
        ;set prime_y prime_y + 2

        ifelse NOT sine  ;; hier ist eine anpassung, um sine auszuschliessen
        [
          ifelse ( ticks mod round ( 1000 / ?1 ) ) = 0
          [
            ask patch (prime_x) (prime_y)
            [
              activate asignalstrength
              set pcolor red
            ]
          ]
          [
            ask patch (prime_x) (prime_y)
            [
              set pcolor white
            ]
          ]
        ]
        [
          ask patch (prime_x) (prime_y)
          [
            set activation0 activation0 + ( inputsignalstrength ) * sin ( ?1 * 360 * ( ticks / 1000 ) )
            set pcolor red
          ]
        ]

        if carrier_for_all_input AND 1 = 2
        [
          ask patch (prime_x + locp) (prime_y + locp)
          [
            ;;activatestrongly casignalstrength
            set activation0 activation0 + ( carriersignalstrength * ( casignalstrength / 100 ) ) * sin ( carriersignal * 360 * ( ticks / 1000 ) )
          ]
        ]
      ]
    ]
  ]
end

to input_all
  if ( ticks < finish - auspendeln AND ticks > einpendeln )
  [
  if ticks mod round (1000 / 120) = 0
    [
      ask patches
      [
        if ( ( not istRand? and ( NOT inaktiv? ) ) ) ;; all active cell
        [
          activate 10
          set pcolor red
        ]
      ]
    ]
  ]
end



;; end of input definition
;;......................................................................................................


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; k-complex
;; first fire 10 to 15 tines in a row with normal activation
;; than wait for another 7-12 ticks and fire every 5 ticks a strong signal (sleep spindel)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to generate-k-complex                                  ;; in testing phase
  ; counter-k-complex
  ; counter-sleep-spindel
  ; period-counter
  if ticks > 100 and ticks < 400
  [
    ask patch xdir ydir
    [
      set activation0 activation0 + ( carriersignalstrength * ( casignalstrength / 100 ) ) * sin ( carriersignal * 360 * ( ticks / 1000 ) )
    ]
  ]
end

;; end of k-complex
;;.........................................................................................


to initalize-ising
  ask patches
  [
    ifelse random 100 < 50 AND NOT istrand?
    [
        set activation0  1
        ;;set slope_old 1
    ]
    [ set activation0 -1 ]
  ]
end

;; update the spin of a single patch
to update-ising  ;; patch procedure
  if ( NOT istrand? )
  [
   ;; flipping changes the sign on our energy,
   ;; so the difference in energy, if we flip,
   ;; is -2 times our current energy
   let Ediff 2 * activation0 * sum [ activation0 ] of neighbors4
   ifelse (Ediff <= 0) OR (temperature > 0 AND (random-float 1.0 < exp ((- Ediff) / temperature)))
   [
     ifelse sigmoid_ising
     [
        set activation0 ( ( activation0 + slope_old ) / ( 1 + damping ) )
        set activation0 ( 8 * ( 1 / ( 1 + 2 * exp( - activation0 ) ) ) ) - 4
     ]
     [
        set activation0 (- activation0)
     ]
   ]
   [
     ;;set activation0 (- activation0)
     ;;set activation0 ( ( activation0 + slope_old ) / ( 1 + damping ) )
     ;;set activation0 ( ( activation0 ) / ( 1 + damping ) )
   ]
 ]
end

          ;if sigmoid
          ;[ set activation0 ( 20 * ( 1 / ( 1 + exp( - activation0) ) ) ) - 10 ]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; simulate spontaneous activity (cells get activated with a defined probability)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to generate-spontaneousactivity
  ;; set sponact random-float spontaneousact  ;; this was set here probabliy in the wrong place because it generates one sponact for all patches. it should be individualized
  ;; set sponact sponact - spontaneousact / 2  ;;for generating negative sponact

  ;;if ( random-float 100 <= 1 ) ;; coordinated spontaneous activity
  ;;[
  ask patches
  [
    ;;if ( ( istRand? and ( NOT inaktiv? ) ) OR ( NOT inaktiv? ) ) ;; just choose all active cells
    ;;if ( ( NOT istRAND? and ( NOT inaktiv? ) )
    if ( NOT inaktiv? and NOT istrand? )
    ;if ( NOT inaktiv? ) AND random-float 100 <= 50
    ;;if (NOT inaktiv? )
    [

      ;; if ( random-float 100 <= ratio_activatedcells AND activation0 <= 0 )     ;; for generating sponact burst when neuron is at zero energy level
      ;; if ( activation0 < 0 OR ( ratio_activatedcells > 0 AND random-float 1 <= exp ( - ( activation0 / ratio_activatedcells ) ) ) )
      ;; if ( (  ratio_activatedcells > 0 AND random-float 1.0 < exp ( ( - slope_vector ) / ratio_activatedcells ) ) ) ;; Ising like dynamics
      ;; if ( ( slope_old <= 0 OR ratio_activatedcells > 0 AND random-float 1.0 < exp ( ( - slope_old ) / ratio_activatedcells ) ) ) ;; Ising like dynamics
      ;if ( random-float 100 <= ratio_activatedcells ) AND activation0 <= 0
      if ( random-float 100 <= ratio_activatedcells )
      [
        ;; set sponact random-float spontaneousact - random-float spontaneousact + random-float spontaneousact - random-float spontaneousact + random-float spontaneousact
        set sponact random-float spontaneousact
        ;;set sponact (-1) * sponact

        ;set sponact sponact - spontaneousact / 2  ;; for negativ association (possible use in Ising but not for Sponact in Brain)
        ;; set sponact ( random spontaneousact ) - ( random spontaneousact ) + ( random spontaneousact ) - ( random spontaneousact ) + ( random spontaneousact ) - ( random spontaneousact ) + ( random spontaneousact ) - ( random spontaneousact )
        ;; set sponact sponact + ( random spontaneousact ) - ( random spontaneousact ) - ( random spontaneousact ) + ( random spontaneousact ) - ( random spontaneousact ) + ( random spontaneousact ) + ( random spontaneousact ) - ( random spontaneousact )
        ;; set sponact ( random spontaneousact ) - 0.5 * spontaneousact
        ;; set sponact -1 * ( random spontaneousact )
        set sponact sponact - spontaneousact / 2
        ;; set activation0 round sponact  ;; independend chaos (always new value of activation but history in slope if energy is transfered)
        ;; set activation0 sponact
        ;; set slope_old ( - 1 ) * slope_old
        ;; set slope_old slope_old + sponact
        ;; set activation0 ( -1 ) * activation0
        set activation0 activation0 + sponact  ;; dependend chaos (with history of activation and history of slope)
                                               ;; set activation0 round activation0 + ( random spontaneousact ) - ( random spontaneousact )

                                               ;; set activation0 round sponact ;; set activation1 sponact (random presence and random history; slope with history of energy is tranfered)
                                               ;; set activation0 sponact ;; set activation1 sponact ;; set slope_old sponact(random presence and random history; slope_old namely the history of slope is also random)
                                               ;; set slope_vector sponact ;; doesnt make sense!? slope_vector is always internal calculated and dependend on activation1 of neeighbour (the activation history);; if latter is random slope_vector will be also random
      ]
    ]
  ]
  ;;]
end
;; end of spontaneousactivity
;;..............................................................................






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Main procedure, Go procedure. Incorporates the main algorithm for non-local information processing, live coloring patches and MEA electrodes, calculation of EEG Electrodes, ..............................................................................................
;; calculation of moving average, Peak finder, Frequency calculation, Primenumber distribution...............................................................................................................................................................................
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to go
  set tickcounter tickcounter + 1                                                     ;; counts the ticks


  ;; routine for creating movies
  if vid:recorder-status = "inactive" and ticks <= 500
  [
    vid:start-recorder
  ]

  if ticks <= 500
  [
    vid:record-view
  ]

  if ticks = 500
  [
    vid:save-recording "filme.mp4"
    print vid:recorder-status
    ;stop
  ]


  ;; alogorithm start
  ifelse ( ticks < finish )       ;; abort condition
  [
    ;; get a useable value for the standardcolor (using the colorslider value from the interface)
    set colornormal ( backgroundcolors * 10 ) + 8

    ;; generate an example for the sum of the energy (cumulative) and the corresponding slope signal
    ;; maybe a cumulative slope would be nice
    ; let sum_energy 0

    set activation0_of_patch 0
    set activation1_of_patch 0
    set slope_vector_of_patch 0
    set slope_old_of_patch 0

    ask patch 1 1
    [
      if ( ( istRand? and ( NOT inaktiv? ) ) OR ( NOT inaktiv? ) ) ;; all active cells
      [
        set sum_of_patch sum_of_patch + activation0
        set activation0_of_patch activation0_of_patch + activation0
        set activation1_of_patch activation1_of_patch + activation1
        set slope_vector_of_patch slope_vector_of_patch + slope_old
        set slope_old_of_patch slope_old_of_patch + slope_vector
      ]
    ]

    ;
    set slope_of_all 0

    ask patches
    [
      ;; calculate the cumulative overall energy of model
      ;; calculate the cumulative overall slope of model
      ;; calculate the overall slope of model at any given processing step
      ;set sum_energy sum_energy + activation0
      ;set sum_of_patches sum_energy

      if ( ( istRand? and ( NOT inaktiv? ) ) OR ( NOT inaktiv? ) ) ;; all active cells
      [
        set sum_of_patches sum_of_patches + activation0
        set sum_of_slopes sum_of_slopes + slope_vector     ;; slope_vector and slope_old are probably just phase shifted
        set slope_of_all slope_of_all + slope_vector
      ]


      ;ifelse activation1 > 0
      ;[ set activation1 1 ]
      ;[
      ;  ifelse activation1 < 0
      ;  [ set activation1 -1 ]
      ;  [ set activation1 0 ]
      ;]

      ;ifelse activation0 > 0
      ;[ set activation0 1 ]
      ;[
      ;  ifelse activation0 < 0
      ;  [ set activation0 -1 ]
      ;  [ set activation0 0 ]
      ;]

      ;; exchange activation0 and activation1  ;; von Krone. wirft immer noch fragen auf. würde ich wohl anders machen...aber solang es funktioniert
      ;; answer: within the go algorithm and within the procedures ask paatches [] that is asking the neighbours for their activation
      ;; it is imporatant that at the beginning the activation1 is constant until all patches are asked.
      ;; activation1 should not be updated as neighbours are asked several times, as they are neighbours of several patches.
      ;; an update of activation1 during this process makes calculation unsymmetrical.
      ;; this is a problem that could be solved by live calculation, parallel computing or the increase of time steps in relation to energy tranfer.
      ;; latter decrease of energy tranfer due to increase of time steps is convergece to live computing but decreases energy tranfer each time step.
      ;; this could decrease the maximum of frequency, but this effect is reversed by increasing time steps (slow mo is live computing!?)

      set activationexchange activation0
      set activation0 activation1
      set activation1 activationexchange

      ;set activation1 activation0  ;;for testing activation0 and activation1


      ;;let slope_change slope_new   ;; define if slope_old and slope_new are dependend on each other (slope vector is actually slope_new;; different calculation that activation0 and activation1)
      ;;set slope_new slope_old
      ;;set slope_old slope_change
    ]

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Main algorithm for non-local information processing. The following procedure calcuates the activation level of each neuronal column...............................................................
    ;; It includes signal transduction, damping, margindamping, wave direction, number of neighbouring units that serve to the signal, ..................................................................
    ;; as well as a live coloring........................................................................................................................................................................
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ask patches
    [
      ;; here there could be implemented a stop ( if activation1 > 100 ( next; ) || ( activation1 = 0 ) || ( activation1 * 0.5 )

      if ( ( istRand? and ( NOT inaktiv? ) ) OR ( NOT inaktiv? ) ) ;; all active cells
      [
        ;; Sum up the activation level and the number of the neighbouring cells
        set neighbourcount 0    ;; counts the neigbours ( currently not used )


        if pycor < max-pycor - 1 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration != 0
        [
          set aktivierung-oben [activation1 * o] of patch-at 0 ( 1 + nextneighbour )
          if random-float 100 < uncorrelated2 [ set aktivierung-oben aktivierung-oben * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]

          if pxcor < max-pxcor - 1 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration1 != 0
          [
            set aktivierung-obenrechts [activation1 * ro] of patch-at ( 1 + nextneighbour ) ( 1 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-obenrechts aktivierung-obenrechts * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 1 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration1 != 0
          [
            set aktivierung-obenlinks [activation1 * ol] of patch-at ( - 1 - nextneighbour ) ( 1 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-obenlinks aktivierung-obenlinks * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]


          if pxcor < max-pxcor - 2 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration3 != 0
          [
            set aktivierung-orr [activation1 * orr] of patch-at ( 2 + nextneighbour ) ( 1 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-orr aktivierung-orr * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 2 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration3 != 0
          [
            set aktivierung-oll [activation1 * oll] of patch-at ( -2 - nextneighbour ) ( 1 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-oll aktivierung-oll * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]


          if pxcor < max-pxcor - 3 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration9 != 0
          [
            set aktivierung-orrr [activation1 * orrr] of patch-at ( 3 + nextneighbour ) ( 1 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-orrr aktivierung-orrr * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 3 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration9 != 0
          [
            set aktivierung-olll [activation1 * olll] of patch-at ( -3 - nextneighbour ) ( 1 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-olll aktivierung-olll * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]


          if pxcor < max-pxcor - 4 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration12 != 0
          [
            set aktivierung-orrrr [activation1 * 1] of patch-at ( 4 + nextneighbour ) ( 1 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-orrrr aktivierung-orrrr * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 4 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration12 != 0
          [
            set aktivierung-ollll [activation1 * 1] of patch-at ( -4 - nextneighbour ) ( 1 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-ollll aktivierung-ollll * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]
        ]



        if pycor > min-pycor + 1 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration != 0
        [
          set aktivierung-unten [activation1 * u] of patch-at 0 ( - 1 - nextneighbour )
          if random-float 100 < uncorrelated2 [ set aktivierung-unten aktivierung-unten * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]


          if pxcor < max-pxcor - 1 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration1 != 0
          [
            set aktivierung-untenrechts [activation1 * ur] of patch-at ( 1 + nextneighbour ) ( - 1 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-untenrechts aktivierung-untenrechts * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 1 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration1 != 0
          [
            set aktivierung-untenlinks [activation1 * ul] of patch-at ( -1 - nextneighbour ) ( - 1 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-untenlinks aktivierung-untenlinks * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]


          if pxcor < max-pxcor - 2 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration3 != 0
          [
            set aktivierung-urr [activation1 * urr] of patch-at ( 2 + nextneighbour ) ( - 1 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-urr aktivierung-urr * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 2 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration3 != 0
          [
            set aktivierung-ull [activation1 * ull] of patch-at ( -2 - nextneighbour ) ( - 1 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-ull aktivierung-ull * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]


          if pxcor < max-pxcor - 3 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration9 != 0
          [
            set aktivierung-urrr [activation1 * 1] of patch-at ( 3 + nextneighbour ) ( - 1 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-urrr aktivierung-urrr * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 3 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration9 != 0
          [
            set aktivierung-ulll [activation1 * ulll] of patch-at ( -3 - nextneighbour ) ( - 1 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-ulll aktivierung-ulll * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]


          if pxcor < max-pxcor - 4 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration12 != 0
          [
            set aktivierung-urrrr [activation1 * 1] of patch-at ( 4 + nextneighbour ) ( - 1 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-urrrr aktivierung-urrrr * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 4 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration12 != 0
          [
            set aktivierung-ullll [activation1 * 1] of patch-at ( -4 - nextneighbour ) ( - 1 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-ullll aktivierung-ullll * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]
        ]



        if pycor < max-pycor - 2 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration2 != 0
        [
          set aktivierung-obenoben [activation1 * oo] of patch-at 0 ( 2 + nextneighbour )
          if random-float 100 < uncorrelated2 [ set aktivierung-obenoben aktivierung-obenoben * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]


          if pxcor < max-pxcor - 1 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration4 != 0
          [
            set aktivierung-oor [activation1 * oor] of patch-at ( 1 + nextneighbour ) ( 2 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-oor aktivierung-oor * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 1 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration4 != 0
          [
            set aktivierung-ool [activation1 * ool] of patch-at ( -1 - nextneighbour ) ( 2 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-ool aktivierung-ool * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]


          if pxcor < max-pxcor - 2 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration6 != 0
          [
            set aktivierung-oorr [activation1 * oorr] of patch-at ( 2 + nextneighbour ) ( 2 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-oorr aktivierung-oorr * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 2 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration6 != 0
          [
            set aktivierung-ooll [activation1 * ooll] of patch-at ( -2 - nextneighbour ) ( 2 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-ooll aktivierung-ooll * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]


          if pxcor < max-pxcor - 3 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration13 != 0
          [
            set aktivierung-oorrr [activation1 * 1] of patch-at ( 3 + nextneighbour ) ( 2 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-oorrr aktivierung-oorrr * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 3 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration13 != 0
          [
            set aktivierung-oolll [activation1 * 1] of patch-at ( -3 - nextneighbour ) ( 2 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-oolll aktivierung-oolll * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]
        ]



        if pycor > min-pycor + 2 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration2 != 0
        [
          set aktivierung-untenunten [activation1 * uu] of patch-at 0 ( -2 - nextneighbour )
          if random-float 100 < uncorrelated2 [ set aktivierung-untenunten aktivierung-untenunten * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]


          if pxcor < max-pxcor - 1 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration4 != 0
          [
            set aktivierung-uur [activation1 * uur] of patch-at ( 1 + nextneighbour ) ( -2 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-uur aktivierung-uur * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 1 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration4 != 0
          [
            set aktivierung-uul [activation1 * uul] of patch-at ( -1 - nextneighbour ) ( -2 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-uul aktivierung-uul * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]


          if pxcor < max-pxcor - 2 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration6 != 0
          [
            set aktivierung-uurr [activation1 * uurr] of patch-at ( 2 + nextneighbour ) ( -2 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-uurr aktivierung-uurr * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 2 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration6 != 0
          [
            set aktivierung-uull [activation1 * uull] of patch-at ( -2 - nextneighbour ) ( -2 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-uull aktivierung-uull * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]


          if pxcor < max-pxcor - 3 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration13 != 0
          [
            set aktivierung-uurrr [activation1 * 1] of patch-at ( 3 + nextneighbour ) ( -2 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-uurrr aktivierung-uurrr * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 3 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration13 != 0
          [
            set aktivierung-uulll [activation1 * 1] of patch-at ( -3 - nextneighbour ) ( -2 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-uulll aktivierung-uulll * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]
        ]



        if pycor < max-pycor - 3 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration5 != 0
        [
          set aktivierung-ooo [activation1 * ooo] of patch-at 0 ( 3 + nextneighbour )
          if random-float 100 < uncorrelated2 [ set aktivierung-ooo aktivierung-ooo * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]


          if pxcor < max-pxcor - 1 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration8 != 0
          [
            set aktivierung-ooor [activation1 * ooor] of patch-at ( 1 + nextneighbour ) ( 3 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-ooor aktivierung-ooor * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 1 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration8 != 0
          [
            set aktivierung-oool [activation1 * oool] of patch-at ( -1 - nextneighbour ) ( 3 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-oool aktivierung-oool * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]


          if pxcor < max-pxcor - 2 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration14 != 0
          [
            set aktivierung-ooorr [activation1 * 1] of patch-at ( 2 + nextneighbour ) ( 3 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-ooorr aktivierung-ooorr * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 2 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration14 != 0
          [
            set aktivierung-oooll [activation1 * 1] of patch-at ( -2 - nextneighbour ) ( 3 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-oooll aktivierung-oooll * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]
        ]



        if pycor > min-pycor + 3 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration5 != 0
        [
          set aktivierung-uuu [activation1 * uuu] of patch-at 0 ( -3 - nextneighbour )
          if random-float 100 < uncorrelated2 [ set aktivierung-uuu aktivierung-uuu * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]


          if pxcor < max-pxcor - 1 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration8 != 0
          [
            set aktivierung-uuur [activation1 * uuur] of patch-at ( 1 + nextneighbour ) ( -3 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-uuur aktivierung-uuur * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 1 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration8 != 0
          [
            set aktivierung-uuul [activation1 * uuul] of patch-at ( -1 - nextneighbour ) ( -3 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-uuul aktivierung-uuul * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]


          if pxcor < max-pxcor - 2 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration14 != 0
          [
            set aktivierung-uuurr [activation1 * 1] of patch-at ( 2 + nextneighbour ) ( -3 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-uuurr aktivierung-uuurr * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 2 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration14 != 0
          [
            set aktivierung-uuull [activation1 * 1] of patch-at ( -2 - nextneighbour ) ( -3 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-uuull aktivierung-uuull * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]
        ]



        if pycor < max-pycor - 4 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration7 != 0
        [
          set aktivierung-oooo [activation1 * oooo] of patch-at 0 ( 4 + nextneighbour )
          if random-float 100 < uncorrelated2 [ set aktivierung-oooo aktivierung-oooo * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]


          if pxcor < max-pxcor - 1 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration11 != 0
          [
            set aktivierung-oooor [activation1 * 1] of patch-at ( 1 + nextneighbour ) ( 4 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-oooor aktivierung-oooor * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 1 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration11 != 0
          [
            set aktivierung-ooool [activation1 * 1] of patch-at ( -1 - nextneighbour ) ( 4 + nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-ooool aktivierung-ooool * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]
        ]



        if pycor > min-pycor + 4 + nextneighbour AND ( random-float 100 >= uncorrelated )  AND neighbourintegration7 != 0
        [
          set aktivierung-uuuu [activation1 * uuuu] of patch-at 0 ( -4 - nextneighbour )
          if random-float 100 < uncorrelated2 [ set aktivierung-uuuu aktivierung-uuuu * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]


          if pxcor < max-pxcor - 1 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration11 != 0
          [
            set aktivierung-uuuur [activation1 * 1] of patch-at ( 1 + nextneighbour ) ( -4 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-uuuur aktivierung-uuuur * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]

          if pxcor > min-pxcor + 1 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration11 != 0
          [
            set aktivierung-uuuul [activation1 * 1] of patch-at ( -1 - nextneighbour ) ( -4 - nextneighbour )
            if random-float 100 < uncorrelated2 [ set aktivierung-uuuul aktivierung-uuuul * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
          ]
        ]



        if pycor < max-pycor - 5 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration13 != 0
        [
          set aktivierung-ooooo [activation1 * 1] of patch-at 0 ( 5 + nextneighbour )
          if random-float 100 < uncorrelated2 [ set aktivierung-ooooo aktivierung-ooooo * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
        ]



        if pycor > min-pycor + 5 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration13 != 0
        [
          set aktivierung-uuuuu [activation1 * 1] of patch-at 0 ( -5 - nextneighbour )
          if random-float 100 < uncorrelated2 [ set aktivierung-uuuuu aktivierung-uuuuu * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
        ]




        if pxcor < max-pxcor - 1 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration != 0
        [
          set aktivierung-rechts [activation1 * r] of patch-at ( 1 + nextneighbour ) 0
          if random-float 100 < uncorrelated2 [ set aktivierung-rechts aktivierung-rechts * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
        ]

        if pxcor > min-pxcor + 1 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration != 0
        [
          set aktivierung-links [activation1 * l] of patch-at ( -1 - nextneighbour ) 0
          if random-float 100 < uncorrelated2 [ set aktivierung-links aktivierung-links * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
        ]



        if pxcor < max-pxcor - 2 - nextneighbour AND ( random-float 100 >= uncorrelated )  AND neighbourintegration2 != 0
        [
          set aktivierung-rechtsrechts [activation1 * rr] of patch-at ( 2 + nextneighbour ) 0
          if random-float 100 < uncorrelated2 [ set aktivierung-rechtsrechts aktivierung-rechtsrechts * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
        ]

        if pxcor > min-pxcor + 2 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration2 != 0
        [
          set aktivierung-linkslinks [activation1 * ll] of patch-at ( -2 - nextneighbour ) 0
          if random-float 100 < uncorrelated2 [ set aktivierung-linkslinks aktivierung-linkslinks * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
        ]



        if pxcor < max-pxcor - 3 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration5 != 0
        [
          set aktivierung-rrr [activation1 * rrr] of patch-at ( 3 + nextneighbour ) 0
          if random-float 100 < uncorrelated2 [ set aktivierung-rrr aktivierung-rrr * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]

        ]

        if pxcor > min-pxcor + 3 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration5 != 0
        [
          set aktivierung-lll [activation1 * lll] of patch-at ( -3 - nextneighbour ) 0
          if random-float 100 < uncorrelated2 [ set aktivierung-lll aktivierung-lll * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
        ]



        if pxcor < max-pxcor - 4 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration7 != 0
        [
          set aktivierung-rrrr [activation1 * rrrr] of patch-at ( 4 + nextneighbour ) 0
          if random-float 100 < uncorrelated2 [ set aktivierung-rrrr aktivierung-rrrr * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
        ]

        if pxcor > min-pxcor + 4 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration7 != 0
        [
          set aktivierung-llll [activation1 * llll] of patch-at ( -4 - nextneighbour ) 0
          if random-float 100 < uncorrelated2 [ set aktivierung-llll aktivierung-llll * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
        ]



        if pxcor < max-pxcor - 5 - nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration10 != 0
        [
          set aktivierung-rrrrr [activation1 * 1] of patch-at ( 5 + nextneighbour ) 0
          if random-float 100 < uncorrelated2 [ set aktivierung-rrrrr aktivierung-rrrrr * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
        ]

        if pxcor > min-pxcor + 5 + nextneighbour AND ( random-float 100 >= uncorrelated ) AND neighbourintegration10 != 0
        [
          set aktivierung-lllll [activation1 * 1] of patch-at ( -5 - nextneighbour ) 0
          if random-float 100 < uncorrelated2 [ set aktivierung-lllll aktivierung-lllll * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100 + ratio_transmitted_energy ) ]
        ]


        ;; Calculate the second derivation using the activation of the neighbouring cells
        let activation3 0
        let activation4 0
        let activation5 0
        let activation6 0
        let activation7 0
        let activation8 0
        let activation9 0
        let activation10 0
        let activation11 0
        let activation12 0
        let activation13 0
        let activation14 0
        let activation15 0
        let activation16 0
        let activation17 0

        ;activation3                        ;; Activation difference of actual act and next-neighbors
        ;activation4                        ;; Activation difference of actual act and next-indirect-neighbors
        ;activation5                        ;; Activation difference of actual act and next-next-neighbors
        ;activation6                        ;; Activation difference of actual act and next-next-indirect-neighbors
        ;activation7                        ;; Activation difference of actual act and next-next-indirect-neighbors
        ;activation8                        ;; Activation difference of actual act and next-next-next-neighbors

        if neighbourintegration != 0  [ set activation3 ( ( aktivierung-oben + aktivierung-unten + aktivierung-rechts + aktivierung-links) / 4 ) ]   ;; /4 could be totally replaced by neighbourintegration
        if neighbourintegration1 != 0 [ set activation4 ( ( aktivierung-obenrechts + aktivierung-obenlinks + aktivierung-untenrechts + aktivierung-untenlinks ) / 4 ) ]
        if neighbourintegration2 != 0 [ set activation5 ( ( aktivierung-obenoben + aktivierung-untenunten + aktivierung-rechtsrechts + aktivierung-linkslinks ) / 4 ) ]
        ;; following the basic and simmetrical activation of 4 to 12 neighbours more and more activation values can be added to the model up to all neighbours in the simulated world which would demonstrate full/compseted non-local processing
        if neighbourintegration3 != 0 [ set activation6 ( ( aktivierung-orr + aktivierung-oll + aktivierung-urr + aktivierung-ull ) / 4 ) ]
        if neighbourintegration4 != 0 [ set activation7 ( ( aktivierung-oor + aktivierung-ool + aktivierung-uur + aktivierung-uul ) / 4 ) ]
        if neighbourintegration5 != 0 [ set activation8 ( ( aktivierung-ooo + aktivierung-uuu + aktivierung-rrr + aktivierung-lll ) / 4 ) ]
        if neighbourintegration6 != 0 [ set activation9 ( ( aktivierung-oorr + aktivierung-ooll + aktivierung-uurr + aktivierung-uull ) / 4 ) ]
        if neighbourintegration7 != 0 [ set activation10 ( ( aktivierung-oooo + aktivierung-uuuu + aktivierung-rrrr + aktivierung-llll ) / 4 ) ]
        if neighbourintegration8 != 0 [ set activation11 ( ( aktivierung-ooor + aktivierung-oool + aktivierung-uuur + aktivierung-uuul ) / 4 ) ]
        if neighbourintegration9 != 0 [ set activation12 ( ( aktivierung-orrr + aktivierung-olll + aktivierung-urrr + aktivierung-ulll ) / 4 ) ]
        if neighbourintegration10 != 0 [ set activation13 ( ( aktivierung-ooooo + aktivierung-uuuuu + aktivierung-rrrrr + aktivierung-lllll ) / 4 ) ]
        if neighbourintegration11 != 0 [ set activation14 ( ( aktivierung-oooor + aktivierung-ooool + aktivierung-uuuur + aktivierung-uuuul ) / 4 ) ]
        if neighbourintegration12 != 0 [ set activation15 ( ( aktivierung-orrrr + aktivierung-ollll + aktivierung-urrrr + aktivierung-ullll ) / 4 ) ]
        if neighbourintegration13 != 0 [ set activation16 ( ( aktivierung-oorrr + aktivierung-oolll + aktivierung-uurrr + aktivierung-uulll ) / 4 ) ]
        if neighbourintegration14 != 0 [ set activation17 ( ( aktivierung-ooorr + aktivierung-oooll + aktivierung-uuurr + aktivierung-uuull ) / 4 ) ]

        ;; Calculate the first derivation using the second derivation and the normal values from the two last ticks
        ;; This is a good point, to change algorithm in a way to produce alpha, beta, gamma and theta waves
        let neighbour_counter 0    ;;number of neighbours


        ;; also neighbourintegration wäre dann sone art verknüpfungsgrad der nachbarn mit der column, denn sie legen die ratio des aktivierungsunterschiede, zwischen nachbarn und column, fest.
        ;; der aktivierungsunterschied wird dann letztendlich mit ursprünglichen slope (slope_old) verrechnet ( vlt. hier namen ändern ).
        ;; neighbourintergration ist eine ratio (normalerweise zwischen 0 und 100% des aktivierungsunterschiedes). mehr als 100% sind in der natur schwer vorstellbar, als einfluss eines nachbarn auf eine column.
        ;; die aktivierung ist mehr eine akkumulation von aktivierungen der nachbarn.
        ;; deren verknüpfungsgrad spiegelt sich wieder in einer ratio ( 0 - 100% ) der aktivierungsdifferenz, aus der ein slope berechnet wird, der einfluss auf die steigung der aktivierungsänder pro zeiteinheit nimmt.
        ;; Beispiel: aus 4 direkten nachbarn wird ein mean slope berechnet zwischen ihrer eigen aktivierung und der aktivierung der betreffenden column.
        ;; der anteil an der slopeänderung des ursprünglichen slope der vier nachbarn wird mit der neighbourintegration bestimmt ( der ratio für den verknüpfungsgrad )
        ;; ist neighbourintegration = 0.5 ist der anteil jeder column 1/8. also verknüpfungsgrad 1/8
        ;; bei der festlegung der neighbourintegrations sollte man sehen dass man insgesamt auf 100 % kommt
        ;; andernfals muss man die dämpfung ( physical ) hochsetzen, den generellen slope_influence herunter setzen, oder das damping durch inhibitory neurons heraufsetzen

        ;; euklidian distance of neighbours and central column
        ;;; ratio_inhibition_activation1
        ;;; ratio_neighbour_activation
        ;;; former: ek_dc (euklidian distance)

        ;; routine for simulating IH activity increase
        set ratio_inhibition_activation2 ratio_inhibition_activation1

        ifelse ( 1 = 0 )   ;; this is for increasing beta band firing
        [
          if (ticks >= 0)
          [
            set ratio_inhibition_activation2 ratio_inhibition_activation1
          ]
          if (ticks > 1000 AND ticks <= 2000)
          [
            set ratio_inhibition_activation2 ratio_inhibition_activation1 + 0.02
          ]
          if (ticks > 2000 AND ticks <= 3000)
          [
            set ratio_inhibition_activation2 ratio_inhibition_activation1 + 0.04
          ]
          if (ticks > 3000 AND ticks <= 4000)
          [
            set ratio_inhibition_activation2 ratio_inhibition_activation1 + 0.06
          ]
          if (ticks > 4000 AND ticks <= 5000)
          [
            set ratio_inhibition_activation2 ratio_inhibition_activation1 + 0.08
          ]
          if (ticks > 5000 and ticks <= 6000)
          [
            set ratio_inhibition_activation2 ratio_inhibition_activation1 + 0.1
          ]
          if (ticks > 6000 and ticks <= 7000)
          [
            set ratio_inhibition_activation2 ratio_inhibition_activation1 + 0.12
          ]
          if (ticks > 7000 and ticks <= 8000)
          [
            set ratio_inhibition_activation2 ratio_inhibition_activation1 + 0.14
          ]
          if (ticks > 8000 and ticks <= 9000)
          [
            set ratio_inhibition_activation2 ratio_inhibition_activation1 + 0.16
          ]
          if (ticks > 9000 and ticks <= 10000)
          [
            set ratio_inhibition_activation2 ratio_inhibition_activation1 + 0.18
          ]
          if (ticks > 10000)
          [
            set ratio_inhibition_activation2 ratio_inhibition_activation1 + 0.2
          ]
        ]
        [
           set ratio_inhibition_activation2 ratio_inhibition_activation1
        ]

        let slope3 ( activation3 * ratio_neighbour_activation - activation1 * ratio_inhibition_activation2 ) * neighbourintegration
        let slope4 ( activation4 * ratio_neighbour_activation  - activation1 * ratio_inhibition_activation2 ) * neighbourintegration1
        let slope5 ( activation5 * ratio_neighbour_activation  - activation1 * ratio_inhibition_activation2 ) * neighbourintegration2
        let slope6 ( activation6 * ratio_neighbour_activation  - activation1 * ratio_inhibition_activation2 ) * neighbourintegration3
        let slope7 ( activation7 * ratio_neighbour_activation  - activation1 * ratio_inhibition_activation2 ) * neighbourintegration4
        let slope8 ( activation8 * ratio_neighbour_activation  - activation1 * ratio_inhibition_activation2 ) * neighbourintegration5
        let slope9 ( activation9 * ratio_neighbour_activation  - activation1 * ratio_inhibition_activation2 ) * neighbourintegration6
        let slope10 ( activation10 * ratio_neighbour_activation  - activation1 * ratio_inhibition_activation2 ) * neighbourintegration7
        let slope11 ( activation11 * ratio_neighbour_activation  - activation1 * ratio_inhibition_activation2 ) * neighbourintegration8
        let slope12 ( activation12 * ratio_neighbour_activation  - activation1 * ratio_inhibition_activation2 ) * neighbourintegration9
        let slope13 ( activation13 * ratio_neighbour_activation  - activation1 * ratio_inhibition_activation2 ) * neighbourintegration10
        let slope14 ( activation14 * ratio_neighbour_activation  - activation1 * ratio_inhibition_activation2 ) * neighbourintegration11
        let slope15 ( activation15 * ratio_neighbour_activation  - activation1 * ratio_inhibition_activation2 ) * neighbourintegration12
        let slope16 ( activation16 * ratio_neighbour_activation  - activation1 * ratio_inhibition_activation2 ) * neighbourintegration13
        let slope17 ( activation17 * ratio_neighbour_activation  - activation1 * ratio_inhibition_activation2 ) * neighbourintegration14

        ;; da muss man nochmal drüber nachdenken
        ;; neighbourcounter gibt aussage über den energietransfer
        ;; neighbourintegration gibt aussage über den anteil an energietranfer von weiter weg liegenden columns
        ;; normal wird ein achtel je nachbar columns übertragen
        ;; vermutlich sollte man den neighbourcounter vernachlässigen
        if neighbourintegration > 0 [ set neighbour_counter neighbour_counter + 1 ]
        if neighbourintegration1 > 0 [ set neighbour_counter neighbour_counter + 1 ]
        if neighbourintegration2 > 0 [ set neighbour_counter neighbour_counter + 1 ]
        if neighbourintegration3 > 0 [ set neighbour_counter neighbour_counter + 1 ]
        if neighbourintegration4 > 0 [ set neighbour_counter neighbour_counter + 1 ]
        if neighbourintegration5 > 0 [ set neighbour_counter neighbour_counter + 1 ]
        if neighbourintegration6 > 0 [ set neighbour_counter neighbour_counter + 1 ]
        if neighbourintegration7 > 0 [ set neighbour_counter neighbour_counter + 1 ]
        if neighbourintegration8 > 0 [ set neighbour_counter neighbour_counter + 1 ]
        if neighbourintegration9 > 0 [ set neighbour_counter neighbour_counter + 1 ]
        if neighbourintegration10 > 0 [ set neighbour_counter neighbour_counter + 1 ]
        if neighbourintegration11 > 0 [ set neighbour_counter neighbour_counter + 1 ]
        if neighbourintegration12 > 0 [ set neighbour_counter neighbour_counter + 1 ]
        if neighbourintegration13 > 0 [ set neighbour_counter neighbour_counter + 1 ]
        if neighbourintegration14 > 0 [ set neighbour_counter neighbour_counter + 1 ]

        let nc neighbour_counter  ;; normalization of slope/neighbours
        ;; set nc 1 ;; for creating chaos no normalizaton (to calculate k value)
        ;; was machen mit dem neighbourcounter??
        ;; irgendeien distanz faktor einbringen??
        ;; oder vernetzungsgrad mit der column??
        ;; wie ist die neighbourintegration definiert!?: hier muss noch gute überlegt werden wie hier parameter gesetzt werden um das biologische sstem wiederzuspiegeln

        ;; hie rmuss man auch nochmal drüber nachdenken
        ;; here it is possible to smooth waves with activation 2. Fits well the way act2 is implemented
        set slope_vector ( slope3 + slope4 + slope5 + slope6 + slope7 + slope8 + slope9 + slope10 + slope11 + slope12 + slope13 + slope14 + slope15 + slope16 + slope17 ) / nc       ;; / nc neighbourcounter (calculation of mean slope of neighbours)
        set slope_vector slope_vector * ( 1 )

        ;; routine for gradually increasing the baseline
        ifelse ( 1 = 0 )   ;; this is for increasing baseline
        [
          if (ticks > 1000 AND ticks <= 2000)
          [
            set slope_vector slope_vector * ( NI_slopev + 0.4 )
          ]
          if (ticks > 2000 AND ticks <= 3000)
          [
            set slope_vector slope_vector * ( NI_slopev + 0.7 )
          ]
          if (ticks > 3000 AND ticks <= 4000)
          [
            set slope_vector slope_vector * ( NI_slopev + 1 )
          ]
          if (ticks > 4000 AND ticks <= 5000)
          [
            set slope_vector slope_vector * ( NI_slopev + 1.3 )
          ]
          if (ticks > 5000 and ticks <= 6000)
          [
            set slope_vector slope_vector * ( NI_slopev + 1.6 )
          ]
          if (ticks > 6000 and ticks <= 7000)
          [
            set slope_vector slope_vector * ( NI_slopev + 1.9 )
          ]
          if (ticks > 7000 and ticks <= 8000)
          [
            set slope_vector slope_vector * ( NI_slopev + 2.2 )
          ]
          if (ticks > 8000 and ticks <= 9000)
          [
            set slope_vector slope_vector * ( NI_slopev + 2.5 )
          ]
          if (ticks > 9000 and ticks <= 10000)
          [
            set slope_vector slope_vector * ( NI_slopev + 2.6 )
          ]
          if (ticks > 10000)
          [
            set slope_vector slope_vector * ( NI_slopev + 2 )
          ]
        ]
        [
           set slope_vector slope_vector * NI_slopev
        ]

        ;; uncorrelated slope vector
        if random-float 100 < uncorrelated3_slopev
        [
          set slope_vector slope_vector * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
        ]

        ;; uncorrelated slope vector damping
        ifelse random-float 100 < uncorrelated3_slopevdamping
        [
          set slope_vector ( slope_vector / ( 1 + slopev_damping * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy ) ) )
        ]
        [
          set slope_vector ( slope_vector / ( 1 + slopev_damping ) )
        ]


        ; set slope_old slope_old + slope_vector ;; normal integration step of slope | könnte hier noch einen neuen slope_new einbringen, für eine individualsierte Änderung des slope_olds, dann braucht es aber auch einen neuen activation_change
        ;set slope_old slope_old ;; test for model without impulse
        set slope_old slope_old * NI_slopeo1 + slope_vector ;; testing effects of lowering first intergation of slope/impulse
        set slope_old slope_old * NI_slopeo

        ;; uncorrelated slope vector
        if random-float 100 < uncorrelated4_slopeo
        [
          set slope_old slope_old * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
        ]

        ;; uncorrelated slope old damping
        ifelse random-float 100 < uncorrelated4_slopeodamping
        [
          set slope_old ( slope_old / ( 1 + slopeo_damping * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy ) ) )
        ]
        [
          set slope_old ( slope_old / ( 1 + slopeo_damping ) )
        ]

        ;; influence of activationdifference in time. Could be a second slope vector, but shouldn be of biological meaning ( currently not used )
        ;; looks like there is no sense as it compares the speed after and before. its better to consider the accelaration ( slope ) after and before.
        let activation_delta activationdifference * ( activation1 - activation0 )

        ;; New activation = Old activation + derivation
        ;; Damping is also implemented in the part (stronger at the margin)
        ifelse istRand?
        [
          ;; calcualtion of activity for the margin

          ;; Margin damping
          ifelse ( ( pxcor - min-pxcor ) < ( max-pxcor - pxcor ) )       ;; Ugly minimumcalculation. If something better is found, REPLACE!!!
          [ set minimummargin ( pxcor - min-pxcor ) ]
          [ set minimummargin ( max-pxcor - pxcor ) ]
          ifelse ( ( pycor - min-pycor ) < minimummargin )
          [ set minimummargin ( pycor - min-pycor ) ]
          [
            if ( ( max-pycor - pycor ) < minimummargin ) [ set minimummargin ( max-pycor - pycor ) ]
          ]


          ;; main algorithm for updating the activtiy of the columns, combined with uncorrelated damping
          ifelse random-float 100 < uncorrelated5_damping
          [
            set activation1.1 ( ( activation1 * NI_act1 + slope_old ) / ( 1 + damping * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )  + ( marginextradamping / ( 1 + minimummargin ) ) ) )
          ]
          [
            set activation1.1 ( ( activation1 * NI_act1 + slope_old ) / ( 1 + damping + ( marginextradamping / ( 1 + minimummargin ) ) ) )
          ]

          set activation0 activation1.1
          ;set activation0 activation0 + activation0 * 0.01 ;; test exponential


          ;; uncorrelated activation0
          if random-float 100 < uncorrelated1
          [
            set activation0 activation0 * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]

          ;;set activation0 activation1 / ( 1 + damping ) ;;maybe when using ising this is used

          ;; update-ising   ;; use this for ising like calculations and put out the activation0!?
          if sigmoid
          [ set activation0 ( 20 * ( 1 / ( 1 + exp( - activation0) ) ) ) - 10 ]


          ;; create fuzzy activation0 to control the degrees of freedoom
          ;ifelse activation0 > 0
          ;[ set activation0 1 ]
          ;[
          ;  ifelse activation0 < 0
          ;  [ set activation0 -1 ]
          ;  [ set activation0 0 ]
          ;]

          ;ifelse activation1 > 0
          ;[ set activation1 1 ]
          ;[
          ;  ifelse activation1 < 0
          ;  [ set activation1 -1 ]
          ;  [ set activation1 0 ]
          ;]

        ]
        [
          ;; calculation of activity for non margin columns

          ;; main algorithm for updating the activtiy of the columns, combined with uncorrelated damping
          ifelse random-float 100 < uncorrelated5_damping
          [
            set activation1.1 ( ( activation1 * NI_act1 + slope_old ) / ( 1 + damping * ( random-float ( ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy ) ) )
          ]
          [
            set activation1.1 ( ( activation1 * NI_act1 + slope_old ) / ( 1 + damping ) )
          ]
          ;; rainold messner
          set activation0 activation1.1
          ;set activation0 activation0 + activation0 * 0.01 ;; test exponential

          ;; uncorrelated activation0
          if random-float 100 < uncorrelated1
          [
            set activation0 activation0 * ( random-float (  ( 1 - ratio_transmitted_energy ) * 100 ) / 100  + ratio_transmitted_energy )
          ]


          ;;set activation0 activation1 / ( 1 + damping )  ;;maybe when using ising this is used

          ;; update-ising   ;; use this for ising like calculations and put out the activation0!?
          if sigmoid
          [ set activation0 ( 20 * ( 1 / ( 1 + exp( - activation0) ) ) ) - 10 ]


          ;; create fuzzy activation0 to control the degrees of freedoom
          ;ifelse activation0 > 0
          ;[ set activation0 1 ]
          ;[
          ;  ifelse activation0 < 0
          ;  [ set activation0 -1 ]
          ;  [ set activation0 0 ]
          ;]

          ;ifelse activation1 > 0
          ;[ set activation1 1 ]
          ;[
          ;  ifelse activation1 < 0
          ;  [ set activation1 -1 ]
          ;  [ set activation1 0 ]
          ;]
          ;; do you need both actiovation0 and activation1?? if not nothing will change?! try!
          ;; activation1 is here the hsitory. before newly calculating activation9 it is the history of hsitory (history degree 2). in results there is past (activation0), presence (activation1) and future (activation0)
          ;; if the calculation is "activation1 ( ( activation1 + slope_old )" the past and the future is the same. The past is also stored in slope_old but integrated or abgeleitet. in result the activation is always in the presence
          ;; if you have not only a past of slope but also a past of the own activation0 there are more degrees of freedom to alter the future
          ;; with slope you can do the same!?
          ;; when activation change activation1 will be the past, activation0 the past-past and calculated will be the presence as activation0.
          ;; if you have activation0 and activation1 and slope_old and slope_new you can calculate an angle between the past and presence and future (like determining peaks) you can build up a model.
          ;; without knwoing slope_new and slope_old seperated it will be difficult to state models like a peak or maximum or mimimum oder nullstellen. you never know where you have been before
          ;; becuase in that time moment the new slope is set the old slope is gone (same storage). information is still stored in activation0. old slope could be calculated again
          ;; but without activation0 there is absolutly now memeory. no triangle no vectore no angle.
          ;; its just. what about my neighbpurs. they say up, so I will update my slope_old with new slope and in that timemoment the history is gone (past and future the same (funny, like aborigines))
        ]
      ]

      labeling_output pxcor pycor
      live_coloring_patches

    ]
    ;; end of main algorithm
    ;;...................................................................................................................................................................................................



    if (generate-spontaneousactivity-on)
    [
      generate-spontaneousactivity
    ]

    if (generate-ising-on)
    [
      repeat 1000
      [
        ask one-of patches [ update-ising ]
      ]
      ;; tick-advance 1000  ;; use `tick-advance`, as we are updating 1000 patches at a time
    ]

    do-plots

    ;ask patches [ set activation0 activation1 ]   ;; for testing the variables activation0 and activation1

    tick
  ]
  [ stop ]
end

;; end of main procedure (go procedure)
;;................................................................................................................................................................................................................................................................
;;................................................................................................................................................................................................................................................................








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Live coloring of the patches regarding their activation level (activation0)................................................................................
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to live_coloring_patches

 ifelse (color_activation_all)
 [
  if ( NOT input? )
  [
    set colormargin margincolor
    ;; let activationshow_upper range_uper
    ;; let activationshow_lower range_lower
    let activationshow activation0

    ifelse istRand? AND NOT input?
    [ set pcolor colormargin ]                                                                                                   ;; Color the margin
    [
      ifelse inaktiv?
      [
        ifelse showlesions
        [ if pcolor != white [ set pcolor grey ] ]                                                                               ;; Color the inactive
        [ if pcolor != white [ set pcolor scale-color pink activationshow (coloringactivation * (-1)) coloringactivation ] ]     ;; Don't color the inactive
      ]
      [
        ifelse output?
        [
          ifelse showMEAelectrode
          [
            set pcolor magenta
            ;set pcolor scale-color magenta activationshow (coloringactivation * (-1)) coloringactivation                        ;; Color the outputs
          ]
          [ set pcolor scale-color colornormal activationshow  (coloringactivation * (-1)) coloringactivation ]                  ;; Outputcells have the same color like activated cells
        ]
        [ set pcolor scale-color colornormal activationshow (coloringactivation * (-1)) coloringactivation ]                     ;; Color normal cells
      ]
    ]
  ]
]
[
  if ( NOT input? )
  [
    set colormargin margincolor
    let activationshow_upper range_upper
    let activationshow_lower range_lower
    let activationshow activation0

    ifelse istRand? AND NOT input?
    [ set pcolor colormargin ]                                                                                                   ;; Color the margin
    [
      ifelse inaktiv?
      [
        ifelse showlesions
        [ if pcolor != white [ set pcolor grey ] ]                                                                               ;; Color the inactive
        [ if pcolor != white [ set pcolor scale-color blue activationshow activationshow_lower activationshow_upper ] ]          ;; Don't color the inactive
      ]
      [
        ifelse output?
        [
          ifelse showMEAelectrode
          [ set pcolor magenta ]                                                                                                 ;; Color the outputs
          [ set pcolor scale-color colornormal activationshow  activationshow_lower activationshow_upper ]                       ;; Outputcells have the same color like activated cells
        ]
        [
          set pcolor scale-color colornormal activationshow activationshow_lower activationshow_upper
          if ( activationshow > activationshow_upper ) [ set pcolor 0 ]                                                          ;; Color normal cells
        ]
      ]
    ]
  ]
]
end
;; end of live coloring the patches
;;................................................................................................................................................................




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Output(EEG and MEA Signal)......................................................................................................................................
;; Retrieval of MEA signaland .....................................................................................................................................
;; Calculation of the "EEG"-Signal for plotting....................................................................................................................
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EEG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to-report get-output-eeg [ x-co y-co electrode radius ]

  if ( electrode = 1 )
  [
    set x-co eegX
    set y-co eegY
  ]
  if ( electrode = 2 )
  [
    set x-co eegX + 1
    set y-co eegY + 1
  ]
  if ( electrode = 3 )
  [
    set x-co eegX + 2
    set y-co eegY + 2
  ]
  if ( electrode = 4 )
  [
    set x-co eegX + 3
    set y-co eegY + 3
  ]
  if ( electrode = 5 )
  [
    set x-co eegX + 4
    set y-co eegY + 4
  ]
  if ( electrode = 6 )
  [
    set x-co eegX + 5
    set y-co eegY + 5
  ]



  let gegenkathete 0
  let number_patches 0
  let EEG_act 0

  while [ radius >= 0 ]
  [
    let alpha 1
    while [ alpha <= 360 ]
    [
      let ankathete sin( alpha ) * radius
      ifelse ( ( alpha >= 90 and alpha <= 180 ) OR ( alpha >= 270 and alpha <= 360 ) )
      [ set gegenkathete ( ( radius ^ 2 ) - ( ankathete ^ 2 ) ) ^ ( 0.5 ) ]
      [ set gegenkathete ( - 1 * ( ( ( radius ^ 2 ) - ( ankathete ^ 2 ) ) ^ ( 0.5 ) ) ) ]
      ask patch ( ankathete + x-co ) ( gegenkathete + y-co )
      [
        set isEEG? true
      ]
      set alpha alpha + 1
    ]
    set radius radius - 1
  ]
  ask patches
  [
    if isEEG?
    [
      if ( showEEGelectrode ) [ set pcolor 117 ]
      set number_patches number_patches + 1
      set EEG_act EEG_act + activation0
      set isEEG? false
    ]
  ]
  ;output-show word "number of EEG patches is:" number_patches
  report EEG_act
end



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Calculation of the "MEA"-Signal for plotting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to-report get-output-mea
  ;; MEA coordinaten varibel gestalten und labeln ist wichtig
  let list_testplot [ 0 0 0 0 0 0 ]
  let list_keys table:keys output_hash
  foreach table:keys output_hash
  [ ?1 ->
    let list_coor split ?1 "_"
    let x read-from-string ( item 0 list_coor )
    let y read-from-string ( item 1 list_coor )
    if ( table:get output_hash ?1 = "01" ) [ ask patch x y [ set list_testplot replace-item 0 list_testplot activation0  ] ]
    if ( table:get output_hash ?1 = "02" ) [ ask patch x y [ set list_testplot replace-item 1 list_testplot activation0  ] ]
    if ( table:get output_hash ?1 = "03" ) [ ask patch x y [ set list_testplot replace-item 2 list_testplot activation0  ] ]
    if ( table:get output_hash ?1 = "04" ) [ ask patch x y [ set list_testplot replace-item 3 list_testplot activation0  ] ]
    if ( table:get output_hash ?1 = "05" ) [ ask patch x y [ set list_testplot replace-item 4 list_testplot activation0  ] ]
    if ( table:get output_hash ?1 = "06" ) [ ask patch x y [ set list_testplot replace-item 5 list_testplot activation0  ] ]
  ]
  report reverse list_testplot
end
;;end of output (EEG, MEA)
;;.....................................................................................................................................................................





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; plot the wave pattern, moving average and peaks.........................................................................................
;; export plots ...........................................................................................................................
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to do-plots
  ;; write all patches activations to matrix
  file-open "activation_matrix_N38SOD1C1S50.txt"

  let xmin min-pxcor
  let xmax max-pxcor
  let ymin min-pycor
  let ymax max-pycor
  let xinrease 0
  let yincrease 0

  while [xmin <= xmax]
  [
    while [ymin <= ymax]
    [
      ask patch xmin ymin
      [
        (ifelse tickcounter = 2
        [
          file-write (word pxcor "|" pycor)
        ]
        tickcounter > 2 [
          file-write activation0
        ])
      ]
      set ymin ymin + 1
    ]
    set ymin min-pycor
    set xmin xmin + 1
  ]
  file-print ""
  file-close-all




  ;; get MEA signal
  let list_MEAact get-output-mea
  let MEA_act0 item 5 list_MEAact                                               ;; sind hier schleifen besser ;; fragestellung beim plotten globale bessser, da ja immer wieder was neu berechnet werden muss wenn es lokale sind
  let MEA_act1 item 4 list_MEAact                                               ;; sowie EEG_act, das für den peakidentifier verwendet wird und für das moving average ( kann es jedes mal wieder übergeben werden oder könnte es probleme
  let MEA_act2 item 3 list_MEAact                                               ;; mit der windowsize geben?? globale listen bei der windowsize? oder gibt es andere möglichkeiten??
  let MEA_act3 item 2 list_MEAact
  let MEA_act4 item 1 list_MEAact
  let MEA_act5 item 0 list_MEAact

  ;; get EEG Signal
  let EEG_act0 get-output-eeg eegX eegY 1 radiusEEG
  let EEG_act1 get-output-eeg eegX eegY 2 radiusEEG
  let EEG_act2 get-output-eeg eegX eegY 3 radiusEEG
  let EEG_act3 get-output-eeg eegX eegY 4 radiusEEG
  let EEG_act4 get-output-eeg eegX eegY 5 radiusEEG
  let EEG_act5 get-output-eeg eegX eegY 6 radiusEEG

  ;; get moving average
  ;let movingaverage1 get-moving-average MEA_act1 1 1 windowsizeMEA
  ;let movingaverageEEG get-moving-average EEG_act0 2 1 windowsizeEEG

  ;; get peaks
  ;let result_peaks get-peak-identifier MEA_act1 1 1 tresholdheight tresholdwidth
  ;let posmax item 5 result_peaks
  ;let maxneu item 7 result_peaks
  ;let maxpeak item 14 result_peaks
  ;let result_peaks get-peak-identifier EEG_act0 2 1 tresholdheighteeg tresholdwidtheeg
  ;let posmaxeeg item 5 result_peaks
  ;let maxneueeg item 16 result_peaks
  ;let maxpeakeeg item 14 result_peaks


  set-current-plot "MEA 01"                                                     ;; Plot different wavepattern
  set-current-plot-pen "MEA_plot00"
  plotxy (tickcounter) ( MEA_act0 )

  set-current-plot "MEA 02"                                                     ;; MEA_plot11 ist ploted with peakidentiier and moving average
  set-current-plot-pen "MEA_plot11"
  plotxy (tickcounter) ( MEA_act1 )

  set-current-plot-pen "peakidentifier"                                         ;; ungewöhnliches plotten mit dem peak der über 200 ist ( wann ist der peak über 200 )
  ;ifelse maxpeak > 200                                                         ;; der peak wird 500 gesetzt wenn ein maximum existiert
  ;[ plotxy ( posmax ) ( 0 )                                                    ;; vlt sollte besser ein eintrag existieren mit maxneu ist maximum ( hash/ table? )
  ;  plotxy ( posmax ) ( maxneu )
  ;  plotxy ( posmax ) ( 0 ) ]
  ;[ plotxy ( posmax - 1 ) ( 0 ) ]

  set-current-plot-pen "movingaverage1"
  ;plotxy ( tickcounter - (windowsizeMEA / 2 )  ) ( movingaverage1 )

  set-current-plot "MEA 03"
  set-current-plot-pen "MEA_plot22"
  plotxy (tickcounter) ( MEA_act2 )

  set-current-plot "MEA 04"
  set-current-plot-pen "MEA_plot33"
  plotxy (tickcounter) ( MEA_act3 )

  set-current-plot "MEA 05"
  set-current-plot-pen "MEA_plot44"
  plotxy (tickcounter) ( MEA_act4 )

  set-current-plot "MEA 06"
  set-current-plot-pen "MEA_plot55"
  plotxy (tickcounter) ( MEA_act5 )

  set-current-plot "EEG Signal"
  set-current-plot-pen "EEGplot"
  plotxy (tickcounter) ( EEG_act0 )

  set-current-plot-pen "peakidentifiereeg"
  ;ifelse maxpeakeeg > 200
  ;[ plotxy ( posmaxeeg ) ( 0 )
  ;  plotxy ( posmaxeeg ) ( maxneueeg )
  ;  plotxy ( posmaxeeg ) ( 0 ) ]
  ;[ plotxy ( posmaxeeg - 1 ) ( 0 ) ]

  set-current-plot-pen "movingaverageeeg"
  ;plotxy ( tickcounter - (windowsizeEEG / 2 )  ) ( movingaverageEEG )

  set-current-plot "EEG Signal2"
  set-current-plot-pen "EEGplot2"
  plotxy (tickcounter) ( EEG_act1 )

  set-current-plot "EEG Signal3"
  set-current-plot-pen "EEGplot3"
  plotxy (tickcounter) ( EEG_act2 )

  set-current-plot "EEG Signal4"
  set-current-plot-pen "EEGplot4"
  plotxy (tickcounter) ( EEG_act3 )

  set-current-plot "EEG Signal5"
  set-current-plot-pen "EEGplot5"
  plotxy (tickcounter) ( EEG_act4 )

  set-current-plot "EEG Signal6"
  set-current-plot-pen "EEGplot6"
  plotxy (tickcounter) ( EEG_act5 )


  ;; Maxwell Approach
  set-current-plot "SlopeVector"
  set-current-plot-pen "SlopeVectorPlot"
  plotxy (tickcounter) ( slope_vector_of_patch )

  set-current-plot "SlopeOld"
  set-current-plot-pen "SlopeOldPlot"
  plotxy (tickcounter) ( slope_old_of_patch )

  set-current-plot "Activation0"
  set-current-plot-pen "Activation0Plot"
  plotxy (tickcounter) ( activation0_of_patch )

  set-current-plot "Activation1"
  set-current-plot-pen "Activation1Plot"
  plotxy (tickcounter) ( activation1_of_patch )


  ;; integration of Energy
  set-current-plot "Sum Energy"
  set-current-plot-pen "SumEnergyPlot"
  plotxy (tickcounter) ( sum_of_patches )

  set-current-plot "SumActivation0"
  set-current-plot-pen "SumActivation0Plot"
  plotxy (tickcounter) ( sum_of_patch )



  set-current-plot "Slope All"
  set-current-plot-pen "SlopePlotOfAll"
  plotxy (tickcounter) ( slope_of_all )

  set-current-plot "Sum Slope All"
  set-current-plot-pen "SumSlopeAll"
  plotxy (tickcounter) ( sum_of_slopes )

   if tickcounter mod round 5000 = 0 or tickcounter mod round finish = 0
  [
  ;;saving plots
  export-plot "MEA 01" "wavepattern00.csv"
  export-plot "MEA 02" "wavepattern11.csv"
  export-plot "MEA 03" "wavepattern22.csv"
  export-plot "MEA 04" "wavepattern33.csv"
  export-plot "MEA 05" "wavepattern44.csv"
  export-plot "MEA 06" "wavepattern55.csv"
  export-plot "EEG Signal" "eegsignal.csv"
  export-plot "EEG Signal2" "eegsignal2.csv"
  export-plot "EEG Signal3" "eegsignal3.csv"
  export-plot "EEG Signal4" "eegsignal4.csv"
  export-plot "EEG Signal5" "eegsignal5.csv"
  export-plot "EEG Signal6" "eegsignal6.csv"
  export-plot "Sum Energy" "sumenergy.csv"
  export-plot "SumActivation0" "sumactivation0.csv"
  export-plot "SlopeVector" "slopevector.csv"
  export-plot "Slope All" "Slope_All.csv"
  export-plot "Sum Slope All" "Sum_Slope_All.csv"
  ]

  ;; saving view and current data matrix
  if tickcounter mod round 5000 = 0
  [
    let export_name (word "qualitative_analysis" random-float 1.0 ".png")
    ;;word ("qualitative_analysis" date-and-time ".png")
    export-interface export_name
  ]

  if tickcounter mod round 5000 = 0
  [
    let export_name (word "world" tickcounter ".csv")
    export-world export_name
  ]


end
;; end of plotting and exporting
;;......................................................................................................................................


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Split and join function
;;; Copyright Jim (https://groups.yahoo.com/neo/groups/netlogo-users/conversations/topics/6490);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to-report split [ string sep ] ; #sep must be non-empty string
  let result [] ; return value
  let w length sep
  loop ; exit when done
  [
    let next-pos position sep string
    if not is-number? next-pos
    [ report reverse (fput string result) ]
    set result fput (substring string 0 next-pos) result
    set string substring string (next-pos + w) (length string)
  ]
end


to-report join [ jlist sep ] ; #list must not be empty
  report reduce [ [?1 ?2] -> (word ?1 "sep" ?2) ] jlist
end
;; end of split function
;;..............................................................
@#$#@#$#@
GRAPHICS-WINDOW
666
262
1381
978
-1
-1
7.04
1
10
1
1
1
0
0
0
1
-50
50
-50
50
1
1
1
msec
30.0

BUTTON
100
127
166
161
stepwise
go
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
1

BUTTON
169
127
249
161
automatically
go
T
1
T
OBSERVER
NIL
A
NIL
NIL
1

SLIDER
7
163
119
196
signal1
signal1
0
1000
50.0
0.01
1
hz
HORIZONTAL

SLIDER
7
196
116
229
signal2
signal2
0
1000
200.0
0.01
1
hz
HORIZONTAL

SLIDER
7
228
116
261
signal3
signal3
0
1000
100.0
0.01
1
hz
HORIZONTAL

SLIDER
7
261
115
294
signal4
signal4
0
1000
250.0
0.01
1
hz
HORIZONTAL

SLIDER
7
293
116
326
signal5
signal5
0
1000
150.0
0.01
1
hz
HORIZONTAL

BUTTON
116
164
171
197
NIL
input1
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
116
197
171
230
NIL
input2
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
116
230
171
263
NIL
input3
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
116
263
171
296
NIL
input4
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
116
295
171
328
NIL
input5
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
167
946
259
979
xdir
xdir
-50
200
50.0
1
1
NIL
HORIZONTAL

SLIDER
1969
498
2240
531
damping
damping
-2
10
0.001
0.00000001
1
(mV/1+ damp)
HORIZONTAL

SLIDER
1505
77
1677
110
backgroundcolors
backgroundcolors
0
50
25.0
1
1
NIL
HORIZONTAL

BUTTON
111
946
166
979
NIL
Fire
NIL
1
T
OBSERVER
NIL
F
NIL
NIL
1

SWITCH
1359
76
1504
109
showMEAelectrode
showMEAelectrode
0
1
-1000

SWITCH
1723
843
1848
876
showLesions
showLesions
0
1
-1000

SLIDER
1509
877
1702
910
lesions
lesions
0.00
2
0.0
0.01
1
approx. %
HORIZONTAL

SWITCH
1723
876
1848
909
regular
regular
1
1
-1000

SLIDER
1728
912
1963
945
uncorrelated
uncorrelated
0
100
0.0
0.00001
1
%
HORIZONTAL

SLIDER
1509
808
1850
841
tresholdsizelesions
tresholdsizelesions
0
1000
31.0
1
1
approx. units
HORIZONTAL

BUTTON
1508
843
1601
876
NIL
cluster
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
1855
874
2128
919
to execute the clustering of lesions push the cluster button and reset ticks after that.\n
12
105.0
1

TEXTBOX
1854
843
1966
875
defects can be regular or random distributed
12
105.0
1

TEXTBOX
1695
1080
1910
1102
Spontaneousactivity
20
105.0
1

SLIDER
1513
1375
1685
1408
windowsizeMEA
windowsizeMEA
0
100
3.0
1
1
NIL
HORIZONTAL

TEXTBOX
1517
1410
1690
1428
windowsize of running average\n
12
105.0
1

SLIDER
1514
1436
1686
1469
tresholdwidth
tresholdwidth
0
20
1.0
0.1
1
NIL
HORIZONTAL

OUTPUT
1518
1657
1909
1887
12

TEXTBOX
1555
1469
1705
1487
width of peaks
12
105.0
1

SLIDER
637
167
1278
200
coloringactivation
coloringactivation
0.01
10000
100.0
0.01
1
mV
HORIZONTAL

PLOT
8
1101
748
1283
MEA 01
msec
mVolt
0.0
1.0
0.0
1.0
true
false
"" ""
PENS
"MEA_plot00" 1.0 0 -16777216 true "" ""

PLOT
748
1102
1509
1284
MEA 02
msec
mVolt
0.0
1.0
0.0
1.0
true
false
"" ""
PENS
"MEA_plot11" 1.0 0 -16383231 true "" ""
"peakidentifier" 1.0 0 -2674135 true "" ""
"movingaverage1" 1.0 0 -13840069 true "" ""

PLOT
5
1281
745
1467
MEA 03
msec
mVolt
0.0
1.0
0.0
1.0
true
false
"" ""
PENS
"MEA_plot22" 1.0 0 -16777216 true "" ""

PLOT
746
1282
1508
1470
MEA 04
msec
mVolt
0.0
1.0
0.0
1.0
true
false
"" ""
PENS
"MEA_plot33" 1.0 0 -16777216 true "" ""

PLOT
4
1467
745
1651
MEA 05
msec
mVolt
0.0
1.0
0.0
1.0
true
false
"" ""
PENS
"MEA_plot44" 1.0 0 -16777216 true "" ""

PLOT
746
1468
1509
1654
MEA 06
msec
mVolt
0.0
1.0
0.0
1.0
true
false
"" ""
PENS
"MEA_plot55" 1.0 0 -16777216 true "" ""

SLIDER
1521
2018
1729
2051
ratio_inhibitories
ratio_inhibitories
0
50
15.0
1
1
approx. %
HORIZONTAL

SLIDER
1517
1291
1689
1324
finish
finish
100
400009
6100.0
1000
1
NIL
HORIZONTAL

SLIDER
2033
1292
2223
1325
nextneighbour
nextneighbour
0
3
0.0
1
1
NIL
HORIZONTAL

TEXTBOX
1583
1220
1801
1247
End of the simulation
20
105.0
1

BUTTON
39
126
99
160
NIL
initialize
NIL
1
T
OBSERVER
NIL
I
NIL
NIL
1

PLOT
1
1653
1511
1898
EEG Signal
msec
microVolt
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"EEGplot" 1.0 0 -16777216 true "" ""
"peakidentifiereeg" 1.0 0 -2674135 true "" ""
"movingaverageeeg" 1.0 0 -10899396 true "" ""
"axis" 1.0 0 -16777216 true ";; draw a horizontal line to show the x axis\nauto-plot-off\nplotxy 0 0\nplotxy 1000000000000000 0\nauto-plot-on" ""

BUTTON
1602
844
1703
877
Reset Ticks
reset-ticks\nask patches [ set activation0 0 ]\ntick
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
259
946
351
979
ydir
ydir
-50
200
50.0
1
1
NIL
HORIZONTAL

TEXTBOX
1575
10
1740
30
Edit Visualization
20
105.0
1

TEXTBOX
529
12
1249
67
Basic Information Processing Interface
40
105.0
1

TEXTBOX
632
1045
1035
1093
Output and Analysis
40
105.0
1

TEXTBOX
1551
931
1683
958
Schizophrenia
20
105.0
1

SLIDER
1505
109
1677
142
margincolor
margincolor
0
200
119.0
1
1
NIL
HORIZONTAL

TEXTBOX
11
91
340
118
Generation of Cortical Input
20
105.0
1

SLIDER
2033
1258
2223
1291
activationdifference
activationdifference
0
2
0.0
0.01
1
NIL
HORIZONTAL

TEXTBOX
1580
468
1739
498
Wavepattern
20
105.0
1

SLIDER
1589
1140
1911
1173
ratio_activatedcells
ratio_activatedcells
0
500
1.0
0.00000001
1
approx. %
HORIZONTAL

SLIDER
2
866
111
899
carriersignal
carriersignal
0
10000
20.0
1
1
hz
HORIZONTAL

BUTTON
110
866
174
899
NIL
Carrier
T
1
T
OBSERVER
NIL
C
NIL
NIL
0

SLIDER
220
1044
418
1077
carriersignalstrength
carriersignalstrength
0
10000
2400.0
1
1
mV
HORIZONTAL

SLIDER
22
1044
218
1077
inputsignalstrength
inputsignalstrength
0
3000
800.0
1
1
mV
HORIZONTAL

SLIDER
1465
497
1716
530
neighbourintegration
neighbourintegration
-10
100
1.0
0.0000000001
1
NIL
HORIZONTAL

SLIDER
6
359
115
392
signal7
signal7
0
1000
250.0
0.01
1
hz
HORIZONTAL

SLIDER
6
392
116
425
signal8
signal8
0
1000
400.0
0.01
1
hz
HORIZONTAL

SLIDER
6
426
115
459
signal9
signal9
0
1000
380.0
0.01
1
hz
HORIZONTAL

SLIDER
6
459
115
492
signal10
signal10
0
1000
480.0
0.01
1
hz
HORIZONTAL

BUTTON
116
327
171
360
NIL
input6
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
116
360
171
393
NIL
input7
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
116
394
171
427
NIL
input8
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
116
427
171
460
NIL
input9
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
113
461
168
494
NIL
input10
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
1632
1946
1921
2003
Inhibitory neurons (old)
20
105.0
1

SLIDER
1730
2052
1938
2085
deactlevel1
deactlevel1
1
100
100.0
1
1
%
HORIZONTAL

SLIDER
1520
2051
1730
2084
activationtreshold
activationtreshold
-10
10
1.0
0.1
1
mV
HORIZONTAL

TEXTBOX
120
1014
342
1044
Level of Inputactivation
20
105.0
1

TEXTBOX
1822
175
1958
229
Wavedirection
20
105.0
1

SLIDER
2033
1222
2221
1255
slope_influence
slope_influence
0
1
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1623
346
1715
379
ul
ul
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
168
166
260
199
axcor
axcor
-50
200
0.0
1
1
NIL
HORIZONTAL

SLIDER
260
166
352
199
aycor
aycor
-50
200
0.0
1
1
NIL
HORIZONTAL

SLIDER
169
198
261
231
bxcor
bxcor
-50
200
100.0
1
1
NIL
HORIZONTAL

SLIDER
260
198
352
231
bycor
bycor
-20
200
120.0
1
1
NIL
HORIZONTAL

SLIDER
169
231
261
264
cxcor
cxcor
-50
200
120.0
1
1
NIL
HORIZONTAL

SLIDER
261
230
353
263
cycor
cycor
-50
200
100.0
1
1
NIL
HORIZONTAL

SLIDER
169
263
261
296
dxcor
dxcor
-50
200
-9.0
1
1
NIL
HORIZONTAL

SLIDER
261
263
353
296
dycor
dycor
-50
200
115.0
1
1
NIL
HORIZONTAL

SLIDER
169
296
261
329
excor
excor
-50
200
22.0
1
1
NIL
HORIZONTAL

SLIDER
261
296
353
329
eycor
eycor
-50
200
94.0
1
1
NIL
HORIZONTAL

SLIDER
170
327
262
360
fxcor
fxcor
-50
200
105.0
1
1
NIL
HORIZONTAL

SLIDER
262
327
354
360
fycor
fycor
-50
200
77.0
1
1
NIL
HORIZONTAL

SLIDER
170
360
262
393
gxcor
gxcor
-50
200
93.0
1
1
NIL
HORIZONTAL

SLIDER
261
359
353
392
gycor
gycor
-50
200
13.0
1
1
NIL
HORIZONTAL

SLIDER
170
393
262
426
hxcor
hxcor
-50
200
97.0
1
1
NIL
HORIZONTAL

SLIDER
261
393
353
426
hycor
hycor
-50
200
56.0
1
1
NIL
HORIZONTAL

SLIDER
170
427
262
460
ixcor
ixcor
-50
200
70.0
1
1
NIL
HORIZONTAL

SLIDER
260
427
352
460
iycor
iycor
-50
100
-19.0
1
1
NIL
HORIZONTAL

SLIDER
170
459
262
492
jxcor
jxcor
-50
200
94.0
1
1
NIL
HORIZONTAL

SLIDER
261
459
353
492
jycor
jycor
-50
200
81.0
1
1
NIL
HORIZONTAL

SLIDER
174
864
266
897
ersxcor
ersxcor
-50
200
50.0
1
1
NIL
HORIZONTAL

SLIDER
264
865
356
898
ersycor
ersycor
-50
200
50.0
1
1
NIL
HORIZONTAL

SLIDER
6
492
115
525
signal11
signal11
0
1000
80.0
0.01
1
hz
HORIZONTAL

BUTTON
115
493
170
526
NIL
input11
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
170
491
262
524
kxcor
kxcor
-50
200
22.0
1
1
NIL
HORIZONTAL

SLIDER
260
491
352
524
kycor
kycor
-50
200
-14.0
1
1
NIL
HORIZONTAL

SLIDER
1968
532
2241
565
marginextradamping
marginextradamping
0
2
2.0
0.01
1
NIL
HORIZONTAL

SLIDER
1466
531
1716
564
neighbourintegration1
neighbourintegration1
-10
100
1.0
0.0000000001
1
NIL
HORIZONTAL

SLIDER
1468
569
1717
602
neighbourintegration2
neighbourintegration2
-10
100
0.0
0.0000000001
1
NIL
HORIZONTAL

SLIDER
1801
1105
1991
1138
spontaneousact
spontaneousact
0
100000
100.0
0.1
1
mV
HORIZONTAL

PLOT
4
1897
1513
2130
EEG Signal2
msec
microVolt
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"EEGplot2" 1.0 0 -16777216 true "" ""

SLIDER
1514
1484
1686
1517
tresholdheight
tresholdheight
0
10
0.5
0.1
1
NIL
HORIZONTAL

SLIDER
1468
607
1717
640
neighbourintegration3
neighbourintegration3
-10
100
0.0
0.0000000001
1
NIL
HORIZONTAL

SLIDER
1808
346
1900
379
ur
ur
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1623
315
1715
348
l
l
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1623
282
1715
315
ol
ol
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1809
282
1901
315
ro
ro
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1715
346
1807
379
u
u
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1715
282
1807
315
o
o
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1716
380
1808
413
uu
uu
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1808
380
1900
413
uur
uur
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1623
379
1715
412
uul
uul
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1715
249
1807
282
oo
oo
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1809
249
1901
282
oor
oor
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1622
250
1714
283
ool
ool
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1531
314
1623
347
ll
ll
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1531
346
1623
379
ull
ull
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1531
282
1623
315
oll
oll
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1903
314
1995
347
rr
rr
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1900
346
1995
379
urr
urr
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1903
282
1995
315
orr
orr
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1439
314
1531
347
lll
lll
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1531
378
1623
411
uull
uull
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1532
250
1624
283
ooll
ooll
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1995
317
2090
350
rrr
rrr
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1900
380
1995
413
uurr
uurr
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1903
249
1995
282
oorr
oorr
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1716
412
1808
445
uuu
uuu
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1715
215
1807
248
ooo
ooo
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1808
315
1900
348
r
r
0
2
1.0
0.01
1
NIL
HORIZONTAL

TEXTBOX
1559
1523
1667
1541
height of peaks
12
105.0
1

SLIDER
1688
1376
1860
1409
windowsizeEEG
windowsizeEEG
0
100
8.0
1
1
NIL
HORIZONTAL

SLIDER
1691
1436
1863
1469
tresholdwidtheeg
tresholdwidtheeg
0
20
2.4
0.1
1
NIL
HORIZONTAL

SLIDER
1693
1484
1865
1517
tresholdheighteeg
tresholdheighteeg
0
10
0.3
0.1
1
NIL
HORIZONTAL

TEXTBOX
1593
776
1819
802
Alzheimer's Disease
20
105.0
1

SLIDER
6
325
117
358
signal6
signal6
0
1000
300.0
0.01
1
hz
HORIZONTAL

TEXTBOX
1570
1343
1825
1370
Running average & Peaks
20
105.0
1

SLIDER
352
166
497
199
asignalstrength
asignalstrength
-100
200
89.0
1
1
%
HORIZONTAL

TEXTBOX
1650
1182
2020
1207
Output panal for varying use (e.g. output of primenumberdistribution of signal or istructions).
11
105.0
1

SLIDER
353
198
497
231
bsignalstrength
bsignalstrength
-100
200
100.0
1
1
%
HORIZONTAL

SLIDER
354
231
497
264
csignalstrength
csignalstrength
-100
200
100.0
1
1
%
HORIZONTAL

SLIDER
353
264
497
297
dsignalstrength
dsignalstrength
-100
200
100.0
1
1
%
HORIZONTAL

SLIDER
354
296
497
329
esignalstrength
esignalstrength
-100
1000
100.0
1
1
%
HORIZONTAL

SLIDER
354
328
498
361
fsignalstrength
fsignalstrength
-200
200
100.0
1
1
%
HORIZONTAL

SLIDER
353
358
497
391
gsignalstrength
gsignalstrength
-100
200
100.0
1
1
%
HORIZONTAL

SLIDER
354
390
497
423
hsignalstrength
hsignalstrength
-100
200
100.0
1
1
%
HORIZONTAL

SLIDER
352
424
498
457
isignalstrength
isignalstrength
-100
200
100.0
1
1
%
HORIZONTAL

SLIDER
352
459
498
492
jsignalstrength
jsignalstrength
-100
200
100.0
1
1
%
HORIZONTAL

SLIDER
352
492
499
525
ksignalstrength
ksignalstrength
-100
200
100.0
1
1
%
HORIZONTAL

SLIDER
352
946
500
979
firesignalstrength
firesignalstrength
-100
2000
100.0
1
1
%
HORIZONTAL

SWITCH
1359
110
1504
143
showEEGelectrode
showEEGelectrode
1
1
-1000

TEXTBOX
1633
1626
1783
1651
Output panel
20
105.0
1

BUTTON
4
945
110
978
NIL
generate-k-complex
T
1
T
OBSERVER
NIL
K
NIL
NIL
1

SWITCH
1358
41
1504
74
showLabels
showLabels
0
1
-1000

SLIDER
1505
40
1677
73
margin_size
margin_size
0
100
0.0
1
1
NIL
HORIZONTAL

SLIDER
1358
145
1505
178
eegX
eegX
-50
150
-2.0
1
1
NIL
HORIZONTAL

SLIDER
1506
145
1678
178
eegY
eegY
-50
150
-2.0
1
1
NIL
HORIZONTAL

SLIDER
1357
179
1506
212
radiusEEG
radiusEEG
0
100
4.0
1
1
NIL
HORIZONTAL

TEXTBOX
540
75
1227
131
The model represents an active brain area of 60 mm in diameter. There are 14400 simulated neuronal columns whereas additonal columns are hided by the margin. Each neuronal column has a diameter of 0.5 mm. The conncetivity of each column is defined by maximum 28 neighbours to exchange information with.
11
0.0
1

SLIDER
1469
642
1718
675
neighbourintegration4
neighbourintegration4
-10
100
0.0
0.0000000001
1
NIL
HORIZONTAL

SLIDER
1470
677
1718
710
neighbourintegration5
neighbourintegration5
-10
100
0.0
0.0000000001
1
NIL
HORIZONTAL

SLIDER
1687
1291
1859
1324
auspendeln
auspendeln
0
10000
0.0
100
1
NIL
HORIZONTAL

SLIDER
22
1078
219
1111
input_neighbour_activation
input_neighbour_activation
-100
100
0.0
1
1
%
HORIZONTAL

SLIDER
220
1078
418
1111
input_neighbour_activation2
input_neighbour_activation2
-100
100
0.0
1
1
%
HORIZONTAL

SWITCH
1520
2117
1730
2150
showActiveInhibitories
showActiveInhibitories
1
1
-1000

SLIDER
1730
2119
1939
2152
deactlevel2
deactlevel2
0
100
100.0
1
1
%
HORIZONTAL

SLIDER
1731
2154
1939
2187
influence_own_activation2
influence_own_activation2
0
100
0.0
1
1
%
HORIZONTAL

SLIDER
1729
1983
1938
2016
deactlevel0
deactlevel0
0
100
100.0
1
1
%
HORIZONTAL

SLIDER
1520
2085
1730
2118
minimumregulation
minimumregulation
-1
1
1.0
2
1
NIL
HORIZONTAL

CHOOSER
1543
2152
1684
2197
deactivation_type
deactivation_type
"ratio_activation" "minus_activation" "ratio_slope"
2

SLIDER
1686
1257
1858
1290
einpendeln
einpendeln
0
1000
1.0
100
1
NIL
HORIZONTAL

SLIDER
1729
2017
1938
2050
influence_own_activation0
influence_own_activation0
0
100
0.0
0.1
1
%
HORIZONTAL

SLIDER
1471
709
1717
742
neighbourintegration6
neighbourintegration6
-10
100
0.0
0.0000000001
1
NIL
HORIZONTAL

MONITOR
1513
1157
1570
1202
NIL
ticks
17
1
11

SLIDER
21
1112
218
1145
carrier_neighbour1
carrier_neighbour1
-100
100
0.0
1
1
%
HORIZONTAL

SLIDER
220
1112
419
1145
carrier_neighbour2
carrier_neighbour2
-100
100
0.0
1
1
%
HORIZONTAL

SLIDER
7
525
114
558
signal12
signal12
0
1000
230.0
0.01
1
hz
HORIZONTAL

BUTTON
114
525
171
558
NIL
input12
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
170
524
262
557
lxcor
lxcor
-50
200
28.0
1
1
NIL
HORIZONTAL

SLIDER
261
524
353
557
lycor
lycor
-50
200
41.0
1
1
NIL
HORIZONTAL

SLIDER
352
524
499
557
lsignalstrength
lsignalstrength
-100
200
100.0
1
1
%
HORIZONTAL

SLIDER
359
866
499
899
casignalstrength
casignalstrength
-100
1000
100.0
1
1
%
HORIZONTAL

SLIDER
1728
2084
1941
2117
influence_own_activation1
influence_own_activation1
0
100
0.0
1
1
%
HORIZONTAL

PLOT
20
2471
1535
2715
Sum Energy
msec
milliVolt
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"SumEnergyPlot" 1.0 0 -16777216 true "" ""

PLOT
1595
2865
3513
3016
SumActivation0
msec
milliVolt
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"SumActivation0Plot" 1.0 0 -16777216 true "" ""

SWITCH
1688
43
1855
76
color_activation_all
color_activation_all
1
1
-1000

SLIDER
1688
80
1856
113
range_upper
range_upper
-10000
100000
5.0
0.1
1
NIL
HORIZONTAL

SLIDER
1689
116
1856
149
range_lower
range_lower
-100
10000000
-1.0
0.001
1
NIL
HORIZONTAL

SWITCH
1588
1104
1801
1137
generate-spontaneousactivity-on
generate-spontaneousactivity-on
0
1
-1000

BUTTON
4
980
109
1013
stimuli_prime
stimuli_prime
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
1228
939
1285
984
ticks
ticks
17
1
11

PLOT
20
3006
1537
3338
Slope All
msce
milliVolt
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"SlopePlotOfAll" 1.0 0 -16777216 true "" ""

PLOT
15
2721
1537
3008
Sum Slope All
msec
milliVolt
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"SumSlopeAll" 1.0 0 -16777216 true "" ""

TEXTBOX
1914
423
2154
465
40 Neighbours, corresponds to neighbourintegration0 to neighbourintegration9
11
0.0
1

SLIDER
1806
215
1898
248
ooor
ooor
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1622
216
1714
249
oool
oool
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1714
181
1806
214
oooo
oooo
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1808
413
1900
446
uuur
uuur
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1625
412
1717
445
uuul
uuul
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1717
445
1809
478
uuuu
uuuu
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1439
281
1531
314
olll
olll
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1438
347
1532
380
ulll
ulll
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1996
283
2090
316
orrr
orrr
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1995
349
2090
382
ulll
ulll
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1347
315
1440
348
llll
llll
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
2090
317
2183
350
rrrr
rrrr
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1717
497
1966
530
neighbourintegration7
neighbourintegration7
-10
100
0.0
0.0000000001
1
NIL
HORIZONTAL

SLIDER
1718
531
1966
564
neighbourintegration8
neighbourintegration8
-10
100
0.0
0.0000000001
1
NIL
HORIZONTAL

SLIDER
1720
567
1966
600
neighbourintegration9
neighbourintegration9
-10
100
0.0
0.0000000001
1
NIL
HORIZONTAL

SLIDER
1720
606
1967
639
neighbourintegration10
neighbourintegration10
-10
100
0.0
0.0000000001
1
NIL
HORIZONTAL

SLIDER
1721
642
1967
675
neighbourintegration11
neighbourintegration11
-10
100
0.0
0.0000000001
1
NIL
HORIZONTAL

SLIDER
1722
676
1967
709
neighbourintegration12
neighbourintegration12
-10
100
0.0
0.0000000001
1
NIL
HORIZONTAL

SLIDER
1722
709
1967
742
neighbourintegration13
neighbourintegration13
-10
100
0.0
0.0000000001
1
NIL
HORIZONTAL

SLIDER
1722
744
1968
777
neighbourintegration14
neighbourintegration14
-10
100
0.0
0.0000000001
1
NIL
HORIZONTAL

SWITCH
111
980
278
1013
carrier_for_all_input
carrier_for_all_input
0
1
-1000

SLIDER
1727
946
1962
979
uncorrelated2
uncorrelated2
0
100
0.0
0.00001
1
%
HORIZONTAL

SLIDER
1489
980
1725
1013
ratio_transmitted_energy
ratio_transmitted_energy
0
2
1.0
0.001
1
ratio
HORIZONTAL

SLIDER
1970
708
2244
741
ratio_neighbour_activation
ratio_neighbour_activation
-10
10
1.0
0.00001
1
NIL
HORIZONTAL

SLIDER
1970
743
2245
776
ratio_inhibition_activation1
ratio_inhibition_activation1
-10
10
1.0
0.00001
1
NIL
HORIZONTAL

SWITCH
2035
1187
2219
1220
sigmoid
sigmoid
1
1
-1000

BUTTON
416
122
517
155
NIL
initalize-ising
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
363
92
513
117
Ising Input
20
105.0
0

BUTTON
276
981
354
1014
input_all
input_all
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
1970
639
2242
672
slopeo_damping
slopeo_damping
-2
10
1.0
0.00000001
1
(mV/1+damp)
HORIZONTAL

SLIDER
1968
568
2241
601
slopev_damping
slopev_damping
-2
10
0.0
0.00001
1
(mv/1+damp)
HORIZONTAL

PLOT
29
3394
229
3544
EEG Signal3
msec
microVolt
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"EEGplot3" 1.0 0 -16777216 true "" ""

PLOT
231
3394
1485
3544
EEG Signal4
msec
microVolt
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"EEGplot4" 1.0 0 -16777216 true "" ""

PLOT
24
3567
1772
3687
EEG Signal5
msec
microVolt
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"EEGplot5" 1.0 0 -16777216 true "" ""

PLOT
5
2131
1515
2367
EEG Signal6
msec
microVolt
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"EEGplot6" 1.0 0 -16777216 true "" ""

SLIDER
1727
980
1962
1013
uncorrelated3_slopev
uncorrelated3_slopev
0
100
12.5
0.00001
1
%
HORIZONTAL

SLIDER
5
560
114
593
signal13
signal13
0
1000
130.0
0.01
1
hz
HORIZONTAL

BUTTON
117
560
172
593
NIL
input13
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
171
558
263
591
mxcor
mxcor
-50
200
16.0
1
1
NIL
HORIZONTAL

SLIDER
264
558
356
591
mycor
mycor
-50
200
54.0
1
1
NIL
HORIZONTAL

SLIDER
353
558
498
591
msignalstrength
msignalstrength
-100
200
100.0
1
1
%
HORIZONTAL

SLIDER
4
593
112
626
signal14
signal14
-50
1000
280.0
0.01
1
hz
HORIZONTAL

BUTTON
115
594
173
627
NIL
input14
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
172
594
264
627
nxcor
nxcor
-50
200
5.0
1
1
NIL
HORIZONTAL

SLIDER
264
594
356
627
nycor
nycor
-50
200
34.0
1
1
NIL
HORIZONTAL

SLIDER
356
595
498
628
nsignalstrength
nsignalstrength
-100
200
100.0
1
1
%
HORIZONTAL

SLIDER
3
627
112
660
signal15
signal15
0
1000
10.0
0.01
1
hz
HORIZONTAL

BUTTON
114
629
172
662
NIL
input15
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
173
628
265
661
oxcor
oxcor
-50
200
14.0
1
1
NIL
HORIZONTAL

SLIDER
264
627
356
660
oycor
oycor
-50
200
-5.0
1
1
NIL
HORIZONTAL

SLIDER
357
627
498
660
osignalstrength
osignalstrength
-100
1000
100.0
1
1
%
HORIZONTAL

SLIDER
4
661
111
694
signal16
signal16
0
1000
20.0
0.01
1
hz
HORIZONTAL

BUTTON
113
662
171
695
NIL
input16
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
173
662
265
695
qxcor
qxcor
-50
200
-24.0
1
1
NIL
HORIZONTAL

SLIDER
265
661
357
694
qycor
qycor
-50
200
51.0
1
1
NIL
HORIZONTAL

SLIDER
358
661
498
694
qsignalstrength
qsignalstrength
-100
200
100.0
1
1
%
HORIZONTAL

SLIDER
1
694
110
727
signal17
signal17
0
1000
30.0
1
1
hz
HORIZONTAL

BUTTON
111
695
172
728
NIL
input17
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
174
696
266
729
rxcor
rxcor
-50
200
2.0
1
1
NIL
HORIZONTAL

SLIDER
265
695
357
728
rycor
rycor
-50
200
44.0
1
1
NIL
HORIZONTAL

SLIDER
357
695
498
728
rsignalstrength
rsignalstrength
-100
200
100.0
1
1
%
HORIZONTAL

SLIDER
2
727
111
760
signal18
signal18
0
1000
40.0
1
1
hz
HORIZONTAL

BUTTON
108
727
174
760
NIL
input18
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
174
729
266
762
sxcor
sxcor
-50
200
-21.0
1
1
NIL
HORIZONTAL

SLIDER
265
729
357
762
sycor
sycor
-50
200
12.0
1
1
NIL
HORIZONTAL

SLIDER
357
729
498
762
ssignalstrength
ssignalstrength
-100
200
100.0
1
1
%
HORIZONTAL

SLIDER
1
760
109
793
signal19
signal19
0
1000
90.0
1
1
hz
HORIZONTAL

BUTTON
109
760
172
793
NIL
input19
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
175
760
267
793
txcor
txcor
-50
200
-11.0
1
1
NIL
HORIZONTAL

SLIDER
265
760
357
793
tycor
tycor
-50
200
-10.0
1
1
NIL
HORIZONTAL

SLIDER
357
761
498
794
tsignalstrength
tsignalstrength
-100
200
100.0
1
1
%
HORIZONTAL

SLIDER
2
793
109
826
signal20
signal20
0
1000
420.0
1
1
hz
HORIZONTAL

BUTTON
110
794
172
827
NIL
input20
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
176
793
268
826
uxcor
uxcor
0
100
1.0
1
1
NIL
HORIZONTAL

SLIDER
265
793
357
826
uycor
uycor
0
100
1.0
1
1
NIL
HORIZONTAL

SLIDER
358
793
498
826
usignalstrength
usignalstrength
-100
200
100.0
1
1
%
HORIZONTAL

SLIDER
2
828
108
861
signal21
signal21
0
1000
450.0
1
1
hz
HORIZONTAL

BUTTON
110
829
173
862
NIL
input21
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
175
829
267
862
vxcor
vxcor
-50
200
41.0
1
1
NIL
HORIZONTAL

SLIDER
267
828
359
861
vycor
vycor
-50
200
28.0
1
1
NIL
HORIZONTAL

SLIDER
358
828
498
861
vsignalstrength
vsignalstrength
-100
200
100.0
1
1
%
HORIZONTAL

BUTTON
109
904
176
937
NIL
Carrier2
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
0
904
113
937
carriersignal2
carriersignal2
0
10000
20.0
1
1
hz
HORIZONTAL

SLIDER
174
902
266
935
ersxcor2
ersxcor2
-50
200
50.0
1
1
NIL
HORIZONTAL

SLIDER
264
903
356
936
ersycor2
ersycor2
-50
200
50.0
1
1
NIL
HORIZONTAL

SLIDER
359
903
498
936
casignalstrength2
casignalstrength2
-100
1000
200.0
1
1
%
HORIZONTAL

SWITCH
271
121
414
154
generate-ising-on
generate-ising-on
1
1
-1000

SLIDER
1970
605
2243
638
NI_slopev
NI_slopev
-10
10
3.8
0.00001
1
NIL
HORIZONTAL

SLIDER
1970
673
2243
706
NI_slopeo
NI_slopeo
-10
10
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
648
123
882
156
temperature
temperature
0
100
2.3
1
1
NIL
HORIZONTAL

SWITCH
518
123
645
156
sigmoid_ising
sigmoid_ising
1
1
-1000

SWITCH
498
165
622
198
BURSTS_ON
BURSTS_ON
0
1
-1000

SWITCH
355
981
501
1014
sine
sine
0
1
-1000

SWITCH
353
1015
500
1048
sine_carrier
sine_carrier
0
1
-1000

TEXTBOX
2013
467
2196
496
Inhibitory Neurons
20
105.0
1

TEXTBOX
2044
1148
2194
1173
testing functions
20
105.0
1

SLIDER
1726
1014
1962
1047
uncorrelated4_slopeo
uncorrelated4_slopeo
0
100
99.0
0.00001
1
%
HORIZONTAL

SLIDER
1963
948
2234
981
uncorrelated3_slopevdamping
uncorrelated3_slopevdamping
0
100
0.0
0.00001
1
%
HORIZONTAL

SLIDER
1965
1012
2234
1045
uncorrelated5_damping
uncorrelated5_damping
0
100
0.0
0.00001
1
%
HORIZONTAL

SLIDER
1963
980
2234
1013
uncorrelated4_slopeodamping
uncorrelated4_slopeodamping
0
100
0.0
0.00001
1
%
HORIZONTAL

PLOT
1591
2254
3505
2404
SlopeVector
msec
milliVolt
0.0
1.0
0.0
1.0
true
false
"" ""
PENS
"SlopeVectorPlot" 1.0 0 -16777216 true "" ""

PLOT
1595
2414
3506
2564
SlopeOld
msec
milliVolt
0.0
1.0
0.0
1.0
true
false
"" ""
PENS
"SlopeOldPlot" 1.0 0 -16777216 true "" ""

PLOT
1595
2563
3512
2713
Activation0
msec
milliVolt
0.0
1.0
0.0
1.0
true
false
"" ""
PENS
"Activation0Plot" 1.0 0 -16777216 true "" ""

PLOT
1595
2714
3511
2864
Activation1
msec
milliVolt
0.0
1.0
0.0
1.0
true
false
"" ""
PENS
"Activation1Plot" 1.0 0 -16777216 true "" ""

SLIDER
1963
913
2235
946
uncorrelated1
uncorrelated1
0
100
99.0
0.00001
1
%
HORIZONTAL

SLIDER
2233
944
2405
977
uncorrelated_input
uncorrelated_input
0
100
99.0
0.00001
1
%
HORIZONTAL

SLIDER
1971
776
2247
809
NI_slopeo1
NI_slopeo1
-10
10
1.0
0.001
1
NIL
HORIZONTAL

SLIDER
1971
810
2247
843
NI_act1
NI_act1
-10
10
1.0
0.001
1
NIL
HORIZONTAL

BUTTON
578
422
649
455
e-input
e-input
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

@#$#@#$#@
Version 26.1
 - Die Wellenberechnung geschieht nicht nur über die 4 direkten Nachbarn, sondern auch über die Ecken, also 8

Version 27.1.
- Empfindlichkeit und Schwellenwert für Outputs eingerichtet.
- Weiterer Testoutput hinzugefügt

Version 28.1.
- Kommentar erweitert

Version 08.02.
- Output in der Mitte begonnen
- Codeoptimierungen
- Farbe wählbar
- Auch in Outputs werden unterschiedliche Erregungszustände angezeigt

Version 09.02.
- Outputs hinzugefügt und getestet

Version 10.02.
- Outputs weiter getestet
- Farbeinstellung abgesichert

Version 11.02.
- Reflexionswegrechnung angefangen

Version 03.03.
- Reflexionsberechnung mithilfe von "unsichtbarem" Rand realisiert und ein Bisschen optimiert (rand 20 und Randdämpfung 0,1 liefern gute Ergebnisse) Leider verlangsamt das Ganze die Berechnung

Version 26.05.
- Signalverlauf kann an abgelesen werden

Version 23.06.
- Signal wird als Summation an den Rändern abgegriffen (vergleichbar mit EEG)
- Basisaktivierung ist an- und abschaltbar

Version 24.06.
- "inhibitorische Neuron" integriert, machen allerdings Probleme, wenn sich das Signal aufschaukelt

Version 28.06.2010
- kleinere Korrekturen am Modell
- Simulation2: Einfache Korrektur von Signalspitzen => komischeres Wellenbild und löst das Problem auch nicht, sondern verzögert es nur

Version 29.06.2010
- Weitere einfache Korrektur der Spitzen

Version 30.06.2010
- Outputagenten können nicht gleichzeitig inhibitorisch sein
- Anteil "inhibitorischer Neurone" einstellbar  .--> 10.07.2012: denke das waren keine inhibitorischen Neurone sondern defects. Tote Zellen die nicht kommunizieren
- Codeoptimierungen
- Entfernen zweier alter Outputzellen
- Korrektur der Signalspitzen wieder auskommentiert

Version 06.07.2010
- Inhibitorische Neurone per Schalter wahlweise regelmaessig angeordnet  --> 10.07.2012: Not inhibitory: Defects. Dead Cells. Inhibitory cells would deactivate other cells.

Version 07.07.2010
- Inputneurone am Anfang definiert
- Inhibitorische Neurone brauchen mindestens ein Neuron Abstand von Inputneuronen

Version 28.07.2010
- Farbeffekt der Amplitude mit Faktor (aktuell 5) versehen
- Mangelnde Korrelation implementiert

Version 25.08.2010
- Überspringen von Zellen implementiert und leicht im Code änderbar

Version 30.08.2010
- Herausrechnen des Alpha-Signals implementiert

Version 02.09.2010
- Begonnen, auf Englisch zu übersetzen

Version 03.09.2010
- Interface und Procedures sind auf Englisch übersetzt
- Bugs bei der Darstellung der Outputs gefixt

Version 22.05.2012
-Implemented clustering
-very slow processing yet: to be fixed

Version 29.05.2012
-Implemented running average

Version 12.06.2012
-Peakfinder is working
-there is a prime number distribution
-Clustering has some problems
-Frequency is calculated by sth like a fourier analysis
-Output is saved as .csv and frequency is measured in Matlab (FFT)
-Coulorcoding is still not reliable
-Amplitude of activation varies greatly ( from 2000 to 1200000 )
--> maybe refraktärzeit and limit of activation. possibly a more freqeuncy related genaration of wave pattern
-Input feuert nicht staendig
-

Version 20.06.2012
-Frequency output is analysed in matlab via fft

Version 09.07.2012
-Clustering algorithm works appropriatly(growing is faster than shrinking)
-Analysis in Matlab works
-Model is now changed to a MEA and an EEG, both outputs are visualized and generated
-there is furthermore a Moving average that can easily be implemented for each EEG and MEA signal and a peakidentifier
-Inputs must be fixed that they work properly
-Basic algorithm need to be fixed (all-or-nothig signaling, treshold and maximum activation
-Alzehiemer's Desease and Schizophrenia can be simulated
-the simualtion can be compared with MEA data of visual cortx, somatosensory coretx and left lateral prefrontal coretx
- commentaries are not completed
- patches are colored in dependence of their activity; a slider in the interface make the coloring of patches variable

Version 10.07.2012
-found bugs of input: when you do input forever without ticks, it is potentiating its activation until you start the tickcounter bzw. the simulation. Need to fix this.
- problem of the input fixed by just initializing the the tick with the value 1. The modulo operation had been the problem. Division through zero.



Version 17.09.2013
-running average everywhere
-plot xy dynamic
-coloring activation feuerfarben
-mea richtig
-kommentare
-schizophrenia
-anordnung der einzelnen procedures
-octave output bearbeiten ´vor allem avalanche analysis
-running average näher beschreiben


Version 04.02.2014
-labeling implementier
-k-complex implementiert
-das ganze programm naeher an objekten orientieren, d.h. mehr procedures und variablen übergaben und globale variablen reduzieren

Version 20.07.2016
-sum of patches implemented
-energy slider with maximum and mimimum and positiv and negativ adjustments

Version 08.08.2016
-slope of patch

Version 23.08.2016
-adjust spontaneous activity


Version 27.02.2017
-slope of all implemented
- sum slope of all implmented
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
setup-random
repeat 67 [ go ]
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
