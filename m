Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7EFEBE8D8
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2019 01:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfIYXTC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Sep 2019 19:19:02 -0400
Received: from mail-eopbgr810111.outbound.protection.outlook.com ([40.107.81.111]:51651
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbfIYXTC (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Sep 2019 19:19:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFLEX36xuv+KdsTI1bQcYOt6gXdW7cjV8VGxGIFzQUQnyW/bM+iL11D8oArcCeRgWtMEWktQuKpCkhOZyQ40SD9YCxK2giUz1D+IuJK2FGrErxW32kD3OxZvzFlQh/h5nbL5+zs3BoFGrEaNOJYUVHFvb58i/IiFIT3senK7MtkMtm+go0C/EILWnfi3stBpP514F1MlO5hFVnRpOqDqt7Of832UDpAni/6FJR/9LZXdQlQ54oF9QcyaDciNEqeZqpP0KNSClj5k3fvxYF2iyiesl9F133w6Q2pSGzMhZYWP5cQFAiMiFY839u+BpHBwrnDpfYW/qNaIVuel3m7twQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeiiXLUz0fmj7sw43hVNZwO3vA1UaowzRE9Kev7cGLg=;
 b=LyhxEKmYOwEBQwGbcUMRxJobn9CZCYznXJUiLae9dZCf08ypI7tso05iARQBiikuOsmxACmJ+sNsDZGwzKBqVRV3jXdi6Qe+l56uYuJjGqePbWALJx6JD0lz3EfUEZvh4JIR9pEfQcYOFXUSS69mOk/FCUEu3cJtSoIy1s9BLm+E4Lopy43hyJ/RdH0SPHC4C+j0/vctxtqLUFiJcVU/AzoRzjdYrFroGxzLP4WAU3WhstR1BTDKV9xZrR4Nzxb8P5/3tazoaQnw/5Xf9NTzjqftp0L+lx0YPGImGZxyXjd6FGakhEyKSrFZcr8yBLdxFouDTkJLu8tcGWOn6zK1cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeiiXLUz0fmj7sw43hVNZwO3vA1UaowzRE9Kev7cGLg=;
 b=RFXt8KJ8WJbaUfNiM5PK5pcJe4fimK+DY3dTVriDfXxaPEmh7uZ01J4xR/ftXYHDEc27tGikHSfKYvoy1gqqgTCphwWMLZwJzyMvZg4+X5tlv8IXiH8LZDfom8s4iRzmKFh4NKs02z2jwcPsiny5l0ttpOy6upOd5N6eXSYsOtk=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB0926.namprd21.prod.outlook.com (52.132.117.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.6; Wed, 25 Sep 2019 23:18:59 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::7d1a:ddb:3473:b383]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::7d1a:ddb:3473:b383%9]) with mapi id 15.20.2327.004; Wed, 25 Sep 2019
 23:18:59 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH][RESEND] clocksource/drivers: hyperv_timer: Fix CPU offlining
 by unbinding the timer
Thread-Topic: [PATCH][RESEND] clocksource/drivers: hyperv_timer: Fix CPU
 offlining by unbinding the timer
