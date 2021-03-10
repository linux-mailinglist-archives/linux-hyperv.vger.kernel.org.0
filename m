Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5557D3334D5
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Mar 2021 06:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhCJFW3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 10 Mar 2021 00:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhCJFWD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 10 Mar 2021 00:22:03 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B72C061760;
        Tue,  9 Mar 2021 21:22:03 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d23so4687359plq.2;
        Tue, 09 Mar 2021 21:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PxoqHN27T6pDjgp5WZBZkMeXIS9WasI3ajvmniwuXIc=;
        b=Fat+mGGlvb0kZXvfB0Ah5dJJZkXsuNpR0SWa0f1jfjY5YKdvqYDbsI7s2Dkf1T5UZ4
         dpBeC9gPA6fp0P94kG+zMOha5hD1UfCcKx4o9kxxcKFM+m9BbVylaZyCPJgWir0JEIvz
         y3J214o49C6qqQgJvaya2oJGpACPSoF9dLTxbXnTnBUv/n0yEBFVb0+QeGtKjJq4PM0V
         cXoSajFjoyqVy2jcHmolNRBTEdi7u6WAMYZziuYGKR8L3LdsXUmTYAu9g7/uzGIt6ASb
         OgYBClGX28+IuIsjhp8LXGXtaHyRubiSjLcz9F5ZtK2Eb6J0ycAOjjtV/ooeAK0qmSFb
         u2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PxoqHN27T6pDjgp5WZBZkMeXIS9WasI3ajvmniwuXIc=;
        b=P/eHDmbjNUlF3whJ/7mcnB1IR6pNkTZOhGYD1NzYaxbDOkaWE8tJ0HXlL2O/2k/50o
         NOXYBi4+G/ET//CIe2rQWUYMZoFB+BWKvKmLaKD7rs4SIFVxKCDfSTk+MBFoY2/V3YaX
         EVtwag/mWRaoiaGqX3hsfzVQNQrA1AqVngvtddUr3++eldVeHEm85fiJiXOR+BXxFAKT
         H1C9tmrtRfQJNnCudx/KeCyzxjaa8aJa5H35rE7pYW5/p3u+JDFOF/3fFkNC9FTPelRH
         YQU0C1o3OqYqdCsx1WlZ0E3dHwq25UK4C/HEuL4SbdqG0qtLNkxJrUvpQUICtpIQa87M
         L0Hg==
X-Gm-Message-State: AOAM532ufcq96mXOJaP9+GX9ofAFGXWJS7KyFiJW+ahW13z97Gg02gHL
        uwQjZ3gBXRKQUBS+/Eec8Sg=
X-Google-Smtp-Source: ABdhPJz4ONgz/x8KMz1gq687gJQOHvFCCp63VCgqqv8efNstksQfpZHCYtDpA3LNvmTuR3uAz7JmNA==
X-Received: by 2002:a17:902:be06:b029:e3:7031:bef with SMTP id r6-20020a170902be06b02900e370310befmr1395102pls.19.1615353723080;
        Tue, 09 Mar 2021 21:22:03 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e01e:c062:1c0c:6962:60a3:24ea])
        by smtp.gmail.com with ESMTPSA id r2sm14535590pgv.50.2021.03.09.21.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 21:22:02 -0800 (PST)
From:   Vasanth <vasanth3g@gmail.com>
To:     kys@microsoft.com
Cc:     haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasanth <vasanth3g@gmail.com>
Subject: [PATCH v2] drivers: hv: Fix EXPORT_SYMBOL and tab spaces issue
Date:   Wed, 10 Mar 2021 10:51:55 +0530
Message-Id: <20210310052155.39460-1-vasanth3g@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

1.Fixed EXPORT_SYMBOL should be follow immediately function/variable.
2.Fixed code tab spaces issue.

Signed-off-by: Vasanth M <vasanth3g@gmail.com>
---

changes in v2:
*  Added commit message
*  Revised Subject

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

