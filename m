Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC50D2FBF74
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Jan 2021 19:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389563AbhASSuF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 Jan 2021 13:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404313AbhASSAx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Jan 2021 13:00:53 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5930C061575;
        Tue, 19 Jan 2021 09:59:14 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id y17so20626310wrr.10;
        Tue, 19 Jan 2021 09:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dFi2rVGiQBTL0fLCTcQY4qoQ/NKDwyj06e8dI5Z12dA=;
        b=ra1QzksXmy8R4hIwmto+HZwSmIGzCOuiv8wFiuT6DW31XlBqEptFOSRPGtK8y3cPDs
         TC8UX7XpZSOs8TdQoaWr24NoFezQXOb/EhP06AZKZ/6vX4T4F2gAPRRoKqJOAU0+TVLI
         Cg9ptQG/zZj7BK7FkfdC/xPEzbA2CAmZc+hBhnkiyg2TUgam9ZNYxQEUf+3S9ZdOMVcY
         HdERndabPLt4mFtlxdBzv+cqGGkYG1ec2yU/mYr5Pv/ydEnVjqMrEENe0HeWPxN5Rqvc
         Sk6cSDVoVm7ZEiSlnnjMN+EEE2jkBlc3Jo5s/HPlttrCGRr4GO9xqIL1ZRO3YDA/lKum
         4Xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dFi2rVGiQBTL0fLCTcQY4qoQ/NKDwyj06e8dI5Z12dA=;
        b=cAbV+0elz3sh9BDwHRcSPE4NZ6cuhSHX+sINM44523LR46Jiq+4M7/yzpZyrbxwSrV
         9HQGPb/7K0GdC5UyhafDYsSCRGKv/dlNSD8K8Ev2iNSJY3s4uxBW5H2H6KFV/LIY8KGy
         pA++2XyBE5iRHfOpH5l5dZ2plYvHPkuPHkTQ2wJqqvH9Q5/0EPCFh/xNfxuhFZKeS159
         VB8x2XdYLb8DEvGDJCyX0v3B5egP2SyGWwgXDMdoykUvAWTOtdhhnYNGOPaVMhmAz3FD
         Rc6zk402W1i9mZ/IJmzAyrzyhm6qJ6pOe84+X+o2U8WXvNHtOE9iTBiqqzxjluXMg1ue
         On1A==
X-Gm-Message-State: AOAM532x68CgGf2XzkkmBWX4eg08iqxnbXh5Cth0bhctg2aeETLHaF0n
        DVT2ws/iTJsvfoVpw0uuiaNmmE3DD0LiEOlJ
X-Google-Smtp-Source: ABdhPJwI670Pb4kbkp1I4y7OJ+bp3Vp47HfSsOCwfH1DH7zktHuYgj6VTPgi3bxDtjPmViCdHpTTUg==
X-Received: by 2002:adf:8145:: with SMTP id 63mr5346212wrm.8.1611079153066;
        Tue, 19 Jan 2021 09:59:13 -0800 (PST)
Received: from anparri.mshome.net (host-79-50-177-118.retail.telecomitalia.it. [79.50.177.118])
        by smtp.gmail.com with ESMTPSA id h125sm5899312wmh.16.2021.01.19.09.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 09:59:12 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 2/4] Drivers: hv: vmbus: Restrict vmbus_devices on isolated guests
