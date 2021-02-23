Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79EC3233F0
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Feb 2021 23:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhBWWuc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 Feb 2021 17:50:32 -0500
Received: from mail-eopbgr690122.outbound.protection.outlook.com ([40.107.69.122]:51382
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232561AbhBWWqM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Feb 2021 17:46:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkKNZoBFTx91OzXqn2g1no0WFzlV8T7Ir3y5Io+iKiBTommOaqlYHUqhsyvrkHDreu5xjTi02IgIeBS6QwcsdwklL2lslem1wn/lawgnQa6UiNsQcc20Gk/0Rib/2rpgzulrJ05tu1z5H0PM8RsrBV2UT599XjZSF+k9GdBDAJDwtNH/FHDIgG6vaiF+MByEPZfpU+0+t5eE30CiyQl59RzRs7lW0V3NVBbZ+W2/rCy6VrGXd2E5iaAGdW5VyajGdTBmdqJqJexJNuDjTzvhyWdGqRmNzgtPuSsXwt1jqVqwWvsI3QfHVnqWIZOyycIi8laGH+Nn+jV917Uki8E4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKdClBG3pv7WtEmdCpyflKBhHfVKfKdUPovSHvPWHeA=;
 b=M1GTJ0FzxNSRp1R40nTMZta01hNP3Pt5ai5Sd+VKJ3LpjYiEN6fKaXOwUzZfpjwuMMoAgfLg8P9EGidtDjabSJTvWZ7iuOhD7jHW7NsJdTRE4wwZuZoqrg1uTD4tXgzlgMVX9g8PDIr5c6GINVse4DkzrC1tLDrcw8uE+kxgng+EMutE3RhQkpxym9LDKBCwXP1IkG5q6NpG7K5JB4YR7a5baYXzDoeo5mhAmD4ogUot2h+pMlQO/f2cCMJLIDVfbFP/8pJb1aMkELO7QjBrKgQbljaMC4KC4bLAIbalmJWQVAIxJiT9aUyklY6VewdYt/Idv5sxYnYcsBtxO8WO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKdClBG3pv7WtEmdCpyflKBhHfVKfKdUPovSHvPWHeA=;
 b=d2EhJOeRcreSeknTdJWWMZfEu9qIeHSd9Lu/Kd0gu2zKHA/wZhmbG4kwYuCpCbB+GALCf2pPyOiU5fG9Eg8bqIOIdfDxBnL5N8Xhz/qoV5KkBGqgY6Qhu0YPgi4nBXZgQe/3ZSx7gFzGbBUBI/VDeDcbnrU4eYxKNjLKCAz58fo=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1404.namprd21.prod.outlook.com (2603:10b6:5:25a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.3; Tue, 23 Feb
 2021 22:45:20 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%5]) with mapi id 15.20.3890.002; Tue, 23 Feb 2021
 22:45:20 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, jejb@linux.ibm.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v2 1/1] scsi: storvsc: Enable scatterlist entry lengths > 4Kbytes
