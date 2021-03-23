Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655B834680D
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Mar 2021 19:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhCWSrt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 Mar 2021 14:47:49 -0400
Received: from mail-dm6nam08on2092.outbound.protection.outlook.com ([40.107.102.92]:7516
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232288AbhCWSrV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Mar 2021 14:47:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6NYdxcn/ytRP/E4YlDsvtUMzOl779vXt6lQuFamV0yOaZic8DTIlgq0StMS2czv2tlDEHvgcgy9glyAuhZEcfmXRpONkS6z96pnV1zZ7IbbLPK40cxtoJFiKZoKpqRZBPLvcuUdIUP/tRUlqJnqg4FgEmMKwNyEGcb2rVyzmI6oGL5Kuw4mvCtWW+UpxWmEktQL1vO65F/mdWUxK8a+qKcEylKOJRtJWZUpdQoTfQh99lV8thO0Ar8orrMmDEJXfhTIUjcvwJpy5W5FhsmFexZQqWrwnkjsnLPGljrcy/zfIhHQihdlytqEBnc6MXHdiGNeM1QtX857XLFzw9Dmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ug8s3Q3cY9dDwsjLXLOMKDLYobbpRTfghUTZF4StjOM=;
 b=Bn/h1YdxONNTVhRpi1r3i8VKCMeIR51U6gzTsd/tt8j1PPYdCyew7VjpabQfewzdAgpwYE+yDygrTkrSX2Ng19fbBeF9Q94Rw32nF4lCqhlLKZS8vRFrJrSswiKWM3tJHI4v/+sOklN96jyW5NHXmuOd288ruK18pdVAA+EF3zyapBk4Ge17vdiXllspA0wej3x90Kprql0uOdszOIzBmmlgF7/BNbhte99lMuSqsaSyK+mWijlZquhmgMrrFr3zlQ+l/WQXBPPx8Uj8jbCy1Oh6LV34ZlNLhUGR4gmZn++ZjzkaJTVmomtb23tmk/jKcqKvCKMyiAlXPh5hAt5u1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ug8s3Q3cY9dDwsjLXLOMKDLYobbpRTfghUTZF4StjOM=;
 b=KJi9/xuRDp3h3rrXOg4AC/FzddXGZQanfYGKHVlc7AVZ43Th8GTE240HWtR+DX12cmLbyYa9E1JRcccsrZrVmNZsYYPWnuxwG07pvKptMfidT++wGoEPyDI8dpGiHYrVVSrXj9mdnRZE7/+roi3Bqi8ZE6UbeQMaKdIugnE8O1Q=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SA0PR21MB1948.namprd21.prod.outlook.com
 (2603:10b6:806:ea::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.1; Tue, 23 Mar
 2021 18:47:17 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::9c4:80e2:3dca:bbeb]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::9c4:80e2:3dca:bbeb%3]) with mapi id 15.20.3999.006; Tue, 23 Mar 2021
 18:47:17 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, vkuznets <vkuznets@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v5] x86/Hyper-V: Support for free page reporting
