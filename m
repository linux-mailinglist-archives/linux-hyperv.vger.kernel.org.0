Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F036D5533
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Apr 2023 01:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjDCXXL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Apr 2023 19:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjDCXXJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Apr 2023 19:23:09 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB6FA10C;
        Mon,  3 Apr 2023 16:23:08 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3C148210CBF2;
        Mon,  3 Apr 2023 16:23:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C148210CBF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680564188;
        bh=y3i3ILhMmxV1ebXDwdyEOEKLgDclYCNwTf+8O1DdSIY=;
        h=From:To:Cc:Subject:Date:From;
        b=JZ59pRikh4gCot8Snc/748VAOZv2Rto3GGHicLk4hnI+99Km6WH75zI2DsTvgj+am
         IAbKMcgpIERqL8K45BbrcHwxJEya++Ol1B7eW2WaNIC3KeRUodmXwhnMnfY7zmJjhf
         l17luQKroD6tGj4Phh6ruCOa1jaer2dQTBbWsYaI=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, decui@microsoft.com
Subject: [PATCH] Drivers: hv: Use nested hypercall for post message and signal event
Date:   Mon,  3 Apr 2023 16:22:58 -0700
Message-Id: <1680564178-31023-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When running nested, these hypercalls must be sent to the L0 hypervisor
or vmbus will fail.
Only relevant for x86; nested functionality is not available in ARM64.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/connection.c | 4 ++++
 drivers/hv/hv.c         | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 9dc27e5d367a..04bf7f168976 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -539,6 +539,10 @@ void vmbus_set_event(struct vmbus_channel *channel)
 	if (hv_isolation_type_snp())
 		hv_ghcb_hypercall(HVCALL_SIGNAL_EVENT, &channel->sig_event,
 				NULL, sizeof(channel->sig_event));
+#if defined(CONFIG_X86_64)
+	else if (hv_nested)
+		hv_do_fast_nested_hypercall8(HVCALL_SIGNAL_EVENT, channel->sig_event);
+#endif
 	else
 		hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, channel->sig_event);
 }
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 8b0dd8e5244d..c7f7652932ca 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -102,6 +102,11 @@ int hv_post_message(union hv_connection_id connection_id,
 		status = hv_ghcb_hypercall(HVCALL_POST_MESSAGE,
 				(void *)aligned_msg, NULL,
 				sizeof(*aligned_msg));
+#if defined(CONFIG_X86_64)
+	else if (hv_nested)
+		status = hv_do_nested_hypercall(HVCALL_POST_MESSAGE,
+				aligned_msg, NULL);
+#endif
 	else
 		status = hv_do_hypercall(HVCALL_POST_MESSAGE,
 				aligned_msg, NULL);
-- 
2.25.1

