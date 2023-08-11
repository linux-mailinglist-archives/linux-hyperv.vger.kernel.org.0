Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AABA7786FD
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Aug 2023 07:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjHKFcm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Aug 2023 01:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHKFcl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Aug 2023 01:32:41 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021020.outbound.protection.outlook.com [52.101.57.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14CE272D;
        Thu, 10 Aug 2023 22:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXczdRO0rzbMfpcSe4Byebjatpfqtq1sXub1q56SlD3XIQ3MGOE086h1byuKhncTJdW+/C1dnf+b/WGe7zPD2BcJjEnrg5jcF4UnBuTmS+VCMmy+STFZMCsZuyRoGEjfBah9lMA1MsiPoAuGUz2wi88fPVk/43kuZ/Bz8AKfofrKoHuIuo5JuD/JDthONh8AyGHNZFjRUqqI63fFoNrJf1MExIJiPZYBeZg5LuerkFvrm3mBsXMq1O7wvV76JNyOE01XQhzQYMK3Zqu0UBtQ/q7M5B32GMDwlz5JJcy51eMEvh4HEr/AcQeJiz0vsxOC2LoUbIxsbRks1HWwts0a1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzy0Ewzju3e2Ma5PgYWYehWnkUHVQOZB9iaXKyaBtGY=;
 b=GkaamhycHoDBAw1uY+9OmAsRCKGldAvZBc9QYLlhQkx6Rt4+slCgyn3/yH8xwXqJ2rwjvFjFvTww7MR9YFEcWXnb+Cswgk9JjLBrS5cFqeopFr363Sn9HoXWHo7imIh/vL46b6plsJG8r0wbqe2xxCpMq2nip+E7c5otdDZV40ivyJdHHjBsC40TybNbr/+h4+LlluBN9gxMJXDTGLsOdt9GS+tdSv/KqdZDQuxWhJJqVwSkTfOruwb/Tp/72J3yIEhCbdTmVAWaCd2pxko7UsJ/Tnb3rBwh2GZpABKkuMiWHx1MVQ9ADADZ3Z0BgRco0D0Aii4I72efZZX/LI/hJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzy0Ewzju3e2Ma5PgYWYehWnkUHVQOZB9iaXKyaBtGY=;
 b=SRN5lJFZdFg8fikh67ivs8JbGsag/mjHQwv5e94O4eqhS1ZBwFqsMJ7bpLROvSHAsr1q2JOE06De5VbCvrcI6K7g+hRK7qvUOgCDDaMrr2NRfBnw9Us7Z+ArMimFOEXJ3eIT0pu6eH1dzUyi0G7vyLjM542ke2nHIlNnTMouTbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by DS7PR21MB3525.namprd21.prod.outlook.com
 (2603:10b6:8:92::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.8; Fri, 11 Aug
 2023 05:32:37 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::879:607:79:c14d]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::879:607:79:c14d%4]) with mapi id 15.20.6699.008; Fri, 11 Aug 2023
 05:32:37 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, linux-hyperv@vger.kernel.org,
        hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dexuan Cui <decui@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH] x86/hyperv: Fix the detection of E820_TYPE_PRAM in a Gen2 VM