Thread-Topic: [PATCH v5] x86/Hyper-V: Support for free page reporting
Thread-Index: AdcgFH7dfC3BJtekQZWwJ3zQkLf0mg==
Date:   Tue, 23 Mar 2021 18:47:16 +0000
Message-ID: <SN4PR2101MB0880121FA4E2FEC67F35C1DCC0649@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:89be:87cb:3c86:691c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60e9fe3c-6c37-4223-dc11-08d8ee2c14f2
x-ms-traffictypediagnostic: SA0PR21MB1948:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SA0PR21MB1948EF791061FCAB7C531825C0649@SA0PR21MB1948.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HmljGkStMER26xam6j0x5JzbO0ljF4+sQh0Wk8ZUPMRndJm8IkZ2/XcB2bcOpzleDJ/rMkj15j3aAxLYIBHoJR8BdVyKbdYGqHiXogiiozTK6mZLnA3Wu937fp19/sCTolxqOs1H7ug7pFUgorHdOqQVktuR6KfIS4UdEkSEQTJwKyZLo1dn3RPV7iyDJaF5qFQHvUYpE351gWstu1WObdg6wCFzunRKhNlt1zPvfziOdPCXVxfSgCjy9tLbQq/Mi45Gw+VzDlZzPLuCRe62P8S7KSKwnOQvcDMt58o3oNyfEz8YykAGHwK2rr72NekbLmMSlZ66a9iV09iCpdy7+WWOLMybXV+Mk9CxzqTgqwOQviveZdm7JXg1Pp87K155PKUfoLpRf4bV4//ZMA1I52r0/LEYopCH/ZOROznCkLasf7v3InkBWo8q127iK+J9aYCSZ1izJmSUSUVYaa24E8YcelqUM3CyHUM9vVia43ZlDXJBEd2ie6qgroFT9IWiYefaMr8ZT5O9hi4hbgKy8jkEVdGlH6+M6E4t29Ro11peLBK6upYO6xe0mONspkRECcoHNgaVEERWnf38+t8PrCLTaMtfwc4zNMG3KTn0euo7pb5Nvyq+dKTyb/cQQqvPSi3ypVU29Pdg1fFCSJoEXYqTsWNkRhZU/f+J+4dS6duyaAkwYVGlNEg6JR/ggn2Ra8/E0U+PpVzrpbMW3b/agQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(54906003)(110136005)(186003)(66946007)(66446008)(9686003)(55016002)(5660300002)(8936002)(33656002)(8676002)(52536014)(76116006)(64756008)(316002)(66556008)(66476007)(10290500003)(86362001)(2906002)(4326008)(478600001)(83380400001)(38100700001)(82960400001)(8990500004)(6506007)(7696005)(82950400001)(6636002)(30864003)(71200400001)(21314003)(4533004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bms4Li9iYwMb1950a3p1PoQqT8fpqnpmjNQ1uxRCEh9oPYivKQMJkkP3q4uk?=
 =?us-ascii?Q?Lqn7HQ2ZVP5PkNXdZICrhcypEkmtQM8p4VSv5wPXXu4R0RjQSyn/wDHkpFxj?=
 =?us-ascii?Q?xI0RmRcPd5aVlVpnFcPi8HhVXpJg3xl8u0m+8Tp2hl0G/e+o/AD8FQfHnXeS?=
 =?us-ascii?Q?gHY2aInAzP7JgdujJP8KwXwdqwdEKBuzIq+jbb0OUSv3HzIARxcPKbfvrKyy?=
 =?us-ascii?Q?tO6H9f1cWI/KSX4EsywMHzMtdPEe2FVkAabg9AVx/egizl98/UFg6ky8N3E5?=
 =?us-ascii?Q?IR9MEAcEJxHmzPNSkw2Q2UaK43F3CRyr3mJtqHwLqeI0hEMc6rxil249e/KP?=
 =?us-ascii?Q?Qd9hQgf1ua0zx1/GetxShH4NEUk0dHXz2TLSmgav5Kl5ZRK4l6CAPNZQYeWd?=
 =?us-ascii?Q?01MqX64PysRiYu4ZD104H48ITafJiv5O70ZfNrYSfSxDplbRswjCZMP0LRaY?=
 =?us-ascii?Q?6EArTnK+OLqMaeWTg3IBIMJPJYNF389O+2Y3RjS8NiIBzli/1ob+oDfyYjaa?=
 =?us-ascii?Q?EE+BHMYd2CQYr/ZhbCSu0RD12mTgdhn+Aq/qe7pFLh8g219wnclPUcWNBdWe?=
 =?us-ascii?Q?2ZamkU1ri3/wkiosKNGuX8peWQWdgGy+qVeb2rMOJJR+SByLQU9/bwC12HZO?=
 =?us-ascii?Q?nbZr6xYvwyyIMBtYl9JkaxrMycNIPjDH36Iv13aNlqPFbDKuACiOTyLtI5Tg?=
 =?us-ascii?Q?5mGXtVjyNsdjeeXrdA4pS6HALdnlTF4uZfUW9o3VG2lw9OXLPKB4LiP3a1OZ?=
 =?us-ascii?Q?tvWcbjITRoRFgZBkIJLBged7Xb6NoJa82toFRaQno2ro/bdRd+T168IvxPCI?=
 =?us-ascii?Q?JTwimU8KEvbtbxmWLI19x6hnnpxmJ9MFlZ5IZbElbhc61WkETOAH0+u0/JCJ?=
 =?us-ascii?Q?3MY2PAJorLpaBI0VSUqj5enjU98028zH+RosXqd1QYmnXhNoGPjSKliBFOB/?=
 =?us-ascii?Q?isIwNKw0iCZ7LH+TNgdp60AkTv2pzM9T9CjhRWoTtz6V/vp8Y6zUAZ/uX8ZZ?=
 =?us-ascii?Q?PKqJ4Y64JJc3sM59XAD7drwpNuEx9lNdisL1zSD398jla3VwpZVcAjjo0/SB?=
 =?us-ascii?Q?fbOgWf6q6SPKJHd/On3e0IeB/6AkXejG/+7rMXXWPFThNxShdylty1vYbNNu?=
 =?us-ascii?Q?TRDHkLMMQborShNQ99EE/XqSxlnRLn3nb08khlKWKjuiEb/KGm18NodljU0x?=
 =?us-ascii?Q?fccqV0eCiThTjssnuvm3K/rw9G2vEY5HuEUsBKr3mTFx5ruQN6w1/rTX0E67?=
 =?us-ascii?Q?dQCjMuF8T72ICUoP1nmw6v40nY6/LZFP3UOGg40GyMvQ7iUivCdozN2Pe4vg?=
 =?us-ascii?Q?gNQ9OqUOP3OunHaVBN3zJXJonJ9VFZzlaeR+1Mhj0LF/SCLrIvxZSKVyght4?=
 =?us-ascii?Q?EFVRg6czHyp4OsrWegil2kpBiAuz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e9fe3c-6c37-4223-dc11-08d8ee2c14f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 18:47:16.8628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFzpyuUMpTGmpzA1fnUqTM05I7+1ueQClvR3/xUcNY1ePScjNCyxvJZARXHX3d8kOVxfzGHm4ZMh2rEZHPseFFViBD7c/qy9lwBO38a+q0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1948
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

