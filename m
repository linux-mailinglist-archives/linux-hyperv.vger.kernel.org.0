Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAF730DDD6
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Feb 2021 16:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhBCPPx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Feb 2021 10:15:53 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:39319 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbhBCPFX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Feb 2021 10:05:23 -0500
Received: by mail-wm1-f44.google.com with SMTP id u14so5550040wmq.4;
        Wed, 03 Feb 2021 07:05:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=thPdbk2I39y9v4lVq2AgBtvWNkjS3q9CO+dodrvqUbY=;
        b=tgdHBF+hERQjlvrBAJUnPUlVeP4qy7i3fW1Eu2gqKd3+fxKtauirGqL+mGv63xjZdj
         L5BHXlP1bg94F/il8Kdj11YqO2/VBvJEM58L5cvmFmEo3MBaZjnRsfUTTs6gB8ZydFwC
         WPlWpKiwAqWI8pcmlCa/z1/aHZHwww6RRmWzI60BBGq3mqT5ocPAF0H8ld9mMkPKJrX6
         Y2fEyrFVZJMXHgD35pCE2bO8hzo0IRgZKMOchpRBVmzTZSXlHpFqMMrkCbYcVLy33bMc
         SRvRijsvSl1N7RDD1hTFYx2Jt5UKquiMsYUvkxQrTaUW5HzQDgIcyhas7lYL2bz7xQbG
         RnNg==
X-Gm-Message-State: AOAM533DWaT3AD6Yrl0sNyV5jGfrkLhc1bmwtS1Dtba9yfb+ExwAD2n7
        3r5M1PEm7+jwm29Qd8AeT3oipiSSG0A=
X-Google-Smtp-Source: ABdhPJzZvXMuVoJ3usecbDICjUSebwsTABDkPMkiOrae7fnZBrQWv08ypskPb/spatgGFWTA0FRURQ==
X-Received: by 2002:a1c:65d5:: with SMTP id z204mr3250757wmb.184.1612364680682;
        Wed, 03 Feb 2021 07:04:40 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r17sm4051704wro.46.2021.02.03.07.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:04:40 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH v6 03/16] Drivers: hv: vmbus: skip VMBus initialization if Linux is root
Date:   Wed,  3 Feb 2021 15:04:22 +0000
Message-Id: <20210203150435.27941-4-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210203150435.27941-1-wei.liu@kernel.org>
References: <20210203150435.27941-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There is no VMBus and the other infrastructures initialized in
hv_acpi_init when Linux is running as the root partition.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
v3: Return 0 instead of -ENODEV.
---
 drivers/hv/vmbus_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 502f8cd95f6d..ee27b3670a51 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2620,6 +2620,9 @@ static int __init hv_acpi_init(void)
 	if (!hv_is_hyperv_initialized())
 		return -ENODEV;
 
+	if (hv_root_partition)
+		return 0;
+
 	init_completion(&probe_event);
 
 	/*
-- 
2.20.1

