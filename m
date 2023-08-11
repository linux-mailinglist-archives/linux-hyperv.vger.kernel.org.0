Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE347799DC
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Aug 2023 23:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbjHKVtJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Aug 2023 17:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbjHKVtJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Aug 2023 17:49:09 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021025.outbound.protection.outlook.com [52.101.57.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C052712;
        Fri, 11 Aug 2023 14:49:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiWPvWCGVPBJl0Tj55VXN6oGsHt8CY5CtDesn2+HAWRqPijW62Z5P4uqDV90pBSqb3dZZ1JuLMAuNDjNKOu7FSt/FGZfpl6vcvmmfvjSySsL1K0PV3w/yaZNYpAQRIqHLNY94Wll2jhLYQ6RqP4zhSia/tyHv8GN5C+aCyiQNRnAwb/Rty8NCSbIqYcY7CGCT3ACHGN64NcvbCJYeKzjTRcN/SYTlYhidNpLUECAdrJg/Q4vjwInXb8Uw3l8KXViN7qSAVyxrvc/xAJ4FO0B5ZgjbF47W2Nqc6EYQtm4yxzQ4oywUlaAVv4lsigUDIuMjM6TwEHtdBd0Tffiv0t1gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raQehgbVCVPVBGyaOZYo2cWES9nxGrUi+RRIw/cgsu0=;
 b=cxluzwxvbgxMrdMraSsHFXbgdCvdg0fnjRRvsqxa91XWy1kvdU4E43ESzjHPqKRKY+JjDJ3Pnf14/vox6A5JUzmo32OsboCFNcgcEHp65wSYFh3srBq318kYQ+X1ToYeh0ircsnDjob7Bs6fMzQedOY+kd8V4ysSBhElY/sy8lqSV49kPKKMGfeNb+LlR4K8vGIcPfl1l7gfIQpZWDtjti6oEj2Eb5bZQBsnlrwQOIv0sW6seoYvehv7ig/uKqYToVaTzoqlovYvtSzNUWjWmMOmK0g01D1TBVmCB63C38mCyIAOpBFkMSQaiS/Xsgw+xSL8pUYmbaByLGDhxulKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raQehgbVCVPVBGyaOZYo2cWES9nxGrUi+RRIw/cgsu0=;
 b=HwkTzPHIW5DrvTzvzpry3Z8IprmOSbmMo6Iu65Opx4hvEGQWwrdhn3w3Q3x34aLKmA20u/xVgT/ubekhA1Xq/uS0rJVnRrxJNIWrxlr/JGcqgWVU0mxdhlD0MsUddwxxEAfFiAYKKE5XLjnyCkBXX5/9CeUbq0ORncNLRdktEDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com (2603:10b6:302:4::29)
 by CY5PR21MB3445.namprd21.prod.outlook.com (2603:10b6:930:e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.8; Fri, 11 Aug
 2023 21:49:04 +0000
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba]) by MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba%4]) with mapi id 15.20.6699.008; Fri, 11 Aug 2023
 21:49:04 +0000
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
Subject: [PATCH v10 1/2] x86/tdx: Retry partially-completed page conversion hypercalls
Date:   Fri, 11 Aug 2023 14:48:25 -0700
Message-Id: <20230811214826.9609-2-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: d6b0e006-3587-40b7-7c7e-08db9ab4c786
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FjvGEeF3fUcdYHuEsN7xSv+lgFnnQ9xw+jwVTh69FjKi3lQ+JV8wrOjlJ7pAtICA37ZpC06gG//x8exkDNTYAqbTgP4wETXybidjH7iS4YhU0wOKZsdVZbj4D1wJWm0uDQDbc3EwIxOtRe3MNvw0nfwMKOtWjVCCYZgVxa0qrao0y8Asi3wrGRAMCDjV4YIADOp+OGoNyoA0KljGIeDXshBYhApKir8ABLqSj/MZDuFu8vw82+s2gAGQ2PGJZiyjASUhGhsEABX2jYnGq83i3D/6fa5VFVsElrQVUe8uuy82tGP0ujuhHJ7mEKIVPnJhbvAhl8TmfM5NXY0j0qFmqIiASVnHrU2a/z6KtFcLaWQJWj2wRNN7Zhhz8x/txrADwcQa0/SQ62E6ZguNQEA2mEOJEDzOIdozSxjUPaSKX8Q6tkbgoXB0SuB2Y49O3avYmA68bY9HmCMjAbeIaPPiGIyvvdihS05VnXPaIxuhMgrE3dlewUfRJK2Ryfta0FlAslperVNjF+x/ywC6N1J7smXWfk4JoCAJ+Qsd+SnEneOraJEGF0ARYe0gOvjbh47U1AssjsFLigGYVYHfctsj+szxdqTTLT3iI4f/YvwvLRxycs+YMz9++/xQXGzYelibSgqynUfTyb3acjJfBd8XPBjww8ECNVTjhnpPv4xY2GyyFCbD8OIphPNAhVenfVYn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1099.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(1800799006)(186006)(12101799016)(2906002)(10290500003)(7416002)(8676002)(8936002)(5660300002)(41300700001)(6636002)(4326008)(66556008)(66476007)(66946007)(316002)(6666004)(6486002)(36756003)(107886003)(6512007)(52116002)(478600001)(6506007)(2616005)(1076003)(83380400001)(82950400001)(82960400001)(38100700002)(921005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fZGLOVVXxzhkHzj/iEleXNXEeihT8i41xSXzAbYGJEN1EgNW0A5ZhQqM/QzW?=
 =?us-ascii?Q?q2WKtZjorwuDKYhCTZotg/BP8w5fa19RzmU3k5ckOgWFP7AACZ/N3dfd7GYu?=
 =?us-ascii?Q?14I4xXkTZym2EMKamDTET6HHXOznY/GkKb5jcYs965EuIw07ENX0tvh4pF0/?=
 =?us-ascii?Q?8k788NjKjE5HKXNJuWpbLD4cdLC54rBuOXEL1JJUpwFYoOTlRx7Um8LYHvsh?=
 =?us-ascii?Q?ntbNwGejOLNMzFrENz7pHlobvKmY2twKXOukHGgrl6pGleBrxsfRgG5AM+pp?=
 =?us-ascii?Q?RrvqrpSURwgDtRv+CUmkvhzzm8CugCQNlxbGTAIQQ93ALKV5ZHzT5/dBno6U?=
 =?us-ascii?Q?KMt0zk906zkOwQ8Re85093flO52/VtPO86R1wewKYv66tE/Ti5yXUAQVcSVg?=
 =?us-ascii?Q?kw4REe3bv7bOLHKyV1LvWF2faTKuRWiCZvi7nqD5PAp1UB4H4vsFHdhoEb/V?=
 =?us-ascii?Q?XH015MMV6QpZo8aVC1tBSriDz6KlgVH5xVNHyZGPTcHNNAP322gCxn2a6FU5?=
 =?us-ascii?Q?coWNmZi167OhBxXtJnzUMUziVKK2ea58/Cir8t4vgzGhmssy/QTWmZySc4nX?=
 =?us-ascii?Q?YYBamm/t36DhOEz8UYEKy3neArQRCQCJM+SWTY/vfH0pnUU08y3HVYBIrDz6?=
 =?us-ascii?Q?83JMyqsBCIB7bH65JnK7/c4U2ZyGyxKAmP/hQO8pG7aOfDccIaQKvulTYcZm?=
 =?us-ascii?Q?LF4O+VydZnR7dGDPyxYzSMdpbzizl0bYVB2rADyYjRdxicgo3txbeY5lgp9Z?=
 =?us-ascii?Q?JmxGz9P4gsXCoL2mWhUToMl5h/SnFrbt8Sgu3U0v3TKuiqs/kOGR8mXwSq1b?=
 =?us-ascii?Q?4SF0CCrF9xCTqLAU16/qcKaJj+sEUVRvfgcf23L3fIZwP6LkffhVTqala6bH?=
 =?us-ascii?Q?w1gxy0sUesG2B8JIucTFrSUCOsh0quQwAVHncIhYaf3d8T2FTb/hCn7swOC7?=
 =?us-ascii?Q?yzfoI20oP7FHBeSvgP6Ech67Dz3lO2RYxWrBsws6t13HWau90lg87OagjouW?=
 =?us-ascii?Q?dGBNcwH3dL+s+ttgrAijAsUDHrVxye/kOwrwRygFDSPuPIAz7OmyF0PoOznx?=
 =?us-ascii?Q?NLmU48OnH0E6/mJLgbhG5WRxKcwmgVStntRykFe2Qu7OA3P+VZxJmDlEreyD?=
 =?us-ascii?Q?LqSdSl3aHaflZVPJ+0GbHvLIvhFAZvq7dFkcTm3UGP9TfzEwAlH9gEV5mDPm?=
 =?us-ascii?Q?FqxNDUW/xFevsGTTXrhaoZ4sv/hKd3Ld8kAoaAoKVWI7km0pByYrSpkPkV+U?=
 =?us-ascii?Q?PfDjFIYT1X+g8u6OTE+BBFzpgGY5FS4yvl95B+KTihLkwIeiGFmoUwG5k0WE?=
 =?us-ascii?Q?yRWUQoaRgmIzBbOkAJwZ2qLMs3p3EEhjsxde9djA3+fV/gRVKEqUNkSP/83E?=
 =?us-ascii?Q?Vss9rHg8CsM/JlqYVl+LESSn7b7TsnO8PbIWylc2EbeDVZezp6BiB9Z80Rxx?=
 =?us-ascii?Q?U7gvr6OvIagQN2QHaLsKDBgTP1yDabT8kI8vRo5TZ54aVlKPPzk8nkJ8aSEZ?=
 =?us-ascii?Q?IHQgCjGWfymvNfVdgkO+hEQNwTnW/aRSLXee9bagw47PRC8huZldmccc9q3+?=
 =?us-ascii?Q?eU+DR8rSANmgHKi5keGcpao25tncUHWp+GIq7oEjP1lcDkBZfJglt0mnHPG5?=
 =?us-ascii?Q?IBCcWB4Fs8JYurapb+NuxEA1Q1fbU57IiMAEuOkhWnxS?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b0e006-3587-40b7-7c7e-08db9ab4c786
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1099.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:49:03.7327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dM0tN8BBd4fnNAsR/cxEK2n754HLq4wxazQbre2trquUOxORXSNlCsUTFL6mV9gtjSDI8WL39mAw0AMjw3dAhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3445
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

TDX guest memory is private by default and the VMM may not access it.
However, in cases where the guest needs to share data with the VMM,
the guest and the VMM can coordinate to make memory shared between
them.

The guest side of this protocol includes the "MapGPA" hypercall.  This
call takes a guest physical address range.  The hypercall spec (aka.
the GHCI) says that the MapGPA call is allowed to return partial
progress in mapping this range and indicate that fact with a special
error code.  A guest that sees such partial progress is expected to
retry the operation for the portion of the address range that was not
completed.

Hyper-V does this partial completion dance when set_memory_decrypted()
is called to "decrypt" swiotlb bounce buffers that can be up to 1GB
in size.  It is evidently the only VMM that does this, which is why
nobody noticed this until now.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/coco/tdx/tdx.c           | 64 +++++++++++++++++++++++++------
 arch/x86/include/asm/shared/tdx.h |  2 +
 2 files changed, 54 insertions(+), 12 deletions(-)

Changes in v10:
    Dave kindly re-wrote the changelog. No other changes.

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1d6b863c42b00..746075d20cd2d 100644
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
index 7513b3bb69b7e..22ee23a3f24a6 100644
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

