Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DAB30AE44
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Feb 2021 18:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhBARop (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Feb 2021 12:44:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:50580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231287AbhBARoQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Feb 2021 12:44:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD36664E92;
        Mon,  1 Feb 2021 17:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612201416;
        bh=6JuMhwiPxB5zwCevxjDcGxnSg7igAiVfttRPt3eGViM=;
        h=Date:From:To:Cc:Subject:From;
        b=RzHBn+zcnVxDBGt7mlXIwAfT7kISdYH5yde5MD1mHMHHzUnJCYwEinKiGKenm/oPj
         4gNFA30b9y2ujEmDtW5YQx6+2qWOGHUW441BU0QAVYzE59NX54GdVwzJGpDMHW1+CS
         jzSdNGz1qB89qQ8YCoN4sYtkiTrZqMWtzTVeaI+cKyUCOpRQ/wvNPKhi/vUY3+uqyu
         Wt9gsJJSJyKk9R0q12r4GD+wtxWaxUOjNSTpdKKwLbjNQ5q8UTL349ir0A4M+4SJYA
         vHB7/t9hfcSja+Lb8/P5lm8/rlCqx9vIziZXWWMlOk+DJcOleoVH7uLw4CoKTLhNEk
         d3cD5RMLT/TXQ==
Date:   Mon, 1 Feb 2021 11:43:34 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] hv: hyperv.h: Replace one-element array with
 flexible-array in struct icmsg_negotiate
Message-ID: <20210201174334.GA171933@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Refactor the code according to the use of a flexible-array member in
struct icmsg_negotiate, instead of a one-element array.

Also, this helps the ongoing efforts to enable -Warray-bounds and fix the
following warnings:

drivers/hv/channel_mgmt.c:315:23: warning: array subscript 1 is above array bounds of ‘struct ic_version[1]’ [-Warray-bounds]
drivers/hv/channel_mgmt.c:316:23: warning: array subscript 1 is above array bounds of ‘struct ic_version[1]’ [-Warray-bounds]

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/109
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/hyperv.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index f0d48a368f13..7877746f1077 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1528,14 +1528,14 @@ struct icmsg_hdr {
 #define IC_VERSION_NEGOTIATION_MAX_VER_COUNT 100
 #define ICMSG_HDR (sizeof(struct vmbuspipe_hdr) + sizeof(struct icmsg_hdr))
 #define ICMSG_NEGOTIATE_PKT_SIZE(icframe_vercnt, icmsg_vercnt) \
-	(ICMSG_HDR + offsetof(struct icmsg_negotiate, icversion_data) + \
+	(ICMSG_HDR + sizeof(struct icmsg_negotiate) + \
 	 (((icframe_vercnt) + (icmsg_vercnt)) * sizeof(struct ic_version)))
 
 struct icmsg_negotiate {
 	u16 icframe_vercnt;
 	u16 icmsg_vercnt;
 	u32 reserved;
-	struct ic_version icversion_data[1]; /* any size array */
+	struct ic_version icversion_data[]; /* any size array */
 } __packed;
 
 struct shutdown_msg_data {
-- 
2.27.0

