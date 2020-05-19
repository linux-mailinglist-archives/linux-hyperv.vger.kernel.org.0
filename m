Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D401D9FA0
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2020 20:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgESSiB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 May 2020 14:38:01 -0400
Received: from mail-co1nam11on2122.outbound.protection.outlook.com ([40.107.220.122]:23009
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727927AbgESSiA (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 May 2020 14:38:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iitq+hyO0t+CRWhqWJInNhK/MB0GC1lRZ7Og1Pij0Q+wXoEWrT/4fKSXIzItUud6WLpZRUa1QJz+Lm8s6uFEOh3nAIgru4A3fcmYwmipDHRC4FtfUxTs3M5NQ6Z4sI7lz9sB+EcshsqahKotbJ8Fi/QtLUK4jmiB10wrx/tUVuO1FjYmEAH+DZxv7cRqDF5yvCTlfAcin0notal/JksUK8oMUsahHXg0b9vWVrJHuPZOEnDmfWDauuT/RJZmMuMC32r7ds4xJIiwelJerhMLJUGj8ns4mMnJWcIEi1usD+tHZD09fmbJIIbvaLOVhYL6d7VuNo9NVGNrg4EgfgxywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcHI2sPbYp7S6enBA4hMGLlwz80QIaeavCVixfcIac8=;
 b=nx+yo/8o2a05weCr+HANfdTLcaZppFad+KQ3C0FXebZTrgJQfxmcu4idvN83uYJwygzzlATgFNFKadXqbuIurAQTUEv+43RiEtdVv+b2lnzPNI+v+RGEV5LYJotuJZ6Mrafxc2TgQ8KSKho4r8oO71Ksv+GvhVr8nIbLF2I8pgUt+0nzmpTzoNq9fmpcn9sWjtbitl/CvzHZa0wI7ojKZF6x/4lGWQ01qagHa3cS8H/glin1glRR17BG4PAqkcrlBHY8wX5Qo5zg1XB28wnr90bHQpkW1XXrgrbD4Ici1j1AbdtVHACAgIL4MdF+gCacCCWqvii5bguplkvEEwSpjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcHI2sPbYp7S6enBA4hMGLlwz80QIaeavCVixfcIac8=;
 b=NWyLEfOr71z5MGGhKwE798gOS+FK4HdSj6PHjiPqNQ9IH6n7O6ahnXeFxO5HBcBaEQDv8L9is5lLhpJWxJUoAPvwFiJOT08SQgC/+EJs9/Jg6S7Sp0tggSwGjHfI//o9N8PcPWdU+weH1s3JcITV+dghdEIqc1rNFeH8qJdIDv8=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN4PR2101MB0734.namprd21.prod.outlook.com
 (2603:10b6:803:51::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Tue, 19 May
 2020 18:37:58 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::e954:af85:b4a6:a718]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::e954:af85:b4a6:a718%7]) with mapi id 15.20.3021.018; Tue, 19 May 2020
 18:37:57 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/Hyper-V: Support for free page reporting
