Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929063F17A8
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Aug 2021 13:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbhHSLGE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Aug 2021 07:06:04 -0400
Received: from mail-db8eur05on2105.outbound.protection.outlook.com ([40.107.20.105]:43103
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238445AbhHSLGD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Aug 2021 07:06:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSgql/7K5fVzYLaCeG9fzZj4QGbM+jZiHQyf+gxxHfoSNh9VwP8P+8VHKPeaSX0lnFF+M+vJpckHEAh1lqduJsivXrFHMl8KUHMh1TYP+qpTSTygMzdjTIhNV+Xx9zM9okw74mSUXWOpXjdaxEddZ/YBIxFe+AH5Q0TrtOsNc/c7INsTXdDcuDoCepfggpiB07A67+t70WdIhwA4O6hM6//uTxvuoBK1nIPj6qUOJUYln1XBsmMnOZlzGIPTXADSAkpovxOEDyouEH1MImhYLdy4StVBHG5Li7hTRZhU+mZsUYIPbNM8IH3ZqKINDkasNn+DzWuGIo51Gh8OOWuf/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoRBvo2jrNFPeFJlV/T6xnoo3cfDk+ddaJjcuIhPP6g=;
 b=Irfnr3q8i7nJHoRzLs1vOxHMEg/fzuu7CNgqB3cqzvz6E6zij4VcSMR60Yfae+bqRhwWFZwmH+D+qjI5C+2XhTI+rtFWjCTT4pnEQU50ThJifym+tJ3rsBpSbpo2uGeUyeA03fxg3HmbIH1aQl/jjVTSbD7ep+aDLQ4VIuj5QAGSKPSrFAAk5i3Hxv7ga887nEJzQ0psUIAdqBJvT6TNb3fa8X0WSwH7adC2id6pXu08g84E9kCVI3dWVCyhq1f6sWp75UE3Uf8APqz85Xf2uxJ+XnNxDrfSc7wYjbS3/WZ0Z0vj51cJvhGeOsRoEQUybPkrKPhHINWiBaNTvxSYlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silk.us; dmarc=pass action=none header.from=silk.us; dkim=pass
 header.d=silk.us; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KAMINARIO.onmicrosoft.com; s=selector2-KAMINARIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoRBvo2jrNFPeFJlV/T6xnoo3cfDk+ddaJjcuIhPP6g=;
 b=ipf92fO0QTmfcPqPLMOJbje8AZPFjo8qqtdhHiK4ydgx1pywdFtj79NS4lsr0cIHbijbVnVIVuWmj2jEDYDNI+XAqLSXyNxM5MwdHVWX/QDrWSYsIuEIPekTmvri8n3c3lgWq2Zi2ct4m9HbIlinuraW+ouZ5Jqluc9tQS7S//w=
Received: from VI1PR0401MB2415.eurprd04.prod.outlook.com
 (2603:10a6:800:2b::12) by VI1PR0401MB2414.eurprd04.prod.outlook.com
 (2603:10a6:800:29::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Thu, 19 Aug
 2021 11:05:24 +0000
Received: from VI1PR0401MB2415.eurprd04.prod.outlook.com
 ([fe80::dd8e:4155:4fa4:605f]) by VI1PR0401MB2415.eurprd04.prod.outlook.com
 ([fe80::dd8e:4155:4fa4:605f%11]) with mapi id 15.20.4436.019; Thu, 19 Aug
 2021 11:05:24 +0000
From:   David Mozes <david.mozes@silk.us>
To:     Wei Liu <wei.liu@kernel.org>
CC:     David Moses <mosesster@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        =?windows-1255?B?+uXu+CDg4eXo4eXs?= <tomer432100@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Thread-Topic: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Thread-Index: AQHXiqRBXwjgsSgsKkyKw+PnE9iSIKtmSmoAgABuwJCAAAw8gIAAP8SAgAB3w4CAD/sBMIAAKS8AgAMc9lA=
Date:   Thu, 19 Aug 2021 11:05:24 +0000
Message-ID: <VI1PR0401MB241599F5E6E5FB46644DA1F9F1C09@VI1PR0401MB2415.eurprd04.prod.outlook.com>
References: <MWHPR21MB15935468547C25294A253E0AD7F39@MWHPR21MB1593.namprd21.prod.outlook.com>
 <FD8265E6-895E-45CF-9AE3-787FAD669FC8@gmail.com>
 <VI1PR0401MB2415E89B6E3D01B446FD1DACF1FE9@VI1PR0401MB2415.eurprd04.prod.outlook.com>
 <20210817112954.ufjd77ujq5nhmmew@liuwe-devbox-debian-v2>
In-Reply-To: <20210817112954.ufjd77ujq5nhmmew@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=silk.us;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aabbc3bb-ea84-4980-f456-08d963013e60
x-ms-traffictypediagnostic: VI1PR0401MB2414:
x-microsoft-antispam-prvs: <VI1PR0401MB24142FBCB47BC42DDB264EFAF1C09@VI1PR0401MB2414.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /dNy/PmBnqQzB4iMSjJsCy9Q02F5a0mLnYTWXiqm9CFJtEN857WS7RzPSUnhjihWZrCG9lgMG3zKa7R4udhtLYb39AQUOgjTzfbqgM8aklgso8Z9i7W1MA7TMk5HZrluj9uF8I4s1USCTts7ZTAVtik3btCQ2I2PRBn/HCKMwSML6C4a6DAX2fI0H6Cz2PXTyFlxztmdOT8G3O4sVYOMPyzLqguSCiiCr2cpcm+aNmRXO0ZGZplJebxrLT8M3hnP5lyEbvylC80WrwV4si3EU0CABTP4fj3pVbLr6KHBHlkizoPtDVQPm9sjiSD7PzyOocgXJwpE2Hd2iyQLSk84dwDAU5pz1ILpgmdj1cCfVatLDurI713vktB3Qc34sFH03mrG+X1+eq2I34TxwAFwkQBcHWMG44APT38bYoLJ/mTCV7TmCQmCLJvRaVoetkq/VMuHhbMTAQNQdoaR5Ih6tcAqhTClCA2rP4dq0hzuJge+K/s8VbfsBS0CUrVAZUxeCVIeYeY/mjTClOK16rgDiG/ugttsF8Z6AY4xwD1dv70XJg+wKUg/1+T2iNQCq4VW+dIhctKKIjDLY8nHIUdmrnXLc4bH3gzLouQNOV2KcXKq0OHIIpjju/OGB3LY6BsftmaOaXHmult+a/cW7RsqaHSvvnBwZUz8hDVmUlzSveQ1znytvpZ3XilDg1z547dqqbiXuChPoBXKXgkizXG11++Utl8Ar+mknvXtuihIwRU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2415.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39850400004)(376002)(136003)(366004)(316002)(52536014)(38100700002)(66446008)(33656002)(55016002)(64756008)(4326008)(66476007)(66556008)(5660300002)(44832011)(38070700005)(45080400002)(7696005)(9686003)(6916009)(8936002)(53546011)(71200400001)(6506007)(66946007)(478600001)(8676002)(186003)(83380400001)(76116006)(2906002)(122000001)(54906003)(86362001)(80162008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?windows-1255?Q?J3Z5HLvHAjt/qAcf8/nQiD+JLQhWZ7p3B2TikQyqet31Vmt5BpUj2boM?=
 =?windows-1255?Q?1fUZfwcBvGnnvD6NgyfFqMb6T8Kv2H5Xh/Gr3KS2GQipW7gPNYi8mOOK?=
 =?windows-1255?Q?Aa+67WXFjEFIJnCR0WJeLJreLSvNAkivnLAIjHNuk4BjABJrExAzbROQ?=
 =?windows-1255?Q?PUSsXOF+BJ7h7kRpVezokxubd1O5qIO7q8/Ya5J34dkf+y6lEjaQMgaN?=
 =?windows-1255?Q?Ov0cyGQqzD3rwlHtilCA3+tqL04AW1UvpljsHPnA5f4edZjf1haQla63?=
 =?windows-1255?Q?7cgCg9yhoYxaRnctr5ULb+VdbvDNJyXOr/Syl4/pjLWAj2gZYBni6uia?=
 =?windows-1255?Q?88gz0KVmeDn+0JBA/DRazbDFXLz/ojxSH/pgF91YAfDPgI+2vckhfkzp?=
 =?windows-1255?Q?BizPOqo1KxEb7fvmS73bb37ejQikXCM3RZ2hSPovBxHuEhHXsqsccnIz?=
 =?windows-1255?Q?fTzm2H3s81dV3O0fk0UvarruXOx3CegZlvL2ptpvaT/wgES9zY4tAl/S?=
 =?windows-1255?Q?w8siP0ChAKBYshFD8eTK803rV1Qv2nZ2gI/JbdW4zP1whFMSu2FZiajX?=
 =?windows-1255?Q?IE+zO7F7diCAqtzWbol7ZQRFza6Yu7JjIZJXxIfXU+VT335fPwdRIMTQ?=
 =?windows-1255?Q?pvxx4LrivLWhsV9tgbPeN7TVabNw4aGyh2GxJ2dc72SYMUCz6o4M7imj?=
 =?windows-1255?Q?wvjTZyebjoGAHFZ9t9tMl2EO1pnRMaHGy+S8QIt+/DEteu5HDb87lmmR?=
 =?windows-1255?Q?NMwHsLgEbWrNfrjw4ib5sKY3XGP97uPyIAP2ioBn+vuyZ4MU/1xihuhC?=
 =?windows-1255?Q?M9N7EMWYgTlYfd3wZElVxyXNw/rl7poCRAsiPSQHHaCT6eiZSAr3Rowh?=
 =?windows-1255?Q?hSL+eMftL2F8f7o2uYfyHqC7xm+8/rcW13d0nHpKQyhBz+SUhBZyxBq9?=
 =?windows-1255?Q?8mSdUsDiShXoQ3USCGyjLPizTHBUDp1c0ViZskm1AsHS2J54JlH5NHtP?=
 =?windows-1255?Q?UFJebLz+2c/i6/e8XXb0ju/xsGGni+H2fpLvN7a/8+z8X7aYWV+FXv1L?=
 =?windows-1255?Q?TBDGa7O9n8589uECxHts6CIdQxzQ4/LrKCsY4200es3Ya5FjB6dJgbmY?=
 =?windows-1255?Q?hW7mGaK+hPcAcPHlnHA/IMZ+Q2/zQwDBSpViuM8DJtf0peC/2VtG23+T?=
 =?windows-1255?Q?WeKCR7lqcyjdjFCAI2dTIQtwtlSatkOYlO6LWbgl4y1oT2aTToNmIE2p?=
 =?windows-1255?Q?wlVSCGerc/m3wlaQEBsqnN1iWkkODdRqChDRgvyfx71iWWkYs88rRIEn?=
 =?windows-1255?Q?oTclLPBpMJOTkOIyl+hz5LoQNocYZu6NwN2vpZ6NbHi7YOViBp4jSbg2?=
 =?windows-1255?Q?iWwji7w1SeddUWbNQySlo00NxVm051Jl+LIb44dgEDhQw1b7Q5YXp0hu?=
 =?windows-1255?Q?3rvX50KKUP+xlYB1TMFwORIyT1ppLmqp7PiqfK1p9LtOiivFHTSpuQe+?=
 =?windows-1255?Q?wweY6sSf?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="windows-1255"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silk.us
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2415.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabbc3bb-ea84-4980-f456-08d963013e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 11:05:24.1444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4a3c5477-cb0e-470b-aba6-13bd9debb76b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKO4sQfEPf37/LYEZTOG9kcnR1LscTCDUPii/dmCzv+M6HPClpWARps3tsG/D7095StrOW2Ltsu1anEC1Bjj7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2414
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



Hi Wei ,
Per your request I move the print cpumask to other two places after the tre=
atment on the empty mask see below=20
And I got the folwing:=20


Aug 19 02:01:51 c-node05 kernel: [25936.562674] Hyper-V: ERROR_HYPERV2: cpu=
_last=3D
Aug 19 02:01:51 c-node05 kernel: [25936.562686] WARNING: CPU: 11 PID: 56432=
 at arch/x86/include/asm/mshyperv.h:301 hyperv_flush_tlb_others+0x23f/0x7b0

So we got empty cpumask  on a different place on the code .
Let me know if you need further information from us.=20
How you sagest to handle this situation?=20

Thx=20
David=20

The new  print cpu mask patch
diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index a72fa69..31f0683 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -70,9 +70,7 @@ static void hyperv_flush_tlb_others(const struct cpumask =
*cpus,
        local_irq_save(flags);

        cpu_last =3D cpumask_last(cpus);
-       if (cpu_last >=3D num_possible_cpus()) {
-               pr_emerg("ERROR_HYPERV: cpu_last=3D%*pbl", cpumask_pr_args(=
cpus));
-       }
+

        /*
         * Only check the mask _after_ interrupt has been disabled to avoid=
 the
@@ -83,6 +81,12 @@ static void hyperv_flush_tlb_others(const struct cpumask=
 *cpus,
                return;
        }

+
+       if (cpu_last >=3D num_possible_cpus()) {
+                               pr_emerg("ERROR_HYPERV1: cpu_last=3D%*pbl",=
 cpumask_pr_args(cpus));
+                       }
+
+
        flush_pcpu =3D (struct hv_tlb_flush **)
                     this_cpu_ptr(hyperv_pcpu_input_arg);

@@ -121,6 +125,13 @@ static void hyperv_flush_tlb_others(const struct cpuma=
sk *cpus,
                 * must. We will also check all VP numbers when walking the
                 * supplied CPU set to remain correct in all cases.
                 */
+               cpu_last =3D cpumask_last(cpus);
+
+               if (cpu_last >=3D num_possible_cpus()) {
+                                       pr_emerg("ERROR_HYPERV2: cpu_last=
=3D%*pbl", cpumask_pr_args(cpus));
+                               }
+
-----Original Message-----
From: Wei Liu <wei.liu@kernel.org>=20
Sent: Tuesday, August 17, 2021 2:30 PM
To: David Mozes <david.mozes@silk.us>
Cc: David Moses <mosesster@gmail.com>; Michael Kelley <mikelley@microsoft.c=
om>; =FA=E5=EE=F8 =E0=E1=E5=E8=E1=E5=EC <tomer432100@gmail.com>; linux-hype=
rv@vger.kernel.org; linux-kernel@vger.kernel.org; Wei Liu <wei.liu@kernel.o=
rg>
Subject: Re: [PATCH] x86/hyper-v: guard against cpu mask changes in hyperv_=
flush_tlb_others()

Please use the "reply all" button in your mail client and  avoid
top-posting. It is very difficult for me to decipher this thread...

On Tue, Aug 17, 2021 at 09:16:45AM +0000, David Mozes wrote:
> Hi Michael and all .
> I am back from the Holiday and did your saggestiones /requstes=20
>=20
> 1. While  running with patch number-2 (disable the Hyper-V specific flush=
 routines)=20
>  As you suspected, we got panic similar to what we got with the Hyper-V s=
pecific flash routines.=20
> Below is the trace we got:=20
>=20
> 	[32097.577728] kernel BUG at kernel/sched/rt.c:1004!
> [32097.577738] invalid opcode: 0000 [#1] SMP
> [32097.578711] CPU: 45 PID: 51244 Comm: STAR4BLKS0_WORK Kdump: loaded Tai=
nted: G           OE     4.19.195-KM9 #1

It seems that you have out of tree module(s) loaded. Please make sure
they don't do anything unusual.

> [32097.578711] Hardware name: Microsoft Corporation Virtual Machine/Virtu=
al Machine, BIOS 090008  12/07/2018
> [32097.578711] RIP: 0010:dequeue_top_rt_rq+0x88/0xa0
> [32097.578711] Code: 00 48 89 d5 48 0f a3 15 6e 19 82 01 73 d0 48 89 c7 e=
8 bc b7 fe ff be 02 00 00 00 89 ef 84 c0 74 0b e8 2c 94 04 00 eb b6 0f 0b <=
0f> 0b e8 b1 93 04 00 eb ab 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00
> [32097.578711] RSP: 0018:ffff9442e0de7b48 EFLAGS: 00010046
> [32097.578711] RAX: ffff94809f9e1e00 RBX: ffff9448295e4c40 RCX: 00000000f=
fffffff
> [32097.578711] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff94809=
f9e2040
> [32097.578711] RBP: ffff94809f9e1e00 R08: fffffffffff0be25 R09: 000000000=
00216c0
> [32097.578711] R10: 00004bbc85e1eff3 R11: 0000000000000000 R12: 000000000=
0000000
> [32097.578711] R13: ffff9448295e4a20 R14: 0000000000021e00 R15: ffff94809=
fa21e00
> [32097.578711] FS:  00007f7b0cea0700(0000) GS:ffff94809f940000(0000) knlG=
S:0000000000000000
> [32097.578711] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [32097.578711] CR2: ffffffffff600400 CR3: 000000201d5b3002 CR4: 000000000=
03606e0
> [32097.578711] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [32097.578711] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [32097.578711] Call Trace:
> [32097.578711]  dequeue_rt_stack+0x3e/0x280
> [32097.578711]  dequeue_rt_entity+0x1f/0x70
> [32097.578711]  dequeue_task_rt+0x26/0x70
> [32097.578711]  push_rt_task+0x1e2/0x220
> [32097.578711]  push_rt_tasks+0x11/0x20
> [32097.578711]  __balance_callback+0x3b/0x60
> [32097.578711]  __schedule+0x6e9/0x830
> [32097.578711]  schedule+0x28/0x80

It looks like the scheduler is in an irrecoverable state. The stack
trace does not show anything related to TLB flush, so it is unclear to
me this has anything to do with the original report.

Have you tried running the same setup on baremetal?


> [32097.578711]  futex_wait_queue_me+0xb9/0x120
> [32097.578711]  futex_wait+0x139/0x250
> [32097.578711]  ? try_to_wake_up+0x54/0x460
> [32097.578711]  ? enqueue_task_rt+0x9f/0xc0
> [32097.578711]  ? get_futex_key+0x2ee/0x450
> [32097.578711]  do_futex+0x2eb/0x9f0
> [32097.578711]  __x64_sys_futex+0x143/0x180
> [32097.578711]  do_syscall_64+0x59/0x1b0
> [32097.578711]  ? prepare_exit_to_usermode+0x70/0x90
> [32097.578711]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [32097.578711] RIP: 0033:0x7fa2ae151334
> [32097.578711] Code: 66 0f 1f 44 00 00 41 52 52 4d 31 d2 ba 02 00 00 00 8=
1 f6 80 00 00 00 64 23 34 25 48 00 00 00 39 d0 75 07 b8 ca 00 00 00 0f 05 <=
89> d0 87 07 85 c0 75 f1 5a 41 5a c3 83 3d f1 df 20 00 00 74 59 48
> [32097.578711] RSP: 002b:00007f7b0ce9f3b0 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000000ca
> [32097.578711] RAX: ffffffffffffffda RBX: 00007f7c1da5bc18 RCX: 00007fa2a=
e151334
> [32097.578711] RDX: 0000000000000002 RSI: 0000000000000080 RDI: 00007f7c1=
da5bc58
> [32097.578711] RBP: 00007f7b0ce9f5b0 R08: 00007f7c1da5bc58 R09: 000000000=
000c82c
> [32097.578711] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7b1=
a149cf0
> [32097.578711] R13: 00007f7c1da5bc58 R14: 0000000000000001 R15: 000000000=
00005a1
>=20
>=20
> 2. as you requested and to help to the community  we running patch no 1 a=
s well :=20
>=20
> And that is what we got:=20
>=20
> 	Aug 17 05:36:22 10.230.247.7 [40544.392690] Hyper-V: ERROR_HYPERV: cpu_l=
ast=3D=20
>=20
> It looks like we got an empty cpumask ! =09

Assuming this is from the patch below, the code already handles empty
cpumask a few lines later.

You should perhaps move your change after that to right before cpus is
actually used.

Wei.

>=20
> Would you please let us know what father info you need and what Is the ne=
xt step for debugging this interesting issue=20
>=20
> Thx
> David=20
>=20
>=20
>=20
>=20
> >> 1) Print the cpumask when < num_possible_cpus():
> >> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> >> index e666f7eaf32d..620f656d6195 100644
> >> --- a/arch/x86/hyperv/mmu.c
> >> +++ b/arch/x86/hyperv/mmu.c
> >> @@ -60,6 +60,7 @@ static void hyperv_flush_tlb_others(const struct cpu=
mask *cpus,
> >>         struct hv_tlb_flush *flush;
> >>         u64 status =3D U64_MAX;
> >>         unsigned long flags;
> >> +       unsigned int cpu_last;
> >>=20
> >>         trace_hyperv_mmu_flush_tlb_others(cpus, info);
> >>=20
> >> @@ -68,6 +69,11 @@ static void hyperv_flush_tlb_others(const struct cp=
umask *cpus,
> >>=20
> >>         local_irq_save(flags);
> >>=20
> >> +       cpu_last =3D cpumask_last(cpus);
> >> +       if (cpu_last > num_possible_cpus()) {
> >=20
> > I think this should be ">=3D" since cpus are numbered starting at zero.
> > In your VM with 64 CPUs, having CPU #64 in the list would be error.
> >=20
> >> +               pr_emerg("ERROR_HYPERV: cpu_last=3D%*pbl", cpumask_pr_=
args(cpus));
> >> +       }
> >> +
> >>         /*
> >>          * Only check the mask _after_ interrupt has been disabled to =
avoid the
> >>          * mask changing under our feet.
> >>=20
