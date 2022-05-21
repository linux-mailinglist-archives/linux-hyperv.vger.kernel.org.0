Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4F652FB19
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 May 2022 13:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354953AbiEULNA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 21 May 2022 07:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354861AbiEULMp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 21 May 2022 07:12:45 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3593C2A270;
        Sat, 21 May 2022 04:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BK6Vmpz92Mp58PwfqNFHqCi3DvEwbmPq0uYuOzk9oGM=;
  b=uStK9+XO5xRUrB/kd4X2HVrkc+z62LfcJBSG/Qg3CgVjjINSbRDatP3Z
   28MNcHc3FuuwGlah1rdx0WuhHX7RjnncASO7W4rlr+LVgTH+1YR8UvumI
   Yc4xqm6lwC0kk5jGUr9xKq+Iz74kxPakh2r5LNX4GpNPThOSb4rl9uVjb
   A=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727965"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:02 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     "K. Y. Srinivasan" <kys@microsoft.com>
Cc:     kernel-janitors@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Drivers: hv: vmbus: fix typo in comment
Date:   Sat, 21 May 2022 13:11:10 +0200
Message-Id: <20220521111145.81697-60-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/hv/channel_mgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 97d8f5646778..b60f13481bdc 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -443,7 +443,7 @@ void hv_process_channel_removal(struct vmbus_channel *channel)
 	/*
 	 * Upon suspend, an in-use hv_sock channel is removed from the array of
 	 * channels and the relid is invalidated.  After hibernation, when the
-	 * user-space appplication destroys the channel, it's unnecessary and
+	 * user-space application destroys the channel, it's unnecessary and
 	 * unsafe to remove the channel from the array of channels.  See also
 	 * the inline comments before the call of vmbus_release_relid() below.
 	 */

