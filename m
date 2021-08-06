Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE583E2EE8
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Aug 2021 19:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241285AbhHFRf3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 6 Aug 2021 13:35:29 -0400
Received: from mail-eopbgr130128.outbound.protection.outlook.com ([40.107.13.128]:65108
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241257AbhHFRf2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 6 Aug 2021 13:35:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2H7UTYehcAmBux9IDnmKShJnwQGlsuelQSJKtcxrgLquyY/gnSh2Yhw4MEQrgEXbtg0S9vdP59bQ8TVJ+vjzFxJuvCya+/adEZQPWKAWxBfC6cY/eD3r51OFADMjCGQnsK/NeSwdcG190rfHtAHn/CMkCI2HGx5JWUyl6+/GSAM7ivKwHv2qnfz6TyTTYuFz6WFGzpyUKQOYtN2PNCpfcduAhbK/yAL8UEfleR3yVxEmygyhDwPeak58Znln/OB4mnzA8AGAKB6D1iNGdxHgt3jem92LmEMoGxILf4U6SKTc+gXst8ikz+bo6GaEZN7C4zKU56+Z6avSaUejTuM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOPzH2NVjkg3T+Sr0gMcgMf54zvUZAz67jzeXNlBLko=;
 b=aa6uJRGLGn5dDWOKwj2RSc6fhNbhzgkoOpY0WfOQbTlAgUdFQFgvm1rUZgLsVZsWeuhMqfvQK9efl4Bs13TIrXSJgL9zZShObtRRsbD5ZhOlSuPrYvGc2Cf4nMjjHIHSiIwDg2xP9LDg0G7WQLP6Yz1gnLzwvt1vALU8O6JHarqu0ULX15sNHXvVdob+v9NhnHVJdag/5g49OWdm5LH5gN1IzIJxloqbzfyE4ZTwka2+YqA6LuRUA2j26hEeD4M8HyIucFLYH2Fy0aowB25dMY2pyI12BWbLhA0FQK/2ITZOkiDWdykVQMz3eB32VGadIfyGD5CzR1/ii2bcJk4h3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silk.us; dmarc=pass action=none header.from=silk.us; dkim=pass
 header.d=silk.us; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KAMINARIO.onmicrosoft.com; s=selector2-KAMINARIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOPzH2NVjkg3T+Sr0gMcgMf54zvUZAz67jzeXNlBLko=;
 b=mwnB1VQCfmsgwZkeplW4Gi8kMG4uYP65IpwDU/G+p0JyMt0LB28mJfR9GUB/WiUDJ+WAOo6Iol0TmMBuWX2T5D6LoSI7fvSGghu9GL9qx/3RNorLKFRTgVOwVu8LA8bfYyQrHQOwe9FSdNc5ZZsD+3tjLyUrw4NVsxSQ2Mh1v5I=
Received: from VI1PR0401MB2415.eurprd04.prod.outlook.com
 (2603:10a6:800:2b::12) by VI1PR04MB5246.eurprd04.prod.outlook.com
 (2603:10a6:803:54::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Fri, 6 Aug
 2021 17:35:08 +0000
Received: from VI1PR0401MB2415.eurprd04.prod.outlook.com
 ([fe80::dd8e:4155:4fa4:605f]) by VI1PR0401MB2415.eurprd04.prod.outlook.com
 ([fe80::dd8e:4155:4fa4:605f%11]) with mapi id 15.20.4394.017; Fri, 6 Aug 2021
 17:35:07 +0000
From:   David Mozes <david.mozes@silk.us>
To:     Michael Kelley <mikelley@microsoft.com>,
        David Moses <mosesster@gmail.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Mozes <david.mozes@silk.us>,
        =?windows-1255?B?+uXu+CDg4eXo4eXs?= <tomer432100@gmail.com>
Subject: RE: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Thread-Topic: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Thread-Index: AQHXiqRBXwjgsSgsKkyKw+PnE9iSIKtmSmoAgABuwJA=
Date:   Fri, 6 Aug 2021 17:35:07 +0000
Message-ID: <VI1PR0401MB2415830F31160F734300C576F1F39@VI1PR0401MB2415.eurprd04.prod.outlook.com>
References: <CA+qYZY3a-FHfWNL2=na6O8TRJYu9kaeyp80VNDxaDTi2EBGoog@mail.gmail.com>
 <MWHPR21MB1593A75E765DBFFE2B12C627D7F39@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB1593A75E765DBFFE2B12C627D7F39@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=64228e1a-dcd2-4ad1-b408-a76637d82554;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-06T10:14:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none header.from=silk.us;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ebe82c7-50ec-4d71-076b-08d9590088a6
x-ms-traffictypediagnostic: VI1PR04MB5246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB524648C10521298EDA03C94BF1F39@VI1PR04MB5246.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4eklEVcsooo/vpAi6rmGO7iYTPVEWLCZhwSGONJ2pUem22PSEV9pyKQI7wOVzIVzBS3ifrvS7Bwmr3XTKxaVK7JiaOgsVXMJVaYgY/fYcNgRyPusRTOjs3YOsVQSThDVLrW7yCgCigvCRHLgxUE0m7EzBYTNzmIMs4D6JcO8P/gbFOk3MGeRIpRDEL1mmJElnUqalGFUkYvutXCF9Cpxbsl/TGcYGM96pwEwbkATljSFFsuhfg7m5z6gXxGqp4zzdox1wH85oe8/rM0g6sDt3RWXAUQiwnGQ/jAKH5/YCTHqCpas6oWjeMTeNvpWknoqWcTkQb0R+LAIlMuBKhgMZ25df5woOeJqtx3nWRzeUmndf5q5Wk0IfHATefJceN+DohV+cC/w7k2QIKWQp8BIgJ28K4ZjaUx52l0fMs2zgDyQ2I2uOCr7i0RFjTM0544K9COAU3IH/MeoSdYGVcu5NHYHkcdhVSueE8Xo/HQwhWvOzDLIwjMbEJXYkYMcNolKhjPUrLnDjLEXKPEhTQfqfG9tW/XZN/E6Ajn6CSryYgKjFek8ZxBpI3SJ/s9nh3ptJ8rt0tfHF4haLw7Ks+v6G/S2reHzsrEBYOvpFU7cdXTYs1yeS6Pj7P0qLkAbTVb3/SmOI3MLWzVwcOKRU7Q7tcG40ZJpSC6JU2RyQHWPLIypxD9l51QYF/hd3AoJDymbdYwVWIeK9sfVoj0cjVVIYh0whn4bzd/AwTdZorvTMmE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2415.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39850400004)(376002)(346002)(136003)(478600001)(8936002)(110136005)(9686003)(8676002)(316002)(55016002)(54906003)(71200400001)(6506007)(38100700002)(4326008)(44832011)(7696005)(53546011)(86362001)(38070700005)(26005)(2906002)(83380400001)(5660300002)(52536014)(122000001)(33656002)(66446008)(66946007)(66476007)(76116006)(66556008)(186003)(64756008)(80162008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?windows-1255?Q?q9mExL94raJHznoFlkG+U0wXYbYtQYb/J5//00VrD84BPO1ZVkgxXDHP?=
 =?windows-1255?Q?KDYbfYGKMermD+eib+YxBR4JRzhjxXLQBxTOWry8z2033o8YP19cSRUm?=
 =?windows-1255?Q?ERIR4W2RCW+y4I9EXxn9m4ya+uSrbvbUbyaKbKDkdHxcIqEYozA0GTgs?=
 =?windows-1255?Q?zlcIHqK6xqiOpuaTW/W8F1OCdEHJaWTO/EonLl7Jk/cl196Wv/xQOJI4?=
 =?windows-1255?Q?J1aR7oQ0LIt04s89ubkE4hwog/GrO4CX0/I5ErU/2tu9m2sUbeH9qc3m?=
 =?windows-1255?Q?gmqvMpgZ6RkBhVVsRiJfG5hUd4bfps9W5ssLW8wlxeXnxomEL1ZpAXtE?=
 =?windows-1255?Q?urMkNoymLY7Czmlo/QT/qGBHEfn/zPoVDLeJt6PfzYs73ymFY11/fGwb?=
 =?windows-1255?Q?0BB4V9upQ2ee4VSrl3EcqUMJIdqyYAwKjwXF8nSl0fjXTlmaozXDY4hb?=
 =?windows-1255?Q?LSwC/QYjcS14SXnDUWzfEyxQwzZalzthPNFEcu9C3M2kFct76+2u7pjl?=
 =?windows-1255?Q?orUK5ar1rrLTs+eSDx2lqZqDRzAxAYhsbWjo7eUyVaG1bOMudlBpMkUV?=
 =?windows-1255?Q?55tQHYIkUhiJlweVJq+sTZKyyR87G/x9O28it5j9w/DrPnuabMtFLgAy?=
 =?windows-1255?Q?EMOL65qNFC5j/13cmATefd41xagGSjIhG4WYqqXm0at/8LSjsP71nh08?=
 =?windows-1255?Q?79yKJOKRVX7AYBxwOUg1gItxzNsgjT5rCJYvOyCEsupThDhbR05Z6Wsr?=
 =?windows-1255?Q?Us3mhXArDSr7tDvAfw9CoxKNpkIGzfoPrjrDCu9sY1jjHn23OtgaFa44?=
 =?windows-1255?Q?+0Sordk3qKgi+DXDENovc2NcmHkT9F5BHPiw9B/K3q096x32xPzhs+Ct?=
 =?windows-1255?Q?V9NiLIeDmQaMmTNQ6edKiX1lyOrPrmOgJrZpn26qm+t608sYe9kXHr8g?=
 =?windows-1255?Q?kqcKsmhSxwv2eatoxZUvDOWId0wgrh3J0ou0eZYSGcgB8WrBK7yqHkx+?=
 =?windows-1255?Q?sO8NHf2O3ED4gAL7ILlsec4d5BQiqCTcqz7VFn0qDfacCmz3R9sLDi/D?=
 =?windows-1255?Q?ynyTwn/S4SMQe0JEmrTkBU0kAdBdqYyDUkYynXkJXqUKoab5GIhTJuPJ?=
 =?windows-1255?Q?nZpowqBNjxM1DVWpP/YnV4OvK+kpzrkP5RrwAETJVSoIwr99tH9AaI8k?=
 =?windows-1255?Q?TKAe8TXFzQ9ygPUYq/ku4mgsGJ2NqQZi57O1t/K476aDdS1YFElHuQSG?=
 =?windows-1255?Q?fRSQTT2C3MyIV70BCeZpIOz4I1aZmuylkpkx/OVRbtr0h67EnyJP7FFT?=
 =?windows-1255?Q?S2ADzzkGRixHAuMrpCARS127T8XMDt6E1e1QO/SIFgI7PCgNEWIS5zZ8?=
 =?windows-1255?Q?o9mvHsdsSiOxy+gz+h3uHjkK11A+heLtWKs=3D?=
Content-Type: text/plain; charset="windows-1255"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silk.us
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2415.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebe82c7-50ec-4d71-076b-08d9590088a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2021 17:35:07.4701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4a3c5477-cb0e-470b-aba6-13bd9debb76b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TEwNumI+tJwFA3046vli4LQSk6zzbvo+O7GNCZH8pkrFX34E+cPpiduyBWmnH0ngCOJTEa+Iw3wNadNqO86NiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5246
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Yes ,please provide the diff.=20
Unfortunately  we saw the problem on every 4.19.x version we tested, starte=
d from 149 we saw the issue as we as in 5.4.80
I believe you are right and it is general kernel issue and not hyper-v spec=
ific.=20
Look that the code I added eliminate the Panic we got but the kernel "doesn=
't like it"
Any suggestions how we can let the kernel continue working while we do our =
experiment?=20

Thx
David=20


-----Original Message-----
From: Michael Kelley <mikelley@microsoft.com>=20
Sent: Friday, August 6, 2021 1:43 PM
To: David Moses <mosesster@gmail.com>
Cc: David Mozes <david.mozes@silk.us>; linux-hyperv@vger.kernel.org; linux-=
kernel@vger.kernel.org
Subject: RE: [PATCH] x86/hyper-v: guard against cpu mask changes in hyperv_=
flush_tlb_others()

From: David Moses <mosesster@gmail.com> Sent: Friday, August 6, 2021 2:20 A=
M

> Hi Michael ,=20
> We are=A0=A0running kernel 4.19.195 (The fix=A0Wei Liu suggested of movin=
g the
> cpumask_empty check after disabling interrupts is included in this versio=
n).
> with the default hyper-v version=A0
> I'm getting the 4 bytes garbage read (trace included) once almost every n=
ight
> We running=A0on Azure vm=A0Standard=A0 D64s_v4 with 64 cores (Our system =
include
> three of such Vms) the application=A0is very high=A0io traffic involving=
=A0iscsi=A0
> We believe=A0this issue casus us to stack corruption on the rt scheduler =
as I forward
> in the previous=A0mail.
>
> Let us know what is more needed=A0to clarify=A0the problem.
> Is it just Hyper-v related?=A0 =A0or could=A0be a general kernel issue.=
=A0
>
> Thx David=A0
>
> even more that that while i add the below patch/fix=A0
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 5b58a6c..165727a 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -298,6 +298,9 @@ static inline struct hv_vp_assist_page *hv_get_vp_ass=
ist_page(unsigned int cpu)
=A0> */
> static inline int hv_cpu_number_to_vp_number(int cpu_number)
> {
> +=A0=A0=A0=A0=A0=A0 if (WARN_ON_ONCE(cpu_number < 0 || cpu_number >=3D nu=
m_possible_cpus()))
> +=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0return VP_INVAL;
> +
> =A0=A0=A0=A0=A0=A0=A0 return hv_vp_index[cpu_number];
> }
>
> we have evidence=A0that we reach this point=A0
>=20
> see below:
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089261] WARNING: CPU: 15 PID: 8=
973 at arch/x86/include/asm/mshyperv.h:301 hyperv_flush_tlb_others+0x1f7/0x=
760
>=A0Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275] RIP: 0010:hyperv_flus=
h_tlb_others+0x1f7/0x760
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275] Code: ff ff be 40 00 00=
 00 48 89 df e8 c4 ff 3a 00