In V4:
- Queried and cached the Hyper-V extended capability for the lifetime
  of the VM
- Addressed feedback from Michael Kelley.

In v5:
- Added a comment clarifying handling of failed query extended
  capability hypercall to address Michael's feedback.
---
 arch/x86/hyperv/hv_init.c         | 51 +++++++++++++++++-
 arch/x86/kernel/cpu/mshyperv.c    |  9 ++--
 drivers/hv/Kconfig                |  1 +
 drivers/hv/hv_balloon.c           | 89 +++++++++++++++++++++++++++++++
 include/asm-generic/hyperv-tlfs.h | 35 +++++++++++-
 include/asm-generic/mshyperv.h    |  3 +-
 6 files changed, 180 insertions(+), 8 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 9d100257b3af..7c9da3f65afa 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -498,6 +498,8 @@ void __init hyperv_init(void)
 		x86_init.irqs.create_pci_msi_domain =3D hv_create_pci_msi_domain;
 #endif
=20
+	/* Query the VMs extended capability once, so that it can be cached. */
+	hv_query_ext_cap(0);
 	return;
=20
 remove_cpuhp_state:
@@ -601,7 +603,7 @@ EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
=20
 enum hv_isolation_type hv_get_isolation_type(void)
 {
-	if (!(ms_hyperv.features_b & HV_ISOLATION))
+	if (!(ms_hyperv.priv_high & HV_ISOLATION))
 		return HV_ISOLATION_TYPE_NONE;
 	return FIELD_GET(HV_ISOLATION_TYPE, ms_hyperv.isolation_config_b);
 }
@@ -612,3 +614,50 @@ bool hv_is_isolation_supported(void)
 	return hv_get_isolation_type() !=3D HV_ISOLATION_TYPE_NONE;
 }
 EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
+
+/* Bit mask of the extended capability to query: see HV_EXT_CAPABILITY_xxx=
 */
