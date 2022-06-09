Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C0F5452C4
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jun 2022 19:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbiFIRQn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Jun 2022 13:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiFIRQl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Jun 2022 13:16:41 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A12191CEAF0;
        Thu,  9 Jun 2022 10:16:40 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4847F20BE68D;
        Thu,  9 Jun 2022 10:16:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4847F20BE68D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1654795000;
        bh=rdXIF+/5BrdwY7RSyPMsiv15cC+P7VG0Gwq7r32ptHs=;
        h=From:To:Subject:Date:From;
        b=f9ptvfusVj2osgluyfV5Hv3sHRKxBtf+BubLtvOxHaYXPMKMc63X1nqXKSypFiOzB
         5sRDx6mMB91Li3RP/sCGNaIPh2og7Q6XO9R+Pa70vbaGH99z9Cy7t6gYN6whVfVvcf
         rBGt51XwgnjBK49Dd1RR5JU9wAa0cBt4TF/crhKw=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        ssengar@microsoft.com, mikelley@microsoft.com
Subject: [PATCH] Drivers: hv: vmbus: Release cpu lock in error case
Date:   Thu,  9 Jun 2022 10:16:36 -0700
Message-Id: <1654794996-13244-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In case of invalid sub channel, release cpu lock before returning.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/hv/channel_mgmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 280b529..5b12040 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -639,6 +639,7 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 		 */
 		if (newchannel->offermsg.offer.sub_channel_index == 0) {
 			mutex_unlock(&vmbus_connection.channel_mutex);
+			cpus_read_unlock();
 			/*
 			 * Don't call free_channel(), because newchannel->kobj
 			 * is not initialized yet.
-- 
1.8.3.1

