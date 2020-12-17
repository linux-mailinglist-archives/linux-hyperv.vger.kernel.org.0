Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FAD2DDA24
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Dec 2020 21:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbgLQUec (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Dec 2020 15:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgLQUeb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Dec 2020 15:34:31 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E5DC0617A7;
        Thu, 17 Dec 2020 12:33:51 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w5so24176125wrm.11;
        Thu, 17 Dec 2020 12:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D2EkVR3dxU3bZL0ia74uk0mklAzjaKcVTJH27BwnHqA=;
        b=qNDfI+w1vtEUNGIewrPPL0sxPrUbw/Gafc96TEevd0Z4rkO1F3U9ZHZW6gN9qvKSNr
         hb5jqTx5WORXv64t6jO1luDSlSL07w3aL73DYjIwWXIUqc6ivcvWneKtTuaMi9unhyYP
         BOnODLkPq03V8gRmgrMcLkPtY6RWHW67Cgtmc9585mwKqjkKfx4SOVFQW3nggH4ZlXfA
         hQyqEqk8EhBU8nUH5etHVXmoeNirrTPo2z+TdM08DfZ8FhTGXyk9LinJK3UGbzuJrGyL
         UTd5kuPCk2YpuwtWWr+2ORBRQty9iwiFrelbJfHFjQ7dbj3q0TOUSeE5gYMEgKoDYFWH
         J/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D2EkVR3dxU3bZL0ia74uk0mklAzjaKcVTJH27BwnHqA=;
        b=rxPDy5NCyvuU1bX+CmMJUDh3/2PydBLwheGDuvIgCCvk9fcof8y+hxvhFNxroLOfjp
         7E6UrZryhetTXNZg6heYw4SDU+eFuEQKiYHQiY8WppPmRJcfDR7FuWDKq2U/gZtJSu0Z
         XQAYqNYPQzYZD6IufJNQ1z6G5HQkjZ3IRllguDMBDB8gDxr9eJiKkHzPnA1VQ1sB1jwZ
         dk5qt11k8OulwsReLbYnudnV6TjjWgKU2CDzDBT2/hV6LMs4F9Ez4Vg/IRgMZc6VpRWs
         9hWXT9zKWllwfRxJhpeb3mWdy71AKg9GbujkAamWABl0CTA9K3stKngEPfNdF0h2mPLJ
         xiYg==
X-Gm-Message-State: AOAM5314DCKtD3hxfl8PTgwKNRjfQOzTgnaA7atflvdxpFzRgy9KIlj/
        5QUmfKh4+LOaHgV9citMsFaGlA1E6Ke/2TPe
X-Google-Smtp-Source: ABdhPJwIPo6y7byUWOne15a0dLqXv8x2zFHV6U/0dtBbvNOVSsOpQaERlAWbFcVuD+KqnkLhGIZnCg==
X-Received: by 2002:adf:f0d0:: with SMTP id x16mr655177wro.162.1608237229537;
        Thu, 17 Dec 2020 12:33:49 -0800 (PST)
Received: from localhost.localdomain (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id a62sm11729128wmh.40.2020.12.17.12.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 12:33:49 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 1/3] scsi: storvsc: Fix max_outstanding_req_per_channel for Win8 and newer
Date:   Thu, 17 Dec 2020 21:33:19 +0100
Message-Id: <20201217203321.4539-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217203321.4539-1-parri.andrea@gmail.com>
References: <20201217203321.4539-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Current code overestimates the value of max_outstanding_req_per_channel
for Win8 and newer hosts, since vmscsi_size_delta is set to the initial
value of sizeof(vmscsi_win8_extension) rather than zero.  This may lead
to wrong decisions when using ring_avail_percent_lowater equals to zero.
The estimate of max_outstanding_req_per_channel is 'exact' for Win7 and
older hosts.  A better choice, keeping the algorithm for the estimation
simple, is to err the other way around, i.e., to underestimate for Win7
and older but to use the exact value for Win8 and newer.

Suggested-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
---
 drivers/scsi/storvsc_drv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index ded00a89bfc4e..64298aa2f151e 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -2141,12 +2141,15 @@ static int __init storvsc_drv_init(void)
 	 * than the ring buffer size since that page is reserved for
 	 * the ring buffer indices) by the max request size (which is
 	 * vmbus_channel_packet_multipage_buffer + struct vstor_packet + u64)
+	 *
+	 * The computation underestimates max_outstanding_req_per_channel
+	 * for Win7 and older hosts because it does not take into account
+	 * the vmscsi_size_delta correction to the max request size.
 	 */
 	max_outstanding_req_per_channel =
 		((storvsc_ringbuffer_size - PAGE_SIZE) /
 		ALIGN(MAX_MULTIPAGE_BUFFER_PACKET +
-		sizeof(struct vstor_packet) + sizeof(u64) -
-		vmscsi_size_delta,
+		sizeof(struct vstor_packet) + sizeof(u64),
 		sizeof(u64)));
 
 #if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
-- 
2.25.1

