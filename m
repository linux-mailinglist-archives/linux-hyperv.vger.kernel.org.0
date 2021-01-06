Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3D82EC6CF
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jan 2021 00:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbhAFXVW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 18:21:22 -0500
Received: from mail-co1nam11on2138.outbound.protection.outlook.com ([40.107.220.138]:17056
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726844AbhAFXVV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 18:21:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXbSGXKlI1W/cM9+nvHEgUWQ44qrkNGybH1PGBf6SwtH/AbgNQoe+6UqoO+uHizhv4ZZYDxclVA+RLpmkPDAqUqDb4Xsa/EC/3f3ilkz0D8hIGfaoT6OM06RdtVwqZxoqGofRH7Wac71j28IYtIOTcK0K/OuNJmMOSugBKf3KN2KVBH9m0CSZzJFKPBQVeaDb/s40uFsEjix7Fis97dUPWMJuf0JEj60bwTq0QUTuxL0aNO7HHl6pgoaTC+liYLD8fQWtLqpqohRJEkCl5kHjEwbKkKLilbgwGm9cjz2pcsVN/nYXqxNndUYBNb+e1iBJ07b5uObU0IH3GmfAhey/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP3p6HBLUJvWE7xFxOS59DqlwrrkDghZSJIqX6R8Muk=;
 b=jB0pVB4rZQvFjbbSqQUp31pLiGdyjL3So2WUI9Tcg72F3oBg6bqiOkHcqw1ZWu3DEPGCXjFlAUEXyPm2T5nU+HRZTJb80YorWfJAsbNen3mnqUU5KdlI4NLS80cXf1oVM0T022/XCx+3qjfV7GbyUtymtadVAht17E4OrdSLnz1VyV/NfTcnGa51YWjrNvpXuBV/k4K/QABmNiddHyu5JCPMybZH9CyhSNPRyDtP2p/snQAd9JcjM49WHxCdKD57hXZa/B0Ppr9doV8uRvkUrQ3LCAumL2ldiqidWVCOMDkOmcnumjPB4uC1cemAFDT/ZItK8o0uCSzV/t9zTol9lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP3p6HBLUJvWE7xFxOS59DqlwrrkDghZSJIqX6R8Muk=;
 b=Lv30MWywF35+x/IG78qZgaafUtRfugormaPxAJMJjexXpfSI31tpvjMoyZWyzK8Z5Dqu6QMO7yBfEIYgZDIEKkRH5pakymcHi0UPkdJGAwTTE3DEh091ngyG3Pd+2irZDMmEd3Alt6y3pzEguDdZ547lD4lnwuiAR5aZicOotRs=
Received: from (2603:10b6:803:51::33) by
 SN4PR2101MB0735.namprd21.prod.outlook.com (2603:10b6:803:51::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.0; Wed, 6 Jan
 2021 23:20:33 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8%4]) with mapi id 15.20.3763.002; Wed, 6 Jan 2021
 23:20:33 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Matheus Castello <matheus@castello.eng.br>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, vkuznets <vkuznets@redhat.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] x86/Hyper-V: Support for free page reporting
Thread-Topic: [PATCH v3] x86/Hyper-V: Support for free page reporting
Thread-Index: Adbkgi7u1VztxegUSBO0uPzYUvP03g==
Date:   Wed, 6 Jan 2021 23:20:33 +0000
Message-ID: <SN4PR2101MB0880CA1C933184498DF1F595C0D09@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: castello.eng.br; dkim=none (message not signed)
 header.d=none;castello.eng.br; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:f11f:f773:1cef:ecfe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f8641d7-112c-4c3e-67aa-08d8b299aaa3
