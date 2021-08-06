Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9CD3E28D1
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Aug 2021 12:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245191AbhHFKng (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 6 Aug 2021 06:43:36 -0400
Received: from mail-dm6nam08on2104.outbound.protection.outlook.com ([40.107.102.104]:11009
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245188AbhHFKn2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 6 Aug 2021 06:43:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRhCvdo2Ndorxo7+3ge+LArx71CuJpoNiGsJvNAQzqffOl8MhzVu2piDn81s3fL7cspORuW9DU9eJTlVHSuzdpj7UscS6o0rU7odWX3UIl1YagB4V/K7pIdsc5rfZKFWkZkHwMzV65WvcuwxwZRxL9J0j0L5uTkMlkgyKuYcP8osr6ZslE/yXEQCOOtE1OYUcRA/DWz3al/4+GqHtwZ03uIi+XEYN2tLxyqWvC0PmY5DmMtS2WqV66RoOOlTzDS8ZBt+PEWXLpm8tEZxVqEjwXci0AKRyih76WiyTbFpvfnn5wAxG1vOtxnZ9BVk9wicOvLcWT4W9EtEquVm4fCIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qr3FkKufmznWIcKb5QG67Kj4PrSSjE5Tapy1OARXFHk=;
 b=nD70r7txck5rA0tPYhWziMDHIlz4OevP44hiumo10UzjUxuyPdpppcfGVBxPg9Baek+1Si3FcM6xR6Jl2slpeWfk8Kw4+y6wAlO+E9LeWJIjWEihXKFudvImO8geKZwwT+BmFldrFZOFq2pM4N48laeSXZlxDbu59/5nd4iX7y8sATIeEyMqoI+t0ECNXV49DTyX+WpzqWcLWq0KId2oHHI3BHscswdFWtmc1ZCBnOSJ7jTKC/0ftxJN4ygSpqwYQDjThYLGJLsjCNucjked8bpqrJuNTZzQG5TSoVv/70b9rNvwsP/7ri7FDo/cQB2ZT0x7gU28pjo7XVZGsHJelA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qr3FkKufmznWIcKb5QG67Kj4PrSSjE5Tapy1OARXFHk=;
 b=BwWGnGygMeHQlkLAG6IjxG7JvZCA2OBpYKYtIGETKR41TRen67Fnm/bAjeX266KwURWJ5PnjIzsBp15TTokgtHBm8ZN+igIvU9xiBz5drdHG7h4kQaIcpxyTOh6E/3eOcMqZm9YCajcC5wrulmykU/6Y0/tiBlY0ukuWAWXL29g=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0158.namprd21.prod.outlook.com (2603:10b6:300:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.1; Fri, 6 Aug
 2021 10:43:11 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e8f7:b582:9e2d:ba55]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e8f7:b582:9e2d:ba55%2]) with mapi id 15.20.4415.005; Fri, 6 Aug 2021
 10:43:11 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     David Moses <mosesster@gmail.com>