Thread-Topic: [PATCH] x86/Hyper-V: Support for free page reporting
Thread-Index: AdYuDAEiPLOc+vnoR1KnBaBInLPPAQ==
Date:   Tue, 19 May 2020 18:37:57 +0000
Message-ID: <SN4PR2101MB0880BB5C9780A854B2609992C0B90@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:5974:dfc3:c4fc:f9e2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df9647a1-d18e-44ae-3c02-08d7fc23c07f
x-ms-traffictypediagnostic: SN4PR2101MB0734:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR2101MB073424E6EE0FB181616983DEC0B90@SN4PR2101MB0734.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D7n12MxV3HabpBfNK/xfGEqqnCL6929CRY3QapMXS6sGEqnVnEiUrcG8OMFt2Q0j4qM9/suc2RMYrEkxr4Ji13KkjfiMsfeYOV2W4uD55U9Aue4tCM0RWEd2dcHuLc7lODrQp7D/vH+75hf3O5vF0RZuLdIIRQYXSv5YHERhmox5BPRIvxkj7aQviCF+3H/qt6ef9iaJQKPZ2toITiDQFOEid7ySKIybx4m5Vwlu8On8UoiNCI93Ib2vdJa0+S7JB2k26+iQqLTAt8/GH8inbBa7BXkj6x9SWkZpM2msHxBAVnG+S6m0qzqnkhFIJNwu0HTHTuuZNptQA9zydj4Yo96wMo6JiMK9dioWZFfCkslvJ2li+TWXWQDGwa+f6hJo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(6506007)(186003)(5660300002)(82960400001)(52536014)(82950400001)(66946007)(71200400001)(66476007)(64756008)(66446008)(66556008)(6636002)(76116006)(4326008)(8990500004)(478600001)(7696005)(2906002)(10290500003)(8676002)(8936002)(316002)(9686003)(110136005)(54906003)(33656002)(450100002)(55016002)(86362001)(4533004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: K4gd3NWvOygaP0NKPOEFECstAOJcJ+OhmKoXWusJq5k1uv6i9IPtmSdDxYGqXlP6dzZWZDBF0ZJus4AqEjcbkisyiazOTFPLH7b8EyRrogfdQHkBCh/FqHGkfabMggyqkvk5BkUllIw0+/p7Wjub2NFCMl/oNKOXsZxbkbI50YdVXCQ38o9J1XUrkCEymAEvFKgwfCtXwAh4klyM0O4gjHB9yTAI4bM+x01VaBRT0BezWQnSNJSErlvgiqlZbTmsySo12HxrExAD3Yj6HG8WoJkHz7LRTS18KUxZ/4eXoB/zyzXbSXUlycXm5z6U7GuKC94qSsLGxuYi4saMJzQ+T50phY+52jxH8/7DA/TVIKycp/45NYtyuFL44YlFMAcxSXaLGVy5Bpnv64WA+W/QyEOoFbXfqmdUXOZ/mWtoCuxpEqZraW+vNKswOQ2getU90hjniOS3ybDpJCTyA0acKdQL3nUfiFIDKsOPff2O6MiK/JvLdKYD4AoAzkMr/XN0C8YLphnEIGTCT7w4AXjr5U8M1WkRGLdHd71KinrKwgw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9647a1-d18e-44ae-3c02-08d7fc23c07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 18:37:57.7554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XEYdtd4A2FlWMokGKiWo6zzfZ61qLnpmaV4xvTyL+qWYc9Qh4adYalc5ko5lI4lZf7CHYHgKzuhHpO57nXD1yGwIwlZPfe9fnAfdfC1nbB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0734
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Linux has support for free page reporting now (36e66c554b5c) for
virtualized environment. On Hyper-V when virtually backed VMs are
configured, Hyper-V will advertise cold memory discard capability,
when supported. This patch adds the support to hook into the free
page reporting infrastructure and leverage the Hyper-V cold memory
discard hint hypercall to report/free these pages back to the host.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
First patch mail bounced backed. Sending it again with the email
addresses fixed.
---
 arch/x86/hyperv/hv_init.c         | 24 ++++++++
 arch/x86/kernel/cpu/mshyperv.c    |  6 +-
 drivers/hv/hv_balloon.c           | 93 +++++++++++++++++++++++++++++++
 include/asm-generic/hyperv-tlfs.h | 29 ++++++++++
 include/asm-generic/mshyperv.h    |  2 +
 5 files changed, 152 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 624f5d9b0f79..925e2f7eb82c 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -506,3 +506,27 @@ bool hv_is_hibernation_supported(void)
 	return acpi_sleep_state_supported(ACPI_STATE_S4);
 }
 EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
