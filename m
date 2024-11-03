Return-Path: <linux-hyperv+bounces-3236-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3869BA408
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Nov 2024 06:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B985DB219D9
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Nov 2024 05:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188E37082D;
	Sun,  3 Nov 2024 05:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="btm/4LnG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010007.outbound.protection.outlook.com [52.103.12.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07932800;
	Sun,  3 Nov 2024 05:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730611045; cv=fail; b=mAVSeH4s9+ZQSIQCHJv57+AQM3IDP47rARwDL+1FHiuTdWNPi7/88nPKs7DxRDUQh5uYv/cIWcxzctGMPNFaC0cK5g0vNE8VhXsnhZjr+NFywOe8Ni4DtbN099t4Nsd7W5iPg0tMNSaQBLOJs+SQDN8PpaiIG9M1J2Rl8QQftUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730611045; c=relaxed/simple;
	bh=r6P3pMbBGEJTcRzSKYgr/OBCKv1O2w08A6PGpY/Hy0M=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kMsyAHQxYFgzd2yYkzbDnhVIkunxFtBJGKgEZt5n6CdIIqQZsJdvonNDEdvLNNyrKpPz3K8uQu1Se+S/7xkIFYu2lwnPeo3RvuUQoOtTMEh++9T4nMc0xyjDNWg+yh3xZ7xl16MZ8Rt5iNieVg5EyAwsSPIzr4mwhDf0hIWcDkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=btm/4LnG; arc=fail smtp.client-ip=52.103.12.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwpmEFJLOgRYfNikU3sibLz44wi4Fyh/POXbAajMlEkrGcFXTWF7Z938do/5dIg5TjPE9NrNtWhYutDkNYZ4EG/DkrUNsqazNRS98CIFskVXAC54gd2Le0SUxnuop8d0MxtpKDn8htIAHpNss1QrY1NslszgZcJSLVuzTJEOcvdQZbeKIKz3QRiJ75fkQ+Rq6osX2YPLtH3aFloMzUM6Y/d29glRntj1HYgQpXXBjsYZDLWBNie1R7awom5Cg4UXKsXenZbG2LXyreDwrTehey1qrxkMSrj3NgNOxxEP+CxcGR7wie0n+8Y40+a+jLlUjAoR636qkPROfy5E4U1qUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmeozByH8RMNCeaP/P9vlQwY3PfiKEGdG0YUumQRwU8=;
 b=JGrKACIEn/04ii1Mfr0CsE6LTQ76faivb7zY2/1yh9vOXx3yG9ttcfdNkeF/lVEhZlY4nbz30+ovRtSVKkMuAvRXbImB9KJrhGmBsqSh32dVz9CgdpDIt1ULfOlZrPmb4T0FJXYr2j57pFJ4/xhMRri5GlMAEA56tikq/Pkx3lHoVtVF4pTpO9Zj3RNo6oxQgxRFszi619StmLx8r3RjfDJ5AWIbINCE2Zlu8aZjyCsrRGQxvhOnr5pjR4a+SsPV61ApW0jtBlZyb+mgDZ1fDnve3rjz4sN2Af7wrTzimP85gFRqPU3YTl8SDYjA9jebpIRhkNfGeVmu2jp5P/vXNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmeozByH8RMNCeaP/P9vlQwY3PfiKEGdG0YUumQRwU8=;
 b=btm/4LnGZhgz51WSkWUymJBlHIZSbg13Y0j4at6DKGNI2V6lG01DM5b7nZlsPk72iKz7wHX8tj8s/PJrv30uZ0U2WqS0TfzndPjMEICKl8eBP/vjYwPFqhzhZbunyPJYyNOfXdFbT5vMd+HD1pQWs6sk8Erf1Ug1EsMMheCIrsSy1q1I8d5ENrYGlji6KmsdhJT7BJT9As6LUf91DJ6EPC3ee3nAKFVp+nueY/noJuxyX3nyH3XCyrpOUCJg3TRzSpIHPGabnNIzP/vuwsF63sAYPTcMK6ttgwoHuPAC8B9upZBEcT+PwV6Jqm6HuFTcn66pIn26OsrAf6SD3Zs4pw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7591.namprd02.prod.outlook.com (2603:10b6:510:4c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Sun, 3 Nov
 2024 05:17:19 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8114.015; Sun, 3 Nov 2024
 05:17:19 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "bentiss@kernel.org" <bentiss@kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Hyper-V HID driver failure in linux-next-20241101
Thread-Topic: Hyper-V HID driver failure in linux-next-20241101
Thread-Index: Adstr2ZrOEm4RxYkTg2DxiMQTFbBGw==
Date: Sun, 3 Nov 2024 05:17:19 +0000
Message-ID:
 <SN6PR02MB41573CDE3E478455D17837DED4502@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7591:EE_
x-ms-office365-filtering-correlation-id: 7571b182-41c9-4cfc-d68b-08dcfbc6ca55
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|8060799006|19110799003|461199028|15080799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OtlO2+rxiJF7mOuIlpcEK5u+GZukHTSlI+HxrsZ0pJGZWV6Pu1Sdw5YQUqld?=
 =?us-ascii?Q?INgkYIMP1FvXNtrXWWhj/n5dY8Npa3X+vIW9vSVmM3AX3KXzn+x8eDco9v1c?=
 =?us-ascii?Q?bLoXSOX5AJbDGWmn22w+hZZEQ5vMvbz+mnZRdGtBLQmSuZXNq81Dk/Dpjb/e?=
 =?us-ascii?Q?/LhjWyn1Nxt4bEUX8RnT3AMN77547s2TraPwgFgA9oWxG9sQuhzRD6qt0MQW?=
 =?us-ascii?Q?ao511VLMlP+KE6vTuDGvDwXzlzfBhue9jFVAPq89KHQvdJtMJNB7rm1AI58h?=
 =?us-ascii?Q?FLIqW7GG58pZvJMb7pVaRvUoqbRA4z0KfiVrPbB6LF0Qnr8D2ZxM4m13CpxZ?=
 =?us-ascii?Q?i09fYfbHfVzfJoUYbTTa3rksgdGhLSisqQSf3V2W8zi42b8N/sUpyIsU370B?=
 =?us-ascii?Q?/N7AxjJH8oriqNZUls0OJRjepzIucYrm3YsnFAVFwqg9hDep75eMrZT8MzVP?=
 =?us-ascii?Q?KSKC54j775VyQXVAmpq6pLVt8FBcSWSG6LJogr/T0NtqWD3+iyLgQtSl4UXP?=
 =?us-ascii?Q?RqDWZOm6iG6b98bU6G886/KxxBF18LVnTDSk4fgMvPT71OKKdgQxe9vb/T30?=
 =?us-ascii?Q?UmSmH1tn17iZXRKZ/P/NIPKH9wktctTWltcZDgKpnnWNy38OUjJyfz+AKl38?=
 =?us-ascii?Q?nDpEpTo9I02lIFB7S/f7E+nEiCuJLx8Qbe8w7dMMogKeMgPPh2F3oMjDSibC?=
 =?us-ascii?Q?CLdr+2WtMYorjHdlFJijd6iv3+IZSScIWtmQPS6oiFA5w54b+ETPTL6LqGBS?=
 =?us-ascii?Q?OtFF8ap9NrjyQS4Hrfiv5mrA1BJBMeVW8+LhYb4itjlAL2ZW2H8hl/IxcSLr?=
 =?us-ascii?Q?DwtqQyXeW1CpcEQt/VQESasqNyUZ/fs3Ouy5hZktv+6on7EydraaV+mzJwnL?=
 =?us-ascii?Q?YIXw1ZBvywnM2lzvnPBFq+6Q+VbZvdf8fu6XomHSAb0QOI/SGHXl61pxKkVC?=
 =?us-ascii?Q?rAhZlcsM09cNF4MkFI6Tm7aRWAp1GHosaeAaK3hzsKcbuQDOXUA0e0XkZH3n?=
 =?us-ascii?Q?CK+Cn4gcRg38oHo6lfBlrtCKiw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?roNlTxV/A/cNg0a21RNlDTDNOy8qm5U/1rfM1E18swNdtZoyawRHafYUmtTf?=
 =?us-ascii?Q?ouSfXXWUYSb+usKzcP3XsD/2UA8qWhRUoz+bx6auiJfEqZoL3EWpkuicll2c?=
 =?us-ascii?Q?n03aYVRh+3NIWAvZrCZOOwuEtBepCJcqPLwtvML36xNZAcHU7RXYeDfYC/mx?=
 =?us-ascii?Q?POl3VpWftoZ1k3ZTpe3pWuhumXz5Rc45MStvSuXL1Q6SmpYO2rHIWGP67Joe?=
 =?us-ascii?Q?NA4BoNcUXazMQDQz1cLYbNHug/1ARlZ+wv09RJfqrswLuYM8eQj5tvqwhx6K?=
 =?us-ascii?Q?9HIE3CVPxUrLiVIjXbKXFFMrNpVVwkfCk1LT9HfbPlk/5DvpmsoQCjwY+o4U?=
 =?us-ascii?Q?0Ca1FRtJI+h5WKTLbPePegV/lbhoK9X9bZMFh3KuqByREjnZLaDmOLKd1pYR?=
 =?us-ascii?Q?1I6TIKEqer7j2MV82ZmyRw3tycesdnxGA6EJS/DBy/Bmc8/vtvON4dEd7cLk?=
 =?us-ascii?Q?07DfY4IUgMcmgadfiJoAuBN1e41TOI0mUSHn/J/pmTBbzQJJjyzHEDnEE4j5?=
 =?us-ascii?Q?mxMBgC//gFYMGJNLaaeb2SXPjFqJKypH8kGOS64np0pJFs0V3naC5SewlI31?=
 =?us-ascii?Q?R1Haotbkm53WXExXLNrzKNm1s9s0GaFlAL3JXoOKq1i0EZBVc4gRKzc9cQC1?=
 =?us-ascii?Q?JtoGnuP3TYuLYhjJtSzHdjqWI/iIrTwjvmEdivghJtnVsdU60LUp9kho7z9Z?=
 =?us-ascii?Q?/KZuK1Dlxxbd/nyTbXiQO8lHTmVGw2vRJTEZ6kKrlxVOEN4D55xm/OiF/m90?=
 =?us-ascii?Q?0Pry3fp4UaAM+ns2/MZvSOKKrvpm9t7ObES1TwTXndw/gGGhcSQB+qrxNxyv?=
 =?us-ascii?Q?m8i5FwvUA8A9OU/c0Zcj6BJJgwgOsEl8LhrwbwBNW3MHEoAm0LbPoUi7+ZKu?=
 =?us-ascii?Q?KozfQ1q6Hjo4PEbVQgThK1Lhxnftds9amRwIBWxhkc7q7sxyg4VmKVUSA8Nq?=
 =?us-ascii?Q?9HioTnEMOvTz8ppESq0ZVqdeldLgrYMPzlkkWMMbgd8wobo6cm89ovq+7riU?=
 =?us-ascii?Q?5Ccc+Sf2fiyLBQBWwp6+/twebJD0fpYOXTOXaiHRpAf4dIrRFLmj4YBE7PlZ?=
 =?us-ascii?Q?PU4cPnqLHvGGJkOGvcPPhw4SF2JP4Ch9aywaDfkjw0C8kBwV4UIaXdlRAwsj?=
 =?us-ascii?Q?2BQuZuQdE1CEqvAttwRJ3dzIk8+Jfp8cSNZXG6NPwuX4JTgKRG41JJxFW5rf?=
 =?us-ascii?Q?nlTUgY67SdLWKC31uQv+vvU8CwuODfGyb4A2MoxcTqgENqW81iX7F/Ey20k?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7571b182-41c9-4cfc-d68b-08dcfbc6ca55
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2024 05:17:19.6197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7591

I was running the linux-next-20241101 kernel in a Hyper-V guest VM today,
and the Hyper-V guest HID (mouse) driver is failing to probe during boot.
I bisected the problem to commit 8b7fd6a15f8c:

    HID: bpf: move HID-BPF report descriptor fixup earlier

Without that commit, the good case probing output looks like this:

[    0.306586] hid: raw HID events driver (C) Jiri Kosina
[    0.357690] hv_vmbus: registering driver hid_hyperv
[    0.372669] input: Microsoft Vmbus HID-compliant Mouse as /devices/0006:=
045E:0621.0001/input/input1
[    0.373202] hid-generic 0006:045E:0621.0001: input: VIRTUAL HID v0.01 Mo=
use [Microsoft Vmbus HID-compliant Mouse] on

With that commit, the relevant probing output is this:

[    0.294685] hid: raw HID events driver (C) Jiri Kosina
[    0.295977] hv_vmbus: registering driver hid_hyperv
[    0.296957] ------------[ cut here ]------------
[    0.297086] WARNING: CPU: 0 PID: 11 at drivers/hid/hid-core.c:1234 hid_o=
pen_report+0x268/0x2f0 [hid]
[    0.297232] Modules linked in: hid_hyperv(E) hv_storvsc(E) hv_netvsc(E+)=
 hid(E) scsi_transport_fc(E) hv_utils(E) hyperv_keyboard(E) crct10dif_pclmu=
l(E) crc32_pclmul(E) ghash_clmulni_intel(E) sha512_ssse3(E) sha256_ssse3(E)=
 sha1_ssse3(E) hv_vmbus(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[    0.297694] CPU: 0 UID: 0 PID: 11 Comm: kworker/u32:0 Tainted: G        =
    E      6.12.0-rc1+ #11
[    0.297835] Tainted: [E]=3DUNSIGNED_MODULE
[    0.297997] Hardware name: Microsoft Corporation Virtual Machine/Virtual=
 Machine, BIOS Hyper-V UEFI Release v4.1 09/04/2024
[    0.298160] Workqueue: async async_run_entry_fn
[    0.298323] RIP: 0010:hid_open_report+0x268/0x2f0 [hid]
[    0.298509] Code: 35 49 8d bd d0 18 00 00 48 c7 c6 80 8c 72 c0 e8 fe a7 =
d4 f7 b8 ea ff ff ff e9 37 ff ff ff 0f 0b b8 f0 ff ff ff e9 53 ff ff ff <0f=
> 0b b8 ed ff ff ff e9 47 ff ff ff 4c 89 ef 89 45 b4 e8 c1 d7 ff
[    0.298953] RSP: 0018:ffffafd980093cc8 EFLAGS: 00010246
[    0.299139] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffb84=
46780
[    0.299325] RDX: 0000000000000000 RSI: 000000000000011b RDI: 00000000000=
00000
[    0.299516] RBP: ffffafd980093d18 R08: 0000000000000000 R09: 00000000000=
00001
[    0.299698] R10: 0000000000000092 R11: ffff958e815733f8 R12: ffff958e988=
f0000
[    0.299861] R13: ffff958e8905c000 R14: ffff958e8905c000 R15: ffff958e803=
a06c0
[    0.300045] FS:  0000000000000000(0000) GS:ffff958f87a00000(0000) knlGS:=
0000000000000000
[    0.300230] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.300424] CR2: 000056324c394f10 CR3: 00000001172d0000 CR4: 00000000003=
50ef0
[    0.301087] Call Trace:
[    0.301280]  <TASK>
[    0.301470]  ? show_regs+0x6b/0x80
[    0.301662]  ? __warn+0x97/0x160
[    0.301848]  ? hid_open_report+0x268/0x2f0 [hid]
[    0.302044]  ? report_bug+0x1bb/0x1d0
[    0.302228]  ? handle_bug+0x60/0xa0
[    0.302879]  ? exc_invalid_op+0x1d/0x80
[    0.303053]  ? asm_exc_invalid_op+0x1f/0x30
[    0.303230]  ? __pfx___device_attach_driver+0x10/0x10
[    0.303410]  ? hid_open_report+0x268/0x2f0 [hid]
[    0.303592]  ? hid_add_device+0x10c/0x2b0 [hid]
[    0.303780]  mousevsc_probe+0x1b4/0x230 [hid_hyperv]
[    0.303963]  vmbus_probe+0x3f/0xa0 [hv_vmbus]
[    0.304148]  really_probe+0xea/0x380
[    0.304327]  __driver_probe_device+0x7e/0x160
[    0.304507]  driver_probe_device+0x23/0xa0
[    0.304685]  __driver_attach_async_helper+0x40/0xa0
[    0.304866]  async_run_entry_fn+0x34/0x120
[    0.305043]  process_scheduled_works+0xa3/0x440
[    0.305351]  worker_thread+0x133/0x270
[    0.305541]  ? __pfx_worker_thread+0x10/0x10
[    0.305734]  kthread+0xf6/0x130
[    0.305920]  ? __pfx_kthread+0x10/0x10
[    0.306090]  ret_from_fork+0x3d/0x60
[    0.306245]  ? __pfx_kthread+0x10/0x10
[    0.306365]  ret_from_fork_asm+0x1a/0x30
[    0.306652]  </TASK>
[    0.306799] ---[ end trace 0000000000000000 ]---
[    0.306953] hid-generic 0006:045E:0621.0001: parse failed
[    0.307190] ------------[ cut here ]------------
[    0.307334] WARNING: CPU: 1 PID: 11 at drivers/base/devres.c:691 devres_=
release_group+0x107/0x120
[    0.307491] Modules linked in: hid_generic(E) hid_hyperv(E) hv_storvsc(E=
) hv_netvsc(E+) hid(E) scsi_transport_fc(E) hv_utils(E) hyperv_keyboard(E) =
crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) sha512_ssse3(E) =
sha256_ssse3(E) sha1_ssse3(E) hv_vmbus(E) aesni_intel(E) crypto_simd(E) cry=
ptd(E)
[    0.307945] CPU: 1 UID: 0 PID: 11 Comm: kworker/u32:0 Tainted: G        =
W   E      6.12.0-rc1+ #11
[    0.308101] Tainted: [W]=3DWARN, [E]=3DUNSIGNED_MODULE
[    0.308259] Hardware name: Microsoft Corporation Virtual Machine/Virtual=
 Machine, BIOS Hyper-V UEFI Release v4.1 09/04/2024