CC:     "david.mozes@silk.us" <david.mozes@silk.us>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Thread-Topic: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Thread-Index: AQHXiqRED5Xjx5or60CuT0JToyz6HatmQkqQ
Date:   Fri, 6 Aug 2021 10:43:10 +0000
Message-ID: <MWHPR21MB1593A75E765DBFFE2B12C627D7F39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <CA+qYZY3a-FHfWNL2=na6O8TRJYu9kaeyp80VNDxaDTi2EBGoog@mail.gmail.com>
In-Reply-To: <CA+qYZY3a-FHfWNL2=na6O8TRJYu9kaeyp80VNDxaDTi2EBGoog@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=64228e1a-dcd2-4ad1-b408-a76637d82554;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-06T10:14:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31d7dcba-dec2-4918-b71c-08d958c6fc5d
x-ms-traffictypediagnostic: MWHPR21MB0158:
x-microsoft-antispam-prvs: <MWHPR21MB01581F6C8FD1841053AA3228D7F39@MWHPR21MB0158.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4xeNfYvFiNbuzgji677hiw7WSqyb5qTNCmPCZj8INzK51rjsWFrKNKVPrSldtKkVzk8d3ooDZ35AQCl5JTT+VGzx7iw14DLMBsPkC6Z2CFfjvO5p30SC+XxrDajdhrDxOZi/VqTdffLhX6MyIKe1YEmbAXw1sxpvmpcW+Lnyz/1iZnToiZ6c78zy0biWa5T1ZfFtTDY2IsdesmffuFdSM4uhyDbccwgVqCzNu0xRKm95SprdaHP8F0MBNRtj4JQ6kaT7XqDL5c/pQJV28fVAGCHbf0ChVqaRkw901BQNZkYpd42j8uplb5y1xNee2M9mtNnjSSBUaKsYscG42sfO+qfn8klGgELsLPIXtKEXKRCGts0w20jRyrs0zD2T0rDpxQzGOgwf9Aw7N3mJzdZGGBvT6MtQL3OiW1HG16qLUn4uG3/55fNmgjqD9Viz6xyK25OroSmW5qhTHSdU72foX74vGpaZwZaropMWxmo+07FVMKnB36sskLwFdc/l06ai8W/QovTAYOzdmLqvuAYs265cJFlFuLkMbM80s5Rb5+qPvFcepRNem6R60DJEbwM2cmNyfFKyZbEQBuErvCikYGjeDIfHbaUPdGO/ZBbqHSsnEEGTpcKIAJc9cTTD36/qAZSjkrIKtxA6y7aFocYkyD6JVquuPeOH/wP37cR4XE+BQuxY5wu+dWXz9zaq3LTixxobeKxehm4j5IPygOl0KQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(38100700002)(82960400001)(82950400001)(8990500004)(33656002)(122000001)(10290500003)(7696005)(52536014)(55016002)(508600001)(66446008)(6506007)(71200400001)(76116006)(38070700005)(186003)(66946007)(66476007)(64756008)(66556008)(86362001)(4326008)(26005)(2906002)(9686003)(5660300002)(83380400001)(8936002)(8676002)(6916009)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uW/NrNNfBxNgl0x3x0n8Aqcq1CiL9maOm7eUzXkvXg74S0OYmB0z0WZ2FA?=
 =?iso-8859-1?Q?WNdSgpeCfuce5ufoA/0rUfMXoTtcwFvuwR+ZATacA6WY8ZZjeekpCGiWnx?=
 =?iso-8859-1?Q?9LRCDgkj3Bn69DdsDqsO7HTBUCZgkPIC4ZeOWAwAJl4e0FZcuCF623nLQD?=
 =?iso-8859-1?Q?3C3LZCCF63qTbjPhmEIPdl7lvBWrvKZlLvOqfbIe6mXWW59w5iBojFt93h?=
 =?iso-8859-1?Q?0KN62EzvdBp7cXaRr+LqAa/1yOahTCRP/FibwNOYNx4ZEBOJaWq6RyX6jL?=
 =?iso-8859-1?Q?8zOC7kEo9ttgx1quexpQRUok778fKOSaAdbjkY4v80WRtnKU57kRDxcbsK?=
 =?iso-8859-1?Q?1SgkzWOIIBCGRBftX1Myn9jrBx+ozT/YhIBbku9mRGLv6jsT7n67Oi4AJE?=
 =?iso-8859-1?Q?F9uEDNpB3gSTL7ce5eM7PxRld72WVCrxeRP0iQUlGO5nV4DcPt7yw+/fSf?=
 =?iso-8859-1?Q?ylKpJDz0C8Kqik69j2uUY0SikwNSfsjB9MBoMAc/8Pb7tEB4PE3PO//MS3?=
 =?iso-8859-1?Q?Eu0+SNw08D6S+csKKJRc3f+aj2VzCC+x1Am8VmfhZhXb/UDIXGk99ViWuy?=
 =?iso-8859-1?Q?RUc73goHIpf9v6A4Ogf4iUSmHBs1INpfvsBmQ3tScJvhzHzwHHVzPiMtZz?=
 =?iso-8859-1?Q?qtZ56lPZYH+ShYjzG7Ot8tsZxGplSv0qBV4UIscRvQ7nLF+XHGDsGZzMWg?=
 =?iso-8859-1?Q?5BzL6xkZ6OTBm4LD+Gs3R7p6gxkHtbPCqadWF9RS2bOkHv1h+Ru93RoC+7?=
 =?iso-8859-1?Q?+xLtDSaFA9ecdsyvYGRxL+FHMXCLKOUz7he6ZQ/0kxMQrLCGPM02LSO39u?=
 =?iso-8859-1?Q?1OO5bKpsGvDvvmTNcCxYJYbNajSdX3LALD5QerdDEgAukfAr4c810o/ST0?=
 =?iso-8859-1?Q?44Y5zgy0eBjnbaAK9g78ZlkGucchm1AamErhR6PXRSMgD0afYh8W25DhQJ?=
 =?iso-8859-1?Q?CDsXIEpL/8BB0LXc2v3qdGK00mBEPWQyaAc++c7L1wKZePc4kZzYFfid4w?=
 =?iso-8859-1?Q?A0CqvhAMhC/XXpeFGvoOTSR8yCgxi72GXDWRDVnUvWDU25AvZwBop9+pEm?=
 =?iso-8859-1?Q?riafockq8E+k3TzYnXSiqENHsU0wKhqHsOW3mPtXh13arxZXzh0qS+g9Li?=
 =?iso-8859-1?Q?a5o33BvteCFRieIqtpY5RUHSJwT0dm4qljjT6BZX4xplw4GSIZ3ZIXz9bj?=
 =?iso-8859-1?Q?N1QZdLpAwtV8LcIIly/Z406QYotMT6i9CpknnohS1J1yvcMFZADk5amXpC?=
 =?iso-8859-1?Q?H6Qz97/B6LLgTehO6/nOpQAK4FNiLTe69bvbVNAJhVfUWm8Koq4JdN7xsF?=
 =?iso-8859-1?Q?DTLEw6pmhf7oXRxPybZbEfOoDLRtlgIHMvH11fjsjmoux4TtaPi9FxqS1o?=
 =?iso-8859-1?Q?/dbzUZPB78?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d7dcba-dec2-4918-b71c-08d958c6fc5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2021 10:43:10.9355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJ4qWoiu0PTbNgOqPAlU2cuS8fpE01T5NnDijyJ7ekMUx5I3gE3J4u5U3wiFuoslQ/7bn+GEpcm4foTqwuvlyLzWd6qAnu/9lXxKZRZpnkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0158
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

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
If that's the case, it would seem to be a general kernel issue rather than =
something
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
