Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A8E2CB8B8
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 10:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbgLBJXi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 04:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388180AbgLBJXe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 04:23:34 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCE1C0613CF;
        Wed,  2 Dec 2020 01:22:48 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h21so5813826wmb.2;
        Wed, 02 Dec 2020 01:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sy381wm44Taj7NbPSG7JcujeYoy3WsPyZ0mkLGSOBXY=;
        b=nldGpVXkmPnJXqgQOox5WtCy9X5FZ3a786yRS1bN3hDVziW4evh6eXGlxbKYVRJJC3
         f79Sv24H5qBZXDKwDnmEDHh2Oi9TyV4+3yPpGnz3LS1pbyMbvJVHxIY7sThr8eCoJjhn
         NmoT/qFz8yEJ6UXdTjPBB3JBessscnKGlKmwnqqjhnOqEephWeNRRmzqnupiSBjnVMzl
         QdWEHHDr3gmh87iXIgqQ5pjh259m/XH38lIb3zOUQk/2vgC2ljjt4wDBS7rLTuPFzLst
         qh98x4buDsVP7mmm5pcmhwoCetABUhhp8fQ5SQ+TFCv0Q8Q9QiDj2wsz9piUHAgob40B
         ynRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sy381wm44Taj7NbPSG7JcujeYoy3WsPyZ0mkLGSOBXY=;
        b=n1C2k+4m0MhWkiZwEnVFwE7CQU4tr8ptSY6nVW78J+5lkCM6NN/PZ6LCD3h7YqGqDc
         t2T3kX9qcwujOUykly9YuAloO842Su1SbX4GsJStAiURjLUOvvLmmmbSUBo8zLnZHMQm
         LZolg95k7Rg+AUNCVwK4mDWHUPqm9VtAplUMJ8GFdOLlnspnhy4o9CALEYAofdVEi7mT
         eDZCUo+goInuPyhD/c19dh+n9R37QZNeNnSDc9LE4Okf2GsoxQU5j0LCBN6C1lOJAmjX
         DDaMlHohLa/q9o4MiFXyi98FALSyBnGNL2JjBJplKSban5kly/cg/YN33v8S+m7nVEVr
         zYpA==
X-Gm-Message-State: AOAM5329e5qSEH5lgiPC7ehTu86KS9VwxkaUFeZcDUuBEtMgGLFF6qmB
        gJhgeJPG25T/ibYx7T0nihgj5UgqAc1sAQ==
X-Google-Smtp-Source: ABdhPJy2eeuczYdL6eYM2NmWJ6YpMLtamWmQMi1JG5UR3M4XxwJEP9kqC+irrecWnTpd21oLkziDww==
X-Received: by 2002:a1c:2b03:: with SMTP id r3mr2097953wmr.184.1606900966987;
        Wed, 02 Dec 2020 01:22:46 -0800 (PST)
Received: from andrea.corp.microsoft.com (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id e27sm1535936wrc.9.2020.12.02.01.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:22:46 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 5/7] Drivers: hv: vmbus: Avoid use-after-free in vmbus_onoffer_rescind()
Date:   Wed,  2 Dec 2020 10:22:12 +0100
Message-Id: <20201202092214.13520-6-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202092214.13520-1-parri.andrea@gmail.com>
References: <20201202092214.13520-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When channel->device_obj is non-NULL, vmbus_onoffer_rescind() could
invoke put_device(), that will eventually release the device and free
the channel object (cf. vmbus_device_release()).  However, a pointer
to the object is dereferenced again later to load the primary_channel.
The use-after-free can be avoided by noticing that this load/check is
redundant if device_obj is non-NULL: primary_channel must be NULL if
device_obj is non-NULL, cf. vmbus_add_channel_work().

Fixes: 54a66265d6754b ("Drivers: hv: vmbus: Fix rescind handling")
Reported-by: Juan Vazquez <juvazq@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
Changes since v1:
  - Fix typo in commit message
  - Add Fixes: tag

 drivers/hv/channel_mgmt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 5bc5eef5da159..4072fd1f22146 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1116,8 +1116,7 @@ static void vmbus_onoffer_rescind(struct vmbus_channel_message_header *hdr)
 			vmbus_device_unregister(channel->device_obj);
 			put_device(dev);
 		}
-	}
-	if (channel->primary_channel != NULL) {
+	} else if (channel->primary_channel != NULL) {
 		/*
 		 * Sub-channel is being rescinded. Following is the channel
 		 * close sequence when initiated from the driveri (refer to
-- 
2.25.1

