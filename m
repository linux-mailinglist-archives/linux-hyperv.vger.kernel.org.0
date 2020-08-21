Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B4424D898
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 17:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgHUP3n (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Aug 2020 11:29:43 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47226 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgHUP3D (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Aug 2020 11:29:03 -0400
Received: from testvm-timer.0wqf5yk0ngwuzjntifuk1ppqse.cx.internal.cloudapp.net (unknown [40.65.222.102])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7AE1320B4908;
        Fri, 21 Aug 2020 08:29:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7AE1320B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598023743;
        bh=1Xx3fDRP6HUhJQ0/HwzwV1+TX9mHcQq7j3/A5j4Vz/s=;
        h=From:To:Cc:Subject:Date:From;
        b=BOLOIn2bYM+SGapuZTTujMnaSM6QFuksi5YdgkIXG/JxKQ7d4OKh2ap5o8+iMMUqd
         E5FvTQb4DW+TvE6MTI9Q/Gai+6/UDnKDEpXxrRZaE+Z2PCkj0agWIzPqDdnGExjZW2
         M+4Emlcn9JP16t4F41OOo+vIq2TwLr4Efg/Lvz2Y=
From:   Vineeth Pillai <viremana@linux.microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hv_utils: drain the timesync packets on onchannelcallback
Date:   Fri, 21 Aug 2020 15:28:49 +0000
Message-Id: <20200821152849.99517-1-viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There could be instances where a system stall prevents the timesync
packaets to be consumed. And this might lead to more than one packet
pending in the ring buffer. Current code empties one packet per callback
and it might be a stale one. So drain all the packets from ring buffer
on each callback.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---

 v2:
    - s/pr_warn/pr_warn_once/
    
---
 drivers/hv/hv_util.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 1f86e8d9b018..a4e8d96513c2 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -387,10 +387,23 @@ static void timesync_onchannelcallback(void *context)
 	struct ictimesync_ref_data *refdata;
 	u8 *time_txf_buf = util_timesynch.recv_buffer;
 
-	vmbus_recvpacket(channel, time_txf_buf,
-			 HV_HYP_PAGE_SIZE, &recvlen, &requestid);
+	/*
+	 * Drain the ring buffer and use the last packet to update
+	 * host_ts
+	 */
+	while (1) {
+		int ret = vmbus_recvpacket(channel, time_txf_buf,
+					   HV_HYP_PAGE_SIZE, &recvlen,
+					   &requestid);
+		if (ret) {
+			pr_warn_once("TimeSync IC pkt recv failed (Err: %d)\n",
+				     ret);
+			break;
+		}
+
+		if (!recvlen)
+			break;
 
-	if (recvlen > 0) {
 		icmsghdrp = (struct icmsg_hdr *)&time_txf_buf[
 				sizeof(struct vmbuspipe_hdr)];
 
-- 
2.17.1