Thread-Index: AQHVc/ecbv5QrwA48EqrdEdWUjIEMQ==
Date:   Wed, 25 Sep 2019 23:18:59 +0000
Message-ID: <1569453525-41874-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0039.namprd12.prod.outlook.com
 (2603:10b6:301:2::25) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12b6d31d-1e4e-4418-2faf-08d7420ebe86
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR2101MB0926:|SN6PR2101MB0926:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <SN6PR2101MB09264A58F56408F55E82B867BF870@SN6PR2101MB0926.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(199004)(189003)(99286004)(256004)(8676002)(81166006)(8936002)(386003)(6506007)(14444005)(478600001)(966005)(102836004)(10290500003)(3450700001)(36756003)(7736002)(52116002)(4720700003)(3846002)(50226002)(6486002)(81156014)(6636002)(25786009)(5660300002)(43066004)(107886003)(2201001)(66946007)(66476007)(64756008)(66556008)(66446008)(71190400001)(2616005)(4326008)(476003)(6436002)(14454004)(2906002)(6116002)(305945005)(86362001)(66066001)(110136005)(6512007)(6306002)(26005)(316002)(1511001)(186003)(10090500001)(71200400001)(22452003)(2501003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0926;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Ea2UFSUQIZ9a9ZTkmcSUOv518ncNZFxpa0HS6xUkcBbQlM19BrAX8o38jRWJCvfSi2rcO/MPf7Zs6piLRkwz9+Tlu3TAOC1abO1L+mXSWOVnDGQUEX3aFKRKop5Lst0x3I07k0orLZtxN8lFW1n7D8ZK64BOly4EYMxRs7h4zsxw70tZKX7OksXSt3nU2p2sUL9FPlubq3koSYCEqCEZSQpLYrz4U7rRFg0XDA+/qv9yomDk5KT0m/YEKH1D40JI+iDJHirl2FsMS3IXmTeIpTpnv3zaCjN/cApd86zDQAbRPuSnPi1fHN7Y3A6pWBxRStkyCXHznfGzRd63HLLpBRXyA90EuEEXrGKqxjl18fnkWTq7FI66ITSfeiIOVHM2oRi0oLLSeMlIS5P8uMHPv7etaWifSuKI+MnL2bTJLCex6yhHHPLlN2YanlQL3Lr1MXubfaHPfyJhJP6vLABpA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b6d31d-1e4e-4418-2faf-08d7420ebe86
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 23:18:59.2813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8welkBKSr4yfy9yrF5Q7aCQGHtZALKiOiSl/iW/TW/F4JvQZWkcHMhccawqM0KvKLXYlYZjqDwuF5BLtHSdXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0926
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The commit fd1fea6834d0 says "No behavior is changed", but actually it
removes the clockevents_unbind_device() call from hv_synic_cleanup().

In the discussion earlier this month, I thought the unbind call is
unnecessary (see https://www.spinics.net/lists/arm-kernel/msg739888.html),
however, after more investigation, when a VM runs on Hyper-V, it turns out
the unbind call must be kept, otherwise CPU offling may not work, because
a per-cpu timer device is still needed, after hv_synic_cleanup() disables
the per-cpu Hyper-V timer device.

The issue is found in the hibernation test. These are the details:

1. CPU0 hangs in wait_for_ap_thread(), when trying to offline CPU1:

hibernation_snapshot
  create_image
    suspend_disable_secondary_cpus
      freeze_secondary_cpus
        _cpu_down(1, 1, CPUHP_OFFLINE)
          cpuhp_kick_ap_work
            cpuhp_kick_ap
              __cpuhp_kick_ap
                wait_for_ap_thread()

2. CPU0 hangs because CPU1 hangs this way: after CPU1 disables the per-cpu
Hyper-V timer device in hv_synic_cleanup(), CPU1 sets a timer... Please
read on to see how this can happen.

2.1 By "_cpu_down(1, 1, CPUHP_OFFLINE):", CPU0 first tries to move CPU1 to
the CPUHP_TEARDOWN_CPU state and this wakes up the cpuhp/1 thread on CPU1;
the thread is basically a loop of executing various callbacks defined in
the global array cpuhp_hp_states[]: see smpboot_thread_fn().

2.2 This is how a callback is called on CPU1:
  smpboot_thread_fn
    ht->thread_fn(td->cpu), i.e. cpuhp_thread_fun
      cpuhp_invoke_callback
        state =3D st->state
        st->state--
        cpuhp_get_step(state)->teardown.single()

2.3 At first, the state of CPU1 is CPUHP_ONLINE, which defines a
.teardown.single of NULL, so the execution of the code returns to the loop
in smpboot_thread_fn(), and then reruns cpuhp_invoke_callback() with a
smaller st->state.

2.4 The .teardown.single of every state between CPUHP_ONLINE and
CPUHP_TEARDOWN_CPU runs one by one.

2.5 When it comes to the CPUHP_AP_ONLINE_DYN range, hv_synic_cleanup()
runs: see vmbus_bus_init(). It calls hv_stimer_cleanup() ->
hv_ce_shutdown() to disable the per-cpu timer device, so timer interrupt
will no longer happen on CPU1.

2.6 Later, the .teardown.single of CPUHP_AP_SMPBOOT_THREADS, i.e.
smpboot_park_threads(), starts to run, trying to park all the other
hotplug_threads, e.g. ksoftirqd/1 and rcuc/1; here a timer can be set up
this way and the timer will never be fired since CPU1 doesn't have
an active timer device now, so CPU1 hangs and can not be offlined:
  smpboot_park_threads
    smpboot_park_thread
      kthread_park
        wait_task_inactive
          schedule_hrtimeout(&to, HRTIMER_MODE_REL)

With this patch, when the per-cpu Hyper-V timer device is disabled, the
system switches to the Local APIC timer, and the hang issue can not
happen.

Fixes: fd1fea6834d0 ("clocksource/drivers: Make Hyper-V clocksource ISA agn=
ostic")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

The patch was firstly posted on Jul 27: https://lkml.org/lkml/2019/7/27/5

There is no change since then.

 drivers/clocksource/hyperv_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyper=
v_timer.c
index ba2c79e6a0ee..17b96f9ed0c9 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -139,6 +139,7 @@ void hv_stimer_cleanup(unsigned int cpu)
 	/* Turn off clockevent device */
 	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
 		ce =3D per_cpu_ptr(hv_clock_event, cpu);
+		clockevents_unbind_device(ce, cpu);
 		hv_ce_shutdown(ce);
 	}
 }
--=20
2.19.1