+
+u64 hv_query_ext_cap(void)
+{
+	u64 *cap;
+	unsigned long flags;
+	u64 ext_cap =3D 0;
+
+	/*
+	 * Querying extended capabilities is an extended hypercall. Check if the
+	 * partition supports extended hypercall, first.
+	 */
+	if (!(ms_hyperv.b_features & HV_ENABLE_EXTENDED_HYPERCALLS))
+		return 0;
+
+	local_irq_save(flags);
+	cap =3D *(u64 **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	if (hv_do_hypercall(HV_EXT_CALL_QUERY_CAPABILITIES, NULL, cap) =3D=3D
+	    HV_STATUS_SUCCESS)
+		ext_cap =3D *cap;
+
+	local_irq_restore(flags);
+	return ext_cap;
+}
+EXPORT_SYMBOL_GPL(hv_query_ext_cap);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.=
c
index ebf34c7bc8bc..2de3f692c8bf 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -224,11 +224,13 @@ static void __init ms_hyperv_init_platform(void)
 	 * Extract the features and hints
 	 */
 	ms_hyperv.features =3D cpuid_eax(HYPERV_CPUID_FEATURES);
+	ms_hyperv.b_features =3D cpuid_ebx(HYPERV_CPUID_FEATURES);
 	ms_hyperv.misc_features =3D cpuid_edx(HYPERV_CPUID_FEATURES);
 	ms_hyperv.hints    =3D cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
=20
-	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
-		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
+	pr_info("Hyper-V: features 0x%x, additional features: 0x%x, hints 0x%x, m=
isc 0x%x\n",
+		ms_hyperv.features, ms_hyperv.b_features, ms_hyperv.hints,
+		ms_hyperv.misc_features);
=20
 	ms_hyperv.max_vp_index =3D cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
 	ms_hyperv.max_lp_index =3D cpuid_ebx(HYPERV_CPUID_IMPLEMENT_LIMITS);
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 32e3bc0aa665..77be31094556 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -21,6 +21,7 @@
 #include <linux/memory.h>
 #include <linux/notifier.h>
 #include <linux/percpu_counter.h>
+#include <linux/page_reporting.h>
=20
 #include <linux/hyperv.h>
 #include <asm/hyperv-tlfs.h>
@@ -563,6 +564,10 @@ struct hv_dynmem_device {
 	 * The negotiated version agreed by host.
 	 */
 	__u32 version;
+
+#ifdef CONFIG_PAGE_REPORTING
+	struct page_reporting_dev_info pr_dev_info;
+#endif
 };
=20
 static struct hv_dynmem_device dm_device;
@@ -1565,6 +1570,83 @@ static void balloon_onchannelcallback(void *context)
=20
 }