x-ms-traffictypediagnostic: SN4PR2101MB0735:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN4PR2101MB0735E0C320304C0CA5895A9AC0D09@SN4PR2101MB0735.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UXwbgm9++F9GVNJXCwDirR0SH6T10IT2tblH8LK5UsEEmxYhfeQqMOEtctY3ClyLLcrcRb2uADS53/3Agn0wANJyWDbZQSoeBtL2tmsoyvDO2Jdib+FGorRF7mdz66FLZyUgdOKZVPMoFEyDum1kswiI0mqHB8foqjIXDWE753I/3uCkjVUtuDY2q/lhcsYCXAHZW+PgHaCevISBWdLKVSAbxSey1wt/DGSND0EAn8CoBPgOQL9LDpGMAmRvVxGzdYIbP38Logc7O0Ba7zSZzRInY11KTBhQ8Y0hB0ZEz5/ve6mkEM3O+szP2oyMApo19Qg6sTIJiu4ugWNIR1WQRjB19IgqWwEegSAjY3HpuXcI5Zp+/cL1He6v8d8PzsDqUnOAYU+jpIUIXTT8llBy4AQ6NgA3avx/BKAWd7THaKCBdF9wRjkd+vqVO2iGKL0lAmECCpnP/q5NkXe6XIP7WA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(83380400001)(186003)(71200400001)(4326008)(478600001)(316002)(10290500003)(86362001)(54906003)(55016002)(66476007)(9686003)(76116006)(110136005)(7696005)(33656002)(64756008)(82960400001)(5660300002)(8936002)(66946007)(66446008)(2906002)(6506007)(8990500004)(82950400001)(8676002)(66556008)(52536014)(21314003)(4533004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BUYaYo84kQ3ri4MjPu6nxsoBTwN6XP+8Ifrhet81Dn4s9ez4YonmiuaN5UPv?=
 =?us-ascii?Q?3f3VCVQTDnLKRHq2uiHswSIBirT07ndGPO47sh+UcgUgtYlYIHdkT2wueRha?=
 =?us-ascii?Q?LxgXTZmu9EiV/VrT7xsh5gqHmXuV9zjoxQstD3HZFEMQi1v6vUs17tslrHwy?=
 =?us-ascii?Q?CCitOOXedob7f8+COMq2zb8eaTc2GTKnfYMFINGt0CzPHGghRCubBGdRuJul?=
 =?us-ascii?Q?+nAgaUtZiTL0BEjIev13bgHlm3WBgLPQVzLdyZEVkwWG3r45neXASL9wGzm1?=
 =?us-ascii?Q?gvJ5QbMEADwWXajz7d9e5Qx/woIh2U3wNk1R8sEorlNxdm/72cTRWZjGW83k?=
 =?us-ascii?Q?Phds7htB+KINnGmRXlWnPIVYrd7dA8AoV6uxDO5GgBKDcky9cVpmDL06+4Rt?=
 =?us-ascii?Q?9vyV4p5ylSrXmYDe3bU+jb3v/Im9lDrLshpUhEsTQKK5/4VvNBfWGIpaF5TO?=
 =?us-ascii?Q?9Gz8MczootPr88+Av7Nc5yJL6hwaIS6GA5J7ZaDcDzr0tclSAnFa8C/3NlcQ?=
 =?us-ascii?Q?h37o3x4V36HeIxUKkwGL9OGOjn+VBN8M6YbvJN8qoOSV8sSIYwxAhTpF3jHu?=
 =?us-ascii?Q?/ep3uK07WNxZWO19a2h6aV/xeCdN33UkvkT9gqtNbuZa/mZPepqVk72Sq3WP?=
 =?us-ascii?Q?0YxteGVHiBucD5/Zcd52Q4IRsmauoo70ovfEBOqgpWHFu390XNZPzRr4Hhzc?=
 =?us-ascii?Q?R9phSgYcowTC/Rop6j0d1CJKKMSnQrzNncxS4C5BMxDDYgIH6BO62ZT5VNSM?=
 =?us-ascii?Q?VqlbQLbUgZwaTjF1IIcv7oVpRgd5Be63xFAE8t0wf6GCmPvk4X5WvIBl2Hyx?=
 =?us-ascii?Q?SD7lU4M5p4jYoiiwpDXB/2sOt19pIgEaKDImgd4tDpArmurbfpKdnXlnfEQL?=
 =?us-ascii?Q?tMZuVIFn7P6HP17B509ON94j44rz+VZK6PPJTNnJ7EQM1dmAUBfv9w++IxoC?=
 =?us-ascii?Q?c4+AGjcsxh6Vp4yjGP0QoMxvEq5HBiUmnEQx1cfLC9JpTUrzLvnx7QF5Tbvv?=
 =?us-ascii?Q?EmBU1jorPu+KyGlejEGqfgLF8OwEX2GMsYjPLWPc+maJrEg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8641d7-112c-4c3e-67aa-08d8b299aaa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2021 23:20:33.1917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mBr4ZA5Njh0QXGOz07ZhMNPWZHaR8nPw0VDE5KURPHFcpgfmlvMf1bphuT7LRuhDecB5T5YcDGl0YVIuoibqdf3wn+dlJQXug21vp/i/lzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0735
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
Tested-by: Matheus Castello <matheus@castello.eng.br>
---
In V2:
- Addressed feedback comments
- Added page reporting config option tied to hyper-v balloon config

In V3:
- Addressed feedback from Vitaly
---
 arch/x86/hyperv/hv_init.c         | 31 +++++++++++
 arch/x86/kernel/cpu/mshyperv.c    |  6 +-
 drivers/hv/Kconfig                |  1 +
 drivers/hv/hv_balloon.c           | 93 +++++++++++++++++++++++++++++++
 include/asm-generic/hyperv-tlfs.h | 32 ++++++++++-
 include/asm-generic/mshyperv.h    |  2 +
 6 files changed, 162 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index e04d90af4c27..5b610e47d091 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -528,3 +528,34 @@ bool hv_is_hibernation_supported(void)
 	return acpi_sleep_state_supported(ACPI_STATE_S4);
 }
 EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
