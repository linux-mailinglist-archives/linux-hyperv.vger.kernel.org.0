Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D371D71D2
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2020 09:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgERHaF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 18 May 2020 03:30:05 -0400
Received: from sonic308-19.consmr.mail.sg3.yahoo.com ([106.10.241.209]:41043
        "EHLO sonic308-19.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727005AbgERHaF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 18 May 2020 03:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589786998; bh=NGAU5HN+QzqbCODlsUjhK9llmEEZTtvL7P1AndJ9Rw8=; h=Date:From:Reply-To:Subject:References:From:Subject; b=bvFeBvry/0HGQalWp+kjmN75EA/8sK87eAQKm6LaoPAOBueqdfE5DAv9TAiPhdtFfe8Qv6mSajJyIYNzXGSctdZky89RMFraUqflSQgyucsSVk7FBA62vGyLKAALOPSUb7lwjXBOMWjZWhbrJy0B+/5fkWYA1ZP1FXl0C0pQ4hWGwNu60UVZyHsETCixQXrsMpnpMY6HYjyxhzE+6FCtRpMMPUZbZ2zb7rDGfJ1cQokOpLbLtWlC8SGngZjxs4hj6fRM7BDHg/RXv1JxNewSirYOmzd37tOvjSbEd2zmuzt9cLQCdH2fRktwkp/wFqskjGvNrakMZxptToKJuOhf/Q==
X-YMail-OSG: _dB55MIVM1lwuEBGWlTwO_x31OAOW8hlSnxPzk.vP_ItXUaOo9Q5l5R0vU.b.uB
 QPcwV7.ZVuFW7gxytDLlIw0yhTiBjfY5WRi.YZ.kAJfrlIw6TItyavokMY3mMvar_wQMJdc1rlqi
 nTEEC.Mre1sqKv9ZQ0jApltAjaSDvzb4nuXVOlBdMjPLpM6X3eHdhk_CCUpjlZbn9UWwQp_nFrOP
 QPrli4FnOxv79Mn4dlB3x1BkVGVLKa9qCC2zQsyT.1M3d3A97Ktlo2eqNUdEOImtUJAcv0MIs6ob
 AmqgkBg6qmefxWYdJAPEUi.A5HxPm8cpAPIHaJNCxJYC.Gg3QKxQvKFQkv0CGY7zWKcpWWIdwD3E
 fZEcxPbzO01aC6KR2kiJ1N5rDFR4P6CQnjs2.bGZwWd6fbpVtXlQhbnhIjtpaHO7Y.Sm7jczsktl
 UGETTpp3LnRgpbgz0YIqDibjOYKOx0OOQA83dW23R6_5gfOGrq55VP38zMgyRJfsu6pdmQhEADeO
 QEafry_tjos60_ZxJ_mu6X0.eHmrrRmsLviw_RprzXTSK.JKxRzAVPU6Q0lnfGnX4IADp6LbL6rD
 l8mPWsilKvwfuwbs8nJS.hY.XDO3tCqjSCLyKM0xd6mIe.9qMezPnK_0Z19nV0EnXDMYZe.wDaA1
 RluonFgduUsmHCtrVwjZWIg4NyxkXAdqblgcccGZs2mxZxmbaDQlkMRSloubfDscMWSa5RNvc88d
 Vc1X1ihKCSpxBDz9enpa5jIBgubjlB0y.3hZrLuyoSPP_apkMKOuoNCVZGSHYc.nhOcntxFl7PKB
 G.Z2fHwysMylsaWH6YHbtmKc54eU1UCwKPcxoj.krU3_as8kbhqY5QB9Dpe_adcsKUBToWDwYcDg
 .SR6I3GoDQBrN8VW5LwgUCfEHo03JUbp.xH_pv141J2oBEOFCYJiAJuHJMAxuBnsU1mgORIgHF4k
 OilZ2ZBPnIc07j2DvsNglKIxcd5N4IuRzObatyMTK1ZbIITi7.A1hNCDyujw856L6EQyChyRK_b5
 ayjmfbF1YYx3ObZEejl6OFBtxslr5BiN2QjeYh2k3wMw1vOP7vN7gnODPYYPT2ef2tS9H4OX.lxe
 tI6UbNdDUhRLyiQStglAVdMwJUX35dyrgsxBKgYY6nUVPWSk5I8sYYHpxk5kDMC.gpZKIYsCQLaM
 Lgqe9ofkZrRJRF89k2yYxc3eotgflgIA.q_SdYfV1cusThAt9mygFsP7cCeXU1GSqpW0fezz0IYX
 Fy_TuK..B1CPUy68ccSDtpc4YxFf6S0k1Ahuc4_3s_hzSaCTr8927FDQ28Cb0uv02DKUYg9s-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.sg3.yahoo.com with HTTP; Mon, 18 May 2020 07:29:58 +0000
Date:   Mon, 18 May 2020 07:29:53 +0000 (UTC)
From:   "Mr. Abdul Salam" <abdulsalam80044@gmail.com>
Reply-To: as8912509@gmail.com
Message-ID: <1996430756.580924.1589786993988@mail.yahoo.com>
Subject: With Due Respect,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1996430756.580924.1589786993988.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15960 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:76.0) Gecko/20100101 Firefox/76.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