[    0.308419] Workqueue: async async_run_entry_fn
[    0.308579] RIP: 0010:devres_release_group+0x107/0x120
[    0.308736] Code: f8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 48 8b =
57 28 48 8d 47 28 48 39 c2 74 8f 48 8b 7f 08 48 39 f7 0f 85 6d ff ff ff <0f=
> 0b 4c 89 c6 4c 89 f7 45 31 ff e8 e9 4a 50 00 eb af e8 f2 5b 4f
[    0.309069] RSP: 0018:ffffafd980093ba0 EFLAGS: 00010046
[    0.309237] RAX: 0000000000000246 RBX: 0000000000000000 RCX: 00000000000=
00000
[    0.309407] RDX: 0000000000000001 RSI: ffff958e8905db70 RDI: ffff958e890=
5db70
[    0.309592] RBP: ffffafd980093be8 R08: 0000000000000246 R09: ffff958e81f=
c7d98
[    0.309765] R10: ffffafd980093b60 R11: ffff958e8023f718 R12: ffff958e890=
5d8d0
[    0.309940] R13: ffffafd980093ba8 R14: ffff958e8905db6c R15: ffff958e890=
5d8d0
[    0.310114] FS:  0000000000000000(0000) GS:ffff958f87a80000(0000) knlGS:=
0000000000000000
[    0.310293] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.310475] CR2: 000056324c398260 CR3: 00000001172d0000 CR4: 00000000003=
50ef0
[    0.310657] Call Trace:
[    0.310833]  <TASK>
[    0.310834]  ? show_regs+0x6b/0x80
[    0.311150]  ? __warn+0x97/0x160
[    0.311481]  ? devres_release_group+0x107/0x120
[    0.312169]  ? report_bug+0x1bb/0x1d0
[    0.313692]  ? handle_bug+0x60/0xa0
[    0.313894]  ? exc_invalid_op+0x1d/0x80
[    0.314132]  ? asm_exc_invalid_op+0x1f/0x30
[    0.314336]  ? devres_release_group+0x107/0x120
[    0.314541]  hid_device_remove+0x5b/0xb0 [hid]
[    0.314746]  device_remove+0x43/0x70
[    0.314947]  device_release_driver_internal+0xbd/0x140
[    0.315154]  device_release_driver+0x16/0x20
[    0.315353]  bus_remove_device+0xcf/0x130
[    0.315552]  device_del+0x16a/0x3c0
[    0.315750]  hid_destroy_device+0x69/0x80 [hid]
[    0.315948]  mousevsc_probe+0x19b/0x230 [hid_hyperv]
[    0.316146]  vmbus_probe+0x3f/0xa0 [hv_vmbus]
[    0.316338]  really_probe+0xea/0x380
[    0.316519]  __driver_probe_device+0x7e/0x160
[    0.316698]  driver_probe_device+0x23/0xa0
[    0.316874]  __driver_attach_async_helper+0x40/0xa0
[    0.317052]  async_run_entry_fn+0x34/0x120
[    0.317221]  process_scheduled_works+0xa3/0x440
[    0.317389]  worker_thread+0x133/0x270
[    0.317552]  ? __pfx_worker_thread+0x10/0x10
[    0.317707]  kthread+0xf6/0x130
[    0.317859]  ? __pfx_kthread+0x10/0x10
[    0.318019]  ret_from_fork+0x3d/0x60
[    0.318169]  ? __pfx_kthread+0x10/0x10
[    0.318317]  ret_from_fork_asm+0x1a/0x30
[    0.318464]  </TASK>
[    0.318610] ---[ end trace 0000000000000000 ]---
[    0.318884] hv_vmbus: probe failed for device 58f75a6d-d949-4320-99e1-a2=
a2576d581c (-19)

I'll do some additional debugging to try to narrow down what's going
wrong. I'm experienced with Linux guests on Hyper-V, but don't have
any existing knowledge of the hid-hyperv.c driver or how it interacts with
the hid-core.c code.  Nonetheless, I should be able to peel the onion a
bit more.

Benjamin -- if you have thoughts on what to look for, I would appreciate
any pointers that could save me some time. It's certainly possible that
there's a latent bug in how the Hyper-V HID driver interacts with the
HID core, so I'll look at both sides of the interaction.

Thanks,

Michael Kelley

