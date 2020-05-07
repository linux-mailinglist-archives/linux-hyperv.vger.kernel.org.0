Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A869B1C99BB
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2020 20:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgEGSs6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 May 2020 14:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728166AbgEGSs6 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 May 2020 14:48:58 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0170E24955;
        Thu,  7 May 2020 18:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877337;
        bh=DzIn/TStIR1qO0jGDRIjha7WKLj8NmPXjLYvrxu8mwU=;
        h=Date:From:To:Cc:Subject:From;
        b=NFBkUx9xKM0l5hkInpK+k2tkyl69LaRPmZIBXRXNlAzC1HgkPcuGLIfxFd3bBAiKg
         Q6+didIh143imEJpECyL8j0pLJrxHR1G5BQCgoQcqpcaQRDxYRNPIwYtnYf/HFp7a2
         uAImZJ8+xeggQZjvOr01itL+Ha0eUzyX6Vi3wqy8=
Date:   Thu, 7 May 2020 13:53:23 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vmbus: Replace zero-length array with flexible-array
Message-ID: <20200507185323.GA14416@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/hyperv.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 692c89ccf5df..ce2c27440e17 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -117,7 +117,7 @@ struct hv_ring_buffer {
 	 * Ring data starts here + RingDataStartOffset
 	 * !!! DO NOT place any fields below this !!!
 	 */
-	u8 buffer[0];
+	u8 buffer[];
 } __packed;
 
 struct hv_ring_buffer_info {
@@ -313,7 +313,7 @@ struct vmadd_remove_transfer_page_set {
 struct gpa_range {
 	u32 byte_count;
 	u32 byte_offset;
-	u64 pfn_array[0];
+	u64 pfn_array[];
 };
 
 /*
@@ -563,7 +563,7 @@ struct vmbus_channel_gpadl_header {
 	u32 gpadl;
 	u16 range_buflen;
 	u16 rangecount;
-	struct gpa_range range[0];
+	struct gpa_range range[];
 } __packed;
 
 /* This is the followup packet that contains more PFNs. */
@@ -571,7 +571,7 @@ struct vmbus_channel_gpadl_body {
 	struct vmbus_channel_message_header header;
 	u32 msgnumber;
 	u32 gpadl;
-	u64 pfn[0];
+	u64 pfn[];
 } __packed;
 
 struct vmbus_channel_gpadl_created {
@@ -672,7 +672,7 @@ struct vmbus_channel_msginfo {
 	 * The channel message that goes out on the "wire".
 	 * It will contain at minimum the VMBUS_CHANNEL_MESSAGE_HEADER header
 	 */
-	unsigned char msg[0];
+	unsigned char msg[];
 };
 
 struct vmbus_close_msg {

