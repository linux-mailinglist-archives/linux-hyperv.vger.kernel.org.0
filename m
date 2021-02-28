Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7343272CB
	for <lists+linux-hyperv@lfdr.de>; Sun, 28 Feb 2021 16:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhB1PG2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 28 Feb 2021 10:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhB1PFj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 28 Feb 2021 10:05:39 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25B5C0617AA;
        Sun, 28 Feb 2021 07:04:21 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id o188so3025539pfg.2;
        Sun, 28 Feb 2021 07:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yOO4CxJRTj0ILG6kUCTIHN05nkW/mARc3jk1rfoAu18=;
        b=K2lcx9nM7T2VHEIAbyzeDQJpMtgyBf3IYLAYs03/EGTZOuFiONpMdarScgMXi6TJF8
         IM4/gElwbzjKBqoGmNjjMSNt01/C8TQzf8LghIzkBmpSDXsxqon4koI8TIET9GppicR4
         y760uZvE4+8/N7iFxm75lwFs0XNXd3GE+/a3T8wylj+gJtdrDTiM0+TuJHTcbvvgpL23
         sAI5q3FH508nLAWjUs+QlwPVIgAEeaB9pGKkYRupWzf+XILldMseMTs3GpPv4oTuIYaX
         rcmH1zhZiu0ijoaoOuAagOtXRCcWEZ8WuElHgya6YTFZLW/C3BEV/VMXptKmxmDh+Pw9
         qENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOO4CxJRTj0ILG6kUCTIHN05nkW/mARc3jk1rfoAu18=;
        b=tlFaFU5kqKNSklLN/oFBHiOZB/0SfelgiJEQ9lySOzyPAXxfXxu4ZddZQhRYN06OGV
         0XTgZFiCIB2wDUVRL5m1NwL1Cdneud7cNxEuhvR36lpVp4KS+gu+DTmrV30k7T6aMBWZ
         DcPSlR3ucbra+LZ/j3AJLeanBqy/n2Du+LCtHt4q6mhMr0JN3yC2kx9brYuL0pj4MnMz
         FqKd89qGzvAHEPP9jZfytYpxBfczwlfr7mjVdo6oCN0ZM/RN1E69x61kile8fx1M6rna
         LE/ysRISXj9xQrPtS6kzlwvT0VzcDSatHKaSgZCa+/zVv5hcqR0qY3FGNnz3Y8FKH4J7
         h0Mw==
X-Gm-Message-State: AOAM533/mOjUXGkySSNUWVhjjM/t/qLIbAS6ER4VNTQP+MRTnLsVW1Gx
        9s6MDCoQpX5BnrF4IrcQ+SEKkENfJcFA8g==
X-Google-Smtp-Source: ABdhPJy8xu36tZnoxa2BD/PA7L7y6Bh6U778WNnV2EsVhJugUaQ0W1Tm5FouNd2SqRVV1aqqU9HqFg==
X-Received: by 2002:a63:2254:: with SMTP id t20mr10040743pgm.230.1614524661481;
        Sun, 28 Feb 2021 07:04:21 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:561f:afde:af07:8820])
        by smtp.gmail.com with ESMTPSA id 142sm8391331pfz.196.2021.02.28.07.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 07:04:21 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com,
        sunilmut@microsoft.com
Subject: [RFC PATCH 12/12] HV/Storvsc: Add bounce buffer support for Storvsc
Date:   Sun, 28 Feb 2021 10:03:15 -0500
Message-Id: <20210228150315.2552437-13-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210228150315.2552437-1-ltykernel@gmail.com>
References: <20210228150315.2552437-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Storvsc driver needs to reverse additional bounce
buffers to receive multipagebuffer packet and copy
data from brounce buffer when get response messge
from message.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index c5b4974eb41f..4ae8e2a427e4 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -33,6 +33,8 @@
 #include <scsi/scsi_transport.h>
 #include <asm/mshyperv.h>
 
+#include "../hv/hyperv_vmbus.h"
+
 /*
  * All wire protocol details (storage protocol between the guest and the host)
  * are consolidated here.
@@ -725,6 +727,10 @@ static void handle_sc_creation(struct vmbus_channel *new_sc)
 	/* Add the sub-channel to the array of available channels. */
 	stor_device->stor_chns[new_sc->target_cpu] = new_sc;
 	cpumask_set_cpu(new_sc->target_cpu, &stor_device->alloced_cpus);
+
+	if (hv_bounce_resources_reserve(device->channel,
+			stor_device->max_transfer_bytes))
+		pr_warn("Fail to reserve bounce buffer\n");
 }
 
 static void  handle_multichannel_storage(struct hv_device *device, int max_chns)
@@ -964,6 +970,18 @@ static int storvsc_channel_init(struct hv_device *device, bool is_fc)
 	stor_device->max_transfer_bytes =
 		vstor_packet->storage_channel_properties.max_transfer_bytes;
 
+	/*
+	 * Reserve enough bounce resources to be able to support paging
+	 * operations under low memory conditions, that cannot rely on
+	 * additional resources to be allocated.
+	 */
+	ret =  hv_bounce_resources_reserve(device->channel,
+			stor_device->max_transfer_bytes);
+	if (ret < 0) {
+		pr_warn("Fail to reserve bounce buffer\n");
+		goto done;
+	}
+
 	if (!is_fc)
 		goto done;
 
@@ -1263,6 +1281,11 @@ static void storvsc_on_channel_callback(void *context)
 
 		request = (struct storvsc_cmd_request *)(unsigned long)cmd_rqst;
 
+		if (desc->type == VM_PKT_COMP && request->bounce_pkt) {
+			hv_pkt_bounce(channel, request->bounce_pkt);
+			request->bounce_pkt = NULL;
+		}
+
 		if (request == &stor_device->init_request ||
 		    request == &stor_device->reset_request) {
 			memcpy(&request->vstor_packet, packet,
-- 
2.25.1