> 85 c0 48 89 c2 78 14 48 8b 3d be 52 32 01 f3 48 0f b8 c7 39 c2 0f 82 7e 0=
1 00 00 <0f> 0b ba ff ff ff ff
> 89 d7 48 89 de e8 68 87 7d 00 3b 05 66 54 32
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275] RSP: 0018:ffff8c536bcaf=
a38 EFLAGS: 00010046
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275] RAX: 0000000000000040 R=
BX: ffff8c339542ea00 RCX: ffffffffffffffff
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275] RDX: 0000000000000040 R=
SI: ffffffffffffffff RDI: ffffffffffffffff
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275] RBP: ffff8c339878b000 R=
08: ffffffffffffffff R09: ffffe93ecbcaa0e8
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275] R10: 00000000020e0000 R=
11: 0000000000000000 R12: ffff8c536bcafa88
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275] R13: ffffe93efe1ef980 R=
14: ffff8c339542e600 R15: 00007ffcbc390000
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275] FS:=A0 00007fcb8eae37a0=
(0000) GS:ffff8c339f7c0000(0000) knlGS:0000000000000000
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275] CS:=A0 0010 DS: 0000 ES=
: 0000 CR0: 0000000080050033
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275] CR2: 000000000135d1d8 C=
R3: 0000004037137005 CR4: 00000000003606e0
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275] DR0: 0000000000000000 D=
R1: 0000000000000000 DR2: 0000000000000000
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275] DR3: 0000000000000000 D=
R6: 00000000fffe0ff0 DR7: 0000000000000400
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275] Call Trace:
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275]=A0 flush_tlb_mm_range+0=
xc3/0x120
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275]=A0 ptep_clear_flush+0x3=
a/0x40
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275]=A0 wp_page_copy+0x2e6/0=
x8f0
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275]=A0 ? reuse_swap_page+0x=
13d/0x390
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275]=A0 do_wp_page+0x99/0x4c=
0
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275]=A0 __handle_mm_fault+0x=
b4e/0x12c0
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275]=A0 ? memcg_kmem_get_cac=
he+0x76/0x1a0
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275]=A0 handle_mm_fault+0xd6=
/0x200
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275]=A0 __get_user_pages+0x2=
9e/0x780
> Aug=A0 5 21:03:01 c-node11 kernel: [17147.089275]=A0 get_user_pages_remot=
e+0x12c/0x1b0


