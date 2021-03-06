ADJTIMEX 

� ���� �������, ��� �� ��� ��������� ��������� man �� adjtimex :-)


��������

��������, �� ��� ������, ��� � ����� ���������� ������� ���� ����� -
"���� ��������� �������" (RTC - Real Time Clock), ������� ���� ��� �����,
� ��������� ����, ������� ���� ������ ��� ���������� ����������. ��������
���� � ��������� ����� (�������� 1 u���), �� � RTC, ��������, ����� 
������������ �� ���������� ���������� (long-term stability). adjtimex
������������ ��� ��������������� ��������� ����� ��������� �����.

RTC �������� �������� �������� ������


	adjtimex --compare

���������� �����, ������� ����� ����� ������, ������ �������� (��� ������
������ ��� ������� ��������� ���� �� ��������� � ��������� ������� � RTC),
� ��� ��������� ��������� ����: tick � ����� �������. ����� ������ ���� 
��������� �� ����� ������� ������������� �������� ����� � ������ �������, 
������� ������������� ��������� ���� � ��������������� ��������� RTC. 
�������, RTC ����� ����� ����������� ��������������� ������. clock(8) ��� 
hwclock(8) ���������� ���� /etc/adjtime ��� ������ ������������ ����� 
(drift rate) � ������� ����� ��������� ��������� RTC. adjtimex ����� 
��������� � ���� ������ � ���������� ��������� �� ������� RTC.

����� ����, adjtimex ����� ���������� ����� ����� ����� � ��������������
������� (reference) �����, � ���. ����� ��� ������������ � ���������� 
�������� � �������������� �������� ����� (drift rates).


���������

��� ���������������� �������� "./configure", ��� ���������� - "make",
����� "make install" ��� ����������� ��������� � /usr/local/bin, �
�������� man � /usr/local/man/man8. ���� �� ������ ���������� ���������
� /usr ������ /usr/local, ������� � "./configure --prefix=/usr".


����� ����

��� ���������� ����������� ������������� �������� �� ������ ����� ��� root.

����������� ���� �� ����� ������� RTC, ���� �� ����� ��������������� ���� 
�� ��������� ���������� (��������, � ������� adjtimex). �����, �����������, 
��� ntpd ���������� ��������� �����, ��������� "���������" RTC ��������
������ ����������� �����. adjtimex ������������� ��� ���������� ������� 
����� ��������� ������ ���������. � ���������������� ����� �� ���������.


�������������

�������� /etc/adjtime, ������� ������������ clock(8) � hwclock(8) ���
��������� ��������������� ������ � RTC. ���������� ���, ��� ������� �
�������� man, ��� ������ ���������. clock ���������� (������ � ����������
������ �������� ������) � ��������� ���� ����� (Rik Faith):
sunsite.unc.edu:pub/Linux/system/Misc/util-linux-1.10.tar.gz ���� ��� RTC
��� ���������� ����� ��� ���, ������ �������� ���� /etc/adjtime, ���������� 
������ ���� ������ �������: '0.0 0 0.0'.

������� � ������� ������ ���������.

������������� � ��������� adjtimex � ������ --compare.
��������� ���������� �������� �����:

	# adjtimex --compare
	794625929   -0.597638 -0.597638  ...
	794625939   -0.602050 -0.004412  ...
			      ^^^^^^^^^
��� ����� ��������, ��� ��������� ���� ������� ����� ��� �� 4 ������������
�� 10 ������ �� ��������� � RTC, ��� 4 ����� �� 10000. �������������,
�� ����������� �������� tick �� 10004 � ��������� ���������:

	# adjtimex  --tick 10004
	# adjtimex --compare
	794626037   -0.644860 -0.644860  ...
	794626047   -0.645259 -0.000399  ...

������ ��������� ���� ������� �������� �� 39.9 ������ �� �������. ��� 
��������� ����� �� ����� �������� ����� ������� (frequency offset). 
���������, ��� ����� ������� - ��� � ������ �� �������, � ������ �������
� ������ (�� 16 ��� � ������ �������). �������������, �� ������������� 
����� � 39.9*65536 = 2614886:

	# adjtimex  --frequency 2614886
	# adjtimex --compare
	794626313   -0.652147 -0.652147  ...
	794626323   -0.652247 -0.000100  ...