Date:   Thu, 10 Aug 2023 22:31:37 -0700
Message-Id: <20230811053137.2789-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:303:6a::32) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|DS7PR21MB3525:EE_
X-MS-Office365-Filtering-Correlation-Id: 26c90c26-1396-44e7-f2be-08db9a2c5f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVASakfliZKqX5Efj5FiF9hd64sIX375Q1jS2BgS5SDCYDpvaLXdMelgKzi24xyt9xtT4zsnXx5bcoa0DPEMgQ904jdgEP/MuGC0Eq8OjGyEpNXMbA+FPU+bUXp6JBYUDdTarnuVtMvCc6CeqPRllZ8SOGnVhiNau55ANbchTcyFu8IQCajdDG+VMMUoxAN2xG50q35qOyV3PpvopW404ggMsxNkM9FTVg5GY5lOQhb734ZJqWz1Uvr8CaFPsnndFRvUJAkp4D1dGEcN1V/m1MQmzutg9mSgctjbIAmQWNWj4KNMJ2oUpBXgm4q0zOygDisOniiTcDsEk5HinkRkRnCvg2/3tT0hVpERCoh5FqZNX0Ed6Pir3OxwHRc9hw70nuiG+jbPzA3OadCvy3dYv7gw3OhZQK9It8apHp2EEOSiMuNqh5B+4eXCuFieuzydaQIeRcgvfx0rDQ0PVTQu8RNFTE7hDGUI9WU8x1B3N+iojruJo6c8p6R+h/47woWK+1Anm+kwKmThjYFaioodEi7p2ccJbLnjmDy/qUM9tXyeO7XyEFw+9xg20u+RHDYXiyCdI5WOZ56H4kW+z5QmgH7UGJvq+vNsGykT4k7nNDyjX8T2GMS8h3U/xtSrWRG7CdQWqm33dV/RFpwcsQw2B3gicyA5i2FN5QUAuJ012/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(346002)(39860400002)(136003)(186006)(1800799006)(451199021)(83380400001)(82950400001)(82960400001)(38100700002)(6512007)(6486002)(10290500003)(54906003)(478600001)(52116002)(41300700001)(8936002)(8676002)(5660300002)(2906002)(316002)(4326008)(66476007)(66556008)(66946007)(36756003)(2616005)(107886003)(1076003)(6506007)(86362001)(12101799016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MqVQt+ONYcyNF4fdaQYbfMl8og4yYQG9X2s6SMXp22a5E/OqDdiUHFweb2eO?=
 =?us-ascii?Q?vmoCeWcrY+fBFhKhsLp4AN9wwlWg+CnjBH2ie3BDqXSnjvV+7upCxIcX5yU3?=
 =?us-ascii?Q?6LI4QhXOX3wlHTaSKr7TWgt1j9hufZ9oUet0Yn7Nd5YwNvZCsBVMk712rXix?=
 =?us-ascii?Q?TnZZ9bEa8HRSOEBmDNj1wuEPDE8pER4xIYw3Yk5ipRB+4XClcTb7mAaAlWfk?=
 =?us-ascii?Q?kWgtOwXaSsIMMeYsdG7sdTwcXBt+BBu4lVrxJjUupakEYuu4e2lLX+zCs7+S?=
 =?us-ascii?Q?NjH6e736pjACOswmtedFkdIXm19Ux/BNpQJodQEpE86Jiinx5HTerxVVLdg8?=
 =?us-ascii?Q?x2iMakXhXVwqOtwn9qq68ep00Xx46ynCO0B/4he5k6l5Ej0O48ScMQVezSib?=
 =?us-ascii?Q?z2zezIjF6oAKljATEKYpcAwb3m5COn8RDg5eIa+tv15U6XhMwgBFODbyWIRr?=
 =?us-ascii?Q?rXoHgCeIiqeyQUr/NrxcGVz/4JP0H/l3c86LRzAl1cxknbKGUxhMRhYWDdhP?=
 =?us-ascii?Q?AMrGzA+ehTepOkFBwfmp1iqKYkv9VpMIMc5MxdQcjE1B/sx99DZHZvc6ePIK?=
 =?us-ascii?Q?Sglw5/amLRcKUtrtco+n2CLkahPxoFWaeutGVBo1i9VxSghDwp9/ObJXipja?=
 =?us-ascii?Q?bW1e3hA+gFFXkEbMN7FLQyVs96hcISJ8lZVDL1M34lvcucbdauo7i/XDcK2C?=
 =?us-ascii?Q?zz8SwTeDB8RzT2mtX6jG7aUd8Mytdz2ZNpRASHix1wTUb4s1yGI2cjMk0uyg?=
 =?us-ascii?Q?cfU42CSAeabM7MjspWqXHpDPulPGZipnwXgqEhL31N2ewERqsxkNfnxLAZWG?=
 =?us-ascii?Q?gXtKvsRug49juevPWMGuv/ShI/X5eVUVAiZa4U2OTUKmcuUCr0573Lba0enl?=
 =?us-ascii?Q?ottJOGsIsUhsrjBE0ZoZ9YYHtR+DELtEuccPNBU6NpcJLsk+tCh673XSMllC?=
 =?us-ascii?Q?T7oHuqpPTsd5yV6rOiJuq3sK+od9PiTVg1nd4nTA54Vxd9+sQRBINGMou2jq?=
 =?us-ascii?Q?KLzATeNppJX8bcNArfdfVItJSYB/+8Bpys+sOZw0YE+zh7+CeYNFnfgnpji2?=
 =?us-ascii?Q?GgH3Tyiqkya/CLMFaaybJ3SVTc4WecDwk0np6c+muT9Ou9r6vExQRN/vqDdY?=
 =?us-ascii?Q?PklhRbQx+jjgXqyE7fnr1i0ThMhI8dZRMuGa1vrYH4XaS7OkgZJtEtaLpMC1?=
 =?us-ascii?Q?4MwBmVZ1sQRgT5xy65bXoENd+7nCog7EnCbX9t6A0hwK3YEOkKDF6/re2G49?=
 =?us-ascii?Q?Q0OhWfinR9/MFu+6eR7cSYbQa39D6YFJwNJ15g5t5EZnoA7mF2wI0xTJ6HBk?=
 =?us-ascii?Q?A+8V5Ws5/5/EFK3EWmtMc34XMlvPFlrmvicJ+NmOlO6JPYbu6ROA7vgASKGh?=
 =?us-ascii?Q?47H9AzCyHVh5YVxxOTMhbKgGIZKu+OvLthyzk1qtskRySSICkSXlfIdkcTGd?=
 =?us-ascii?Q?dVyQ74kTjcy9gjSyDKHcL+zS9LCctqWcdmaNRowixn3mzsk/9oR3atI6mSSQ?=
 =?us-ascii?Q?rZdrskXIatDltgz8BHbZ76QhRA8BQQZhOYpESpz4T+wHYlnCoNxrO0Oy3Wrf?=
 =?us-ascii?Q?NOO+9ggUFpvaIuLT0a3b6X3vBo8SB35NQTVv8KQyYMp7fsdRX3BU/Y95Yfl1?=
 =?us-ascii?Q?kNL/ZXPTNDIN+vs0x+u+Wt2P69D7oGnebLHTxXQP5RZJ?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c90c26-1396-44e7-f2be-08db9a2c5f0c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 05:32:37.0973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmy7LaQ3pgp3gGvg7nBeRUOHUz4RIK3aASDQhqvaw/G/V40//4BX5bp19B+bvu0z5g+/0bobcPvF1mlSdbF+fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3525
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

A Gen2 VM doesn't support legacy PCI/PCIe, so both raw_pci_ops and
raw_pci_ext_ops are NULL, and pci_subsys_init() -> pcibios_init()
doesn't call pcibios_resource_survey() -> e820__reserve_resources_late();
as a result, any emulated persistent memory of E820_TYPE_PRAM (12) via
the kernel parameter memmap=nn[KMG]!ss is not added into iomem_resource
and hence can't be detected by register_e820_pmem().

Fix this by directly calling e820__reserve_resources_late() in
hv_pci_init(), which is called from arch_initcall(pci_arch_init).

It's ok to move a Gen2 VM's e820__reserve_resources_late() from
subsys_initcall(pci_subsys_init) to arch_initcall(pci_arch_init) because
the code in-between doesn't depend on the E820 resources.
e820__reserve_resources_late() depends on e820__reserve_resources(),
which has been called earlier from setup_arch().

For a Gen-2 VM, the new hv_pci_init() also adds any memory of
E820_TYPE_PMEM (7) into iomem_resource, and acpi_nfit_register_region() ->
acpi_nfit_insert_resource() -> region_intersects() returns
REGION_INTERSECTS, so the memory of E820_TYPE_PMEM won't get added twice.

Changed the local variable "int gen2vm" to "bool gen2vm".

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index b004370d3b01..6b22d49aee7b 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <asm/apic.h>
 #include <asm/desc.h>
+#include <asm/e820/api.h>
 #include <asm/sev.h>
 #include <asm/hypervisor.h>
 #include <asm/hyperv-tlfs.h>
@@ -282,15 +283,31 @@ static int hv_cpu_die(unsigned int cpu)
 
 static int __init hv_pci_init(void)
 {
-	int gen2vm = efi_enabled(EFI_BOOT);
+	bool gen2vm = efi_enabled(EFI_BOOT);
 
 	/*
-	 * For Generation-2 VM, we exit from pci_arch_init() by returning 0.
-	 * The purpose is to suppress the harmless warning:
+	 * A Generation-2 VM doesn't support legacy PCI/PCIe, so both
+	 * raw_pci_ops and raw_pci_ext_ops are NULL, and pci_subsys_init() ->
+	 * pcibios_init() doesn't call pcibios_resource_survey() ->
+	 * e820__reserve_resources_late(); as a result, any emulated persistent
+	 * memory of E820_TYPE_PRAM (12) via the kernel parameter
+	 * memmap=nn[KMG]!ss is not added into iomem_resource and hence can't be
+	 * detected by register_e820_pmem(). Fix this by directly calling
+	 * e820__reserve_resources_late() here: e820__reserve_resources_late()
+	 * depends on e820__reserve_resources(), which has been called earlier
+	 * from setup_arch(). Note: e820__reserve_resources_late() also adds
+	 * any memory of E820_TYPE_PMEM (7) into iomem_resource, and
+	 * acpi_nfit_register_region() -> acpi_nfit_insert_resource() ->
+	 * region_intersects() returns REGION_INTERSECTS, so the memory of
+	 * E820_TYPE_PMEM won't get added twice.
+	 *
+	 * We return 0 here so that pci_arch_init() won't print the warning:
 	 * "PCI: Fatal: No config space access function found"
 	 */
-	if (gen2vm)
+	if (gen2vm) {
+		e820__reserve_resources_late();
 		return 0;
+	}
 
 	/* For Generation-1 VM, we'll proceed in pci_arch_init().  */
 	return 1;
-- 
2.25.1

