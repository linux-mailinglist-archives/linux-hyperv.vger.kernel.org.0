Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDCD303C47
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Jan 2021 12:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405287AbhAZL6m (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 Jan 2021 06:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405074AbhAZL5y (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Jan 2021 06:57:54 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E93C0613D6;
        Tue, 26 Jan 2021 03:57:14 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a9so16151606wrt.5;
        Tue, 26 Jan 2021 03:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dFi2rVGiQBTL0fLCTcQY4qoQ/NKDwyj06e8dI5Z12dA=;
        b=hmHqgzDBPaeeu574dL0mCNilGzrQpka7c0YdywTZgSudnJRnAvLe68Z0jSK96Cj8e4
         a+DIAaqTxnXyQSKWwjizfW+X/OhH0VLdNbd/5O4uai04GkfpsyFGD1v0fx3kNXt8nJCU
         XEJO3h8pttowq8Y0TaW07w4dhdpBsYMeyV7HwxBXP6LKYJhDlnjUxzorU6QZxvyLeIhs
         3MrRe4TM11dVUDe5GbhyRztOtKvhnoxAoLE3A8ORtNWj5WKl1DSTV7iI8q3WqQjNLsHE
         LMlw5G0JxBWyp6MoGZSoiGnkO7lwpUJPDfSGq2kNQHZudad7a7VDPt00qqTRgKNoBTwJ
         V4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dFi2rVGiQBTL0fLCTcQY4qoQ/NKDwyj06e8dI5Z12dA=;
        b=XUAuD2whVWZMuG8en2DDE2vp58VJ8/DdSmr3OFOaOUdceb5WbXb+mMH37VXBC87O60
         yl+aU9GJat7wc2gIwUFd2OJlhUYa9FT459lx19nKD+Doqi3F2VpU0Qcc0myAdwaWVoXF
         kGGtoV5aAF7VJnsrLo62OeMMPE7ZYsZzuC8pHpysrQx5ooD3w6871+f5ZZm3AM8RTP7R
         6yFuEpCICGylF6QPfyOHOI0na1v87f4i7wJFyP0jmr25jo6Zz0sMUP1GS2zy5omWhgKr
         BwpdYTMOh5vkH0dVYWrKrT9eAArY+6LrRy3inOvZtuIifpijZ2U2L98fnaTZKwOBrbKw
         pFhQ==
X-Gm-Message-State: AOAM532XGag7CBPZIBT13rP57DcSLX5igvNCmULjfBILxDyxpOBN+h07
        HyzCsBUcI0G9hbjegpQJisvOL/8SN2UPbQrf
X-Google-Smtp-Source: ABdhPJyfx34b8BQu2a16AF9ALGUrewPIqqQ3LQNbRiFoWaykkDe0Xq+9euuXs6AeklaXlBVb37QOZg==
X-Received: by 2002:a5d:554e:: with SMTP id g14mr5738235wrw.305.1611662232419;
        Tue, 26 Jan 2021 03:57:12 -0800 (PST)
Received: from anparri.mshome.net (host-95-238-70-33.retail.telecomitalia.it. [95.238.70.33])
        by smtp.gmail.com with ESMTPSA id z185sm3330283wmb.0.2021.01.26.03.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 03:57:12 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 2/4] Drivers: hv: vmbus: Restrict vmbus_devices on isolated guests
Date:   Tue, 26 Jan 2021 12:56:39 +0100
Message-Id: <20210126115641.2527-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126115641.2527-1-parri.andrea@gmail.com>
References: <20210126115641.2527-1-parri.andrea@gmail.com>
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