My=C2=A0Dear=C2=A0Friend,

Before=C2=A0I=C2=A0introduce=C2=A0myself,=C2=A0I=C2=A0wish=C2=A0to=C2=A0inf=
orm=C2=A0you=C2=A0that=C2=A0this=C2=A0letter=C2=A0is=C2=A0not=C2=A0a=C2=A0h=
oax=C2=A0mail=C2=A0and=C2=A0I=C2=A0urge=C2=A0you=C2=A0to=C2=A0treat=C2=A0it=
=C2=A0serious.=C2=A0This=C2=A0letter=C2=A0must=C2=A0come=C2=A0to=C2=A0you=
=C2=A0as=C2=A0a=C2=A0big=C2=A0surprise,=C2=A0but=C2=A0I=C2=A0believe=C2=A0i=
t=C2=A0is=C2=A0only=C2=A0a=C2=A0day=C2=A0that=C2=A0people=C2=A0meet=C2=A0an=
d=C2=A0become=C2=A0great=C2=A0friends=C2=A0and=C2=A0business=C2=A0partners.=
=C2=A0Please=C2=A0I=C2=A0want=C2=A0you=C2=A0to=C2=A0read=C2=A0this=C2=A0let=
ter=C2=A0very=C2=A0carefully=C2=A0and=C2=A0I=C2=A0must=C2=A0apologize=C2=A0=
for=C2=A0barging=C2=A0this=C2=A0message=C2=A0into=C2=A0your=C2=A0mail=C2=A0=
box=C2=A0without=C2=A0any=C2=A0formal=C2=A0introduction=C2=A0due=C2=A0to=C2=
=A0the=C2=A0urgency=C2=A0and=C2=A0confidentiality=C2=A0of=C2=A0this=C2=A0bu=
siness=C2=A0and=C2=A0I=C2=A0know=C2=A0that=C2=A0this=C2=A0message=C2=A0will=
=C2=A0come=C2=A0to=C2=A0you=C2=A0as=C2=A0a=C2=A0surprise.=C2=A0Please=C2=A0=
this=C2=A0is=C2=A0not=C2=A0a=C2=A0joke=C2=A0and=C2=A0I=C2=A0will=C2=A0not=
=C2=A0like=C2=A0you=C2=A0to=C2=A0joke=C2=A0with=C2=A0it=C2=A0ok,=C2=A0with=
=C2=A0due=C2=A0respect=C2=A0to=C2=A0your=C2=A0person=C2=A0and=C2=A0much=C2=
=A0sincerity=C2=A0of=C2=A0purpose,=C2=A0I=C2=A0make=C2=A0this=C2=A0contact=
=C2=A0with=C2=A0you=C2=A0as=C2=A0I=C2=A0believe=C2=A0that=C2=A0you=C2=A0can=
=C2=A0be=C2=A0of=C2=A0great=C2=A0assistance=C2=A0to=C2=A0me.=C2=A0My=C2=A0n=
ame=C2=A0is=C2=A0Mr.=C2=A0Abdul=C2=A0Salam,=C2=A0from=C2=A0Burkina=C2=A0Fas=
o,=C2=A0West=C2=A0Africa.=C2=A0I=C2=A0work=C2=A0in=C2=A0United=C2=A0Bank=C2=
=A0for=C2=A0Africa=C2=A0(UBA)=C2=A0as=C2=A0telex=C2=A0manager,=C2=A0please=
=C2=A0see=C2=A0this=C2=A0as=C2=A0a=C2=A0confidential=C2=A0message=C2=A0and=
=C2=A0do=C2=A0not=C2=A0reveal=C2=A0it=C2=A0to=C2=A0another=C2=A0person=C2=
=A0and=C2=A0let=C2=A0me=C2=A0know=C2=A0whether=C2=A0you=C2=A0can=C2=A0be=C2=
=A0of=C2=A0assistance=C2=A0regarding=C2=A0my=C2=A0proposal=C2=A0below=C2=A0=
because=C2=A0it=C2=A0is=C2=A0top=C2=A0secret.

