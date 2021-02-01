Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD2A30AB71
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Feb 2021 16:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBAPcy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Feb 2021 10:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhBAOtU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Feb 2021 09:49:20 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32E2C061756;
        Mon,  1 Feb 2021 06:48:39 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 7so16888572wrz.0;
        Mon, 01 Feb 2021 06:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MrdDGacMKCIZdKDtffCda/hf+tqcsilM2SrNSDQZFkA=;
        b=g3m/Uefknf+Tw9gJ4gW613Mego03vwWNfleAkBtZ/JRAQE04UXjx6eV4uu8mvOLHk0
         01AGsTOq64gm/WCT97OfggTH9oEprKCTXQZRh7BUMWOCbbGEHQZ5WgRUMHEU8uqFuI6D
         CuJxkKELMHSuXtNwkEj/8kU0M+T8oYEDx43qQ4QaGenzVC63fO9N3g6u7JipJDaGbFv8
         f1xlxctcv0uTwc9/s7MVGzwMNe6epLQA+N8fWTmHQwjhWlXFgAIaIcW1iobIE7rx/JQt
         65KRmKoiRbA0gdCIqZlrLTs8EBFcYadNHuRqNd06Kzi8NFvxlAtdcKUQumJHuYZixwaw
         EOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MrdDGacMKCIZdKDtffCda/hf+tqcsilM2SrNSDQZFkA=;
        b=DStrRp/sk4G2sPs2RemnARcoijRJrIvYLNnu0ra5wd8KiTvFcSScjWnlupVRzdkZQa
         pu35Ts33LnKt4f2IZ09wzShSw08rFXEetHwXE/bvvNvkR0NiUhRHVO8oU/Q2jMusZaUf
         ajsbzGfh/coAMhGwKV7rGp7PH5J4VAQ/fAmSHAll9KuXUFOhKYOmDdoqvQybvgLSnmEa
         t0AkMHKgFz0JL0aBIwQV3eq5+3sdJzo8gxieZHGsnpoi425hVRlQF2SLfFVJemTMvjNw
         AHonC3uLwz4kSotmirIgROZQf/D+jSnOV1vM4IQcNRO0Nj7JYCa5jUbCPjytQEOJgk8C
         Xh5g==
X-Gm-Message-State: AOAM531RQdhsy4UFn+a0pev9as9EQi9KSiXC2rbSchTU2GfgnOWL6Tr+
        BsbqTNS/TQ53LlhsF5+KdUEBKEdwznKc6Ost
X-Google-Smtp-Source: ABdhPJwOIXdjBD1hdOAkce2smiXzdtoMBZvzcHr3omy/uyXc29Zrdjd6oitBbX4kJcfezMRQVhFxiw==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr18111168wrp.422.1612190918001;
        Mon, 01 Feb 2021 06:48:38 -0800 (PST)
Received: from anparri.mshome.net (host-95-238-70-33.retail.telecomitalia.it. [95.238.70.33])
        by smtp.gmail.com with ESMTPSA id c11sm26106591wrs.28.2021.02.01.06.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:48:37 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v3 hyperv-next 2/4] Drivers: hv: vmbus: Restrict vmbus_devices on isolated guests
Date:   Mon,  1 Feb 2021 15:48:12 +0100
Message-Id: <20210201144814.2701-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201144814.2701-1-parri.andrea@gmail.com>
References: <20210201144814.2701-1-parri.andrea@gmail.com>
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
 drivers/hv/channel_mgmt.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/hyperv.h    |  1 +
 2 files changed, 39 insertions(+)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 68950a1e4b638..f0ed730e2e4e4 100644
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
@@ -917,6 +948,13 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 
 	trace_vmbus_onoffer(offer);
 
+	if (!vmbus_is_valid_device(&offer->offer.if_type)) {
+		pr_err_ratelimited("Invalid offer %d from the host supporting isolation\n",
+				   offer->child_relid);
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

