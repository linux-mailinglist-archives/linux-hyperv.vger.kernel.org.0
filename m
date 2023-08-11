Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EABB778540
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Aug 2023 04:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjHKCNz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Aug 2023 22:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjHKCNx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Aug 2023 22:13:53 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021022.outbound.protection.outlook.com [52.101.57.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034262D55;
        Thu, 10 Aug 2023 19:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOPub01++P75gdMmnB5+l1C3jtTsCrj4cbHpNesfVqPmZEZBWHZOQP64ydNpMU7QaeTXdX4VZB2fVQfeHU+V4QV7AdK64qbPwPus/wwhoBVdAGZI6Mdbcdo5Z64G6HySkn2CyZUMGr/tci4u6GnBmKSEx09B5Cua0Y9Qfc8KnMVHEeWB6F4tYjWqxHoOF7/j1rqIx8EICkTE5vvrmFWmxsMHjQe+zMO0L4umeDCLmwWprS6pGhSW7swybc7I1lZxCa79QyGKCyz/f22FPQ1etAhipG0aAVXuxp3x9KV7wfFuYZ6Bbtzu+l0KehP1H6TPFN60uxc8wR1G51b+AOWf7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoShCcok9v3RsEqshNsG1W/xu9wjx6Hb1pOatLGR5DY=;
 b=OIv1u39o1JZ8ZgvU2PRnVqY8N9lFY4Lb5afHk9i//X6oqDNn53JXjHhe1ThHYhal+y0heG4vShVcJEpBMnk2epn+o6z4xWBWKWBmWFunW92pYA8Ld273VPZ2Kr3x3K6PZIlA7y70aFMFpJ02DGBeQQxh/G8b+BNEOwqBeiwl36ITP6w2gb3kTuCaVDicb6lKGxFwCSqFMVN9UypERiyzoF/h39pRActta1trm2oFby6bd+pt8IZcFmF3YxmBSI2DGL5sCSmSFxGWD6dfQf8yY0d0G2crRxny3OBr4jrmM6yY6+cX6YWTz4Te0R/dnj6M9v1Mvk2pKBwrtw67+QjZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoShCcok9v3RsEqshNsG1W/xu9wjx6Hb1pOatLGR5DY=;
 b=dTfJIl4Oe7IFHDfzknnqyS9iihUDdjOUsroXqpiJypCJX0VHThUxeKzNIDBGC0VI8ChckgpzCwlxDOcfWIefyS/AXiFwfktHAlbVmyCCZ+f8lYbhF69BR+BmwOlc25b3kAP28OZINRq+xpuio1i6vH9H99cHvIQIkwx9Jsjqfhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MN0PR21MB3072.namprd21.prod.outlook.com
 (2603:10b6:208:370::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.7; Fri, 11 Aug
 2023 02:13:50 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::879:607:79:c14d]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::879:607:79:c14d%4]) with mapi id 15.20.6699.007; Fri, 11 Aug 2023
 02:13:50 +0000
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
Subject: [PATCH RESEND v9 1/2] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Date:   Thu, 10 Aug 2023 19:12:45 -0700
Message-Id: <20230811021246.821-2-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230811021246.821-1-decui@microsoft.com>
References: <20230811021246.821-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:303:8f::6) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|MN0PR21MB3072:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f89d454-2110-4607-cc9c-08db9a1099c8
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6UTVayODrOGCDPJSVywjc/nyeFYmmljVACdvY6O8zqr1Nk96BlJpYrFa/t7FzZtauHlhuV1tnhbGNL5ViwCQfRNzEIYkATvzILD79bO/juzsMco4rbgJAirxjUD7zjmP8X0QhAj337hXuXNt7HDrpRYnBtxTbpPnQsxl7pRaQ7vpucPaGYJzA7llyzRIntweTeC4mhIhJG29kYj1s9XWrYsUWzm8j3p394pUvipZYt0Oqs0YOHBJ4kQoCGNlggIWcZZajND5xW/R8rPXOUnAujyjBngNKeZBTa8ixyicJUQ+/z3TSek+ge7vLJY9DwlLKSoYEZr9cNxN3a0OGThkGTw+phOSyYEE0eek47armHTufheEXG1U0fofPIdzsc/iM8uaEb9GO8XfU0LCEob//IuKhPOfgvrmtAdCkLhDiXQiiuFyT+5gaU1d0l992s4/78uQ7x7d4uUj1x6FSEl0T+I6fH1n0Frnf4v1zO6dwmFogXWqPOOh5I94sdRPvQBVytYpFrB/O1IzjrQpVocGyroh117Pz7aTbJdftWJkm/O5bsMEkOqO9MRZkb8tLNwnn9UxKs8uskVe6U73DUnNoCnMLpg8KPjayJnNf+DvOETOSH2DOtV4wUmsjIHJ9w3IejfnDFN5+9AqaUnO9wx5+XrcwfiHjmFSJA26f/8rsAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(186006)(1800799006)(10290500003)(478600001)(36756003)(82960400001)(107886003)(6506007)(966005)(82950400001)(6486002)(38100700002)(86362001)(52116002)(2906002)(6512007)(6666004)(2616005)(83380400001)(1076003)(921005)(5660300002)(12101799016)(41300700001)(66946007)(6636002)(316002)(4326008)(8936002)(66476007)(66556008)(8676002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nuSDDYvlPGfZGeDmS0Jg//x1uECBveYSXq4yP0fcrKzhkVW6UThH0CGC2SaZ?=
 =?us-ascii?Q?qCPjhVhSELAsddRVU4laiq6erkzGhE1AfsIb275JM1z/BKwBenBd04zSzlPi?=
 =?us-ascii?Q?xCWFVZ8QlHrK06EwM6t6PXZT6JlP9PkR/JmIi597zWcgKYV43Rs8dytxmdBj?=
 =?us-ascii?Q?oS9SaYnN3QCYYHCPxORT1JLJOBpjU+zMcENzEdgWkuvkxQUKdgfm8TkkK0gC?=
 =?us-ascii?Q?SMC23s8x/f4j75h9QSHNIRar4nsJ/TQoI6jVw//uEnicfWEVq3NAyyx53fPe?=
 =?us-ascii?Q?ZDCw5viPXRo0iaz8yUxdn/Q7SHNtlHLBc9k7Jmwm8DN37wJQVmylumlqGXf2?=
 =?us-ascii?Q?Wu0BnwjwB9vDS29RE7dVZp66u/XhKByr/QUifqmTT8aJLqgao0rumn8M+Y5I?=
 =?us-ascii?Q?mRUh0di99C4QiaWsNDGXWYQUP5rrpasL7QDlo4bImXS54eBQ+IdwrBiC9Cxh?=
 =?us-ascii?Q?Yi+11sENakN8fIwP+f2SGP7O6FUDM2uhaVohr2PjEZCjk4Hlou/6eQq4BEpc?=
 =?us-ascii?Q?SDuyfVsrXctrLfb+fDin6ah8Ir/AY/SrRjjlchHNHcaMZZ3CZ3L/6zVQ40W7?=
 =?us-ascii?Q?+LrDadYLEyZtcq6cVWVcMQud1PhrfgotJQNoy7DV2xkcVWBTXeUMpaxzFXlZ?=
 =?us-ascii?Q?kugIx0WvS1fCnZJ2oR70xkjiEbAd3XANQ2teVPVq90Y97AIMOnl5A5Or4lhY?=
 =?us-ascii?Q?CqQFxbIAEeWmrY/xT03wEpuMrFjGkNW3umL5erxuQeU+R0w4nwoxoc6j6d+d?=
 =?us-ascii?Q?c5SlVM0oV5jZMdeiiMHp9JXMRBwvtj2tiV8pMFSV+x6u/GF9NKpMOaejgZqc?=
 =?us-ascii?Q?aBZdswwow7R8K+Y7V5Peie1tBrDlT2OjsMFIWB1AFyPJPwEAKqTMOeeomkd7?=
 =?us-ascii?Q?O3Jwqv2KYS3polcpsyQzldF1sQlW2EArgQOMG1lxaWMQkjX1H5w6imUvI1Eo?=
 =?us-ascii?Q?p+KAfFP93lHtAGCgiL5/zvT3gm7XuIIeTZYDacnjYFatQFRYPmPzxKsmYg0u?=
 =?us-ascii?Q?chBcfNu+4A7XCqntEw2izzhVjMU+v32McoeMxvRg+HN8LiJ8izWjKOJ85l4+?=
 =?us-ascii?Q?u6QebM0wR5mLG/Gh5fBu+JGGypDOER/W7hRYGoRxu/wid+YoJJMz5FLW9ZR+?=
 =?us-ascii?Q?Y0zHfxr0s/Tm3qPTHIQNRyNZoOtbfJwbLNWmKCDk5nG4BZKw828/NVvcyWj7?=
 =?us-ascii?Q?yDnQ1to069D/ZnaRrUHJU5Gl1v7kXFvbdL7V54082HkDrG4p2L2u/VXb6jc0?=
 =?us-ascii?Q?8J2dUfC/S3KvGm/JiByeZxqgqb8qWHdMimECvdz9jJY8xvwPhq0+GmsWPpLX?=
 =?us-ascii?Q?iIYKSBosfxSo0yyZq/Q9xvNqd/hlNb2ANpE7Gg2PFFXdOC4WIsMx72yZtXza?=
 =?us-ascii?Q?LGvseId0Y0jaKTO60nSUNwC8nrKHfJOmBbhq9uT21vU7nX3r00G8HKOW89uX?=
 =?us-ascii?Q?zQL6H+b5ydXbukyXl/o4W+8KhSwm6W2J1DMUPhODPRnZ59CILcr9vpz2C7mP?=
 =?us-ascii?Q?vP7te9ExFtbV+cUHrDIQ2ABDhCwAIFKV4dMs3qY5PPd+aRkNce/5JYWKf2BQ?=
 =?us-ascii?Q?flseme93MGL+UE0fBigop9xMWhC/Src4FkGIS3BTxLWpz+RjR2Hoal7KNTxJ?=
 =?us-ascii?Q?vlUnusmZvvZnOfx/GyaG1cSwPNNG1nossr+7uwSN2Rim?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f89d454-2110-4607-cc9c-08db9a1099c8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 02:13:49.8489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IJ4+kaEvFNQ8U9A1Q//hRmT/AMWH1EeGCSdjW9L96ai/sKxRrv/8dNtLfflfktu06OY9y5aXEBgslsOU3w25A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3072
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