I=C2=A0am=C2=A0about=C2=A0to=C2=A0retire=C2=A0from=C2=A0active=C2=A0Banking=
=C2=A0service=C2=A0to=C2=A0start=C2=A0a=C2=A0new=C2=A0life=C2=A0but=C2=A0I=
=C2=A0am=C2=A0skeptical=C2=A0to=C2=A0reveal=C2=A0this=C2=A0particular=C2=A0=
secret=C2=A0to=C2=A0a=C2=A0stranger.=C2=A0You=C2=A0must=C2=A0assure=C2=A0me=
=C2=A0that=C2=A0everything=C2=A0will=C2=A0be=C2=A0handled=C2=A0confidential=
ly=C2=A0because=C2=A0we=C2=A0are=C2=A0not=C2=A0going=C2=A0to=C2=A0suffer=C2=
=A0again=C2=A0in=C2=A0life.=C2=A0It=C2=A0has=C2=A0been=C2=A010=C2=A0years=
=C2=A0now=C2=A0that=C2=A0most=C2=A0of=C2=A0the=C2=A0greedy=C2=A0African=C2=
=A0Politicians=C2=A0used=C2=A0our=C2=A0bank=C2=A0to=C2=A0launder=C2=A0money=
=C2=A0overseas=C2=A0through=C2=A0the=C2=A0help=C2=A0of=C2=A0their=C2=A0Poli=
tical=C2=A0advisers.=C2=A0Most=C2=A0of=C2=A0the=C2=A0funds=C2=A0which=C2=A0=
they=C2=A0transferred=C2=A0out=C2=A0of=C2=A0the=C2=A0shores=C2=A0of=C2=A0Af=
rica=C2=A0were=C2=A0gold=C2=A0and=C2=A0oil=C2=A0money=C2=A0that=C2=A0was=C2=
=A0supposed=C2=A0to=C2=A0have=C2=A0been=C2=A0used=C2=A0to=C2=A0develop=C2=
=A0the=C2=A0continent.=C2=A0Their=C2=A0Political=C2=A0advisers=C2=A0always=
=C2=A0inflated=C2=A0the=C2=A0amounts=C2=A0before=C2=A0transferring=C2=A0to=
=C2=A0foreign=C2=A0accounts,=C2=A0so=C2=A0I=C2=A0also=C2=A0used=C2=A0the=C2=
=A0opportunity=C2=A0to=C2=A0divert=C2=A0part=C2=A0of=C2=A0the=C2=A0funds=C2=
=A0hence=C2=A0I=C2=A0am=C2=A0aware=C2=A0that=C2=A0there=C2=A0is=C2=A0no=C2=
=A0official=C2=A0trace=C2=A0of=C2=A0how=C2=A0much=C2=A0was=C2=A0transferred=
=C2=A0as=C2=A0all=C2=A0the=C2=A0accounts=C2=A0used=C2=A0for=C2=A0such=C2=A0=
transfers=C2=A0were=C2=A0being=C2=A0closed=C2=A0after=C2=A0transfer.=C2=A0I=
=C2=A0acted=C2=A0as=C2=A0the=C2=A0Bank=C2=A0Officer=C2=A0to=C2=A0most=C2=A0=
of=C2=A0the=C2=A0politicians=C2=A0and=C2=A0when=C2=A0I=C2=A0discovered=C2=
=A0that=C2=A0they=C2=A0were=C2=A0using=C2=A0me=C2=A0to=C2=A0succeed=C2=A0in=
=C2=A0their=C2=A0greedy=C2=A0act;=C2=A0I=C2=A0also=C2=A0cleaned=C2=A0some=
=C2=A0of=C2=A0their=C2=A0banking=C2=A0records=C2=A0from=C2=A0the=C2=A0Bank=
=C2=A0files=C2=A0and=C2=A0no=C2=A0one=C2=A0cared=C2=A0to=C2=A0ask=C2=A0me=
=C2=A0because=C2=A0the=C2=A0money=C2=A0was=C2=A0too=C2=A0much=C2=A0for=C2=
=A0them=C2=A0to=C2=A0control.=C2=A0They=C2=A0laundered=C2=A0over=C2=A0$5bil=
lion=C2=A0Dollars=C2=A0during=C2=A0the=C2=A0process.