(FYI -- email to the Linux kernel mailing lists should be in plaintext form=
at, and
not use HTML or other formatting.)

This is an excellent experiment.  It certainly suggests that the cpumask th=
at is
passed to hyperv_flush_tlb_others() has bits set for CPUs above 64 that don=
't exist.
f that's the case, it would seem to be a general kernel issue rather than s=
omething
specific to Hyper-V.

Since it looks like you can  to add debugging code to the kernel, here are =
a couple
of thoughts:

1) In hyperv_flush_tlb_others() after the call to disable interrupts, check=
 the value
of cpulast(cpus), and if it is greater than num_possible_cpus(), execute a =
printk()
statement that outputs the entire contents of the cpumask that is passed in=
.  There's
a special printk format string for printing out bitmaps like cpumasks.   Le=
t me know
if you would like some help on this code -- I can provide a diff later toda=
y.  Seeing
what the "bad" cpumask looks like might give some clues as to the problem.

2) As a different experiment, you can disable the Hyper-V specific flush ro=
utines
entirely.  At the end of the mmu.c source file, have hyperv_setup_mmu_ops()
always return immediately.  In this case, the generic Linux kernel flush ro=
utines
will be used instead of the Hyper-V ones.   The code may be marginally slow=
er,
but it will then be interesting to see if a problem shows up elsewhere.

But based on your experiment, I'm guessing that there's a general kernel is=
sue
rather than something specific to Hyper-V.=20

Have you run 4.19 kernels previous to 4.19.195 that didn't have this proble=
m?  If
you have a kernel version that is good, the ultimate step would be to do=20
a bisect and find out where the problem was introduced in the 4.19-series. =
 That
could take a while, but it would almost certainly identify the problematic
code change and would be beneficial to the Linux kernel community in
general.

Michael
