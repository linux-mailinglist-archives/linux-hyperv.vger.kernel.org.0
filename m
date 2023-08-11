Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5592B778544
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Aug 2023 04:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjHKCN5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Aug 2023 22:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjHKCN4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Aug 2023 22:13:56 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021017.outbound.protection.outlook.com [52.101.57.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B061C270C;
        Thu, 10 Aug 2023 19:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbpQd7n4HA64gu0MuDXnD14iMMNbOwMKQASKFRc8TUktz18dDAqThOP3gfTwVGAoIjqWI9ATecA7J4YSC+q/v7E//F91qh3cKVj8/jpq4hbuzncVwqDodnrpgCyedgdo85+OZQ/XJ0ArfXSwrOR9BaxTrNE0CQQn7bhcRl/iEfBfE/Pnu9ZbFfdwLrYjPor8LUn+Ax8LdKoyAKK+L8/rqw+ir/ucqz/aKgE4gjf7w7tiRxPyKb98UAyhkL2kGSf/kYC9F6U/F0iNgE3+KjPz8xr3ZQVyGTz0GiUBdH7JQPrSaUB7F3mSAANlck5EcEBXFwKwx/8fsEbxWh1yJWWODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MsDwaOwi/CgW6Yr7aTJR5hfbE35O5E4fDtBHbmSzLM=;
 b=Ni0WKjMalxrOXX4UfS1eW39ZbrbQl4a+D4PPdDDjv2CTDyZzNYLKFvdN0Ruy5FbyZ0ayAeQ9MIPeD+OC0X9ZgUwrfuV0s0Iahz+RGq9hHBYDld4TgIlTO0VS/rqzHofiNan0hUJ6qyx3aSMT41iUx7nDRvVt1+dTBkybcTjr/u9ERhiRtGvQou1eK3DXCGFvc/PRMrjDUGBLFadCVZvme2xJ28oJeWk5/293QglTggHDyvrnrnqZd6kdeVzzktPQJo5hrv8ysNil0HlupSuUZrscbo0/+KdZJZw6bQILrrwV22z+ARurCRaF0jPJ1St/jDf5nM3HLkxkEr288l9hFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MsDwaOwi/CgW6Yr7aTJR5hfbE35O5E4fDtBHbmSzLM=;
 b=XZzzftx1pHexb5KSXmzsfUwVn3cAOcd5ASnOggKobAgODj/gTZ6OlTmJsTWgK1/Zz4z8FWQVS3t8XSjWEBAe6CEXY++SP2/1L0EAauZmyqTfvGYkJVNrbKYqH1KA+NH6G9wUYDzSkZI2QuuK+iNqM6XUW64HDb+uv6zL7txao4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MN0PR21MB3072.namprd21.prod.outlook.com
 (2603:10b6:208:370::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.7; Fri, 11 Aug
 2023 02:13:53 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::879:607:79:c14d]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::879:607:79:c14d%4]) with mapi id 15.20.6699.007; Fri, 11 Aug 2023
 02:13:52 +0000
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
Subject: [PATCH RESEND v9 2/2] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Date:   Thu, 10 Aug 2023 19:12:46 -0700
Message-Id: <20230811021246.821-3-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: e88597c8-4407-4ef7-fbb0-08db9a109ba7
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Du3Ac1irkkHizzLvW1nrByxEUOrBJod4vuCEhsQOTFI7xFnKMoOS8WfmEGGcIYtwATr/KCo+V7UQbspnC/Kxat8Xb+3lCy3ystCFNLT8KL9qA6O0sk+FYipV8usNESpIFTmlgit32PKHCEi93nPW1mbcxzLPcT2nQ7dtrObhYLesm/0abD7YCtI9l3ViY2gc7zHbsEsIko0jBypZEvvNOWQHvNcdrK34l2xScmLZsVlVKERDo8D51mY1EXXbux2rX1s6cqPwQ2M0lJsPi1U6LwthLPz3Q38Kxm9Zpk8twFzfPB120aeHydaTtKV2STvUsGCYJODQom/BvEl/SYEv9VfqCOGKuPhaluRQ2Jl2uhfurTaAGcryD60PsvKXayBuyGE9+seoKIbg7f4TvDvdyIy6JdUaiv1P/N4fywhV5d8kU3gr7/77Qc8i+H7aoJljnhIfIZhHlTTZKnPXTi8LM/sXeGHHWVNN40QuZVhJj/oVcaMzCNAaNVpEAk6GRNOg2sJvWJ2M9wRWPsso8JdviOqzxyLzj2hJqDeKfaaMiu90XUK2vA2CUKcrtmeudMrM6PkT15bJx5wOb+zZxKMDcfM4MNb3EFl3902uHHgFVI2Vi0hlHK07LMMPsEGHtmpf+N6FZcQtm+ZBd6T84qzFdj/AutmhhYgRc9FRCzyDo+RkFDDkP11NVcpi7oLpIuhs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(186006)(1800799006)(10290500003)(478600001)(36756003)(82960400001)(107886003)(6506007)(82950400001)(6486002)(38100700002)(86362001)(52116002)(2906002)(6512007)(6666004)(2616005)(83380400001)(1076003)(921005)(5660300002)(12101799016)(41300700001)(66946007)(6636002)(316002)(4326008)(8936002)(66476007)(66556008)(8676002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RsIVPYIoSikfjWUzUzpvO6Bbqp05G5Q4YqQsm2Kf7jZMTKe0F/Xp4SrUZa8q?=
 =?us-ascii?Q?1KmMHncdonyDhw3O6i0DP+Vm5i8oWCy84RFx5TBd3RDz/d5lpwHbeTQN/we0?=
 =?us-ascii?Q?dMAPMgQILn/WjDDEYxQpvDs7x30A5ZKvjQbFG0S+MTMW4J7UH+WkaZC5l/Ni?=
 =?us-ascii?Q?WvCDe/knnnzeoQhMuP12YgGypVBAIVzXCVl3w7Y0xYYpBeDBk+wJlXYdMEoG?=
 =?us-ascii?Q?I4t9DLTmo4uVLxLEfgN3A7BUCqhVDHJofDnZ4dShZmt/g2LQ1TGtM+VWTsUQ?=
 =?us-ascii?Q?aTeLxtxMwg8yiQawHqFvvS/LRLlLPUxGYlV4rnPyqP3Ig/sgZKqaAA3+SMgc?=
 =?us-ascii?Q?vKj9jfc77/c+dt320vPpvEFyfsSIBLKwotie+Hyas/+T8UXJVtieo9hHnZ8T?=
 =?us-ascii?Q?YiWDwl6PVFeUihofkhU/ojYFnL7gPq05AjBzOqyfYWNvIRabOVvyIGdoQRk5?=
 =?us-ascii?Q?lb70MrCdAnRshJlw1h6+im5WCoxv96BLPNdDaC+5AuJY8neSlXpIb6rkaY+z?=
 =?us-ascii?Q?JJ8+M6C3WmaiyBsi1Xnx2kIoB4X6XO3snZqSQCKHJk73AsppPFbbMJooWEZb?=
 =?us-ascii?Q?9m5vUHXVrDRzqI8cRlCtf2CsuQ1Gg/MM8JzIDk2qGYb9YWO6NoNViwv43Clb?=
 =?us-ascii?Q?6j2AsewmnfyjhbetGMFbzVZJSybFEhzqtOEtiFbz4sJA8gFGqVF/yck+JGfh?=
 =?us-ascii?Q?Z5NilksisrKqpnWc29OSUjAjRqw2P7pue0ctXHrJJe7Bo65s5AGNNm+HDi0W?=
 =?us-ascii?Q?DpG/Sc38ccVhk6uJjVCkRbJ0mYjxaqDpc4vDTFNe6EUYD7XEn8/aOSgVMIAL?=
 =?us-ascii?Q?PwYeyujnwuKJ/Xl0PPCBl7BPl6N7bj43blHbLZMiPv1oXsc8S7iZqEynqIwU?=
 =?us-ascii?Q?b2fmDvZ6NsifSFAyzpRNevZ8aBxCdFcF4IeJIPi+0UZX7Q4ZP5lvgetvimUv?=
 =?us-ascii?Q?rlRqUNOAM2v2rFqivikeK88vhYwGU05dO7LQjVpHA3QT9ehp49tIMbs+eH/Z?=
 =?us-ascii?Q?QFeCVL7ZIm8QHzkpDaxYONs4JHx9tQ3IrLEbLdL8+lHsFZXSp/ZPrY2ueNOR?=
 =?us-ascii?Q?aGsawWCvaKjssRfuJaIXtmnlDtock+ohrlsfQUWHmbuF4SiOM+kQyYpUorIR?=
 =?us-ascii?Q?+ea/ycj4JQeqFQJmkny7bde7dP8H+Q0nXsN8GCMaxUvDwSNyH92zxj4MFfFZ?=
 =?us-ascii?Q?55OYvKbRg4S6or7QpsAu7MrkkpJV0HqafdBQi2e7fpQuwL9W12f1eHxy1msc?=
 =?us-ascii?Q?c4ultXla0gVcM1MChbOV0Ibn5xDL8huV71Osl/0Q3qRTwtZ3JiXIzIUK691r?=
 =?us-ascii?Q?vNz4pK8s+/OhjgVo4kfpqZyBjZr8/yICOaKtjwzcw0r619QKAHRbuyz3PTWY?=
 =?us-ascii?Q?McPuIF4j0AeQau0rQdLzdJdGJ4XLcNgXhUyRTupIIJncVBtUrFeJC43hR+yi?=
 =?us-ascii?Q?5JOL1kyTbeVKE5dnR1UzldISZfzvaNIYP0gdq5Kmz3WOXv23JXGyckJL4Cve?=
 =?us-ascii?Q?S0MKf5jqJL8iAoOv+TPtfCQvekUfRewxuSyLkfBKBUVFidmS+gvx2FjWuPZa?=
 =?us-ascii?Q?FvuivTggR0VoddVKSg+0ID7y44sFhpmxADNf82QLZwE1Qd7GXpl5+pb4tcUU?=
 =?us-ascii?Q?kJHS2JAvmxIfHicQD4940K798jx5KzJq7PYtuwxMnR0N?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88597c8-4407-4ef7-fbb0-08db9a109ba7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 02:13:52.6667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C29+kWpOrWuBw1B3spCABZFhqb/rwIA3WV1+AwfeQEtRaRZ4N7+s1UTZijZ2nqLGUZt+d/ieZzetIG0JzFCWsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3072
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
 arch/x86/coco/tdx/tdx.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

Changes in v2:
  Changed tdx_enc_status_changed() in place.

Changes in v3:
  No change since v2.

Changes in v4:
  Added Kirill's Co-developed-by since Kirill helped to improve the
    code by adding tdx_enc_status_changed_phys().

  Thanks Kirill for the clarification on load_unaligned_zeropad()!

Changes in v5:
  Added Kirill's Signed-off-by.
  Added Michael's Reviewed-by.

Changes in v6: None.

Changes in v7: None.
  Note: there was a race between set_memory_encrypted() and
  load_unaligned_zeropad(), which has been fixed by the 3 patches of
  Kirill in the x86/tdx branch of the tip tree.

Changes in v8:
  Rebased to tip.git's master branch.

Changes in v9:
  Added Kuppuswamy Sathyanarayanan's Reviewed-by.

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 746075d20cd2..c1a2423a8159 100644
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
@@ -760,15 +774,24 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
  */
 static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 {
-	phys_addr_t start = __pa(vaddr);
-	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+	unsigned long start = vaddr;
+	unsigned long end = start + numpages * PAGE_SIZE;
 
-	if (!tdx_map_gpa(start, end, enc))
+	if (offset_in_page(start) != 0)
 		return false;
 
-	/* shared->private conversion requires memory to be accepted before use */
-	if (enc)
-		return tdx_accept_memory(start, end);
+	if (!is_vmalloc_addr((void *)start))
+		return tdx_enc_status_changed_phys(__pa(start), __pa(end), enc);
+
+	while (start < end) {
+		phys_addr_t start_pa = slow_virt_to_phys((void *)start);
+		phys_addr_t end_pa = start_pa + PAGE_SIZE;
+
+		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
+			return false;
+
+		start += PAGE_SIZE;
+	}
 
 	return true;
 }
-- 
2.25.1