Before=C2=A0I=C2=A0send=C2=A0this=C2=A0message=C2=A0to=C2=A0you,=C2=A0I=C2=
=A0have=C2=A0already=C2=A0diverted=C2=A0($10.5million=C2=A0Dollars)=C2=A0to=
=C2=A0an=C2=A0escrow=C2=A0account=C2=A0belonging=C2=A0to=C2=A0no=C2=A0one=
=C2=A0in=C2=A0the=C2=A0bank.=C2=A0The=C2=A0bank=C2=A0is=C2=A0anxious=C2=A0n=
ow=C2=A0to=C2=A0know=C2=A0who=C2=A0the=C2=A0beneficiary=C2=A0to=C2=A0the=C2=
=A0funds=C2=A0is=C2=A0because=C2=A0they=C2=A0have=C2=A0made=C2=A0a=C2=A0lot=
=C2=A0of=C2=A0profits=C2=A0with=C2=A0the=C2=A0funds.=C2=A0It=C2=A0is=C2=A0m=
ore=C2=A0than=C2=A0Eight=C2=A0years=C2=A0now=C2=A0and=C2=A0most=C2=A0of=C2=
=A0the=C2=A0politicians=C2=A0are=C2=A0no=C2=A0longer=C2=A0using=C2=A0our=C2=
=A0bank=C2=A0to=C2=A0transfer=C2=A0funds=C2=A0overseas.=C2=A0The=C2=A0($10.=
5million=C2=A0Dollars)=C2=A0has=C2=A0been=C2=A0laying=C2=A0waste=C2=A0in=C2=
=A0our=C2=A0bank=C2=A0and=C2=A0I=C2=A0don=E2=80=99t=C2=A0want=C2=A0to=C2=A0=
retire=C2=A0from=C2=A0the=C2=A0bank=C2=A0without=C2=A0transferring=C2=A0the=
=C2=A0funds=C2=A0to=C2=A0a=C2=A0foreign=C2=A0account=C2=A0to=C2=A0enable=C2=
=A0me=C2=A0share=C2=A0the=C2=A0proceeds=C2=A0with=C2=A0the=C2=A0receiver=C2=
=A0(a=C2=A0foreigner).=C2=A0The=C2=A0money=C2=A0will=C2=A0be=C2=A0shared=C2=
=A060%=C2=A0for=C2=A0me=C2=A0and=C2=A040%=C2=A0for=C2=A0you.=C2=A0There=C2=
=A0is=C2=A0no=C2=A0one=C2=A0coming=C2=A0to=C2=A0ask=C2=A0you=C2=A0about=C2=
=A0the=C2=A0funds=C2=A0because=C2=A0I=C2=A0secured=C2=A0everything.=C2=A0I=
=C2=A0only=C2=A0want=C2=A0you=C2=A0to=C2=A0assist=C2=A0me=C2=A0by=C2=A0prov=
iding=C2=A0a=C2=A0reliable=C2=A0bank=C2=A0account=C2=A0where=C2=A0the=C2=A0=
funds=C2=A0can=C2=A0be=C2=A0transferred.