GHCI spec for TDX 1.0 says that the MapGPA call may fail with the R10
error code = TDG.VP.VMCALL_RETRY (1), and the guest must retry this
operation for the pages in the region starting at the GPA specified
in R11.

When a fully enlightened TDX guest runs on Hyper-V, Hyper-V can return
the retry error when set_memory_decrypted() is called to decrypt up to
1GB of swiotlb bounce buffers.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/coco/tdx/tdx.c           | 64 +++++++++++++++++++++++++------
 arch/x86/include/asm/shared/tdx.h |  2 +
 2 files changed, 54 insertions(+), 12 deletions(-)

Changes in v2:
  Used __tdx_hypercall() directly in tdx_map_gpa().
  Added a max_retry_cnt of 1000.
  Renamed a few variables, e.g., r11 -> map_fail_paddr.

Changes in v3:
  Changed max_retry_cnt from 1000 to 3.

Changes in v4:
  __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT) -> __tdx_hypercall_ret()
  Added Kirill's Acked-by.

Changes in v5:
  Added Michael's Reviewed-by.

Changes in v6: None.

Changes in v7:
  Addressed Dave's comments:
  see https://lwn.net/ml/linux-kernel/SA1PR21MB1335736123C2BCBBFD7460C3BF46A@SA1PR21MB1335.namprd21.prod.outlook.com