+
+/* Bit mask of the extended capability to query: see HV_EXT_CAPABILITY_xxx=
 */
+bool hv_query_ext_cap(u64 cap_query)
+{
+	u64 *cap;
+	unsigned long flags;
+	u64 ext_cap =3D 0;
+
+	/*
+	 * Querying extended capabilities is an extended hypercall. Check if the
+	 * partition supports extended hypercall, first.
+	 */
+	if (!(ms_hyperv.priv_high & HV_ENABLE_EXTENDED_HYPERCALLS))
+		return 0;
+
+	/*
+	 * Repurpose the input page arg to accept output from Hyper-V for
+	 * now because this is the only call that needs output from the
+	 * hypervisor. It should be fixed properly by introducing an
+	 * output arg once we have more places that require output.
+	 */
+	local_irq_save(flags);
+	cap =3D *(u64 **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	if (hv_do_hypercall(HV_EXT_CALL_QUERY_CAPABILITIES, NULL, cap) =3D=3D
+	    HV_STATUS_SUCCESS)
+		ext_cap =3D *cap;
+
+	local_irq_restore(flags);
+	return ext_cap & cap_query;
+}
+EXPORT_SYMBOL_GPL(hv_query_ext_cap);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.=
c
index 05ef1f4550cb..f4c0d69c61ae 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -225,11 +225,13 @@ static void __init ms_hyperv_init_platform(void)
 	 * Extract the features and hints
 	 */
 	ms_hyperv.features =3D cpuid_eax(HYPERV_CPUID_FEATURES);
+	ms_hyperv.priv_high =3D cpuid_ebx(HYPERV_CPUID_FEATURES);
 	ms_hyperv.misc_features =3D cpuid_edx(HYPERV_CPUID_FEATURES);
 	ms_hyperv.hints    =3D cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
=20
-	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
-		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
+	pr_info("Hyper-V: privilege flags low:0x%x, high:0x%x, hints:0x%x, misc:0=
x%x\n",
+		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
+		ms_hyperv.misc_features);
=20
 	ms_hyperv.max_vp_index =3D cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
 	ms_hyperv.max_lp_index =3D cpuid_ebx(HYPERV_CPUID_IMPLEMENT_LIMITS);
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 79e5356a737a..66c794d92391 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -23,6 +23,7 @@ config HYPERV_UTILS
 config HYPERV_BALLOON
 	tristate "Microsoft Hyper-V Balloon driver"
 	depends on HYPERV
+	select PAGE_REPORTING
 	help
 	  Select this option to enable Hyper-V Balloon driver.
=20
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 8c471823a5af..c0ff0a48f540 100644
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
@@ -1568,6 +1573,84 @@ static void balloon_onchannelcallback(void *context)
=20
 }