Date:   Tue, 19 Jan 2021 18:58:39 +0100
Message-Id: <20210119175841.22248-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119175841.22248-1-parri.andrea@gmail.com>
References: <20210119175841.22248-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Only the VSCs or ICs that have been hardened and that are critical for
the successful adoption of Confidential VMs should be allowed if the
guest is running isolated.  This change reduces the footprint of the
code that will be exercised by Confidential VMs and hence the exposure
to bugs and vulnerabilities.

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel_mgmt.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/hyperv.h    |  1 +
 2 files changed, 37 insertions(+)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 68950a1e4b638..774ee19e3e90d 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -31,101 +31,118 @@ const struct vmbus_device vmbus_devs[] = {
 	{ .dev_type = HV_IDE,
 	  HV_IDE_GUID,
 	  .perf_device = true,
+	  .allowed_in_isolated = false,
 	},
 
 	/* SCSI */
 	{ .dev_type = HV_SCSI,
 	  HV_SCSI_GUID,
 	  .perf_device = true,
+	  .allowed_in_isolated = true,
 	},
 
 	/* Fibre Channel */
 	{ .dev_type = HV_FC,
 	  HV_SYNTHFC_GUID,
 	  .perf_device = true,
+	  .allowed_in_isolated = false,
 	},
 
 	/* Synthetic NIC */
 	{ .dev_type = HV_NIC,
 	  HV_NIC_GUID,
 	  .perf_device = true,
+	  .allowed_in_isolated = true,
 	},
 
 	/* Network Direct */
 	{ .dev_type = HV_ND,
 	  HV_ND_GUID,
 	  .perf_device = true,
+	  .allowed_in_isolated = false,
 	},
 
 	/* PCIE */
 	{ .dev_type = HV_PCIE,
 	  HV_PCIE_GUID,
 	  .perf_device = false,
+	  .allowed_in_isolated = false,
 	},
 
 	/* Synthetic Frame Buffer */
 	{ .dev_type = HV_FB,
 	  HV_SYNTHVID_GUID,
 	  .perf_device = false,
+	  .allowed_in_isolated = false,
 	},
 
 	/* Synthetic Keyboard */
 	{ .dev_type = HV_KBD,
 	  HV_KBD_GUID,
 	  .perf_device = false,
+	  .allowed_in_isolated = false,
 	},
 
 	/* Synthetic MOUSE */
 	{ .dev_type = HV_MOUSE,
 	  HV_MOUSE_GUID,
 	  .perf_device = false,
+	  .allowed_in_isolated = false,
 	},
 
 	/* KVP */
 	{ .dev_type = HV_KVP,
 	  HV_KVP_GUID,
 	  .perf_device = false,
+	  .allowed_in_isolated = false,
 	},
 
 	/* Time Synch */
 	{ .dev_type = HV_TS,
 	  HV_TS_GUID,
 	  .perf_device = false,
+	  .allowed_in_isolated = true,
 	},
 
 	/* Heartbeat */
 	{ .dev_type = HV_HB,
 	  HV_HEART_BEAT_GUID,
 	  .perf_device = false,
+	  .allowed_in_isolated = true,
 	},
 
 	/* Shutdown */
 	{ .dev_type = HV_SHUTDOWN,
 	  HV_SHUTDOWN_GUID,
 	  .perf_device = false,
+	  .allowed_in_isolated = true,
 	},
 
 	/* File copy */
 	{ .dev_type = HV_FCOPY,
 	  HV_FCOPY_GUID,
 	  .perf_device = false,
+	  .allowed_in_isolated = false,
 	},
 
 	/* Backup */
 	{ .dev_type = HV_BACKUP,
 	  HV_VSS_GUID,
 	  .perf_device = false,
+	  .allowed_in_isolated = false,
 	},
 
 	/* Dynamic Memory */
 	{ .dev_type = HV_DM,
 	  HV_DM_GUID,
 	  .perf_device = false,
+	  .allowed_in_isolated = false,
 	},
 
 	/* Unknown GUID */
 	{ .dev_type = HV_UNKNOWN,
 	  .perf_device = false,
+	  .allowed_in_isolated = false,
 	},
 };
 
@@ -903,6 +920,20 @@ find_primary_channel_by_offer(const struct vmbus_channel_offer_channel *offer)
 	return channel;
 }
 
+static bool vmbus_is_valid_device(const guid_t *guid)
+{
+	u16 i;
+
+	if (!hv_is_isolation_supported())
+		return true;
+
+	for (i = 0; i < ARRAY_SIZE(vmbus_devs); i++) {
+		if (guid_equal(guid, &vmbus_devs[i].guid))
+			return vmbus_devs[i].allowed_in_isolated;
+	}
+	return false;
+}
+
 /*
  * vmbus_onoffer - Handler for channel offers from vmbus in parent partition.
  *
@@ -917,6 +948,11 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 
 	trace_vmbus_onoffer(offer);
 
+	if (!vmbus_is_valid_device(&offer->offer.if_type)) {
+		atomic_dec(&vmbus_connection.offer_in_progress);
+		return;
+	}
+
 	oldchannel = find_primary_channel_by_offer(offer);
 
 	if (oldchannel != NULL) {
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index f0d48a368f131..e3426f8c12db9 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -789,6 +789,7 @@ struct vmbus_device {
 	u16  dev_type;
 	guid_t guid;
 	bool perf_device;
+	bool allowed_in_isolated;
 };
 
 #define VMBUS_DEFAULT_MAX_PKT_SIZE 4096
-- 
2.25.1

