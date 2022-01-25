Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762BE49BC34
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Jan 2022 20:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiAYTgG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Jan 2022 14:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiAYTfp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Jan 2022 14:35:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC2DC061755;
        Tue, 25 Jan 2022 11:35:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01B78B819D9;
        Tue, 25 Jan 2022 19:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FC3C340E6;
        Tue, 25 Jan 2022 19:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643139327;
        bh=2SKgMeaepEa/3fqmOk3qpuRploR2lWhnOwQ1mCTG4l8=;
        h=Date:From:To:Cc:Subject:From;
        b=svmfcgT96x5RmVksMCBJvYdIuMEaOvAt+P5FqTHqYL1XJONcH3ydicPxs5N35LEUb
         9cCSgKfYet6QPhmh/03Vx6xIZ55/j/ULba+Iua+QuhGaVVDLRZeN7rV/tVP2t0wjEu
         yVV7a48kjsXtLdRBUsbPDT81z5jHvlR39f5tYG9h95l7tjJp47S1hSZJ8aGaRz2XKI
         mXkwr3J4wJSeZaWQOaQtZpuXupwcELyp+qlp/Au30u+qNuAaLkmAypZ/wC8WSrFbl9
         5OQmfLCr4mb4wox0Sd9B2Vi2HYPOBD0/RpCDgc/PFD+oNGC4Zh7njIlUZhxhEuA/dZ
         L+gUhbJCnczXA==
Date:   Tue, 25 Jan 2022 13:42:13 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] scsi: storvsc: Use struct_size() helper in
 storvsc_queuecommand()
Message-ID: <20220125194213.GA74670@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Also, address the following sparse warnings:
drivers/scsi/storvsc_drv.c:1843:39: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/storvsc_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 9a0bba5a51a7..89c20dfc6609 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1755,7 +1755,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	struct scatterlist *sgl;
 	struct vmscsi_request *vm_srb;
 	struct vmbus_packet_mpb_array  *payload;
-	u32 payload_sz;
+	size_t payload_sz;
 	u32 length;
 
 	if (vmstor_proto_version <= VMSTOR_PROTO_VERSION_WIN8) {
@@ -1839,8 +1839,8 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 
 		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
 
-			payload_sz = (hvpg_count * sizeof(u64) +
-				      sizeof(struct vmbus_packet_mpb_array));
+			payload_sz = struct_size(payload, range.pfn_array,
+						 hvpg_count);
 			payload = kzalloc(payload_sz, GFP_ATOMIC);
 			if (!payload)
 				return SCSI_MLQUEUE_DEVICE_BUSY;
-- 
2.27.0