+bool hv_query_ext_cap(u64 cap_query)
+{
+	/*
+	 * The address of the 'hv_extended_cap' variable will be used as an
+	 * output parameter to the hypercall below and so it should be
+	 * compatible with 'virt_to_phys'. Which means, it's address should be
+	 * directly mapped. Use 'static' to keep it compatible; stack variables
+	 * can be virtually mapped, making them imcompatible with
+	 * 'virt_to_phys'.
+	 * Hypercall input/output addresses should also be 8-byte aligned.
+	 */
+	static u64 hv_extended_cap __aligned(8);
+	static bool hv_extended_cap_queried;
+	u64 status;
+
+	/*
+	 * Querying extended capabilities is an extended hypercall. Check if the
+	 * partition supports extended hypercall, first.
+	 */
+	if (!(ms_hyperv.priv_high & HV_ENABLE_EXTENDED_HYPERCALLS))
+		return false;
+
+	/* Extended capabilities do not change at runtime. */
+	if (hv_extended_cap_queried)
+		return hv_extended_cap & cap_query;
+
+	status =3D hv_do_hypercall(HV_EXT_CALL_QUERY_CAPABILITIES, NULL,
+				 &hv_extended_cap);
+
+	/*
+	 * The query extended capabilities hypercall should not fail under
+	 * any normal circumstances. Avoid repeatedly making the hypercall, on
+	 * error.
+	 */
+	hv_extended_cap_queried =3D true;
+	status &=3D HV_HYPERCALL_RESULT_MASK;
+	if (status !=3D HV_STATUS_SUCCESS) {
+		pr_err("Hyper-V: Extended query capabilities hypercall failed 0x%llx\n",
+		       status);
+		return false;
+	}
+
+	return hv_extended_cap & cap_query;
+}
+EXPORT_SYMBOL_GPL(hv_query_ext_cap);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.=
c
index cebed535ec56..3546d3e21787 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -265,12 +265,13 @@ static void __init ms_hyperv_init_platform(void)
 	 * Extract the features and hints
 	 */
 	ms_hyperv.features =3D cpuid_eax(HYPERV_CPUID_FEATURES);
-	ms_hyperv.features_b =3D cpuid_ebx(HYPERV_CPUID_FEATURES);
+	ms_hyperv.priv_high =3D cpuid_ebx(HYPERV_CPUID_FEATURES);
 	ms_hyperv.misc_features =3D cpuid_edx(HYPERV_CPUID_FEATURES);
 	ms_hyperv.hints    =3D cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
=20
-	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
-		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
+	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc 0=
x%x\n",
+		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
+		ms_hyperv.misc_features);
=20
 	ms_hyperv.max_vp_index =3D cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
 	ms_hyperv.max_lp_index =3D cpuid_ebx(HYPERV_CPUID_IMPLEMENT_LIMITS);
@@ -316,7 +317,7 @@ static void __init ms_hyperv_init_platform(void)
 		x86_platform.calibrate_cpu =3D hv_get_tsc_khz;
 	}
