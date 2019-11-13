Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 113DBF9FEB
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Nov 2019 02:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfKMBLy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Nov 2019 20:11:54 -0500
Received: from mail-eopbgr760127.outbound.protection.outlook.com ([40.107.76.127]:23271
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbfKMBLx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Nov 2019 20:11:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYDLOxq8zxlEQNfcAPp8OGyYiQkDj2IfAM7arvxaCPk1kgVuZkgQf+YgVI1FxLRupJBDzZ/mW7aormDsXBpOiF4+qqoagjEBVTC7AL3zuyS+68eiEhy7pqEIScj4L+zXju16C+YjO1e9TowSeqe3kvruyynIbHWXIcyhxeIRkJDTsnfLHMsjNrBzdzcicgWrMCJpeSMS0yzpNmOVw0rhSWtbGY+wEFy5nvQBCXAl9gRcp3lBJyz8N8yEORu+d6r6cwVi/TJvL4zOH4pqhY7FVgK0RQo1xqQoG7nXzZ08l73fXwiWV1pNcHalkscxuwdhYux+ZQ+b2VYEY0LcMU5CeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exiP9koMBO2TFRZo7Fpb8HtlvUUfkBkAQomjQeK9AWk=;
 b=YWLz9tYq8vjczjS6ZH6jZZFBIdS8jM7LV3UygnavfAPmOfo0ik5wOPlJkeXn77mjxAaGTop8zCCSzUnO4nu6J2qCW7DIN0O9QTzu0EOwepM5GYD/GZyoGCoTB3+0Xdr/a8acIw5kVvD8WVL8PEzvfjS0/+P63MrPyE/6w6mOBFH4C54jy0KMLceujvPLLjAM4879xdooz2JnsmAEhevvncn7rfE+PSksxeugA8PoH/cilEx0T3bLw8mjiudZAmNIMbJH80vLboZ+oKB2nTKlnewBTtn7jl4YXm3e/449+eBj91WyOqwxlccqloUQTdwlQuHlLDx3ltbNJa2hdbmhvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exiP9koMBO2TFRZo7Fpb8HtlvUUfkBkAQomjQeK9AWk=;
 b=i6rWlmEAmLJcUSZg5V0vAcXG7rA+KgFUmTcS1I/VHq0c6XqQ3PRb3I9dt01b32j8bgJipN0AGEWNMe1RFSzxjIF2tNNysqY8c9mFoRxo7/XrQ/ytM84ETdMVHZmLp5kaec8rUlU/NSM6gKVmZCi7UHNmLIDT6mtDRsqAexqq3aQ=
Received: from SN6PR2101MB1135.namprd21.prod.outlook.com (52.132.114.24) by
 SN6PR2101MB0989.namprd21.prod.outlook.com (52.132.114.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.15; Wed, 13 Nov 2019 01:11:49 +0000
Received: from SN6PR2101MB1135.namprd21.prod.outlook.com
 ([fe80::185e:548e:7cc4:942e]) by SN6PR2101MB1135.namprd21.prod.outlook.com
 ([fe80::185e:548e:7cc4:942e%9]) with mapi id 15.20.2451.018; Wed, 13 Nov 2019
 01:11:49 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        vkuznets <vkuznets@redhat.com>, Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "Ganapatrao.Kulkarni@cavium.com" <Ganapatrao.Kulkarni@cavium.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "josephl@nvidia.com" <josephl@nvidia.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v2 1/1] x86/hyperv: Initialize clockevents earlier in CPU
 onlining
Thread-Topic: [PATCH v2 1/1] x86/hyperv: Initialize clockevents earlier in CPU
 onlining
Thread-Index: AQHVmb9TAIfD7Ra2tkqgwSg/PXh9yw==
Date:   Wed, 13 Nov 2019 01:11:49 +0000
Message-ID: <1573607467-9456-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0125.namprd04.prod.outlook.com
 (2603:10b6:104:7::27) To SN6PR2101MB1135.namprd21.prod.outlook.com
 (2603:10b6:805:4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [131.107.147.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66eedb15-c64c-42c2-f312-08d767d6759a
x-ms-traffictypediagnostic: SN6PR2101MB0989:|SN6PR2101MB0989:|SN6PR2101MB0989:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN6PR2101MB0989363E081E5DB481FFC1CCD7760@SN6PR2101MB0989.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(189003)(107886003)(66946007)(2201001)(10090500001)(86362001)(110136005)(3846002)(316002)(6116002)(6486002)(305945005)(22452003)(2906002)(476003)(4326008)(2616005)(66446008)(64756008)(66556008)(6436002)(66476007)(486006)(7736002)(2501003)(6512007)(71190400001)(186003)(256004)(71200400001)(1511001)(52116002)(30864003)(478600001)(4720700003)(10290500003)(102836004)(8676002)(386003)(26005)(6506007)(81166006)(81156014)(5660300002)(14444005)(7416002)(50226002)(99286004)(36756003)(66066001)(8936002)(25786009)(14454004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0989;H:SN6PR2101MB1135.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wknUcPaPYotYEzwYCrTi2/9pd0WgT9fDAsoIKIOg+V0CesVnmSFMxHjy3kfC3wfvxm+kLQcXjJoNyrYSTNGZetUOdW7THjQZf0RaEfwWBP7wXeN85gbSOom7IwGVUsfE70VAuK06jmo24P4C5WUV4JbSGRknctxHKiGeqA0neMlNfTuZl0BEcEENucK9B79vvfhr3GSprN2H+izcOZh6gpOUfzmVGcDCB/zphQpMKmV7FgapnUEvc5WYOVnx7iVesSdD+ySqWs7jMfW+WnUF0IXxj3SqdMyR8BQyoNeD+z7Dnco/yq/QEA4G0yUZphKLY4iMEs0GiZMviSJvNwS+UdEdilTXjpxJz65+P4dGpL3g/gr/Za5+avpYzy3C8rLEdNMDl59nyvdNrOoMDxgH10unB62kC0k3skjPK+sth2OgWgEPd/Yx7Y0AAN+rS/B2
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66eedb15-c64c-42c2-f312-08d767d6759a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 01:11:49.1385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6v1lYMSqY2fTfaqBrmg4QinP/cH0SlSxSQJv8Yx0DiLMEe+wAgroZ0Ai5tvmiVdK4lE0RH8XN13aZ9uN0rH2hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0989
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V has historically initialized stimer-based clockevents late
in the process of onlining a CPU because clockevents depend on
stimer interrupts. In the original Hyper-V design, stimer
interrupts generate a VMbus message, so the VMbus machinery must
be running first, and VMbus can't be initialized until relatively
late. On x86/64, LAPIC timer based clockevents are used during early
initialization before VMbus and stimer-based clockevents are ready,
and again during CPU offlining after the stimer clockevents have been
shut down.

Unfortunately, this design creates problems when offling CPUs for
hibernation or other purposes. stimer-based clockevents are shut
down relatively early in the offlining process, so
clockevents_unbind_device() must be used to fallback to the
LAPIC-based clockevents for the remainder of the offlining process.
Furthermore, the late initialization and early shutdown of
stimer-based clockevents doesn't work well on ARM64 since there
is no other timer like the LAPIC to fallback to. So CPU onlining and
offlining doesn't work properly.

Fix this by recognizing that stimer Direct Mode is the normal path
for newer versions of Hyper-V on x86/64, and the only path on other
architectures. With stimer Direct Mode, stimer interrupts don't
require any VMbus machinery. stimer clockevents can be initialized
and shut down consistent with how it is done for other clockevent
devices. While the old VMbus-based stimer interrupts must still
be supported for backward compatibility on x86, that mode of
operation can be treated as legacy.

So add a new Hyper-V stimer entry in the CPU hotplug state
list, and use that new state when in Direct Mode. Update the
Hyper-V clocksource driver to allocate and initialize stimer
clockevents earlier during boot. Update Hyper-V initialization
and the VMbus driver to use this new design. As a result,
the LAPIC timer is no longer used during boot or CPU
onlining/offlining and clockevents_unbind_device() is not
called.  But retain the old design as a legacy implementation
for older versions of Hyper-V that don't support Direct Mode.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---

Changes in v2 [all from Dexuan Cui]:
* Tweaked hv_stimer_alloc() so errors can be ignored on x86,
  since a fallback to LAPIC timer clockevents will happen
* Fixed handling of return value from cpuhp_setup_state()
* Fixed hv_stimer_cleanup() to skip redundant call to
  hv_ce_shutdown() when clockevents_unbind_device() is called
* Fixed hv_stimer_global_cleanup() to allow hv_stimer_free() and
  the cpuhp state mechanism stop the stimer on all CPUs instead
  of looping through the CPUs
* Re-added the call to hv_stimer_cleanup() in hv_crash_handler().
  A separate patch will fix the problem that hv_synic_cleanup()
  doesn't actually do anything in many cases because a channel
  interrupt is assigned to the CPU.

---
 arch/x86/hyperv/hv_init.c          |   6 ++
 drivers/clocksource/hyperv_timer.c | 154 +++++++++++++++++++++++++++++----=
----
 drivers/hv/hv.c                    |   4 +-
 drivers/hv/vmbus_drv.c             |  30 ++++----
 include/clocksource/hyperv_timer.h |   7 +-
 include/linux/cpuhotplug.h         |   1 +
 6 files changed, 151 insertions(+), 51 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index b2daf0e..426dc8b 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -319,6 +319,12 @@ void __init hyperv_init(void)
 	hypercall_msr.guest_physical_address =3D vmalloc_to_pfn(hv_hypercall_pg);
 	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
=20
+	/*
+	 * Ignore any errors in setting up stimer clockevents
+	 * as we can run with the LAPIC timer as a fallback.
+	 */
+	(void)hv_stimer_alloc();
+
 	hv_apic_init();
=20
 	x86_init.pci.arch_init =3D hv_pci_init;
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyper=
v_timer.c
index 2317d4e..9b99a79 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -17,6 +17,7 @@
 #include <linux/clocksource.h>
 #include <linux/sched_clock.h>
 #include <linux/mm.h>
+#include <linux/cpuhotplug.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
@@ -30,6 +31,15 @@
  * mechanism is used when running on older versions of Hyper-V
  * that don't support Direct Mode. While Hyper-V provides
  * four stimer's per CPU, Linux uses only stimer0.
+ *
+ * Because Direct Mode does not require processing a VMbus
+ * message, stimer interrupts can be enabled earlier in the
+ * process of booting a CPU, and consistent with when timer
+ * interrupts are enabled for other clocksource drivers.
+ * However, for legacy versions of Hyper-V when Direct Mode
+ * is not enabled, setting up stimer interrupts must be
+ * delayed until VMbus is initialized and can process the
+ * interrupt message.
  */
 static bool direct_mode_enabled;
=20
@@ -102,17 +112,12 @@ static int hv_ce_set_oneshot(struct clock_event_devic=
e *evt)
 /*
  * hv_stimer_init - Per-cpu initialization of the clockevent
  */
-void hv_stimer_init(unsigned int cpu)
+static int hv_stimer_init(unsigned int cpu)
 {
 	struct clock_event_device *ce;
=20
-	/*
-	 * Synthetic timers are always available except on old versions of
-	 * Hyper-V on x86.  In that case, just return as Linux will use a
-	 * clocksource based on emulated PIT or LAPIC timer hardware.
-	 */
-	if (!(ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE))
-		return;
+	if (!hv_clock_event)
+		return 0;
=20
 	ce =3D per_cpu_ptr(hv_clock_event, cpu);
 	ce->name =3D "Hyper-V clockevent";
@@ -127,28 +132,55 @@ void hv_stimer_init(unsigned int cpu)
 					HV_CLOCK_HZ,
 					HV_MIN_DELTA_TICKS,
 					HV_MAX_MAX_DELTA_TICKS);
+	return 0;
 }
-EXPORT_SYMBOL_GPL(hv_stimer_init);
=20
 /*
  * hv_stimer_cleanup - Per-cpu cleanup of the clockevent
  */
-void hv_stimer_cleanup(unsigned int cpu)
+int hv_stimer_cleanup(unsigned int cpu)
 {
 	struct clock_event_device *ce;
=20
-	/* Turn off clockevent device */
-	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
-		ce =3D per_cpu_ptr(hv_clock_event, cpu);
+	if (!hv_clock_event)
+		return 0;
+
+	/*
+	 * In the legacy case where Direct Mode is not enabled
+	 * (which can only be on x86/64), stimer cleanup happens
+	 * relatively early in the CPU offlining process. We
+	 * must unbind the stimer-based clockevent device so
+	 * that the LAPIC timer can take over until clockevents
+	 * are no longer needed in the offlining process. Note
+	 * that clockevents_unbind_device() eventually calls
+	 * hv_ce_shutdown().
+	 *
+	 * The unbind should not be done when Direct Mode is
+	 * enabled because we may be on an architecture where
+	 * there are no other clockevent devices to fallback to.
+	 */
+	ce =3D per_cpu_ptr(hv_clock_event, cpu);
+	if (direct_mode_enabled)
 		hv_ce_shutdown(ce);
-	}
+	else
+		clockevents_unbind_device(ce, cpu);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(hv_stimer_cleanup);
=20
 /* hv_stimer_alloc - Global initialization of the clockevent and stimer0 *=
/
-int hv_stimer_alloc(int sint)
+int hv_stimer_alloc(void)
 {
-	int ret;
+	int ret =3D 0;
+
+	/*
+	 * Synthetic timers are always available except on old versions of
+	 * Hyper-V on x86.  In that case, return as error as Linux will use a
+	 * clockevent based on emulated LAPIC timer hardware.
+	 */
+	if (!(ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE))
+		return -EINVAL;
=20
 	hv_clock_event =3D alloc_percpu(struct clock_event_device);
 	if (!hv_clock_event)
@@ -159,22 +191,78 @@ int hv_stimer_alloc(int sint)
 	if (direct_mode_enabled) {
 		ret =3D hv_setup_stimer0_irq(&stimer0_irq, &stimer0_vector,
 				hv_stimer0_isr);
-		if (ret) {
-			free_percpu(hv_clock_event);
-			hv_clock_event =3D NULL;
-			return ret;
-		}
+		if (ret)
+			goto free_percpu;
+
+		/*
+		 * Since we are in Direct Mode, stimer initialization
+		 * can be done now with a CPUHP value in the same range
+		 * as other clockevent devices.
+		 */
+		ret =3D cpuhp_setup_state(CPUHP_AP_HYPERV_TIMER_STARTING,
+				"clockevents/hyperv/stimer:starting",
+				hv_stimer_init, hv_stimer_cleanup);
+		if (ret < 0)
+			goto free_stimer0_irq;
 	}
+	return ret;
=20
-	stimer0_message_sint =3D sint;
-	return 0;
+free_stimer0_irq:
+	hv_remove_stimer0_irq(stimer0_irq);
+	stimer0_irq =3D 0;
+free_percpu:
+	free_percpu(hv_clock_event);
+	hv_clock_event =3D NULL;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(hv_stimer_alloc);
=20
+/*
+ * hv_stimer_legacy_init -- Called from the VMbus driver to handle
+ * the case when Direct Mode is not enabled, and the stimer
+ * must be initialized late in the CPU onlining process.
+ *
+ */
+void hv_stimer_legacy_init(unsigned int cpu, int sint)
+{
+	if (direct_mode_enabled)
+		return;
+
+	/*
+	 * This function gets called by each vCPU, so setting the
+	 * global stimer_message_sint value each time is conceptually
+	 * not ideal, but the value passed in is always the same and
+	 * it avoids introducing yet another interface into this
+	 * clocksource driver just to set the sint in the legacy case.
+	 */
+	stimer0_message_sint =3D sint;
+	(void)hv_stimer_init(cpu);
+}
+EXPORT_SYMBOL_GPL(hv_stimer_legacy_init);
+
+/*
+ * hv_stimer_legacy_cleanup -- Called from the VMbus driver to
+ * handle the case when Direct Mode is not enabled, and the
+ * stimer must be cleaned up early in the CPU offlining
+ * process.
+ */
+void hv_stimer_legacy_cleanup(unsigned int cpu)
+{
+	if (direct_mode_enabled)
+		return;
+	(void)hv_stimer_cleanup(cpu);
+}
+EXPORT_SYMBOL_GPL(hv_stimer_legacy_cleanup);
+
+
 /* hv_stimer_free - Free global resources allocated by hv_stimer_alloc() *=
/
 void hv_stimer_free(void)
 {
-	if (direct_mode_enabled && (stimer0_irq !=3D 0)) {
+	if (!hv_clock_event)
+		return;
+
+	if (direct_mode_enabled) {
+		cpuhp_remove_state(CPUHP_AP_HYPERV_TIMER_STARTING);
 		hv_remove_stimer0_irq(stimer0_irq);
 		stimer0_irq =3D 0;
 	}
@@ -190,14 +278,20 @@ void hv_stimer_free(void)
 void hv_stimer_global_cleanup(void)
 {
 	int	cpu;
-	struct clock_event_device *ce;
=20
-	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
-		for_each_present_cpu(cpu) {
-			ce =3D per_cpu_ptr(hv_clock_event, cpu);
-			clockevents_unbind_device(ce, cpu);
-		}
+	/*
+	 * hv_stime_legacy_cleanup() will stop the stimer if Direct
+	 * Mode is not enabled, and fallback to the LAPIC timer.
+	 */
+	for_each_present_cpu(cpu) {
+		hv_stimer_legacy_cleanup(cpu);
 	}
+
+	/*
+	 * If Direct Mode is enabled, the cpuhp teardown callback
+	 * (hv_stimer_cleanup) will be run on all CPUs to stop the
+	 * stimers.
+	 */
 	hv_stimer_free();
 }
 EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index fcc5279..6098e0c 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -202,7 +202,7 @@ int hv_synic_init(unsigned int cpu)
 {
 	hv_synic_enable_regs(cpu);
=20
-	hv_stimer_init(cpu);
+	hv_stimer_legacy_init(cpu, VMBUS_MESSAGE_SINT);
=20
 	return 0;
 }
@@ -277,7 +277,7 @@ int hv_synic_cleanup(unsigned int cpu)
 	if (channel_found && vmbus_connection.conn_state =3D=3D CONNECTED)
 		return -EBUSY;
=20
-	hv_stimer_cleanup(cpu);
+	hv_stimer_legacy_cleanup(cpu);
=20
 	hv_synic_disable_regs(cpu);
=20
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 5d2304b..664a415 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1342,10 +1342,6 @@ static int vmbus_bus_init(void)
 	if (ret)
 		goto err_alloc;
=20
-	ret =3D hv_stimer_alloc(VMBUS_MESSAGE_SINT);
-	if (ret < 0)
-		goto err_alloc;
-
 	/*
 	 * Initialize the per-cpu interrupt state and stimer state.
 	 * Then connect to the host.
@@ -1402,9 +1398,8 @@ static int vmbus_bus_init(void)
 err_connect:
 	cpuhp_remove_state(hyperv_cpuhp_online);
 err_cpuhp:
-	hv_stimer_free();
-err_alloc:
 	hv_synic_free();
+err_alloc:
 	hv_remove_vmbus_irq();
=20
 	bus_unregister(&hv_bus);
@@ -2317,20 +2312,23 @@ static void hv_crash_handler(struct pt_regs *regs)
 static int hv_synic_suspend(void)
 {
 	/*
-	 * When we reach here, all the non-boot CPUs have been offlined, and
-	 * the stimers on them have been unbound in hv_synic_cleanup() ->
+	 * When we reach here, all the non-boot CPUs have been offlined.
+	 * If we're in a legacy configuration where stimer Direct Mode is
+	 * not enabled, the stimers on the non-boot CPUs have been unbound
+	 * in hv_synic_cleanup() -> hv_stimer_legacy_cleanup() ->
 	 * hv_stimer_cleanup() -> clockevents_unbind_device().
 	 *
-	 * hv_synic_suspend() only runs on CPU0 with interrupts disabled. Here
-	 * we do not unbind the stimer on CPU0 because: 1) it's unnecessary
-	 * because the interrupts remain disabled between syscore_suspend()
-	 * and syscore_resume(): see create_image() and resume_target_kernel();
+	 * hv_synic_suspend() only runs on CPU0 with interrupts disabled.
+	 * Here we do not call hv_stimer_legacy_cleanup() on CPU0 because:
+	 * 1) it's unnecessary as interrupts remain disabled between
+	 * syscore_suspend() and syscore_resume(): see create_image() and
+	 * resume_target_kernel()
 	 * 2) the stimer on CPU0 is automatically disabled later by
 	 * syscore_suspend() -> timekeeping_suspend() -> tick_suspend() -> ...
-	 * -> clockevents_shutdown() -> ... -> hv_ce_shutdown(); 3) a warning
-	 * would be triggered if we call clockevents_unbind_device(), which
-	 * may sleep, in an interrupts-disabled context. So, we intentionally
-	 * don't call hv_stimer_cleanup(0) here.
+	 * -> clockevents_shutdown() -> ... -> hv_ce_shutdown()
+	 * 3) a warning would be triggered if we call
+	 * clockevents_unbind_device(), which may sleep, in an
+	 * interrupts-disabled context.
 	 */
=20
 	hv_synic_disable_regs(0);
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyper=
v_timer.h
index 422f5e5..553e539 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -21,10 +21,11 @@
 #define HV_MIN_DELTA_TICKS 1
=20
 /* Routines called by the VMbus driver */
-extern int hv_stimer_alloc(int sint);
+extern int hv_stimer_alloc(void);
 extern void hv_stimer_free(void);
-extern void hv_stimer_init(unsigned int cpu);
-extern void hv_stimer_cleanup(unsigned int cpu);
+extern int hv_stimer_cleanup(unsigned int cpu);
+extern void hv_stimer_legacy_init(unsigned int cpu, int sint);
+extern void hv_stimer_legacy_cleanup(unsigned int cpu);
 extern void hv_stimer_global_cleanup(void);
 extern void hv_stimer0_isr(void);
=20
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 89d75ed..e51ee77 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -129,6 +129,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARC_TIMER_STARTING,
 	CPUHP_AP_RISCV_TIMER_STARTING,
 	CPUHP_AP_CSKY_TIMER_STARTING,
+	CPUHP_AP_HYPERV_TIMER_STARTING,
 	CPUHP_AP_KVM_STARTING,
 	CPUHP_AP_KVM_ARM_VGIC_INIT_STARTING,
 	CPUHP_AP_KVM_ARM_VGIC_STARTING,
--=20
1.8.3.1

