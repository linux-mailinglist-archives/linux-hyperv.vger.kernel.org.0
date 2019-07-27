Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95E67776B1
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Jul 2019 07:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfG0FHX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 27 Jul 2019 01:07:23 -0400
Received: from mail-eopbgr800109.outbound.protection.outlook.com ([40.107.80.109]:53152
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbfG0FHX (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 27 Jul 2019 01:07:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yfqcn5afrr04j/fkglWlnKXa6Ky855LrxJ0pIT9cWtGFQ77CAJN7OAPE+lztwVyEhT7EHx+H9OZ4lNtLrQQjLGxg9wmGhhsT6RmzgUWncTpR19bBoR+0F3Inww2Lm3y9KS5paNjehSo0mzfYe4lAlS//ZiY0I8lE8CmnOUCRawc/glJ+6yhBFljeaVg4emoDbGINg0Nam/wslCFuEtMmngyN95Y9dcGFowyZudmtFAGnrnWd7kBhRoiaH4T9XfzfDXUE5wLmuB8AGaNSrZYMRdrJdZNhuXV91jRC6PmFxQfJMkYFG1vNgwgckzBRy9o3GiCaNid4lKK62ApnIXD8uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZEqbAQQSSucyxz29ULziAmMQ2egzbuxduqf4vKyQbg=;
 b=LLO4fes9DZml+vR6ee0a0k59q8d0s5Q+0n6Ee8ILeQcgswt0v3rlMYa82HCPNI3wO2H2l53A4VLurvueZjOBYFgXnGLZzjpVFIDVb2UlCCJEed42Tci2hE07MHiJUN1twgT7AG4EJi0eINavdzueE/BGTfi/WrPc3CoZv801ulgcP0YcrVXaSgR0+1WvwtrcI1w8wM4/UthByOSL1I/7qBw80LABppmPj4fu/somQWpn59o3ZTkplLwOhIRlRLy+jVyrwnGFWLO8KEG3G0go/L3MPvfCK21dpdN0EhBR9YOAfN4AJJpHYtpOU+GTeYcqhyEgAduKzBxCtQeLH8CYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZEqbAQQSSucyxz29ULziAmMQ2egzbuxduqf4vKyQbg=;
 b=iDyQNF10RlY/tvsraVCnt+kNWtLIp0GeXANZyoUVqpsjRvJGWoE7b+aJCXEDI8eAcHBBNH7bF6fwPUh8Yflf0imLjFPcoEpwwdJXlslAHkRPrYvnUvArpALO/LIWJLt6WI9JndTS8nhFoaOFlRvrCoqBCwpuifR62jeLGy/XCRs=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1054.namprd21.prod.outlook.com (52.132.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.0; Sat, 27 Jul 2019 05:07:19 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d0c3:ba8d:dfe7:12f9]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d0c3:ba8d:dfe7:12f9%7]) with mapi id 15.20.2136.000; Sat, 27 Jul 2019
 05:07:19 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] clocksource/drivers: hyperv_timer: Fix CPU offlining by
 unbinding the timer
Thread-Topic: [PATCH] clocksource/drivers: hyperv_timer: Fix CPU offlining by
 unbinding the timer
Thread-Index: AQHVRDkqxpOba/RP5k2xyrvtHgPhPw==
Date:   Sat, 27 Jul 2019 05:07:19 +0000
Message-ID: <1564203996-29838-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:300:ee::21) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0deaeeb1-a835-4b45-ee6c-08d712504cae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR2101MB1054;
x-ms-traffictypediagnostic: SN6PR2101MB1054:|SN6PR2101MB1054:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR2101MB1054835B898E9619164FB2DDBFC30@SN6PR2101MB1054.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 01110342A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(199004)(189003)(14454004)(14444005)(256004)(2201001)(486006)(52116002)(10090500001)(6506007)(102836004)(99286004)(386003)(43066004)(186003)(26005)(3450700001)(6116002)(3846002)(22452003)(110136005)(54906003)(2906002)(316002)(7736002)(305945005)(71200400001)(71190400001)(8676002)(107886003)(5660300002)(6436002)(2501003)(81166006)(476003)(2616005)(6306002)(10290500003)(66066001)(66446008)(64756008)(66556008)(66476007)(66946007)(6486002)(86362001)(4326008)(68736007)(50226002)(6512007)(966005)(36756003)(53936002)(478600001)(1511001)(8936002)(4720700003)(25786009)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1054;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rj8SxYEYgm7V+UkJVQOTAh+CK/woo8qtIKqPxRVHXB2LWV+pEjQ/Ta6hyH3yKP6nYOA5cw3lU3vFSL46rn0EgW2HcLvBhibhFhiy5849W5mTmAZVv5IYVy62rIwPUr/GOPFRe7gXZTcwG0OdIwjeqUN8r1/Forv5+nwg0at1fjwy25otineCjpaQuZ0pMc4VvGMaZ6hellwIP+YIHiZNxz01SfVhJgoGxWheYO7MNGxUSv+l7dDT/WUrUgzcXg47kHRs008lIcvTKxlSw7gcbwM0abjxGjzIcz7Y7XTAxqXB9KOGIvjWYkghWmV6gtPWq2cr1vxUdZG5jx+j2LAoMGegydRBmQSh8t7qM2ra8r/rQ9N0bjy2phltc2Z6t4Qqg/NWmszh8GFv9PZHGOHVlWcdJ/7Y9/NThy9jd6glmlc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0deaeeb1-a835-4b45-ee6c-08d712504cae
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2019 05:07:19.2788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkmldc@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1054
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
 drivers/clocksource/hyperv_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyper=
v_timer.c
index 41c31a7ac0e4..8f3422c66cbb 100644
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

