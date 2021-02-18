Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA9A31F17C
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Feb 2021 22:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhBRVDf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Feb 2021 16:03:35 -0500
Received: from mail-dm6nam11on2132.outbound.protection.outlook.com ([40.107.223.132]:23072
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229671AbhBRVDJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Feb 2021 16:03:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvJUa7+Bg/qoKbvmPxv2rNGidKocOdpxaGsNV831DLcVSs2MfdpaGQ6+16CTms1VMb1LQEo249iVcD6i3UsGQMD01jq1VKhvamDbQJiNUUKM1wGuUVAoyepbrisqzZfvUMF4uohM2udtCpY8rT+cWvXVx/iZ4z0BvBOkg39KzNCOADN+VAmvbeciIUjUpKz68ryYj1X74qtNFRs9Xge7qnsOKjeo+qmjv/a9lwUbQF234pPAe7opTIUOHd4FGhgUGPreevpcr7vepRaliaK+V6GpcUhVlcD+QDPXG9hU/5rG2n85XgEepGEA5uEG07ouLo+QsqL6doDE58XreAm/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb553JjDFfDPJo9/Pt7OBvdjOTgAfCF3uRWnDI/Q+v4=;
 b=luX4/kKLryQQBTC4jwfDPN1OyBu8xNanF7gdJpJtsSaoiSawF8fy8ePyAL/4wM4Qib3R1vrxwzC4tavl3GUHJwAnFZQyGeMTXFq5gdyfrRV2BnoJ8c8lNn9yeFW4SKa692PTM27BWyFpy2zwmK1HWgmC9wK5ns3tPJth2DBXpFTVB06OBtEBnHQ4S7/CX8c8K+LWi0xTzJYlh+2iNbBv1rZMnI6HA7Wm0QLFaltIm9TytBzrIag35pK+7M9VE6shCWkCu2CZa3FEGwMEfszRkdP3TmFCSO2ik+G+IPhhNS8YV1PiU9iHWTB7Ypjp9W7BfSXmcAut95QETn3YgWgGZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb553JjDFfDPJo9/Pt7OBvdjOTgAfCF3uRWnDI/Q+v4=;
 b=b1f75KDkG48+ieXJLDHPsVYVgVi0Y4FEpQpQJ1Nb4FnLZUjBJy2QeAkkVTYQCefCLRiqXisKkhgSZmpAgbEoY77TD4Peg0YFaxmWgnRihj2DaOzUGraUG6p78jZJy4Gg5UjB/ol7o3Z9XYqYdNrKqkTs43mmJUTIFG+2DGbLCcc=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from (2603:10b6:5:22d::11) by
 DM5PR21MB1543.namprd21.prod.outlook.com (2603:10b6:4:7a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.3; Thu, 18 Feb 2021 21:02:21 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%5]) with mapi id 15.20.3890.002; Thu, 18 Feb 2021
 21:02:21 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, jejb@linux.ibm.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] scsi: storvsc: Enable scatterlist entry lengths > 4Kbytes
