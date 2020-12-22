Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBB02E07C7
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Dec 2020 10:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgLVJOi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Dec 2020 04:14:38 -0500
Received: from mail-dm6nam12on2101.outbound.protection.outlook.com ([40.107.243.101]:21857
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbgLVJOg (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Dec 2020 04:14:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhUIjA2LeFcpxFO0KHbjpu/RSj0XJcpvsFmZET4/vePIDyxT0T+ieqDb09P3lAuTt37TCxoDtN7DpdhZDkcub0kFWqv6IfrdYMqF5q0d8sgp2nj8wmRk14SA+7FtEwtFYT4XGue9fLuQCOTuqi0KvvHbeJvx5yffjnW7dixA7/gl7NTHjKU7tb+Lngf83if/ki6zoSyZRt551QbbNpm2K4s/oHYLCveKI9n2fYYhmskalM3kmzGoB5ReJ3jCBf3rrNthmB4TahUTqvbMER4OFEBjeMP9zB9Ym6Zb+bZzvp3zBJlmAuQc3ze8DGpx+undvZ5H7AI3qPufFlnXzWJEaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MC60dDOgeMimCCFcZy4/a+M5Eesx8VqBzmRlBna/40=;
 b=a3tUWYHhwluM4KvMcZmY+GB3FRBBqNE5BGYC8Om9H781bQ8SRNUSgW5P/3AcHHo4kywz8dNj5rwkOfVew0H4CnwXKNiOmHn0Yt+qWwsvLSOv3horcLhS0D6+oPBN1hoZGCcU+so4cUXBVeO6ruMi/L2Q6JdXPLXUUjrcHZaxnme66tz/RVfEHR7nOnajil0qxnF54ywxAopg8mlck8Y0EESBR8jchMrnOaxxcnltLdSpudTWPI8mSM5hg7xGQIPSKQ8ax845cUDpSU+D9BPws8jL6OmG55uxRIWbf+z4JVNsTNR0S7Fvp4noeOODOJWRz5Wx6k+EnnKrEHqmHST6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MC60dDOgeMimCCFcZy4/a+M5Eesx8VqBzmRlBna/40=;
 b=azpNZW5nUA6KmB86x9gZxSyppb0+WbwMqInXi4N/GaNNQr4oiQqgSBdZyZX3GGKDuE/+llUlZXdtZ5YNwPlpyUA+yKrZGEfyy/lj62wyeTqJ4RTKmD3UmQcHb1YeZ8l6w0FnfhS4u+dzzc1dU2jqYxUwiw3yGszwlJdDa7OXA4o=
Received: from (2603:10b6:303:74::12) by
 MW2PR2101MB0892.namprd21.prod.outlook.com (2603:10b6:302:10::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.6; Tue, 22 Dec
 2020 09:13:47 +0000
Received: from MW4PR21MB1857.namprd21.prod.outlook.com
 ([fe80::f133:55b5:4633:c485]) by MW4PR21MB1857.namprd21.prod.outlook.com
 ([fe80::f133:55b5:4633:c485%5]) with mapi id 15.20.3721.008; Tue, 22 Dec 2020
 09:13:46 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: v5.10: sched_cpu_dying() hits BUG_ON during hibernation: kernel BUG
 at kernel/sched/core.c:7596!
Thread-Topic: v5.10: sched_cpu_dying() hits BUG_ON during hibernation: kernel
 BUG at kernel/sched/core.c:7596!
Thread-Index: AdbYQq18xc9NlU57RRyWL/lF+Wmp7A==
Date:   Tue, 22 Dec 2020 09:13:46 +0000
Message-ID: <MW4PR21MB1857BF96E59E75EF9CE406E2BFDF9@MW4PR21MB1857.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=38e1e0dd-4282-4e53-b0f5-663fe0e69371;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-22T08:24:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:3591:4820:2a8b:862]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f973f115-945a-47e5-00ae-08d8a659e32a
x-ms-traffictypediagnostic: MW2PR2101MB0892:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB08926634DC6D7E91C9688FE0BFDF9@MW2PR2101MB0892.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:312;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FSeVLtsVstIStL+MeSlKoD2P1kjxyitM+ADIu8U6B3KzdCRr2Q1b2/7VKc+/C8SFP9lirQ1xl05xeMq2+k8btsfNeH3mJqYVxeK86NomTGI0YWv8GfB/hOP5FVvBFVw8ulI4YhQmC3ac3Y7Ior3d/aYG8j3UanNn6QPcq4VelkoV1wDVZggnSGqJa0vVGBpncgOxVYtR7FG0kXXb0Hz7qOgB7/chcFlqSMTcvtVbvq4r/JfqDN9f20nZ3zC1H1JfdHRTqK7qGn90q5wgPhsIBid6JqyAiZn5qVvCcivK0h00ITb21cctJevTTHUb5aba96EubEE9Zo/eNS7xEnjy7NM7FpbP8LOtmqr9/ZZVDE5AbJQQg8CYvQxAkMifzkGMl/RkHgLFn6j/rGuYlnuQH7IHjyVeHLVzRRPzhtGrQTVnWoE06n1MQp3R7xrfQqQ6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB1857.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(54906003)(5660300002)(71200400001)(921005)(66556008)(186003)(7696005)(4326008)(2906002)(316002)(478600001)(76116006)(52536014)(8990500004)(83380400001)(55016002)(9686003)(8936002)(33656002)(7416002)(82960400001)(66476007)(8676002)(66946007)(82950400001)(110136005)(64756008)(6506007)(107886003)(66446008)(10290500003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IyXAh8fyJ/+Hu3biYZ7KsCFRrjSXbWMzFXcK3AbHzhQ4d9pkdSgiikOcRqua?=
 =?us-ascii?Q?jC4DQol08IrVImZ6vTOHCg/uiNbFYByViDMVmESDYlsjvODeHhJctnjMV4UH?=
 =?us-ascii?Q?sJyyQsaRaasv5jQY8UuW5e/83Mg4QF4mNe0Q6QNAC3h1aF8XR1B+qEPqVNIM?=
 =?us-ascii?Q?8F/yHHYzRUOG9B66FzMtOPioVL2fbgjQmhEkHbiqJfRU/Z1PUjXIDIzCxXBv?=
 =?us-ascii?Q?a9pZsErx8lPPD94NEiiexqPZv2djbyQLxpXurf5SlrgigD/e+ThgK4XWEWmd?=
 =?us-ascii?Q?4j6mkrmdSozTv+fE9tOaSb0nmpIM/dV2xt/FlrZFFgl5nADEc+xYMSCOG5ug?=
 =?us-ascii?Q?nyhD9enBK5Trbn6Q+iCECuoeWBM26PSiyhoWyhXmoV96lF09qNbqEF9oStg/?=
 =?us-ascii?Q?dgNkFN4a0U7GhayE8e0YjMtXgJiPtv2SBdSv9/o5AJw24cLg9Ds5bcl+yWyN?=
 =?us-ascii?Q?SeHD99p75yGFAnV5NZVRqy8r+C1pHC5Ai6KbmnxRpPsdVLFHRdw+BtxKfti2?=
 =?us-ascii?Q?scazIoV1QyCQqoLhvLU9ZY+Au9YA7SisfVuGoVgAfosZrSFIx6u22ctz13DH?=
 =?us-ascii?Q?eAc6hHFDXsFkqTyXs33Opp8T0yDOBWdVTenrZnNAu9Cq/dez41psTNg2yb4i?=
 =?us-ascii?Q?e0Zzj2LKe8yOk7yp8w5ZNBfjlkip8j/NWS9PmZ2bn1p0bJLXbA+sfuti2f1Y?=
 =?us-ascii?Q?SaXaL9hAvD9gj8OEwdFZtGgzUTjTgEzH1/o/1dUGgQhhKaas01DrN/SfAbbn?=
 =?us-ascii?Q?CoGpzFtCVYKKEOnsGeuvnR5XnSviuDXszlN0T5RA8SLmG+LMUZM2xkj4u+e0?=
 =?us-ascii?Q?HFXMr1en2VqU9hYbT5IoH6koal19mSwjV47RMtVAWZGMlyHw96dVKCsZQHSG?=
 =?us-ascii?Q?wmPygojXjT2n9fw7wUG2VZl8G+zR+GO1oIXaLw5N4IPtKduYnLJEjKSDqtdE?=
 =?us-ascii?Q?qQHv6CuvEhP+oMsq2j39eBA1J+YwJsmAGnbk2GyfoD70NavBYKc9JOFCo7Ko?=
 =?us-ascii?Q?g2/DvquBvDkLM++pb47DY6s7SlVKxl3zEDSQoq3H5yY3qFI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB1857.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f973f115-945a-47e5-00ae-08d8a659e32a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2020 09:13:46.5012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Rz6iUkLBUwad7MAwXqKlqNKH81obsWwziSxiVGqTP5D/NTWL3TBz0223/6xSb/oGF3IEWTHrp4j8T87OaBMFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0892
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,
I'm running a Linux VM with the recent mainline (48342fc07272, 12/20/2020) =
on Hyper-V.
When I test hibernation, the VM can easily hit the below BUG_ON during the =
resume
procedure (I estimate this can repro about 1/5 of the time). BTW, my VM has=
 40 vCPUs.

I can't repro the BUG_ON with v5.9.0, so I suspect something in v5.10.0 may=
 be broken?

In v5.10.0, when the BUG_ON happens, rq->nr_running=3D=3D2, and rq->nr_pinn=
ed=3D=3D0:

7587 int sched_cpu_dying(unsigned int cpu)
7588 {
7589         struct rq *rq =3D cpu_rq(cpu);
7590         struct rq_flags rf;
7591
7592         /* Handle pending wakeups and then migrate everything off */
7593         sched_tick_stop(cpu);
7594
7595         rq_lock_irqsave(rq, &rf);
7596         BUG_ON(rq->nr_running !=3D 1 || rq_has_pinned_tasks(rq));
7597         rq_unlock_irqrestore(rq, &rf);
7598
7599         calc_load_migrate(rq);
7600         update_max_interval();
7601         nohz_balance_exit_idle(rq);
7602         hrtick_clear(rq);
7603         return 0;
7604 }

The last commit that touches the BUG_ON line is the commit
3015ef4b98f5 ("sched/core: Make migrate disable and CPU hotplug cooperative=
")
but the commit looks good to me.

Any idea?

Thanks,
-- Dexuan

[    5.383378] PM: Image signature found, resuming
[    5.388027] PM: hibernation: resume from hibernation
[    5.395794] Freezing user space processes ... (elapsed 0.001 seconds) do=
ne.
[    5.397058] OOM killer disabled.
[    5.397059] Freezing remaining freezable tasks ... (elapsed 0.001 second=
s) done.
[    5.413013] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x000=
00fff]
[    5.419331] PM: hibernation: Marking nosave pages: [mem 0x0009f000-0x000=
fffff]
[    5.425502] PM: hibernation: Marking nosave pages: [mem 0xf7ff0000-0xfff=
fffff]
[    5.431706] PM: hibernation: Basic memory bitmaps created
[    5.465205] PM: Using 3 thread(s) for decompression
[    5.469590] PM: Loading and decompressing image data (505553 pages)...
[    5.492790] PM: Image loading progress:   0%
[    6.532641] PM: Image loading progress:  10%
[    6.899683] PM: Image loading progress:  20%
[    7.251672] PM: Image loading progress:  30%
[    7.598808] PM: Image loading progress:  40%
[    8.056153] PM: Image loading progress:  50%
[    8.534077] PM: Image loading progress:  60%
[    9.029886] PM: Image loading progress:  70%
[    9.542015] PM: Image loading progress:  80%
[   10.025326] PM: Image loading progress:  90%
[   10.525804] PM: Image loading progress: 100%
[   10.530241] PM: Image loading done
[   10.533295] PM: hibernation: Read 2022212 kbytes in 5.05 seconds (400.43=
 MB/s)
[   10.540827] PM: Image successfully loaded
[   10.599243] serial 00:04: disabled
[   10.619935] vmbus 242ff919-07db-4180-9c2e-b86cb68c8c55: parent VMBUS:01 =
should not be sleeping
[   10.646542] Disabling non-boot CPUs ...
[   10.694380] smpboot: CPU 1 is now offline
[   10.729044] smpboot: CPU 2 is now offline
[   10.756819] smpboot: CPU 3 is now offline
[   10.776784] smpboot: CPU 4 is now offline
[   10.800866] smpboot: CPU 5 is now offline
[   10.828923] smpboot: CPU 6 is now offline
[   10.849013] smpboot: CPU 7 is now offline
[   10.876722] smpboot: CPU 8 is now offline
[   10.909426] smpboot: CPU 9 is now offline
[   10.929360] smpboot: CPU 10 is now offline
[   10.957059] smpboot: CPU 11 is now offline
[   10.976542] smpboot: CPU 12 is now offline
[   11.008470] smpboot: CPU 13 is now offline
[   11.036356] smpboot: CPU 14 is now offline
[   11.072396] smpboot: CPU 15 is now offline
[   11.100229] smpboot: CPU 16 is now offline
[   11.128638] smpboot: CPU 17 is now offline
[   11.148479] smpboot: CPU 18 is now offline
[   11.173537] smpboot: CPU 19 is now offline
[   11.205680] smpboot: CPU 20 is now offline
[   11.231799] smpboot: CPU 21 is now offline
[   11.259562] smpboot: CPU 22 is now offline
[   11.288672] smpboot: CPU 23 is now offline
[   11.319691] smpboot: CPU 24 is now offline
[   11.355523] smpboot: CPU 25 is now offline
[   11.399469] smpboot: CPU 26 is now offline
[   11.435438] smpboot: CPU 27 is now offline
[   11.471402] smpboot: CPU 28 is now offline
[   11.515488] smpboot: CPU 29 is now offline
[   11.551355] smpboot: CPU 30 is now offline
[   11.591326] smpboot: CPU 31 is now offline
[   11.624004] smpboot: CPU 32 is now offline
[   11.659326] smpboot: CPU 33 is now offline
[   11.687478] smpboot: CPU 34 is now offline
[   11.719243] smpboot: CPU 35 is now offline
[   11.747252] smpboot: CPU 36 is now offline
[   11.771224] smpboot: CPU 37 is now offline
[   11.795089] ------------[ cut here ]------------
[   11.798052] kernel BUG at kernel/sched/core.c:7596!
[   11.798052] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[   11.798052] CPU: 38 PID: 202 Comm: migration/38 Tainted: G            E =
    5.10.0+ #6
[   11.798052] Hardware name: Microsoft Corporation Virtual Machine/Virtual=
 Machine, BIOS 090008  12/07/2018
[   11.798052] Stopper: multi_cpu_stop+0x0/0xf0 <- 0x0
[   11.798052] RIP: 0010:sched_cpu_dying+0xa3/0xc0
[   11.798052] Code: 73 85 05 00 84 c0 75 12 48 83 c4 08 31 c0 5b c3 f0 48 =
01 05 af f4 7e ...
[   11.798052] RSP: 0000:ffffbb3c820bfde0 EFLAGS: 00010002
[   11.798052] RAX: 0000000000000082 RBX: ffff94f83acaac40 RCX: 00000000000=
00000
[   11.798052] RDX: 0000000000000001 RSI: 000000000000005a RDI: 00000000000=
00001
[   11.798052] RBP: 0000000000000026 R08: 0000000000000000 R09: 00000000000=
00000
[   11.798052] R10: 000000000000000b R11: ffffffff89cbed88 R12: ffffffff88a=
a7ed0
[   11.798052] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00003
[   11.798052] FS:  0000000000000000(0000) GS:ffff94f83ac80000(0000) knlGS:=
0000000000000000
[   11.798052] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.798052] CR2: 0000000000000000 CR3: 00000001144fa002 CR4: 00000000003=
706e0
[   11.798052] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   11.798052] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   11.798052] Call Trace:
[   11.798052]  ? rcutree_dying_cpu+0x12/0x30
[   11.798052]  cpuhp_invoke_callback+0x82/0x4a0
[   11.798052]  take_cpu_down+0x67/0xa0
[   11.798052]  multi_cpu_stop+0x64/0xf0
[   11.798052]  ? stop_machine_yield+0x10/0x10
[   11.798052]  cpu_stopper_thread+0x95/0x130
[   11.798052]  ? sort_range+0x20/0x20
[   11.798052]  smpboot_thread_fn+0x198/0x230
[   11.798052]  kthread+0x13d/0x160
[   11.798052]  ? kthread_create_on_node+0x60/0x60
[   11.798052]  ret_from_fork+0x22/0x30
[   11.798052] Modules linked in: hv_utils(E) cn(E) hid_generic(E) ...
[   11.798052] ---[ end trace 9f1a31ebcf9c45a1 ]---
[   11.798052] RIP: 0010:sched_cpu_dying+0xa3/0xc0
[   11.798052] Code: 73 85 05 00 84 c0 75 12 48 83 c4 08 31 c0 5b c3 f0 48 =
01 05 af f4 7e ...
[   11.798052] RSP: 0000:ffffbb3c820bfde0 EFLAGS: 00010002
[   11.798052] RAX: 0000000000000082 RBX: ffff94f83acaac40 RCX: 00000000000=
00000
[   11.798052] RDX: 0000000000000001 RSI: 000000000000005a RDI: 00000000000=
00001
[   11.798052] RBP: 0000000000000026 R08: 0000000000000000 R09: 00000000000=
00000
[   11.798052] R10: 000000000000000b R11: ffffffff89cbed88 R12: ffffffff88a=
a7ed0
[   11.798052] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00003
[   11.798052] FS:  0000000000000000(0000) GS:ffff94f83ac80000(0000) knlGS:=
0000000000000000
[   11.798052] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.798052] CR2: 0000000000000000 CR3: 00000001144fa002 CR4: 00000000003=
706e0
[   11.798052] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   11.798052] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   11.798052] note: migration/38[202] exited with preempt_count 2

