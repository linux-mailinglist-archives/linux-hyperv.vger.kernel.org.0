Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23BA8E6AA9
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2019 03:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfJ1CJw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 27 Oct 2019 22:09:52 -0400
Received: from mail-eopbgr710111.outbound.protection.outlook.com ([40.107.71.111]:6071
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727598AbfJ1CJw (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 27 Oct 2019 22:09:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7hBDFpMHQ/ysc0jJ63/KDiE+lE/jNrJVDvhwqX6nmOtFL6PL8MWeOojbk8vAuh2SMqgrwoJBPMLMs3nWo3ZzYc4purmq3YW3i1JrzJS9UPESkRx3DD9fx/63p6sFmpZdVYpZu3iwLN9F7QNCfcdcWtPlkhFyw81UVB0dvX5sX/1HF6O2UYtylQRq22NhGQF41Geg9nmRX0ER0IJVoUas1J3DBkDgJ4S7kea6YR3jywE8Wvc+9AD13uwv+GUheH4sTRjv9T8ZrC2x75Nq0WdQnp3LwLpmeUED670bbuyinE95t/l8/XDUvuS7t0NBO3YxdCcJYa5StzgIU9bxOt79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImHn9wYw+gmdtkcOZxCWJ3kTw+AJeV8Cug7DC9C5CqI=;
 b=oafwAYDBx8HW8Az5Ng9XFcply1z9KFDR6UhFLk8mA64x/WEogHqWsaDF6N+2Cf3t20AHyvYn9lfDSeNEeSHnJCtPrNfW76+XfJGJEm4bi4SX9N2tpEqMAoovOcmh9fFzDdj6WlCGZFt9HD+Q3a+IHv29k3WU/UGuwMmWcm9MJOwi6wzrSQfkz/l1mL4e6K6FJJjToA8eUxSXRHlU2F+GW4mIhfOfAUb0Yz7SBVEy2HQ+K1gvPsmTWK6fzFKuKabsMXfpw0NZkcI/SDeYTNzMdcS6ljmboNpiMyx/Klw35HKkHIGQNMcF+WfCjszHsn2JyjbU5U8JVW5D7dTrxTLV4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImHn9wYw+gmdtkcOZxCWJ3kTw+AJeV8Cug7DC9C5CqI=;
 b=UBHrw97abWrH3u3+d/1vBmPT/9aKNYqivTh6biNY6KlHYFLiPv0dugoCh0IAwvAaqsljL2kDvIn3tsE+afkq8zSCs6g4KK0POGdRwoA4u+SJABz4ITThS3pcRumHWzRhpP06BC3IGnz00ipN74eFCSPbkahZpRFE3TayV0wXDjo=
Received: from SN6PR2101MB1135.namprd21.prod.outlook.com (52.132.114.24) by
 SN6PR2101MB1101.namprd21.prod.outlook.com (52.132.115.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.6; Mon, 28 Oct 2019 02:09:42 +0000
Received: from SN6PR2101MB1135.namprd21.prod.outlook.com
 ([fe80::1cc6:7b31:4489:4fbb]) by SN6PR2101MB1135.namprd21.prod.outlook.com
 ([fe80::1cc6:7b31:4489:4fbb%5]) with mapi id 15.20.2408.014; Mon, 28 Oct 2019
 02:09:42 +0000
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
        "m.szyprowski@samsumg.com" <m.szyprowski@samsumg.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH 1/1] x86/hyperv: Initialize clockevents earlier in CPU
 onlining
Thread-Topic: [PATCH 1/1] x86/hyperv: Initialize clockevents earlier in CPU
 onlining
Thread-Index: AQHVjTTCcywpG+T+tUGFemPgvP9gmA==
Date:   Mon, 28 Oct 2019 02:09:42 +0000
Message-ID: <1572228459-10550-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1701CA0005.namprd17.prod.outlook.com
 (2603:10b6:301:14::15) To SN6PR2101MB1135.namprd21.prod.outlook.com
 (2603:10b6:805:4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [131.107.160.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a460630-e06d-46ab-6c38-08d75b4be522
x-ms-traffictypediagnostic: SN6PR2101MB1101:|SN6PR2101MB1101:|SN6PR2101MB1101:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN6PR2101MB110185918ACCB85186D04773D7660@SN6PR2101MB1101.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(1511001)(476003)(2616005)(110136005)(86362001)(6506007)(66066001)(386003)(486006)(6512007)(22452003)(2201001)(10090500001)(7736002)(316002)(305945005)(186003)(66946007)(102836004)(66556008)(64756008)(66446008)(66476007)(52116002)(26005)(107886003)(25786009)(81156014)(81166006)(50226002)(8936002)(478600001)(4720700003)(10290500003)(8676002)(2501003)(99286004)(36756003)(6116002)(3846002)(14454004)(6436002)(6486002)(2906002)(30864003)(71190400001)(7416002)(4326008)(5660300002)(256004)(14444005)(71200400001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1101;H:SN6PR2101MB1135.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: svu3B0d7YGbzZGeTVB12uCsroTiNRfJmY233D7bFfINisKto+NBEmzzeaHhL6gZHMEceUCwfH41zbqPAJzsuA+fmExsRT2m6jovs7nydHRBJnWakC/U7lCM/LSOH0n6hhNWgXu05jb437GDdncOh14Dfcmh09P1SKfuTVTc67clUoKRheWfrwrhBltszmaqwM+pAixE+yj6M/D1md20HVFqUtjFQjSo1IzFjkFeOxMpaFQMKDc/c1phy11bmZF0GVvWOvVaNDL0iKoCaGpD0pDSBJ4TPNZEWHEP5gRCGdo1X2aD/oeLcoWooSoWI721Yw7e0l7sSEtLCdUo36Jk6b2xlxwTXkQQ9WAzjyCVKiuU0g31V62XiBfff2Y8yYeKj3hpkR7qDra4iRD++Cmy6WLaxG1n/EDGExMQWUrJYCNJwJy1IX0Ypxxx9aJYxfITt
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a460630-e06d-46ab-6c38-08d75b4be522
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 02:09:42.2626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8ubpVX/fjCAGPh8yuurKbSgjmyfT/S5rsQdeZhSgSvemg2GtIg1TLC7QEPr8j6fRg9pUK3oGLwoMevX3uagIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1101
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
be supported for backward compatibility on x86/64, that mode of
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
 arch/x86/hyperv/hv_init.c          |   7 ++
 drivers/clocksource/hyperv_timer.c | 127 ++++++++++++++++++++++++++++++---=
----
 drivers/hv/hv.c                    |   4 +-
 drivers/hv/vmbus_drv.c             |  31 ++++-----
 include/clocksource/hyperv_timer.h |   6 +-
 include/linux/cpuhotplug.h         |   1 +
 6 files changed, 131 insertions(+), 45 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index b2daf0e..453d5fa 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -323,8 +323,15 @@ void __init hyperv_init(void)
=20
 	x86_init.pci.arch_init =3D hv_pci_init;
=20
+	if (hv_stimer_alloc())
+		goto remove_hypercall_page;
+
 	return;
=20
+remove_hypercall_page:
+	hypercall_msr.as_uint64 =3D 0;
+	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	hv_hypercall_pg =3D NULL;
 remove_cpuhp_state:
 	cpuhp_remove_state(cpuhp);
 free_vp_assist_page:
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyper=
v_timer.c
index 2317d4e..00f6429 100644
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
@@ -30,12 +31,22 @@
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
 static int stimer0_irq;
 static int stimer0_vector;
 static int stimer0_message_sint;
+static int stimer0_cpuhp;
=20
 /*
  * ISR for when stimer0 is operating in Direct Mode.  Direct Mode
@@ -102,7 +113,7 @@ static int hv_ce_set_oneshot(struct clock_event_device =
*evt)
 /*
  * hv_stimer_init - Per-cpu initialization of the clockevent
  */
-void hv_stimer_init(unsigned int cpu)
+static int hv_stimer_init(unsigned int cpu)
 {
 	struct clock_event_device *ce;
=20
@@ -112,7 +123,7 @@ void hv_stimer_init(unsigned int cpu)
 	 * clocksource based on emulated PIT or LAPIC timer hardware.
 	 */
 	if (!(ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE))
-		return;
+		return 0;
=20
 	ce =3D per_cpu_ptr(hv_clock_event, cpu);
 	ce->name =3D "Hyper-V clockevent";
@@ -127,28 +138,42 @@ void hv_stimer_init(unsigned int cpu)
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
+static int hv_stimer_cleanup(unsigned int cpu)
 {
 	struct clock_event_device *ce;
=20
 	/* Turn off clockevent device */
 	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
 		ce =3D per_cpu_ptr(hv_clock_event, cpu);
+
+		/*
+		 * In the legacy case where Direct Mode is not enabled
+		 * (which can only be on x86/64), stimer cleanup happens
+		 * relatively early in the CPU offlining process. We
+		 * must unbind the stimer-based clockevent device so
+		 * that the LAPIC timer can take over until clockevents
+		 * are no longer needed in the offlining process. The
+		 * unbind should not be done when Direct Mode is enabled
+		 * because we may be on an architecture where there are
+		 * no other clockevents devices to fallback to.
+		 */
+		if (!direct_mode_enabled)
+			clockevents_unbind_device(ce, cpu);
 		hv_ce_shutdown(ce);
 	}
+	return 0;
 }
-EXPORT_SYMBOL_GPL(hv_stimer_cleanup);
=20
 /* hv_stimer_alloc - Global initialization of the clockevent and stimer0 *=
/
-int hv_stimer_alloc(int sint)
+int hv_stimer_alloc(void)
 {
-	int ret;
+	int ret =3D 0;
=20
 	hv_clock_event =3D alloc_percpu(struct clock_event_device);
 	if (!hv_clock_event)
@@ -159,24 +184,83 @@ int hv_stimer_alloc(int sint)
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
+		stimer0_cpuhp =3D ret;
 	}
+	return ret;
=20
-	stimer0_message_sint =3D sint;
-	return 0;
+free_stimer0_irq:
+	hv_remove_stimer0_irq(stimer0_irq);
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
+	 * clocksource driver just to set the sint in the legacy
+	 * (i.e., no Direct Mode) case.
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
-		hv_remove_stimer0_irq(stimer0_irq);
-		stimer0_irq =3D 0;
+	if (direct_mode_enabled) {
+		if (stimer0_cpuhp) {
+			cpuhp_remove_state(stimer0_cpuhp);
+			stimer0_cpuhp =3D 0;
+		}
+		if (stimer0_irq) {
+			hv_remove_stimer0_irq(stimer0_irq);
+			stimer0_irq =3D 0;
+		}
 	}
 	free_percpu(hv_clock_event);
 	hv_clock_event =3D NULL;
@@ -190,14 +274,11 @@ void hv_stimer_free(void)
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
+	for_each_present_cpu(cpu) {
+		hv_stimer_cleanup(cpu);
 	}
+
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
index 0ab126b..18fdddb 100644
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
@@ -2310,7 +2305,6 @@ static void hv_crash_handler(struct pt_regs *regs)
 	 */
 	vmbus_connection.conn_state =3D DISCONNECTED;
 	cpu =3D smp_processor_id();
-	hv_stimer_cleanup(cpu);
 	hv_synic_cleanup(cpu);
 	hyperv_cleanup();
 };
@@ -2318,20 +2312,23 @@ static void hv_crash_handler(struct pt_regs *regs)
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
index 422f5e5..9b477c4 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -21,10 +21,10 @@
 #define HV_MIN_DELTA_TICKS 1
=20
 /* Routines called by the VMbus driver */
-extern int hv_stimer_alloc(int sint);
+extern int hv_stimer_alloc(void);
 extern void hv_stimer_free(void);
-extern void hv_stimer_init(unsigned int cpu);
-extern void hv_stimer_cleanup(unsigned int cpu);
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

