Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F4E32EF93
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Mar 2021 17:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhCEQFR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Mar 2021 11:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhCEQE4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Mar 2021 11:04:56 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932D3C061574;
        Fri,  5 Mar 2021 08:04:56 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d11so1620044plo.8;
        Fri, 05 Mar 2021 08:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfbPe4y+qNmwKCNWUTETLQgs2AuA8wWHnELtmAz6Iik=;
        b=XjkIf5o0O4/Et530A8g4c40PbVvQkzP66iZwp1qWa2/la2LnbP7IKCd+vpFdWYQJ/A
         1WDOokzpgjhoWW6mBsB4pMAXEgkQsCEDM02TfPf0pozZ3VPMuKqb/LQVT4VxP6tUffrd
         3xbqfLxqaIDzzzIzayRoSSgmF91KdBoYrIerl6uTpTWS1g/ohNbj/jTlDyEIOrS1W/Tn
         HD/R7HNCAgsnrir36omgnLwzqfLvyb5If0qM4/FgDmypYIHLf6+7bkjR1CHf0/Q4O6FX
         GL7/VdV7xMMuEV5j/n6Yon2AyUZNBaLZGh6fx9ch1kLVIR8s7VM0olGb/a12IpuQhP3C
         N+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfbPe4y+qNmwKCNWUTETLQgs2AuA8wWHnELtmAz6Iik=;
        b=Ox+Z2mzyqukv2EvWDSsEGGC2d0H73GV6OCAEONI/Sn5eriTZREMmCPs7bLeHlgUmps
         DtWy50+A8D9vdpTxL98juPkzWOP0PwL8HIQGSDuAz7GNMoBRycmP2GBtPe5wzchWKuYI
         0JDWtJm00lmpmERXV33HGf9x+NRpTj94MSDd7zw+dZ5FX0F9UTFOIfBjIZyrU6JB3FxR
         n5zfvXLOLFhS+pHTKArFHdRnhV+1QE1EiyJSZOvug6ExbkmMRvWaAh16krS0/J7aMku6
         nBK9VGpJ9cWeV0YhcHBSOaKwcs7Z30xmzj9SH/kQftSsmYA8v3ZpD2zFES4X59EYPyW5
         wP3g==
X-Gm-Message-State: AOAM531wFRFSJ8QQ8sBQDFRU30pIf8kG3n0lZJ9UOt7TXJcUwd8VbRfT
        rzQVKMvuIWRPlVJyIJCuBSQ=
X-Google-Smtp-Source: ABdhPJw2jc5tqPM1zZn2kuF2lm2ZMeknjhO0myS9xP3sC9MmZsQFRDo9hEfl/iCEY8Nc9z5jTPuXag==
X-Received: by 2002:a17:90a:400f:: with SMTP id u15mr10792417pjc.80.1614960295976;
        Fri, 05 Mar 2021 08:04:55 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e01e:c062:e46d:8579:f29a:adcf])
        by smtp.gmail.com with ESMTPSA id j125sm3290231pfd.27.2021.03.05.08.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 08:04:55 -0800 (PST)
From:   Vasanth <vasanth3g@gmail.com>
To:     kys@microsoft.com
Cc:     haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasanth <vasanth3g@gmail.com>
Subject: [PATCH] drivers: hv: Fix no spaces issue
Date:   Fri,  5 Mar 2021 21:34:49 +0530
Message-Id: <20210305160449.22822-1-vasanth3g@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fixed code spaces issue.

Signed-off-by: Vasanth M <vasanth3g@gmail.com>
---
 drivers/hv/channel_mgmt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 1d44bb635bb8..84d6b3dde76f 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -302,7 +302,6 @@ bool vmbus_prep_negotiate_resp(struct icmsg_hdr *icmsghdrp,
 	negop->icversion_data[1].minor = icmsg_minor;
 	return found_match;
 }
-
 EXPORT_SYMBOL_GPL(vmbus_prep_negotiate_resp);
 
 /*
@@ -562,10 +561,10 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 	 * CPUS_READ_UNLOCK		CPUS_WRITE_UNLOCK
 	 *
 	 * Forbids: CPU1's LOAD from *not* seing CPU2's STORE &&
-	 * 		CPU2's SEARCH from *not* seeing CPU1's INSERT
+	 *              CPU2's SEARCH from *not* seeing CPU1's INSERT
 	 *
 	 * Forbids: CPU2's SEARCH from seeing CPU1's INSERT &&
-	 * 		CPU2's LOAD from *not* seing CPU1's STORE
+	 *              CPU2's LOAD from *not* seing CPU1's STORE
 	 */
 	cpus_read_lock();
 
@@ -928,7 +927,7 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 		 *					UNLOCK channel_mutex
 		 *
 		 * Forbids: r1 == valid_relid &&
-		 * 		channels[valid_relid] == channel
+		 *              channels[valid_relid] == channel
 		 *
 		 * Note.  r1 can be INVALID_RELID only for an hv_sock channel.
 		 * None of the hv_sock channels which were present before the
-- 
2.25.1

