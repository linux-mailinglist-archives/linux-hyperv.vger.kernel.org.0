Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164E12EB18E
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jan 2021 18:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbhAERkd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jan 2021 12:40:33 -0500
Received: from mail-bn7nam10on2136.outbound.protection.outlook.com ([40.107.92.136]:50400
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726132AbhAERkd (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jan 2021 12:40:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTDVlIwiLO0Lpm+dR/FBlPbnS+UQ7Lp+XhABDNQ4mxKfBwrI0EHSl6uUAYTex3CPKlH9rLwBHJf8KdAHbhKk29hVwpHYnmmHAfU9u0YmaPntbjwAwXa9lb8NylZCr1EPfcqezjwweEN4142ODs265OL6DFBW+t3WXcJzhiPIUxLv4s5TGxB3/GcoZaaOWIZSPB9NYKAOnoYYdwr10zXnM1nTkDNVn2TZpLffX0t2eHq1np0hyEUUtjBcxR9rw/Ja3wcbqjGYoAA6fZCjoq2sOjHq5BxBK9DZlhzKCrW7znMFTFvy06JGyEaGk2sThAIcaeOgMVZCVeZkHgXO9anwSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBm9Gxf0v1GryB9aaGeZGosPbdOU66QupOaGPePhXTM=;
 b=JS6sMIFDn11/jmjz/1qhRnA+ZyaMo33Ne844EnTSzXYpVac+XxShEOCXEcrpqHcSpRjoMVlbRsaKPKSh+8OGvySOW12XZ4wrgn7rD0iBcQ2VZtBSg6eUMhqTSc+YJX+iM5GTtEHmDDkh+UnN27DHjsHsmgqat/HyfGOodXQUtuuqEWah1dYHJP9R83HKl3p/IBKxjBVNA1gAxE+hQKQ3CBbM1m9teDzRjyUMhBAgeKZ7MtRYPjyhtacA+r9Vyv8V0GwSRK95XNkbdvsgO7tc2AUHsXANZglMq4bEFq5ngBxZgx18oCx0YA6ndkCz5V4o9TKmC3lTc6yeGnnyW4YN8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBm9Gxf0v1GryB9aaGeZGosPbdOU66QupOaGPePhXTM=;
 b=KXKMvqr/r2a4YmaX0HG4BUSZHHtc2ZXGvBD7aXsLFqMx0J9dwCmaiB6r54xQL4caMM9tt4WzeEmpKjrwHaw3/omjHSPs63OD5Si/RBJCr2E8fJUcHD3AobE3uOOv1ff84oCd+1SQ/gP5PNW6IsuZqNpdt10+o3yCRQiIfhJQkgo=
Received: from (2603:10b6:803:51::33) by
 SN4PR2101MB0815.namprd21.prod.outlook.com (2603:10b6:803:51::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2; Tue, 5 Jan
 2021 17:39:43 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8%4]) with mapi id 15.20.3763.002; Tue, 5 Jan 2021
 17:39:43 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, vkuznets <vkuznets@redhat.com>
CC:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matheus Castello <matheus@castello.eng.br>,
        KY Srinivasan <kys@microsoft.com>
Subject: [PATCH v2] x86/Hyper-V: Support for free page reporting
Thread-Topic: [PATCH v2] x86/Hyper-V: Support for free page reporting
Thread-Index: AdbjiOckXy2XABo0QQC5vn/n9MZDig==
Date:   Tue, 5 Jan 2021 17:39:43 +0000
Message-ID: <SN4PR2101MB08800F9A2F6961A05DAEAE4BC0D19@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:f11f:f773:1cef:ecfe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 938856dd-4869-4823-c92f-08d8b1a0e307
x-ms-traffictypediagnostic: SN4PR2101MB0815:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN4PR2101MB0815407AF419ADDAB51E864BC0D19@SN4PR2101MB0815.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FSLtkdNV8wbEr/LuPiTZl2bZfZxfmPHak8irfFKNqN1XQtlXtTmmdBoMKkjtsTQ/lnQ5KN6UilxyDiRX/XtFeoABOklK/knKgM540aP0GbH1YRJVfmWR1/KvzqbaQr9Syg6W9taUSl+bELk0Tbgh5d5rZTFPy2NacUy4VDAsej2oZhwxxyEwGLOwrmtEg5/+BteBdJ41hp43enpl/A2InL9C6Kz21nCNpq9XyeHKOY9aOW6qYLsYcEJjsz7TOMAksiXmQtBPG+MrVImG7+b+2/deYfWiZkreXhiCGnlh33rHL2p3fDOMyIIRtEj/AUmDhG8reTAs7YTD2rKvH/ASTBxOt/LxfzZHhbUNjL6WdTeRdW6APiDnmddHz2QqRrwKxq6uVCBuqaGHpS7cL/gb0mwcxlNTaeoL3ZUCCokLWLf2mLcpQ05PjrE/QQOE6wC2i0NHfkC75+SXrvVC0w/1TA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(107886003)(66556008)(55016002)(83380400001)(10290500003)(9686003)(8676002)(71200400001)(86362001)(8936002)(54906003)(110136005)(478600001)(5660300002)(6506007)(52536014)(4326008)(2906002)(7696005)(316002)(186003)(82960400001)(82950400001)(76116006)(66946007)(66446008)(8990500004)(64756008)(33656002)(66476007)(21314003)(4533004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DyMRvgRYUNQqv+L8ofP9enMckFLrY/XI3CaPZCTXY9CnGqEHI+S3doizLVuO?=
 =?us-ascii?Q?UD9+c0NUBIoFoA58PndOPirMPuRr2DURF0jfAo5+z/mmFpKy/aQ4SVp4pwFX?=
 =?us-ascii?Q?2NXecLb2N27FZ2Rdf8J6NKAo9Zz+Qs9wo8jlhX4/a1tS6U88aC/rHPrOizh2?=
 =?us-ascii?Q?TaPlyaQyVam3Kb84bGSj5IZp4Yo1mjiVOcJeHJVhDuTRUs8+3Zte5YJAwhsx?=
 =?us-ascii?Q?9cjACG8szDxSuMuo8eKuJV7lIWZ3ti60aj3yzqxd076T1rFIyAD9CR4EbzAf?=
 =?us-ascii?Q?mH1MyFtLdz0FW+JJ2gR20o7qjx0aTMZiKAHC4TeJX1EhEYhgWB1nKA73El12?=
 =?us-ascii?Q?1s3QqlnNlCAhUC8adG6GlGid6X58ccuDFbUpI6UKJv5klwGyAqRRgKiNH0/0?=
 =?us-ascii?Q?//MhRSVVgb8EQjsn0A9yDITDQYPpOr5zb8oUq1WnNmvoq6f8e8+1VnFR2Qej?=
 =?us-ascii?Q?eBu96vl5PBXy9xei5zitfAUEmIZyxppiS0MOxisptiMSeQkhQp1++OxwZo7U?=
 =?us-ascii?Q?vYfdgLhN7P4IIjbVSYIX8Dpfp973VOGejjVX+yZaw2UYxxtkVMiHjWBYnkEJ?=
 =?us-ascii?Q?BROGWAiOdGH/sAl2cfgaeAWAmYumkNMDC3O6wuYBurD0tNcvHkX+gUNejKGj?=
 =?us-ascii?Q?fW65GERc7TKO+ZFTFOBWBUhli6DCCFd6JHT9CjT5uOhfdd6qcnpaikwbLQY7?=
 =?us-ascii?Q?dkZlF0oItn58H8BrspiOg8DNlVqoVEfXinBoMFEhFBKycCx6Rx2/yVeLR/6R?=
 =?us-ascii?Q?A9Nzl4ldWYIS0zGuyBvnVdq19SSPNgoLeLv+pr1E8f+ZhqUYltzoIiuwqkRu?=
 =?us-ascii?Q?g+1slSf5QUoq+6VjfJvlCahkE7ZGfvOGKE+cRuojbh7NHpCPG6AOfaXtBLGw?=
 =?us-ascii?Q?tlwACvurIDP4fDBSdcp43MzRUFvGRxwja9dtKMK7Zv9lAvTbwLUQoqbIcUPE?=
 =?us-ascii?Q?k01ed0F6fpV9seFJbZXeLobIVUsJkAr5i2v5PZMQAs5/WHfOgAmXqAPx/GP2?=
 =?us-ascii?Q?eTZry/0y+yBQc4hNtcmiMc0jRWkrPtmsXF5SBZPJBzXEcN0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 938856dd-4869-4823-c92f-08d8b1a0e307
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 17:39:43.3574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zj7oNsipE0nWYpActaFMT3yFnke8TOjcFPORPvv0nVpR81fjduxkG2T5XvmwKK24XoHMSZutrjwNZuASepCT1OP2M+1oBbo7Jjfe6+oj4Bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0815
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
---
 arch/x86/hyperv/hv_init.c         | 31 +++++++++++
 arch/x86/kernel/cpu/mshyperv.c    |  6 +-
 drivers/hv/Kconfig                |  1 +
 drivers/hv/hv_balloon.c           | 93 +++++++++++++++++++++++++++++++
 include/asm-generic/hyperv-tlfs.h | 32 ++++++++++-
 include/asm-generic/mshyperv.h    |  2 +
 6 files changed, 162 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index e04d90af4c27..1ed7ba07e009 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -528,3 +528,34 @@ bool hv_is_hibernation_supported(void)
 	return acpi_sleep_state_supported(ACPI_STATE_S4);
 }
 EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
+
+// Bit mask of the extended capability to query: see HV_EXT_CAPABILITY_xxx
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
index 05ef1f4550cb..7a7735918350 100644
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
+	pr_info("Hyper-V: features 0x%x, privilege flags high: 0x%x, hints 0x%x, =
misc 0x%x\n",
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
index 8c471823a5af..bb0624bf615b 100644
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
+	WARN_ON(nents > HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES);
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
+		pr_info("Cold memory discard hint not supported by Hyper-V\n");
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
+#endif //CONFIG_PAGE_REPORTING
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
index e73a11850055..abffd27bd6cb 100644
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
+};
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