=20
-	if (ms_hyperv.features_b & HV_ISOLATION) {
+	if (ms_hyperv.priv_high & HV_ISOLATION) {
 		ms_hyperv.isolation_config_a =3D cpuid_eax(HYPERV_CPUID_ISOLATION_CONFIG=
);
 		ms_hyperv.isolation_config_b =3D cpuid_ebx(HYPERV_CPUID_ISOLATION_CONFIG=
);
=20
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
index 2f776d78e3c1..58af84e30144 100644
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
@@ -563,6 +564,8 @@ struct hv_dynmem_device {
 	 * The negotiated version agreed by host.
 	 */
 	__u32 version;
+
+	struct page_reporting_dev_info pr_dev_info;
 };
=20
 static struct hv_dynmem_device dm_device;
@@ -1568,6 +1571,89 @@ static void balloon_onchannelcallback(void *context)
=20
 }
=20
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
+	WARN_ON_ONCE(sgl->length < HV_MIN_PAGE_REPORTING_LEN);
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
+		/* page reporting only reports 2MB pages or higher */
+		range->page.largepage =3D 1;
+		range->page.additional_pages =3D
+			(sg->length / HV_MIN_PAGE_REPORTING_LEN) - 1;
+		range->page_size =3D HV_GPA_PAGE_RANGE_PAGE_SIZE_2MB;
+		range->base_large_pfn =3D
+			page_to_hvpfn(sg_page(sg)) >> HV_MIN_PAGE_REPORTING_ORDER;
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
+	/* Essentially, validating 'PAGE_REPORTING_MIN_ORDER' is big enough. */
+	if (pageblock_order < HV_MIN_PAGE_REPORTING_ORDER) {
+		pr_debug("Cold memory discard is only supported on 2MB pages and above\n=
");
+		return;
+	}
+
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
+
 static int balloon_connect_vsp(struct hv_device *dev)
 {
 	struct dm_version_request version_req;
@@ -1713,6 +1799,7 @@ static int balloon_probe(struct hv_device *dev,
 	if (ret !=3D 0)
 		return ret;
=20
+	enable_page_reporting();
 	dm_device.state =3D DM_INITIALIZED;
=20
 	dm_device.thread =3D
@@ -1727,6 +1814,7 @@ static int balloon_probe(struct hv_device *dev,
 probe_error:
 	dm_device.state =3D DM_INIT_ERROR;
 	dm_device.thread  =3D NULL;
+	disable_page_reporting();
 	vmbus_close(dev->channel);
 #ifdef CONFIG_MEMORY_HOTPLUG
 	unregister_memory_notifier(&hv_memory_nb);
@@ -1749,6 +1837,7 @@ static int balloon_remove(struct hv_device *dev)
 	cancel_work_sync(&dm->ha_wrk.wrk);
=20
 	kthread_stop(dm->thread);
+	disable_page_reporting();
 	vmbus_close(dev->channel);
 #ifdef CONFIG_MEMORY_HOTPLUG
 	unregister_memory_notifier(&hv_memory_nb);
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv=
-tlfs.h
index 9cf10837d005..515c3fb06ab3 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -89,9 +89,9 @@
 #define HV_ACCESS_STATS				BIT(8)
 #define HV_DEBUGGING				BIT(11)
 #define HV_CPU_MANAGEMENT			BIT(12)
+#define HV_ENABLE_EXTENDED_HYPERCALLS		BIT(20)
 #define HV_ISOLATION				BIT(22)
=20
-
 /*
  * TSC page layout.
  */
@@ -159,11 +159,18 @@ struct ms_hyperv_tsc_page {
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
@@ -408,8 +415,10 @@ struct hv_guest_mapping_flush {
  *  by the bitwidth of "additional_pages" in union hv_gpa_page_range.
  */
 #define HV_MAX_FLUSH_PAGES (2048)
+#define HV_GPA_PAGE_RANGE_PAGE_SIZE_2MB		0
+#define HV_GPA_PAGE_RANGE_PAGE_SIZE_1GB		1
=20
-/* HvFlushGuestPhysicalAddressList hypercall */
+/* HvFlushGuestPhysicalAddressList, HvExtCallMemoryHeatHint hypercall */
 union hv_gpa_page_range {
 	u64 address_space;
 	struct {
@@ -417,6 +426,12 @@ union hv_gpa_page_range {
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
@@ -774,4 +789,20 @@ struct hv_input_unmap_device_interrupt {
 #define HV_SOURCE_SHADOW_NONE               0x0
 #define HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE   0x1
=20
+/*
+ * The whole argument should fit in a page to be able to pass to the hyper=
visor
+ * in one hypercall.
+ */
+#define HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES  \
+	((HV_HYP_PAGE_SIZE - sizeof(struct hv_memory_hint)) / \
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
index 2d1b6cd9f000..63c0e579bf6d 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -27,7 +27,7 @@
=20
 struct ms_hyperv_info {
 	u32 features;
-	u32 features_b;
+	u32 priv_high;
 	u32 misc_features;
 	u32 hints;
 	u32 nested_features;
@@ -179,6 +179,7 @@ bool hv_is_hibernation_supported(void);
 enum hv_isolation_type hv_get_isolation_type(void);
 bool hv_is_isolation_supported(void);
 void hyperv_cleanup(void);
+bool hv_query_ext_cap(u64 cap_query);
 #else /* CONFIG_HYPERV */
 static inline bool hv_is_hyperv_initialized(void) { return false; }
 static inline bool hv_is_hibernation_supported(void) { return false; }
--=20
2.17.1
