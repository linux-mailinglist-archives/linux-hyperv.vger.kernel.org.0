Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0A31FD29C
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jun 2020 18:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgFQQsF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Jun 2020 12:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgFQQsC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Jun 2020 12:48:02 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C6EC06174E;
        Wed, 17 Jun 2020 09:48:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x6so3049567wrm.13;
        Wed, 17 Jun 2020 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KgaamQcsTSd9AMXog0Hi7EO7KOr3psID2I79QRDOuPQ=;
        b=baZKsS2PSQFJV4FGXbBDHaDDNGu50Q0QQj8+IWh1E0Wk3M37gdiUZ1KQ0Gz9vNQFCy
         gjFGqdPgcyytw3YSKzxtsntZuKvSLDLaTwtxcGyx++7wuyIQmFHzYgMczfwhjpDJWxOk
         yYqlzDhuBhg71YuNc37f6+LRYJbVnAQxeHe2fKlT06IKvE9UnTBAmoZ5YyQYgf+qbjKn
         9Mb8Ilyob2jkz/mHGNMqkv1+6CU3QA/2dxp5pRhLcfE7N64r9h6bwz0N9bTP6cK5UZrb
         zC47QMsh5cDX66rQfWW7XYe6BbA7CSiqVmYuB6YQoUGXK7KNmBYKCcRC6Zfa99tHmJeu
         5UvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KgaamQcsTSd9AMXog0Hi7EO7KOr3psID2I79QRDOuPQ=;
        b=R7aobpB+WEf66okJ37ZmBaTrk/Mv0y35JC2jws7SYDM/GqE/JTyMYelxfI/Zx8oFtz
         0G0oNzaR2/MPi6PnTSk7/l0iezx96SVKB0B/SjKOeVB9wNnu7Q3HQDVHHX4niHKKv3LN
         liUDw/W4v6wRv6NQfS/GZOpNeYCoQxm9t4sEDPgOQtWXeAPVMmLZYJZTpIo1rwpqpsod
         naDVFJG5480OmCjSH5Fs18qtDtvaRSz82IzVRGG2ueYGNATOxEtrvvxTYjgaMjy0RsM3
         +eJWP16takoJLvY2pNUr0lMlf/h2gfbrQbGzsmUIBgAP2CRq/pz6Osqd2BiloDXI3/LN
         VAng==
X-Gm-Message-State: AOAM532fKpgn+x2arEfN+ISvyQzPAg/3f3LVpY2RSpLXwetvAKgmFsAR
        UNJQRBMFumnizHGLCEUvUCjHV3X0WWptYg==
X-Google-Smtp-Source: ABdhPJxZQ8jYu5lHQEW10dBKw+VOWFH1nQ4BWKptVGtBEWTKr8fZ39vMFEwMn+iGriCJXW89Ng5kcw==
X-Received: by 2002:a5d:500d:: with SMTP id e13mr189466wrt.150.1592412479190;
        Wed, 17 Jun 2020 09:47:59 -0700 (PDT)
Received: from localhost.localdomain (ip-213-220-210-175.net.upcbroadband.cz. [213.220.210.175])
        by smtp.gmail.com with ESMTPSA id g3sm199165wrb.46.2020.06.17.09.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:47:58 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 5/8] Drivers: hv: vmbus: Use channel_mutex in channel_vp_mapping_show()
Date:   Wed, 17 Jun 2020 18:46:39 +0200
Message-Id: <20200617164642.37393-6-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617164642.37393-1-parri.andrea@gmail.com>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The primitive currently uses channel->lock to protect the loop over
sc_list w.r.t. list additions/deletions but it doesn't protect the
target_cpu(s) loads w.r.t. a concurrent target_cpu_store(): while the
data races on target_cpu are hardly of any concern here, replace the
channel->lock critical section with a channel_mutex critical section
and extend the latter to include the loads of target_cpu; this same
pattern is also used in hv_synic_cleanup().

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/vmbus_drv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index b5ae45eb8aef7..9e39692dc13ee 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -507,18 +507,17 @@ static ssize_t channel_vp_mapping_show(struct device *dev,
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct vmbus_channel *channel = hv_dev->channel, *cur_sc;
-	unsigned long flags;
 	int buf_size = PAGE_SIZE, n_written, tot_written;
 	struct list_head *cur;
 
 	if (!channel)
 		return -ENODEV;
 
+	mutex_lock(&vmbus_connection.channel_mutex);
+
 	tot_written = snprintf(buf, buf_size, "%u:%u\n",
 		channel->offermsg.child_relid, channel->target_cpu);
 
-	spin_lock_irqsave(&channel->lock, flags);
-
 	list_for_each(cur, &channel->sc_list) {
 		if (tot_written >= buf_size - 1)
 			break;
@@ -532,7 +531,7 @@ static ssize_t channel_vp_mapping_show(struct device *dev,
 		tot_written += n_written;
 	}
 
-	spin_unlock_irqrestore(&channel->lock, flags);
+	mutex_unlock(&vmbus_connection.channel_mutex);
 
 	return tot_written;
 }
-- 
2.25.1