=20
+#ifdef CONFIG_PAGE_REPORTING
+/* Hyper-V only supports reporting 2MB pages or higher */
+#define HV_MIN_PAGE_REPORTING_ORDER	9
+#define HV_MIN_PAGE_REPORTING_LEN (HV_HYP_PAGE_SIZE << HV_MIN_PAGE_REPORTI=
NG_ORDER)
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
+	WARN_ON_ONCE(nents > HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES);
+	local_irq_save(flags);
+	hint =3D *(struct hv_memory_hint **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	if (!hint) {
+		local_irq_restore(flags);
+		return -ENOSPC;
+	}
+
+	hint->type =3D HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD;
+	hint->reserved =3D 0;
+	for_each_sg(sgl, sg, nents, i) {
+		union hv_gpa_page_range *range;
+
+		range =3D &hint->ranges[i];
+		range->address_space =3D 0;
+		/* page reportting only reports 2MB pages or higher */
+		range->page.largepage =3D 1;
+		range->page.additional_pages =3D
+			(sg->length / HV_MIN_PAGE_REPORTING_LEN) - 1;
+		range->base_large_pfn =3D
+			page_to_pfn(sg_page(sg)) >> HV_MIN_PAGE_REPORTING_ORDER;
+	}
+
+	status =3D hv_do_rep_hypercall(HV_EXT_CALL_MEMORY_HEAT_HINT, nents, 0,
+				     hint, NULL);
+	local_irq_restore(flags);
+	if ((status & HV_HYPERCALL_RESULT_MASK) !=3D HV_STATUS_SUCCESS) {
+		pr_err("Cold memory discard hypercall failed with status %llx\n",
+			status);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void enable_page_reporting(void)
+{
+	int ret;
+
+	BUILD_BUG_ON(pageblock_order < HV_MIN_PAGE_REPORTING_ORDER);
+	if (!hv_query_ext_cap(HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT)) {
+		pr_debug("Cold memory discard hint not supported by Hyper-V\n");
+		return;
+	}
+
+	BUILD_BUG_ON(PAGE_REPORTING_CAPACITY > HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES=
);
+	dm_device.pr_dev_info.report =3D hv_free_page_report;
+	ret =3D page_reporting_register(&dm_device.pr_dev_info);
+	if (ret < 0) {
+		dm_device.pr_dev_info.report =3D NULL;
+		pr_err("Failed to enable cold memory discard: %d\n", ret);
+	} else {
+		pr_info("Cold memory discard hint enabled\n");
+	}
+}
+
+static void disable_page_reporting(void)
+{
+	if (dm_device.pr_dev_info.report) {
+		page_reporting_unregister(&dm_device.pr_dev_info);
+		dm_device.pr_dev_info.report =3D NULL;
+	}
+}
+#endif /* CONFIG_PAGE_REPORTING */
+
 static int balloon_connect_vsp(struct hv_device *dev)
 {
 	struct dm_version_request version_req;
@@ -1713,6 +1796,10 @@ static int balloon_probe(struct hv_device *dev,
 	if (ret !=3D 0)
 		return ret;
=20
+#ifdef CONFIG_PAGE_REPORTING
+	enable_page_reporting();
+#endif
+
 	dm_device.state =3D DM_INITIALIZED;
=20
 	dm_device.thread =3D
@@ -1731,6 +1818,9 @@ static int balloon_probe(struct hv_device *dev,
 #ifdef CONFIG_MEMORY_HOTPLUG
 	unregister_memory_notifier(&hv_memory_nb);
 	restore_online_page_callback(&hv_online_page);
+#endif
+#ifdef CONFIG_PAGE_REPORTING
+	disable_page_reporting();
 #endif
 	return ret;
 }
@@ -1753,6 +1843,9 @@ static int balloon_remove(struct hv_device *dev)
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
index e73a11850055..75c20be2cc44 100644
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
@@ -152,11 +153,18 @@ struct ms_hyperv_tsc_page {
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
@@ -367,7 +375,7 @@ struct hv_guest_mapping_flush {
  */
 #define HV_MAX_FLUSH_PAGES (2048)
=20
-/* HvFlushGuestPhysicalAddressList hypercall */
+/* HvFlushGuestPhysicalAddressList, HvExtCallMemoryHeatHint hypercall */
 union hv_gpa_page_range {
 	u64 address_space;
 	struct {
@@ -375,6 +383,12 @@ union hv_gpa_page_range {
 		u64 largepage:1;
 		u64 basepfn:52;
 	} page;
+	struct {
+		u64 reserved:12;
+		u64 page_size:1;
+		u64 reserved1:8;
+		u64 base_large_pfn:43;
+	};
 };
=20
 /*
@@ -494,4 +508,20 @@ struct hv_set_vp_registers_input {
 	} element[];
 } __packed;
=20
+/*
+ * The whole argument should fit in a page to be able to pass to the hyper=
visor
+ * in one hypercall.
+ */
+#define HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES  \
+	((PAGE_SIZE - sizeof(struct hv_memory_hint)) / \
+		sizeof(union hv_gpa_page_range))
+
+/* HvExtCallMemoryHeatHint hypercall */
+#define HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD	2
+struct hv_memory_hint {
+	u64 type:2;
+	u64 reserved:62;
+	union hv_gpa_page_range ranges[];
+} __packed;
+
 #endif
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.=
h
index c57799684170..93c1303f5e00 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -27,6 +27,7 @@
=20
 struct ms_hyperv_info {
 	u32 features;
+	u32 priv_high;
 	u32 misc_features;
 	u32 hints;
 	u32 nested_features;
@@ -170,6 +171,7 @@ void hyperv_report_panic_msg(phys_addr_t pa, size_t siz=
e);
 bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
 void hyperv_cleanup(void);
+bool hv_query_ext_cap(u64 cap_query);
 #else /* CONFIG_HYPERV */
 static inline bool hv_is_hyperv_initialized(void) { return false; }
 static inline bool hv_is_hibernation_supported(void) { return false; }
--=20
2.17.1

