Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F67F3D1953
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jul 2021 23:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhGUVAd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Jul 2021 17:00:33 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42980 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhGUVAd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Jul 2021 17:00:33 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1632120B7178;
        Wed, 21 Jul 2021 14:41:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1632120B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1626903669;
        bh=rxHKdsUNLKbDsn84G6KYcfQP7IsFg+NK27RAAOVlDdI=;
        h=From:To:Subject:Date:From;
        b=rsLRk49v2xQ6YXT5xk79qL+c4WPqyYFbG1hsdBBBYE69cOViS1Bc4ToYNUUnln1GT
         aLrxhCKHtzZ1Tm8SwQMGDAGPbxZsfEqZaCQKjjbNeJCfa73ZevYksOp26uVPH38qtW
         Op76G6ASCXirxhSJsJPXe+DpKOoTM1O0XGm/TYps=
From:   Sonia Sharma <sosha@linux.microsoft.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sonia Sharma <sosha@microsoft.com>
Subject: [PATCH] hv: Remove unused inline functions in hyperv.h
Date:   Wed, 21 Jul 2021 14:41:03 -0700
Message-Id: <1626903663-23615-1-git-send-email-sosha@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sonia Sharma <sonia.sharma@microsoft.com>

There are some unused inline functions in hyperv header file.
Remove those unused functions.

Signed-off-by: Sonia Sharma <sonia.sharma@microsoft.com>
---
 include/linux/hyperv.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 2e859d2..ddc8713 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -538,12 +538,6 @@ struct vmbus_channel_rescind_offer {
 	u32 child_relid;
 } __packed;
 
-static inline u32
-hv_ringbuffer_pending_size(const struct hv_ring_buffer_info *rbi)
-{
-	return rbi->ring_buffer->pending_send_sz;
-}
-
 /*
  * Request Offer -- no parameters, SynIC message contains the partition ID
  * Set Snoop -- no parameters, SynIC message contains the partition ID
@@ -1092,16 +1086,6 @@ static inline void set_channel_pending_send_size(struct vmbus_channel *c,
 	c->outbound.ring_buffer->pending_send_sz = size;
 }
 
-static inline void set_low_latency_mode(struct vmbus_channel *c)
-{
-	c->low_latency = true;
-}
-
-static inline void clear_low_latency_mode(struct vmbus_channel *c)
-{
-	c->low_latency = false;
-}
-
 void vmbus_onmessage(struct vmbus_channel_message_header *hdr);
 
 int vmbus_request_offers(void);
-- 
1.8.3.1