You=C2=A0are=C2=A0not=C2=A0to=C2=A0face=C2=A0any=C2=A0difficulties=C2=A0or=
=C2=A0legal=C2=A0implications=C2=A0as=C2=A0I=C2=A0am=C2=A0going=C2=A0to=C2=
=A0handle=C2=A0the=C2=A0transfer=C2=A0personally.=C2=A0If=C2=A0you=C2=A0are=
=C2=A0capable=C2=A0of=C2=A0receiving=C2=A0the=C2=A0funds,=C2=A0do=C2=A0let=
=C2=A0me=C2=A0know=C2=A0immediately=C2=A0to=C2=A0enable=C2=A0me=C2=A0give=
=C2=A0you=C2=A0a=C2=A0detailed=C2=A0information=C2=A0on=C2=A0what=C2=A0to=
=C2=A0do.=C2=A0For=C2=A0me,=C2=A0I=C2=A0have=C2=A0not=C2=A0stolen=C2=A0the=
=C2=A0money=C2=A0from=C2=A0anyone=C2=A0because=C2=A0the=C2=A0other=C2=A0peo=
ple=C2=A0that=C2=A0took=C2=A0the=C2=A0whole=C2=A0money=C2=A0did=C2=A0not=C2=
=A0face=C2=A0any=C2=A0problems.=C2=A0This=C2=A0is=C2=A0my=C2=A0chance=C2=A0=
to=C2=A0grab=C2=A0my=C2=A0own=C2=A0life=C2=A0opportunity=C2=A0but=C2=A0you=
=C2=A0must=C2=A0keep=C2=A0the=C2=A0details=C2=A0of=C2=A0the=C2=A0funds=C2=
=A0secret=C2=A0to=C2=A0avoid=C2=A0any=C2=A0leakages=C2=A0as=C2=A0no=C2=A0on=
e=C2=A0in=C2=A0the=C2=A0bank=C2=A0knows=C2=A0about=C2=A0my=C2=A0plans.=C2=
=A0Please=C2=A0get=C2=A0back=C2=A0to=C2=A0me=C2=A0if=C2=A0you=C2=A0are=C2=
=A0interested=C2=A0and=C2=A0capable=C2=A0to=C2=A0handle=C2=A0this=C2=A0proj=
ect,=C2=A0I=C2=A0shall=C2=A0intimate=C2=A0you=C2=A0on=C2=A0what=C2=A0to=C2=
=A0do=C2=A0when=C2=A0I=C2=A0hear=C2=A0from=C2=A0your=C2=A0confirmation=C2=
=A0and=C2=A0acceptance.=C2=A0If=C2=A0you=C2=A0are=C2=A0capable=C2=A0of=C2=
=A0being=C2=A0my=C2=A0trusted=C2=A0associate,=C2=A0do=C2=A0declare=C2=A0you=
r=C2=A0consent=C2=A0to=C2=A0me=C2=A0I=C2=A0am=C2=A0looking=C2=A0forward=C2=
=A0to=C2=A0hear=C2=A0from=C2=A0you=C2=A0immediately=C2=A0for=C2=A0further=
=C2=A0information.
Thanks=C2=A0with=C2=A0my=C2=A0best=C2=A0regards.
Mr.=C2=A0Abdul=C2=A0Salam,
Telex=C2=A0Manager
United=C2=A0Bank=C2=A0for=C2=A0Africa=C2=A0(UBA)
Burkina=C2=A0Faso
