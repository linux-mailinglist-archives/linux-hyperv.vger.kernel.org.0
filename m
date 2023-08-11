Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C8F7799DE
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Aug 2023 23:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236910AbjHKVtK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Aug 2023 17:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbjHKVtJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Aug 2023 17:49:09 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021025.outbound.protection.outlook.com [52.101.57.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562482709;
        Fri, 11 Aug 2023 14:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLDuI2EVS6SFEUfVKbOXtITHfxp64r/tZdDKtv+Gx+IlBTaemXPZZV2gMORYdY2mQ8BbD5D7Chi4jymGgNXsTEYGjfB6A8BEjjC7rEziZbERLiorHhln0rrCeb2ckMD6xEAxn/L7cjMTlTp6fO184qQ2VP4HzXkwnJz7MBZS+lCqtKlMdRIv0ZVHrvG2nIpKeYDKFNmJTkgbWyCTfoVULtnTgzNZzcGS0F4xpbho3OGKbnjstJfZsaoq5/Pv56/lC3FjZK8/Y94VSeORPJN6cEbpgUmPLzX3J0wWTmxfD7aOwIF+rWck/iOWRvSK7nWPfgBsGBZkDFwgijkteenEYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XP8UhP6CqR/DuPM4kToEV2iOUc/0+YyVf58PAFrgC0=;
 b=PAEZ1PdLdMGt5fD2BG9ES8DwFQHmkQE0EawWYwFWjilXmLSoTLdxrq1696P6qtq28m7QSPaZG1jq108ZX8RQBu8VLRUpgWd+mQCU8WIT8kpn5rgozqllM1KHvDNkOvyi1qPtqC75j9IQsLbJmjGzdbQQ+vL0bF3Dlf8rtAr7yDo8u+rBHENuLiifYy2QW+Z67jGAaClXqgFONPToBNP5zcxfOlxPtprN3r+t2Bb5WH+DjZv1b5zpdvdoVW0g8kBD/cf+jMTFFm3bMDZw0fk0Cg8K8x6w4X8PKh959IdcWoI2aVqZHlxLOowJ9PqKUC0oLn+XV2L5Y3qk4PSYNsLNng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XP8UhP6CqR/DuPM4kToEV2iOUc/0+YyVf58PAFrgC0=;
 b=I+QdvlvKRfZ/rpc20p1kIuCsS7UnvIbUQeEzU4hbjExJZ19s4hos+L6mbgZvbo8OwYzx0kVrB8nbrKjnzTtfipEwl9JHLnxr3ORsXOiTpZee4221DLcr4SIMLlpQ9TgsXxXdA8Y+qqNkQdq8UXZ/zYvOyNJyZ9OKhtb+oSQGog0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com (2603:10b6:302:4::29)
 by CY5PR21MB3445.namprd21.prod.outlook.com (2603:10b6:930:e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.8; Fri, 11 Aug
 2023 21:49:05 +0000
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba]) by MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba%4]) with mapi id 15.20.6699.008; Fri, 11 Aug 2023
 21:49:05 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     x86@kernel.org, ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        wei.liu@kernel.org, Jason@zx2c4.com, nik.borisov@suse.com,
        mikelley@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tianyu.Lan@microsoft.com, rick.p.edgecombe@intel.com,
        andavis@redhat.com, mheslin@redhat.com, vkuznets@redhat.com,
        xiaoyao.li@intel.com, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v10 2/2] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Date:   Fri, 11 Aug 2023 14:48:26 -0700