Date:   Tue, 23 Feb 2021 14:44:54 -0800
Message-Id: <1614120294-1930-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [131.107.174.144]
X-ClientProxiedBy: MWHPR18CA0026.namprd18.prod.outlook.com
 (2603:10b6:320:31::12) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MWHPR18CA0026.namprd18.prod.outlook.com (2603:10b6:320:31::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 23 Feb 2021 22:45:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6709807d-7003-4ff1-097a-08d8d84cb2ac
X-MS-TrafficTypeDiagnostic: DM6PR21MB1404:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR21MB14043CAB76330BABE0BB396BD7809@DM6PR21MB1404.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tn4VCTdoB0D5B1IU0MlEskKT24ti1Hj+mmoOIlt+Bnv+fneU+GL7jhEwkKTLmMhPeBtF/LNG3VxPrsE60H7C8L4Oe+d3nXdtHtXqEkxhcurzbzZxRRZ7jP7GG8UXOGeZU7w+zMyoM3e+mKWHSMQVuMK8Yf5CwFAoWGpqAaCwc/HUTxF/gfJyG5i/qiCD07fTEt3kMiodyu7oGtb2aDR2V3Dk+Kffk4I216Tmd9Ro3c6xYVpp8m4HjINZmr7BdDu93Fuukhero1A86YBDvrlFF8ZrxCDH5wsVmOyh5ZL2txFekNKxYHv9Qd2V6KlrISZRP/81qAkS3q62V3zNkVY1pd4YeBkJqAvHY8srHl5uLygQDh+B4DL9/tmAzX/tn3YAHnTE3Cps5OYNSWlsR1mGycB44qqu/XuqMte17AX0+9pUxEz2NDZE6ZzSK+gNK1fxNVrHK85REUOQK2ItfAv5fxOGo4d3ySbZe4KBGteHLPN0QRPdUxHO7gDPnR+cCjP2Tgb/Arb1dNtX3sEnOpYdjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(2616005)(82950400001)(2906002)(107886003)(5660300002)(4326008)(66946007)(8936002)(83380400001)(66556008)(16526019)(82960400001)(8676002)(7696005)(52116002)(86362001)(66476007)(956004)(186003)(26005)(36756003)(6486002)(478600001)(6666004)(316002)(10290500003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+jC6AKuIViBvOEgSmVG5OdI+Q0vAg1a2uCYj9koOrDoPKC+3TZdR8iJiDLgs?=
 =?us-ascii?Q?EcnCaAAo+uou5uOrWvOc4VA3ynboo/LDXp/Tc1/S+oY6k+B6V9ZvovsHvv7Y?=
 =?us-ascii?Q?EpTJjxmhlqfQN5EV85+R0LUU2Ii632FoBDKBHvThrKH9B0NAjRR56KtUg0o2?=
 =?us-ascii?Q?q/vKcUhobg5UeVFluPm5OMc0hBjAfOkr8HDmw2fuDqbr09tQqEqVxB6ZAOm3?=
 =?us-ascii?Q?VFnZrNpeuaEscXu9C3GV1cnjM0EU30T6xqwzsUmh+rfZ8zSZMdBEQl+Yq22l?=
 =?us-ascii?Q?0sUVZSGD8vdoEod3b1t4ucFmK1Qxb9mYcyICA07C5u4ugx6VQ5PTJuwbsucH?=
 =?us-ascii?Q?vuo2z0US2LYrXZLqb8dfbMIoAvqjFYXNCRz32DBsYY0LgaBnaovrhd7uTGsd?=
 =?us-ascii?Q?a6Lqn1xU+GCXAvonueBolC3Nipv/N8CuON+x8yuMwA+di7LOE5BJOPhD2aBR?=
 =?us-ascii?Q?6dmXkLR5apTLzpouiWUQ881fAlh490ZR3+/Y4Tq116vsZ8dH8h4O0lEmDJxT?=
 =?us-ascii?Q?xcB41RWIPTBI1t/gXO109rpI345MyKlwiOwT10wwkBujak4iMCqu9L3UB53G?=
 =?us-ascii?Q?gSgE/AXN3fvejpxT/wSb/jEnA1EzhBFfgDqMlEFzoZjyVHiCYZbWgOLzCj+e?=
 =?us-ascii?Q?oYJwocPArVc30ycedJ32gXL8DMCy2clnrnx39LCOU4/1+P3mpFxzoPYQeD+C?=
 =?us-ascii?Q?JtroBpNsIHLZYLt0xzzfCC3AytVbnUbrOhhZb6eTmMDBO6V1E6Ui7ahLOJLe?=
 =?us-ascii?Q?ohZtdyA5HcCG5iWC1kaQadtrJsH4exdX97ezloU1NLnfsvzLNWxOof0Kh1FJ?=
 =?us-ascii?Q?78cn9UjmAZvf2R4a+j8FZkQVW7z4EMUcStYdvn853eLxM+/xSuUq8qqtTadf?=
 =?us-ascii?Q?6yOVN2BrJ8X3hA/q7lcwuCYQOEhfu8Jdpdx9dt0q01lVJCFDbuilG5r9SNXa?=
 =?us-ascii?Q?w2ZcdpMV4kTh/9THmIqCvdJU4xfo6Cq+NQ4XCj0mXpmVrD4B58EeZ9OaCulP?=
 =?us-ascii?Q?JB5w8R3AiRhG1jGf4BIP08BJYAWzrXj1b7PIviUyJoxdXAJorPozHudd02k2?=
 =?us-ascii?Q?aSJwpkvEbkPP0L6o0gwLl+PN6qBlWFOECQmxRAwFzAgNC16cpBI8tOvLZdzE?=
 =?us-ascii?Q?vdrBKquDwnPe2ERj19/U8ogdLrUCnhLa73i/8tsfMKkbBAeJ/BYqwcJO/wK2?=
 =?us-ascii?Q?QOk1k6rRygyzqFdAFxCBOF8eW9gVfv+F2YTHPmO8woxmkEmh4xiAZMkvE4b8?=
 =?us-ascii?Q?aiy+505XZC5m4PBTQwqd/h2oxQ/3/YtbAkw4gTWsIVAMdwFyn7IH4Y7EBXqv?=
 =?us-ascii?Q?INpKDvYc+tg9Gsp7+vNFRhGv?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6709807d-7003-4ff1-097a-08d8d84cb2ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 22:45:20.4088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4aTFbZKbR31t7Vmt38WrMaZ4czQI4/WO6IQmmIYKVvewWd5bgTMc6/9SLKzb0G4UXM6Cd9m9DbpEOKJop+YQAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1404
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

storvsc currently sets .dma_boundary to limit scatterlist entries
to 4 Kbytes, which is less efficient with huge pages that offer
large chunks of contiguous physical memory. Improve the algorithm
for creating the Hyper-V guest physical address PFN array so
that scatterlist entries with lengths > 4Kbytes are handled.
As a result, remove the .dma_boundary setting.

The improved algorithm also adds support for scatterlist
entries with offsets >= 4Kbytes, which is supported by many
other SCSI low-level drivers.  And it retains support for
architectures where possibly PAGE_SIZE != HV_HYP_PAGE_SIZE
(such as ARM64).

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---

Changes in v2:
* Add HVPFN_DOWN() macro and use it instead of open coding
  [Vitaly Kuznetsov]
* Change loop that fills pfn array and its initialization
  [Vitaly Kuznetsov]
* Use offset_in_hvpage() instead of open coding


 drivers/scsi/storvsc_drv.c | 66 ++++++++++++++++------------------------------
 include/linux/hyperv.h     |  1 +
 2 files changed, 24 insertions(+), 43 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 2e4fa77..5ba3145 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1678,9 +1678,8 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	struct storvsc_cmd_request *cmd_request = scsi_cmd_priv(scmnd);
 	int i;
 	struct scatterlist *sgl;
-	unsigned int sg_count = 0;
+	unsigned int sg_count;
 	struct vmscsi_request *vm_srb;
-	struct scatterlist *cur_sgl;
 	struct vmbus_packet_mpb_array  *payload;
 	u32 payload_sz;
 	u32 length;
@@ -1759,8 +1758,8 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	payload_sz = sizeof(cmd_request->mpb);
 
 	if (sg_count) {
-		unsigned int hvpgoff = 0;
-		unsigned long offset_in_hvpg = sgl->offset & ~HV_HYP_PAGE_MASK;
+		unsigned int hvpgoff, hvpfns_to_add;
+		unsigned long offset_in_hvpg = offset_in_hvpage(sgl->offset);
 		unsigned int hvpg_count = HVPFN_UP(offset_in_hvpg + length);
 		u64 hvpfn;
 
@@ -1773,51 +1772,34 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 				return SCSI_MLQUEUE_DEVICE_BUSY;
 		}
 
-		/*
-		 * sgl is a list of PAGEs, and payload->range.pfn_array
-		 * expects the page number in the unit of HV_HYP_PAGE_SIZE (the
-		 * page size that Hyper-V uses, so here we need to divide PAGEs
-		 * into HV_HYP_PAGE in case that PAGE_SIZE > HV_HYP_PAGE_SIZE.
-		 * Besides, payload->range.offset should be the offset in one
-		 * HV_HYP_PAGE.
-		 */
 		payload->range.len = length;
 		payload->range.offset = offset_in_hvpg;
-		hvpgoff = sgl->offset >> HV_HYP_PAGE_SHIFT;
 
-		cur_sgl = sgl;
-		for (i = 0; i < hvpg_count; i++) {
+
+		for (i = 0; sgl != NULL; sgl = sg_next(sgl)) {
 			/*
-			 * 'i' is the index of hv pages in the payload and
-			 * 'hvpgoff' is the offset (in hv pages) of the first
-			 * hv page in the the first page. The relationship
-			 * between the sum of 'i' and 'hvpgoff' and the offset
-			 * (in hv pages) in a payload page ('hvpgoff_in_page')
-			 * is as follow:
-			 *
-			 * |------------------ PAGE -------------------|
-			 * |   NR_HV_HYP_PAGES_IN_PAGE hvpgs in total  |
-			 * |hvpg|hvpg| ...              |hvpg|... |hvpg|
-			 * ^         ^                                 ^                 ^
-			 * +-hvpgoff-+                                 +-hvpgoff_in_page-+
-			 *           ^                                                   |
-			 *           +--------------------- i ---------------------------+
+			 * Init values for the current sgl entry. hvpgoff
+			 * and hvpfns_to_add are in units of Hyper-V size
+			 * pages. Handling the PAGE_SIZE != HV_HYP_PAGE_SIZE
+			 * case also handles values of sgl->offset that are
+			 * larger than PAGE_SIZE. Such offsets are handled
+			 * even on other than the first sgl entry, provided
+			 * they are a multiple of PAGE_SIZE.
 			 */
-			unsigned int hvpgoff_in_page =
-				(i + hvpgoff) % NR_HV_HYP_PAGES_IN_PAGE;
+			hvpgoff = HVPFN_DOWN(sgl->offset);
+			hvpfn = page_to_hvpfn(sg_page(sgl)) + hvpgoff;
+			hvpfns_to_add =	HVPFN_UP(sgl->offset + sgl->length) -
+						hvpgoff;
 
 			/*
-			 * Two cases that we need to fetch a page:
-			 * 1) i == 0, the first step or
-			 * 2) hvpgoff_in_page == 0, when we reach the boundary
-			 *    of a page.
+			 * Fill the next portion of the PFN array with
+			 * sequential Hyper-V PFNs for the continguous physical
+			 * memory described by the sgl entry. The end of the
+			 * last sgl should be reached at the same time that
+			 * the PFN array is filled.
 			 */
-			if (hvpgoff_in_page == 0 || i == 0) {
-				hvpfn = page_to_hvpfn(sg_page(cur_sgl));
-				cur_sgl = sg_next(cur_sgl);
-			}
-
-			payload->range.pfn_array[i] = hvpfn + hvpgoff_in_page;
+			while (hvpfns_to_add--)
+				payload->range.pfn_array[i++] =	hvpfn++;
 		}
 	}
 
@@ -1851,8 +1833,6 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	.slave_configure =	storvsc_device_configure,
 	.cmd_per_lun =		2048,
 	.this_id =		-1,
-	/* Make sure we dont get a sg segment crosses a page boundary */
-	.dma_boundary =		PAGE_SIZE-1,
 	/* Ensure there are no gaps in presented sgls */
 	.virt_boundary_mask =	PAGE_SIZE-1,
 	.no_write_same =	1,
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 5ddb479..a1eed76 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1717,6 +1717,7 @@ static inline unsigned long virt_to_hvpfn(void *addr)
 #define NR_HV_HYP_PAGES_IN_PAGE	(PAGE_SIZE / HV_HYP_PAGE_SIZE)
 #define offset_in_hvpage(ptr)	((unsigned long)(ptr) & ~HV_HYP_PAGE_MASK)
 #define HVPFN_UP(x)	(((x) + HV_HYP_PAGE_SIZE-1) >> HV_HYP_PAGE_SHIFT)
+#define HVPFN_DOWN(x)	((x) >> HV_HYP_PAGE_SHIFT)
 #define page_to_hvpfn(page)	(page_to_pfn(page) * NR_HV_HYP_PAGES_IN_PAGE)
 
 #endif /* _HYPERV_H */
-- 
1.8.3.1