=20
+#ifdef CONFIG_PAGE_REPORTING
+static int hv_free_page_report(struct page_reporting_dev_info *pr_dev_info=
,
+		    struct scatterlist *sgl, unsigned int nents)
+{
+	unsigned long flags;
+	struct hv_memory_hint *hint;
+	int i;
+	u64 status;
+	struct scatterlist *sg;
+
+	WARN_ON(nents > HV_MAX_GPA_PAGE_RANGES);
+	local_irq_save(flags);
+	hint =3D *(struct hv_memory_hint **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	if (!hint) {
+		local_irq_restore(flags);
+		return -ENOSPC;
+	}
+
+	hint->type =3D HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD;
+	hint->reserved =3D 0;
+	for (i =3D 0, sg =3D sgl; sg; sg =3D sg_next(sg), i++) {
+		int order;
+		union hv_gpa_page_range *range;
+
+		order =3D get_order(sg->length);
+		range =3D &hint->ranges[i];
+		range->address_space =3D 0;
+		range->page.largepage =3D 1;
+		range->page.additional_pages =3D (1ull << (order - 9)) - 1;
+		range->base_large_pfn =3D page_to_pfn(sg_page(sg)) >> 9;
+	}
+
+	status =3D hv_do_rep_hypercall(HV_EXT_CALL_MEMORY_HEAT_HINT, nents, 0,
+				     hint, NULL);
+	local_irq_restore(flags);
+	status &=3D HV_HYPERCALL_RESULT_MASK;
+	if (status !=3D HV_STATUS_SUCCESS) {
+		pr_err("Cold memory discard hypercall failed with status %llx\n",
+			status);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int enable_page_reporting(void)
+{
+	int ret;
+
+	if (!(hv_query_ext_cap() &
+	      HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT)) {
+		pr_info("Cold memory discard hint not supported by Hyper-V\n");
+		return 0;
+	}
+
+	BUILD_BUG_ON(PAGE_REPORTING_CAPACITY > HV_MAX_GPA_PAGE_RANGES);
+	dm_device.pr_dev_info.report =3D hv_free_page_report;
+	ret =3D page_reporting_register(&dm_device.pr_dev_info);
+	if (ret < 0) {
+		dm_device.pr_dev_info.report =3D NULL;
+		pr_err("Failed to enable cold memory discard: %d\n", ret);
+	} else {
+		pr_info("Cold memory discard hint enabled\n");
+	}
+
+	return ret;
+}
+
+static void disable_page_reporting(void)
+{
+	if (dm_device.pr_dev_info.report) {
+		page_reporting_unregister(&dm_device.pr_dev_info);
+		dm_device.pr_dev_info.report =3D NULL;
+	}
+}
+#endif //CONFIG_PAGE_REPORTING
+
 static int balloon_connect_vsp(struct hv_device *dev)
 {
 	struct dm_version_request version_req;
@@ -1710,6 +1792,11 @@ static int balloon_probe(struct hv_device *dev,
 	if (ret !=3D 0)
 		return ret;
=20
+#ifdef CONFIG_PAGE_REPORTING
+	if (enable_page_reporting() < 0)
+		goto probe_error;
+#endif
+
 	dm_device.state =3D DM_INITIALIZED;
=20
 	dm_device.thread =3D
@@ -1728,6 +1815,9 @@ static int balloon_probe(struct hv_device *dev,
 #ifdef CONFIG_MEMORY_HOTPLUG
 	unregister_memory_notifier(&hv_memory_nb);
 	restore_online_page_callback(&hv_online_page);
+#endif
+#ifdef CONFIG_PAGE_REPORTING
+	disable_page_reporting();
 #endif
 	return ret;
 }
@@ -1750,6 +1840,9 @@ static int balloon_remove(struct hv_device *dev)
 #ifdef CONFIG_MEMORY_HOTPLUG
 	unregister_memory_notifier(&hv_memory_nb);
 	restore_online_page_callback(&hv_online_page);
+#endif
+#ifdef CONFIG_PAGE_REPORTING
+	disable_page_reporting();
 #endif
 	spin_lock_irqsave(&dm_device.ha_lock, flags);
 	list_for_each_entry_safe(has, tmp, &dm->ha_region_list, list) {
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv=
-tlfs.h
index 262fae9526b1..75aeea0e7f9b 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -89,6 +89,7 @@
 #define HV_ACCESS_STATS				BIT(8)
 #define HV_DEBUGGING				BIT(11)
 #define HV_CPU_POWER_MANAGEMENT			BIT(12)
+#define HV_ENABLE_EXTENDED_HYPERCALLS		BIT(20)
=20
=20
 /*
@@ -149,11 +150,18 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
=20
+/* Extended hypercalls */
+#define HV_EXT_CALL_QUERY_CAPABILITIES		0x8001
+#define HV_EXT_CALL_MEMORY_HEAT_HINT		0x8003
+
 #define HV_FLUSH_ALL_PROCESSORS			BIT(0)
 #define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES	BIT(1)
 #define HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY	BIT(2)
 #define HV_FLUSH_USE_EXTENDED_RANGE_FORMAT	BIT(3)
=20
+/* Extended capability bits */
+#define HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT BIT(8)
+
 enum HV_GENERIC_SET_FORMAT {
 	HV_GENERIC_SET_SPARSE_4K,
 	HV_GENERIC_SET_ALL,
@@ -371,6 +379,12 @@ union hv_gpa_page_range {
 		u64 largepage:1;
 		u64 basepfn:52;
 	} page;
+	struct {
+		u64:12;
+		u64 page_size:1;
+		u64 reserved:8;
+		u64 base_large_pfn:43;
+	};
 };
=20
 /*
@@ -490,4 +504,19 @@ struct hv_set_vp_registers_input {
 	} element[];
 } __packed;
=20
+/*
+ * The whole argument should fit in a page to be able to pass to the hyper=
visor
+ * in one hypercall.
+ */
+#define HV_MAX_GPA_PAGE_RANGES ((PAGE_SIZE - sizeof(u64)) / \
+				sizeof(union hv_gpa_page_range))
+
+/* HvExtCallMemoryHeatHint hypercall */
+#define HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD	2
+struct hv_memory_hint {
+	u64 type:2;
+	u64 reserved:62;
+	union hv_gpa_page_range ranges[1];
+};
+
 #endif
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.=
h
index 1c4fd950f091..c664af4a7503 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -27,6 +27,7 @@
=20
 struct ms_hyperv_info {
 	u32 features;
+	u32 b_features;
 	u32 misc_features;
 	u32 hints;
 	u32 nested_features;
@@ -169,6 +170,7 @@ bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
 void hyperv_cleanup(void);
 void hv_setup_sched_clock(void *sched_clock);
+u64 hv_query_ext_cap(void);
 #else /* CONFIG_HYPERV */
 static inline bool hv_is_hyperv_initialized(void) { return false; }
 static inline bool hv_is_hibernation_supported(void) { return false; }
--=20
2.17.1