�����, ��� ���� ��� ������� ����� 10 ppm, ������� �� �������� ����� ��
10*65536, �� 3270246:

	# adjtimex  --frequency 3270246
	# adjtimex --compare
	794627233   -0.795221 -0.795221  ...
	794627243   -0.795231 -0.000009  ...

����� �� ������� ������������� �������� � ������� "suggested" ("�������������").
���������� ����� --adjust �������������� ������� - ������������ ������������
"�������������" ��������.

������, ������������� ����� --offset ��� --singleshot ������� �����
���������� �������� �� ����. � ���������� ��� ���������� �������� tick � 
������� �� ���������� ������ �����.

� ��� ��� ����� ���� ������, �������� ����, � /etc/rc.d/rc.S, /etc/init.d/boot 
��� ����� �� ������ ��������� ������:

	# Adjust CMOS clock based on /etc/adjtime, then set system clock.
	# Add -u switch if your system keeps GMT.
	if [ -x /sbin/clock ]; then
	  /sbin/clock -a
	fi

������ �������� ������ ���� ����:

	# Regulate the sytem clock
	if [ -x /sbin/adjtimex ]; then
	  /sbin/adjtimex  --tick 10004  --frequency 3270246 
	fi


��������������� ���������

adjtimex ����� ������������ ��� ������ �������� ������� CMOS � �������,
� ��������������� �������� (reference) �������, ����� ����� ���� ����������
����������� ����� �� ���������� �������. ��� ������� ����� �������� 
������� �����������

	# adjtimex  --log --watch

adjtimex �������� ��� ������ �������, ����� �� ������ �����, �����
������� ����� � ��������������� ��������. ����� ������� ��� �� ���� �����
���� ����� � ������� ��������� ������ � ����. ����� �� ������ ����� � 
������ �����, ���������� ������� ���� WWV ��� CHU � �.�.

���� � ��� ���������� ntpdate (����� ������ xntp) � ��������� ���������
� ����, �����������

	# adjtimex  --log  --host www.xxx.yyy.zzz

� adjtimex ����� ������������ ntpdate ��� ������� ������� � ����������
�����. (�������� � ������ ����������, ����� �� �� ������ ������� NTP, 
��� ����� �� ����� ����������.)

����� ����, ��� �� �������� ��������� ������� � log, �� ������ ���������
adjtimex ����������� ��� � �������

	# adjtimex  --review

�� ������� ������ ���� ������� ���� � ����� � �������� ��� ��� �����������
������ � ������ �� ������� (ppm) � �������� ���������. ����� ����� �������
����������� ������ � ���������� �������� ���������� ��� ������������� �����. 
��������� ��������������� ����������. ���� ������������ ������ �������� 
������� ����� �������� ��� ����������.


���������� ����������

������������ ������������ �� ��������� ������� ���� �������� �����,
��� �������� David L. Mills <mills@udel.edu>:

[MIL92a] Mills, D.L. Network Time Protocol (Version 3) specification,
implementation and analysis, RFC 1305, University of Delaware, March
1992, 113 pp.

[MIL92c] Mills, D.L. Simple Network Time Protocol (SNTP), RFC 1361,
University of Delaware, August 1992, 10 pp.

[MIL94a] Mills, D.L. A kernel model for precision timekeeping. ARPA
Network Working Group Report RFC-1589, University of Delaware, March
1994. 31 pp.

README.kern, ������� ����� ����� �� louie.udel.edu:/pub/ntp/kernel.tar.Z.


�������������

������ ������ (David Mills) �� ��� ���������� ������� ����, � �������
���� (Steven Dick) <ssd@nevets.oau.org> �� �������������� ��������� 
adjtimex. (� ������ ������� ���. ����� �������� - ��� ���������������.)
������������� ����� ������� ������� (Michael Meskes) <meskes@debian.org>, 
��� ��������������� ������ � Debian ��������� �� ����� "--compare" �
"--adjust".


�������������!
                - Jim Van Zandt <jrv at comcast.net>