Changes in v8:
  Rebased to tip.git's master branch.

Changes in v9:
  Added a comment before 'max_retries_per_page'.
  Moved 'args', 'map_fail_paddr' and 'ret' into the loop.
  Added Kuppuswamy Sathyanarayanan's Reviewed-by.

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1d6b863c42b0..746075d20cd2 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -703,14 +703,15 @@ static bool tdx_cache_flush_required(void)
 }
 
 /*
- * Inform the VMM of the guest's intent for this physical page: shared with
- * the VMM or private to the guest.  The VMM is expected to change its mapping
- * of the page in response.
+ * Notify the VMM about page mapping conversion. More info about ABI
+ * can be found in TDX Guest-Host-Communication Interface (GHCI),
+ * section "TDG.VP.VMCALL<MapGPA>".
  */
-static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 {
-	phys_addr_t start = __pa(vaddr);
-	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+	/* Retrying the hypercall a second time should succeed; use 3 just in case */
+	const int max_retries_per_page = 3;
+	int retry_count = 0;
 
 	if (!enc) {
 		/* Set the shared (decrypted) bits: */
@@ -718,12 +719,51 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 		end   |= cc_mkdec(0);
 	}
 
-	/*
-	 * Notify the VMM about page mapping conversion. More info about ABI
-	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
-	 * section "TDG.VP.VMCALL<MapGPA>"
-	 */
-	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
+	while (retry_count < max_retries_per_page) {
+		struct tdx_hypercall_args args = {
+			.r10 = TDX_HYPERCALL_STANDARD,
+			.r11 = TDVMCALL_MAP_GPA,
+			.r12 = start,
+			.r13 = end - start };
+
+		u64 map_fail_paddr;
+		u64 ret = __tdx_hypercall_ret(&args);
+
+		if (ret != TDVMCALL_STATUS_RETRY)
+			return !ret;
+		/*
+		 * The guest must retry the operation for the pages in the
+		 * region starting at the GPA specified in R11. R11 comes
+		 * from the untrusted VMM. Sanity check it.
+		 */
+		map_fail_paddr = args.r11;
+		if (map_fail_paddr < start || map_fail_paddr >= end)
+			return false;
+
+		/* "Consume" a retry without forward progress */
+		if (map_fail_paddr == start) {
+			retry_count++;
+			continue;
+		}
+
+		start = map_fail_paddr;
+		retry_count = 0;
+	}
+
+	return false;
+}
+
+/*
+ * Inform the VMM of the guest's intent for this physical page: shared with
+ * the VMM or private to the guest.  The VMM is expected to change its mapping
+ * of the page in response.
+ */
+static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+{
+	phys_addr_t start = __pa(vaddr);
+	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+
+	if (!tdx_map_gpa(start, end, enc))
 		return false;
 
 	/* shared->private conversion requires memory to be accepted before use */
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 90ea813c4b99..9db89a99ae5b 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -24,6 +24,8 @@
 #define TDVMCALL_MAP_GPA		0x10001
 #define TDVMCALL_REPORT_FATAL_ERROR	0x10003
 
+#define TDVMCALL_STATUS_RETRY		1
+
 #ifndef __ASSEMBLY__
 
 /*
-- 
2.25.1