Date:   Thu, 18 Feb 2021 13:01:27 -0800
Message-Id: <1613682087-102535-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [131.107.159.144]
X-ClientProxiedBy: MW4PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:303:6b::33) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.159.144) by MW4PR04CA0088.namprd04.prod.outlook.com (2603:10b6:303:6b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 21:02:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d57950e-c7fb-4d2b-7b18-08d8d4507bdb
X-MS-TrafficTypeDiagnostic: DM5PR21MB1543:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR21MB154314360F904086A13367AFD7859@DM5PR21MB1543.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7uW697sJSaTMFy1NMmBB6y1SKV4Y5Wmpm9MsRA+ylsludr4hoQJEfD0suth8qlqDH4M6+CK4OnAky2xD6b4qY/Bd06c+5iysAKgFzLP7RwZczh/BvteqtkTUHJJ4k5N2w+SPwrY0vAKwv+p7mxBGxBOklEm19+m1YckWcgcwGXfmhSxwp+EBeQ3OZyY7FfxvpaPc1LuUYiphBzlcnXHwNrLX0wgju5B4tx1JOA0wpij1wR+yds7KH1PGGJQWiiy9aFe7KuqU5PQocHAJqJqLGsWyXXRfqtDubuPxeBldnV/vDtFAhIU7GTboNVbk7Zh3dmonN6+WKeTilasqIpP/nLYG9CWfS1c1MQwxAW5NBJqWRvXcBJskCHvw1UuQU+1iRIebC9Z15xtPJRLh//3hKXLe+7F/W2FrgG0YyjAblgASGdjNaICXa4gIcbsEMBv4A7VDlja5/RMq2a75aPvUCJHHOcLpD2s0ItvJmF2bClxzNb+dhfBsGYTXbwcYcyqxRjFyNyKntY0yez/uf87qOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(5660300002)(6486002)(2906002)(8676002)(316002)(10290500003)(478600001)(36756003)(26005)(107886003)(66476007)(66946007)(52116002)(7696005)(82960400001)(2616005)(66556008)(82950400001)(4326008)(956004)(83380400001)(16526019)(86362001)(8936002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/lHAcCoKvjJUqPSPRA+JUg/nIULXcR17+nAOZ2h+4rUi3qiMCSYnohMuFv5V?=
 =?us-ascii?Q?VgkTXDbbgX0vMFBBgpQXYfhrHD210QDLBtpnwRJHN21HsjneTOM6GLrgV/pO?=
 =?us-ascii?Q?+3wWxLMZ9VS9V3jjGV+BvrW5a00oKxXZbrT1dzI09/VCW6pjNzjC0RxuhAG2?=
 =?us-ascii?Q?iwRKVB1JuX/QY1UXH+ISoCIzxS5pjyJIaGPFTFR7LZcxQpmCicPbY7nDGWxr?=
 =?us-ascii?Q?dHiVEC84uf1WywtaufSj7t37zzRqCjKShYg2zt9LZXPJ2vYn4hU105awYmpg?=
 =?us-ascii?Q?PcTd+pOD35Wxm7dIfaU7cKWJrpdkUt+NfVdsRnZdOGVtvXZ7iD1IhnFs0fJe?=
 =?us-ascii?Q?p+uMP0fDgD+Px05ODTHtoY8K32NBDmWW27M+LgE27pKNwy5tJGXC0K6p7gTG?=
 =?us-ascii?Q?KoOoGlMsE7ODbWy61C8hQRLxGuXJmv/8ro9oqHFGLQfbyI+9nxo78hk8wCs3?=
 =?us-ascii?Q?BsJJ9myf5KjVqbCqYloI4e2CjDcAKxV2jaOciX/QjVAe5rvrdZ7H1e6podx2?=
 =?us-ascii?Q?wwTTCUgtXUkjw17GPHr14QjqDIQ4l+AzaiCSYeIyh6/dSl2PcOGwkoWpam5R?=
 =?us-ascii?Q?ckjZYrUiswMyPPPA4Irt+GYlQtiztwhwM3UcZC33MucfAuSOIspuScNCLbDr?=
 =?us-ascii?Q?YYmm2QjeLM7fVKzO02wcBeZa9ZE+0VML6630YI/nM0cWSVqrjovzUx2KNVBH?=
 =?us-ascii?Q?wHQ5M+GGPYDIh0cLYm1SUeZXcYSJZTOttW61D+gUHH2rePpj2oNaRJomhgDP?=
 =?us-ascii?Q?5PPEoj/fWTJkBQUzSTJrN/EObqpmhloPB1kZFLvg+9rHP7M095RkWtZiB5Hl?=
 =?us-ascii?Q?LebHTmui3Wt000VSvv3nvlCkbSxVL0e5Wg+Dc08ixak4wn0BmuRsBggzlu+r?=
 =?us-ascii?Q?0gtRJ0hn3Kc9lYYp4cBJKxYYSneWC8Au6izZT6Jqivr1bTAw4uCnnDJ18okl?=
 =?us-ascii?Q?2Hoet6vhSOFZkUjcO8ohjuE+HPhRtuuOsGS/K08Y29RGpUHttc0j5cZSPBm/?=
 =?us-ascii?Q?2xSQzIcIQPIZYWgDY/gYHoDke63Pk3Fe5WNo8kjXxF4SWrOouukS7WtelmqF?=
 =?us-ascii?Q?0G+GU4bNhiClpqZoDiEqIz0CQrSr79fFDlloLzHDKytaoOPXVf5rdocv/QFv?=
 =?us-ascii?Q?l7m9NbvytY40GK0EqUwiRP4V/Fz9obnPLrvjFbCd/Xz5glQDQ7W6kKl0nvQl?=
 =?us-ascii?Q?MsMoH0QWC3cjQbdbExPfUxI0SoI16BLxAz6b66y8rvQwk3WrX0Qlgm5/aHzU?=
 =?us-ascii?Q?M5cY6LYPtiFrOvmDwvjfIS536iyQJlceu0lA8rZW/oslmrQ3u8eV0t+5P4ey?=
 =?us-ascii?Q?4Jwy43jOd+OnTGH/Te0wtrsV?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d57950e-c7fb-4d2b-7b18-08d8d4507bdb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 21:02:21.5111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNkQgEBuI2KY6Q34llTV3gLUx8RipLaiu/yyntLiOnaGPF2EF5lKMZ/d6bRxkd173mQjLSGZrPGU8uECyJ6TmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB1543
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
 drivers/scsi/storvsc_drv.c | 63 ++++++++++++++++------------------------------
 1 file changed, 22 insertions(+), 41 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 2e4fa77..5d06061 100644
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
@@ -1759,7 +1758,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	payload_sz = sizeof(cmd_request->mpb);
 
 	if (sg_count) {
-		unsigned int hvpgoff = 0;
+		unsigned int hvpgoff, sgl_size;
 		unsigned long offset_in_hvpg = sgl->offset & ~HV_HYP_PAGE_MASK;
 		unsigned int hvpg_count = HVPFN_UP(offset_in_hvpg + length);
 		u64 hvpfn;
@@ -1773,51 +1772,35 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
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
+			 * Init values for the current sgl entry. sgl_size
+			 * and hvpgoff are in units of Hyper-V size pages.
+			 * Handling the PAGE_SIZE != HV_HYP_PAGE_SIZE case
+			 * also handles values of sgl->offset that are
+			 * larger than PAGE_SIZE. Such offsets are handled
+			 * even on other than the first sgl entry, provided
+			 * they are a multiple of PAGE_SIZE.
 			 */
-			unsigned int hvpgoff_in_page =
-				(i + hvpgoff) % NR_HV_HYP_PAGES_IN_PAGE;
+			sgl_size = HVPFN_UP(sgl->offset + sgl->length);
+			hvpgoff = sgl->offset >> HV_HYP_PAGE_SHIFT;
+			hvpfn = page_to_hvpfn(sg_page(sgl));
 
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
+			while (hvpgoff != sgl_size) {
+				payload->range.pfn_array[i++] =
+							hvpfn + hvpgoff++;
 			}
-
-			payload->range.pfn_array[i] = hvpfn + hvpgoff_in_page;
 		}
 	}
 
@@ -1851,8 +1834,6 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	.slave_configure =	storvsc_device_configure,
 	.cmd_per_lun =		2048,
 	.this_id =		-1,
-	/* Make sure we dont get a sg segment crosses a page boundary */
-	.dma_boundary =		PAGE_SIZE-1,
 	/* Ensure there are no gaps in presented sgls */
 	.virt_boundary_mask =	PAGE_SIZE-1,
 	.no_write_same =	1,
-- 
1.8.3.1