Message-Id: <20230811214826.9609-3-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230811214826.9609-1-decui@microsoft.com>
References: <20230811214826.9609-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0294.namprd04.prod.outlook.com
 (2603:10b6:303:89::29) To MW2PR2101MB1099.namprd21.prod.outlook.com
 (2603:10b6:302:4::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR2101MB1099:EE_|CY5PR21MB3445:EE_
X-MS-Office365-Filtering-Correlation-Id: 10641cfb-551c-4442-c69c-08db9ab4c7d2
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WL1/kCfXFgsKw6dhBIJl4liFPvFG6ZoHyrGFSuDJ1bst85WdPwPNocnu0tdja0Rw3iU/Sr4XM90dxsbHSVO1pjqxOQHIzPl8klGeHJdn9ipCKF+NIK2gAnS85NjuHlu8z1pnLe8fWbMx6WdoJ+oT41GGnLavcUWQ3vCmd5yIBxbmA5D5P68laWfD97cbATYxfquPPmolDO81TZ0Poyued81fg2qDexaJ+sms0B0lEJ95luAOaUnLFP7EGLFLwMPDbLRsx9Zpaeb8K3wTsU2erTRrqOub4Vmz8a1wu+ddpIslF77uD8fl0uj+yupQKMhbOToUj2QQptsTP8G3AwGa7CDbJ80u13YlKq4SWP8YnfmeKjr1xrhrXVTv4QyQn0+3rxR2u0YDXiAyYpd8HfZRh3xUBAdAWUzte6PmU1eYV3a+z0hhRloRzYBCN8PobBT5UOodWuBL42y8Nlm48ODI1X/vouU8F66pJrNh4p792cWFjn2HoTyhpOVqN4lKqbkhwGpxsCrS81WyZNUcYGws3ztKFw6WoxvxwZFP+XNHJUnjrwXTRdNEiz0rE7UmO5NPbEWcKtl/WxEDKKc11o1sSN3FEhM9f8CjEXdptKi4GbmuBG0A65xtOwZLs2ID7Sbu53kAQ1E3vqUz8wU8ybbcCDJgHxYywo0B50D8F6Gvjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1099.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(1800799006)(186006)(12101799016)(2906002)(10290500003)(7416002)(8676002)(8936002)(5660300002)(41300700001)(6636002)(4326008)(66556008)(66476007)(66946007)(316002)(6666004)(6486002)(36756003)(107886003)(6512007)(966005)(52116002)(478600001)(6506007)(2616005)(1076003)(83380400001)(82950400001)(82960400001)(38100700002)(921005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xYxcK6xMgBt8CP7cplbX9C0D+tNvLxCRXv8szq14fftSzfWPwm8zxoNgOVdJ?=
 =?us-ascii?Q?4dN6zUgVzo2osMqGZyTVkcC8O3xeQ8Pv4eLQ0saq13UP9E3BAzYB562dP/TL?=
 =?us-ascii?Q?GEH3H8qCEYta3h7b5R4wheCV0unSmggX7OmgyyTfveinFgDA8fwS2cS/6FYp?=
 =?us-ascii?Q?zYwVMq5qCt9BfmA6Ic1wfiUvFXCcfPlwAe0c6psgfBFufYDWNSnWkFHG5+kr?=
 =?us-ascii?Q?6YrZQ72V09hC7sHgIknaRcBF0Ohe6sx2yJ9AJ44sV187BC7esDwMumSOOcRx?=
 =?us-ascii?Q?CkmNuPVStM+yRl78SgdrB5T5d5FoqzIsq0gnE0t/qNg7CoLpZ2bEEuUScH+t?=
 =?us-ascii?Q?ahgomBLV/dWb0OwPsBa639v6mH7gL69poD+PHiZ7wDYrZnUeAwvIndJlY2qw?=
 =?us-ascii?Q?Zb37VDod/wyWalSqWiv7LwRdvRpXqwZbJUObRPe02Z6q3269dqYUq/QFv8oK?=
 =?us-ascii?Q?O86NUoiJRmPElYdLLPvqYpUodbHVl1FjMp4iX526YLNKpETz1TJgt7EUeAxZ?=
 =?us-ascii?Q?V45HYuW1415SAFTHimQSPAvfGgfh5ymKW3/dCj8mcoB5P7HCojP6HI8p7xgL?=
 =?us-ascii?Q?feU+j/sBEmfjvW/aGlIm4xTT5RgeH+zIkZcG9Ex36Q0/oPBfA8T99GXux1YA?=
 =?us-ascii?Q?508ZTVVmiQQaZwqVrYPwKaTDy1ov7X9yvCytSKS6q2WkEqdhdoE2SAx9ladc?=
 =?us-ascii?Q?KqqGL9PoihFXGztvcyz9vVbzRmDCDU1T+m+NTkR3atRosqs8Sq7cWeGTX60i?=
 =?us-ascii?Q?gXYMMwz/fwjb6yg+eVjMbcD0dOKMql2Yjn7IZZF9VOnRr7VYOiNZLG+DLLu/?=
 =?us-ascii?Q?840LAs90av9KQr1bdTX4NtM931gRhqyXfF7nQHKWYGiLV2WiIFvBy6TJolJK?=
 =?us-ascii?Q?eT+6V56lx6Y/DsYuBME/j60wDaWH6nTZYFxDW+m/StgpLAeCmaVfHC8qvExi?=
 =?us-ascii?Q?seC1SSeTGMILY+kT+s1ikwuINtQB9RLhrm5ogfXvVsUZDT4YN3qmJ5+e+k0L?=
 =?us-ascii?Q?NiH3ZFE41EDIbwQnXh/ut1x/vEe2bIo3juFJAO5DOAm01WphpYJ97pbEVPSG?=
 =?us-ascii?Q?aAiMQY29gU06SVbPnzX6UzagjZn1jqKGDOS3rUhrqmB6tjjunRjsSeRjopuC?=
 =?us-ascii?Q?BUBkF7QLrnsEobBtzXjiCNKKKJL+HCNYcA4AnudO32OTkxPudUqA46njDiXN?=
 =?us-ascii?Q?ejatoEzFvEGNxTqVJPoo2FQw3qNciq7RezjFZs8V6G8+ItjYN4sXajA4ryDQ?=
 =?us-ascii?Q?Itm0X0/Pdl1hRFStYgHmLNJCBWPIxRqXCOfCJoqlFrbGHBooCszso2BWFZDA?=
 =?us-ascii?Q?A9oqQhJMFNz6F9mvXxhL8i+2Vh2kpG/MttWZ+SBpZy7rLQN8va5OBhMozxTf?=
 =?us-ascii?Q?8PxXk0B/Y5IlrP7t3J94DVXAJ14kYxNpHv9Op7/soN/moGGXdUsgQF5QQI74?=
 =?us-ascii?Q?Yeq/IgDqwTMiIuluCefitMUxERYFm06f6/ezpQlxmFGZ5JuUpkC/pAZmkA07?=
 =?us-ascii?Q?bpmpF1vLOKYhc1DToB1ZGD2OPymUXys1pDtYydngjnEdEl356+ebIwdTbTlV?=
 =?us-ascii?Q?mtDvkQ9GZRZNU2SWQ/xGTZLXyXwr56YtC1h8AYEEgs5MZMWRbrgv+K/lw3/3?=
 =?us-ascii?Q?reBh+BhLE8mesGicPnmPblnQjiNzoUkbjvD5W90Dlixm?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10641cfb-551c-4442-c69c-08db9ab4c7d2
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1099.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:49:04.1943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kVdw3azmo3k/7fbzfW8m+cbiEXCfcCILjOXmfpbFPqVWWFI2Ek6Zn3M9XEQsCkV/f9NuwDcuMFQpR72u6gRpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3445
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf()
allocates buffers using vzalloc(), and needs to share the buffers with the
host OS by calling set_memory_decrypted(), which is not working for
vmalloc() yet. Add the support by handling the pages one by one.

Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/coco/tdx/tdx.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

Changes in v10:
  Dave kindly improved tdx_enc_status_changed():
    Call tdx_enc_status_changed_phys() only once.
    Make the change concise and more readable
    See https://lwn.net/ml/linux-kernel/69b46bf3-40ab-c379-03d5-efd537ed44c7@intel.com/

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 746075d20cd2d..38044bb32c498 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -7,6 +7,7 @@
 #include <linux/cpufeature.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/mm.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -753,6 +754,19 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 	return false;
 }
 
+static bool tdx_enc_status_changed_phys(phys_addr_t start, phys_addr_t end,
+					bool enc)
+{
+	if (!tdx_map_gpa(start, end, enc))
+		return false;
+
+	/* shared->private conversion requires memory to be accepted before use */
+	if (enc)
+		return tdx_accept_memory(start, end);
+
+	return true;
+}
+
 /*
  * Inform the VMM of the guest's intent for this physical page: shared with
  * the VMM or private to the guest.  The VMM is expected to change its mapping
@@ -760,15 +774,25 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
  */
 static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 {
-	phys_addr_t start = __pa(vaddr);
-	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+	unsigned long start = vaddr;
+	unsigned long end = start + numpages * PAGE_SIZE;
+	unsigned long step = end - start;
+	unsigned long addr;
 
-	if (!tdx_map_gpa(start, end, enc))
+	if (offset_in_page(start) != 0)
 		return false;
 
-	/* shared->private conversion requires memory to be accepted before use */
-	if (enc)
-		return tdx_accept_memory(start, end);
+	/* Step through page-by-page for vmalloc() mappings: */
+	if (is_vmalloc_addr((void *)vaddr))
+		step = PAGE_SIZE;
+
+	for (addr = start; addr < end; addr += step) {
+		phys_addr_t start_pa = slow_virt_to_phys((void *)addr);
+		phys_addr_t end_pa   = start_pa + step;
+
+		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
+			return false;
+	}
 
 	return true;
 }
-- 
2.25.1

