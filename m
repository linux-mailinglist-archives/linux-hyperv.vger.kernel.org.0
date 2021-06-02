Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8D8399579
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 23:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhFBVis (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Jun 2021 17:38:48 -0400
Received: from mail-co1nam11on2109.outbound.protection.outlook.com ([40.107.220.109]:57759
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229576AbhFBVis (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 17:38:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhelD8pqajIAmY8xaw2ZkOYXh1MdLKAIvTaWwNMecM4Ud4LI7WTONggXTZzOZfQLFDgqPrGsNeoUiMdLnvyxFVsiuvDQabx8Ecmtay6GdTix1BuJqI7k8oHZiJvypTFI44Y5WU6m1312L2vDDPmqAEhZXRxqEE/LyGU4bOzCxMKwehFRYxqx6vjy7QuNwAYvSldpFMdqm/p0+wNo6/pzKDppOXSEapkrlrwr3dZ0qfJUpwM4Nw9EnvHIeegYenhXHL4qC3egCnOwmNDOd0Crlh0CUkIH/PwodHaeARGluk/8cLfBh0hPOPCExMS1DOoMIJfRncAs/z6c69qW0fhBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTUKD/kjniKdXqtN5vvmMWazKJC+vgrmTuHH1fT1RmE=;
 b=AcVQu9vgr3UFw2NLxvhD1likkT8VqWmoLew+gz/14h4fA3RcDecZFNJKEwuLPEtEi0ltIXlKa5gmNLCocSjwV2FlckbbtxC0NuZcOl9dE9xMp02vAyOSh+1NJzel/RgizfSVy0cnvgJ0beFZ7IoAUIB1Rljvi+XVsEqbXDjUuDms88DfGPKrno4ppm/JcKRKT/NRmi8cTZwA4+lCrC9cCBRAcECNgo8QFsIKlSLDUdpBGoSaTBdl/G2UfiUVa+UQxdGykKQxDIbn/oHQl0PaE/FHZX3O3yUWnDI3Hb1IXGgieKMVuWwV8Hj3qmNQVPPZdgED2opG978EZAOdla8gkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTUKD/kjniKdXqtN5vvmMWazKJC+vgrmTuHH1fT1RmE=;
 b=I7YzyZRznSXwGvDtzRFrnJ8HVIbmN3CaVGz7NUW6h8xpRApWKrrgHuaVGkbUwwkZpMTyrsaS67XEoXFYIHpuU05RNDoZv3N6deDYyaVequRp66VxN2xaCOVow+HvWVHnC1n64PJ5dUYWYD7HiiRxBifsSEfJmMRh1770/7LG2gw=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR21MB0155.namprd21.prod.outlook.com (2603:10b6:3:a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.3; Wed, 2 Jun
 2021 21:37:02 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588%6]) with mapi id 15.20.4219.010; Wed, 2 Jun 2021
 21:37:02 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, sunilmut@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] Drivers: hv: Move Hyper-V extended capability check to arch neutral code
Date:   Wed,  2 Jun 2021 14:36:44 -0700
Message-Id: <1622669804-2016-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [131.107.159.144]
X-ClientProxiedBy: MW4PR04CA0251.namprd04.prod.outlook.com
 (2603:10b6:303:88::16) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.159.144) by MW4PR04CA0251.namprd04.prod.outlook.com (2603:10b6:303:88::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Wed, 2 Jun 2021 21:37:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0744343d-bb42-4133-7cf2-08d9260e8f0e
X-MS-TrafficTypeDiagnostic: DM5PR21MB0155:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR21MB0155DEAB87D5F9C66D64D46DD73D9@DM5PR21MB0155.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 752DCqT6UdKIf4ScB0/norhkYFKFRfsopQEzmXSfoXHMNpcLzl4klhvF+MrDjG/5PK4HjaIWal59RZpaLToiA8ZyinLnKYztmrZeYZY/D6u+42ji1cgKL8sPMgjSAno57ioQZyYGe0Xou0exnFenokH6+51BgH++vQcg8F3bR5vGdr0nkzYu7QMv5mBGiv5mjHwUz9f9G6dm3xh0CqCojOan9LbfkNPsGoWymAdJz3XCypLtgY/4x8trTYcWIpjNpNX0cJ82m0HXbvq2cpCd2sLyslTpx3ytrjtoi0Ez6cAe0BWBa4Qbhz9/xpvtSJXHruprwjQlwwOdAepefmcH5mv48zq5lrkd+2dT8wQYa5d4+YtQT7ta23XE6dcn4bRL1D7PQZdpmhguRuh7q/dGf6g2WBXtf+rMXT2LDmWI/2L/G32ilhDgFrnm0jjGNRYyHw3eV98Nc+x+aTCrBuwDeIqLKNupxfqP+tmuE+DHpyJ7s4WDILMfemFv3UKYH1Cqo6Gvn38qrHRlUGsXNklAQU5G77PHUmjrhWtgDZK508mDBV45L0UEMOol/0aPAY4wHqZJ7W5n4qytoWDUaDuzJ8PcSadhat7nHruwG2Ri4EFLMF3kvwV8505Rl541VUbO2y1XD/xT9MQCxFhSDVmu3gKAlTqL36fxyxgRIlIUNMy7rpH9dZbAVrML0JL6ZkkmBCpV2HKQ7VEUSZ/mngJ+XVxAs4kn5nyI+iQeGZ9w96t3Yt/UAEsRIOMtvyr7Y9CM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(52116002)(4326008)(8936002)(10290500003)(6486002)(66946007)(26005)(66556008)(66476007)(8676002)(2906002)(107886003)(6666004)(956004)(2616005)(5660300002)(16526019)(498600001)(6636002)(186003)(83380400001)(86362001)(36756003)(921005)(38100700002)(38350700002)(82960400001)(82950400001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Q8NIlTJfmZyGcbagTyoa6edKneozaGA2/d2/VoMPVQ9KZHxVfFus0Q6C4w+?=
 =?us-ascii?Q?d1xavXLimRSx/c84jukEoTtNtfNK8l8ku9i8eRySkE1vzT4/oLCZsMXtvi0c?=
 =?us-ascii?Q?fs43xfezIBeptclml6a7sUCr0uMPvWnZ+5+aHfNdqvyoo1cG6JWo1n9ebx4C?=
 =?us-ascii?Q?bROOCXFPI+F591BVeFCwXVSnIGjR7LdnOI9lF6iy4OYykFqkbCMqk71Q9fsR?=
 =?us-ascii?Q?CYOpxzV2tGPHR8rPpVBBii3XZFaYsW01I2hV53mcJ9BlE68TQELsUp2w3iAC?=
 =?us-ascii?Q?AcLeaV/ZPx1rhbwSYA0dJ6Yi/mZ77UHAjw4NWTcuuOnJbP/er8Q8IqbFMKHs?=
 =?us-ascii?Q?EyeGFzhNkIEmUuSK/55cgWHDqcp+/UdUyZ7d++5o7mbc4jlA4le5O5h0+RIo?=
 =?us-ascii?Q?MCMXW4NBqyX6WzHQXcrqXP4AlGWZPNw0t0dGsYKdiuEDjt8XFeiTW5PsbsXC?=
 =?us-ascii?Q?IepoKvz2OiTHUtO0GWBqpRWW/0YG3jDSVnO0YdUvrX/Jsrjq0EGmwnf2+pIv?=
 =?us-ascii?Q?Ihh9JEQXNDC6W1CL04/NdebM4rcKbI8kEA4CjLjOj5OKI2OMboOnLs+2pexd?=
 =?us-ascii?Q?MJksgS8Z4K6QypQkbwBUkC+ZCbqkmmyoSQUWZmb6/eXX5QlO4TnQ0KYDhLF5?=
 =?us-ascii?Q?R8OjF4k7ANo8+KiSfE2JoMazfBVVWKwwPPsb9skwkLvz0v/R51IYiymWsOWX?=
 =?us-ascii?Q?WtUZODhB46aXryLN2oIgiWH7tpjDsSnfOnAwoUcOb+eiSvohTTgeRs1O9LJR?=
 =?us-ascii?Q?DUn5UR3/0FG4+i23os9B9uw3xRx0IHckVcoouW+CIsxK1UPBbprF7qcHQ+eN?=
 =?us-ascii?Q?C27+RHO6rxHanNiUOTlb4xwGHQ2FuxbQqrBcdoWP9pTlbxCwzmuHwJ43yLeX?=
 =?us-ascii?Q?dWnamsplSsyyNRy46dVt31Yn3BQX/iQ+B6POeGfDZMjBTuSmMmuq7N1xDTBj?=
 =?us-ascii?Q?DjPVgA2/KKgBCi/3CwhooPGi9hBdNXYVCkkfOYS2?=
X-MS-Exchange-AntiSpam-MessageData-1: /p6WxsgErLmhVPB+JFm88JoiJ22M70SCCJ615nt/gmuJxg+9GtWtku+aWDknn1U59vQenTLdK10vwxeH06rpC2+4NzifjO26608JylauG0JQ5pgqTGfr5HUqRsOe1WLp9YF5xR9TwnFkhnIQvQB+oG4YX16ubdmc6IirZNqVbsRNKGidBhEJ7fK2FDZIdlmsTYz/ppYmbiRUFI+7BLZyUv5T+VecIOTbRgnEuyjQXoTL1vJ/nEFaDesWS8Dtq6FMRwvY6dmmU1eh17p4dW+lGrePCOXcnnExyTwKkFDIUq2DAHI5X0TwvPRG67pKrsHIa2NIIgwYfZeae+kNCVA+cmGc
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0744343d-bb42-4133-7cf2-08d9260e8f0e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 21:37:02.2249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3Gvv0UxDmNN7fvbiV5dsqASWG8q99f6ElGosffFBHlDNpJkRW5Zipc5KNT/V93w1RhHnodSAX2Ue+DhP7vBkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0155
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The extended capability query code is currently under arch/x86, but it
is architecture neutral, and is used by arch neutral code in the Hyper-V
balloon driver. Hence the balloon driver fails to build on other
architectures.

Fix by moving the ext cap code out from arch/x86.  Because it is also
called from built-in architecture specific code, it can't be in a module,
so the Makefile treats as built-in even when CONFIG_HYPERV is "m".  Also
drivers/Makefile is tweaked because this is the first occurrence of a
Hyper-V file that is built-in even when CONFIG_HYPERV is "m".

While here, update the hypercall status check to use the new helper
function instead of open coding. No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 47 ---------------------------------
 drivers/Makefile          |  2 +-
 drivers/hv/Makefile       |  3 +++
 drivers/hv/hv_common.c    | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 48 deletions(-)
 create mode 100644 drivers/hv/hv_common.c

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index bb0ae4b..6952e21 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -614,50 +614,3 @@ bool hv_is_isolation_supported(void)
 	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
 }
 EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
-
-/* Bit mask of the extended capability to query: see HV_EXT_CAPABILITY_xxx */
-bool hv_query_ext_cap(u64 cap_query)
-{
-	/*
-	 * The address of the 'hv_extended_cap' variable will be used as an
-	 * output parameter to the hypercall below and so it should be
-	 * compatible with 'virt_to_phys'. Which means, it's address should be
-	 * directly mapped. Use 'static' to keep it compatible; stack variables
-	 * can be virtually mapped, making them imcompatible with
-	 * 'virt_to_phys'.
-	 * Hypercall input/output addresses should also be 8-byte aligned.
-	 */
-	static u64 hv_extended_cap __aligned(8);
-	static bool hv_extended_cap_queried;
-	u64 status;
-
-	/*
-	 * Querying extended capabilities is an extended hypercall. Check if the
-	 * partition supports extended hypercall, first.
-	 */
-	if (!(ms_hyperv.priv_high & HV_ENABLE_EXTENDED_HYPERCALLS))
-		return false;
-
-	/* Extended capabilities do not change at runtime. */
-	if (hv_extended_cap_queried)
-		return hv_extended_cap & cap_query;
-
-	status = hv_do_hypercall(HV_EXT_CALL_QUERY_CAPABILITIES, NULL,
-				 &hv_extended_cap);
-
-	/*
-	 * The query extended capabilities hypercall should not fail under
-	 * any normal circumstances. Avoid repeatedly making the hypercall, on
-	 * error.
-	 */
-	hv_extended_cap_queried = true;
-	status &= HV_HYPERCALL_RESULT_MASK;
-	if (status != HV_STATUS_SUCCESS) {
-		pr_err("Hyper-V: Extended query capabilities hypercall failed 0x%llx\n",
-		       status);
-		return false;
-	}
-
-	return hv_extended_cap & cap_query;
-}
-EXPORT_SYMBOL_GPL(hv_query_ext_cap);
diff --git a/drivers/Makefile b/drivers/Makefile
index 5a6d613..1c2e1ac 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -161,7 +161,7 @@ obj-$(CONFIG_SOUNDWIRE)		+= soundwire/
 
 # Virtualization drivers
 obj-$(CONFIG_VIRT_DRIVERS)	+= virt/
-obj-$(CONFIG_HYPERV)		+= hv/
+obj-$(subst m,y,$(CONFIG_HYPERV))	+= hv/
 
 obj-$(CONFIG_PM_DEVFREQ)	+= devfreq/
 obj-$(CONFIG_EXTCON)		+= extcon/
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 94daf82..d76df5c 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -11,3 +11,6 @@ hv_vmbus-y := vmbus_drv.o \
 		 channel_mgmt.o ring_buffer.o hv_trace.o
 hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_fcopy.o hv_utils_transport.o
+
+# Code that must be built-in
+obj-$(subst m,y,$(CONFIG_HYPERV)) += hv_common.o
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
new file mode 100644
index 0000000..f0053c7
--- /dev/null
+++ b/drivers/hv/hv_common.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Architecture neutral utility routines for interacting with
+ * Hyper-V. This file is specifically for code that must be
+ * built-in to the kernel image when CONFIG_HYPERV is set
+ * (vs. being in a module) because it is called from architecture
+ * specific code under arch/.
+ *
+ * Copyright (C) 2021, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ */
+
+#include <linux/types.h>
+#include <linux/export.h>
+#include <linux/bitfield.h>
+#include <asm/hyperv-tlfs.h>
+#include <asm/mshyperv.h>
+
+
+/* Bit mask of the extended capability to query: see HV_EXT_CAPABILITY_xxx */
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
+	status = hv_do_hypercall(HV_EXT_CALL_QUERY_CAPABILITIES, NULL,
+				 &hv_extended_cap);
+
+	/*
+	 * The query extended capabilities hypercall should not fail under
+	 * any normal circumstances. Avoid repeatedly making the hypercall, on
+	 * error.
+	 */
+	hv_extended_cap_queried = true;
+	if (!hv_result_success(status)) {
+		pr_err("Hyper-V: Extended query capabilities hypercall failed 0x%llx\n",
+		       status);
+		return false;
+	}
+
+	return hv_extended_cap & cap_query;
+}
+EXPORT_SYMBOL_GPL(hv_query_ext_cap);
-- 
1.8.3.1

