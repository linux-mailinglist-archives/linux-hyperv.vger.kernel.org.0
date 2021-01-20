Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E95B2FD0E2
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Jan 2021 14:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388767AbhATM60 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Jan 2021 07:58:26 -0500
Received: from mail-ej1-f44.google.com ([209.85.218.44]:33772 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389063AbhATMKB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Jan 2021 07:10:01 -0500
Received: by mail-ej1-f44.google.com with SMTP id by1so26780484ejc.0;
        Wed, 20 Jan 2021 04:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mEBt6kadL06yrWP6jkRQ6hKHgAZ+ACyWHQVmdjiqpDc=;
        b=Tq3cDODU2WBec2iUu26b8eh4Y4vjaeDWkeQdXuDJFwQf6qTK8W2gDOiiHk2ly4696K
         OJsjUKvbZ1cVAoiijNz4vGowzmxAkf6XSKr7MPS4Kp1ECfM+FsUav3qsGKLsJIBuNd7a
         vHFfLETSD5W1WggXhascWZLrZu0O5zKnm5ysUBGIafxznZqi/LmHFG9gBRrmGn3vGGoZ
         TPLCf6IlhwGEZ3xXepdattsY0QpgMsXIabWPUnEEFddVam3XGdTzmvjOE2SxQz2gFO0a
         Odq0UzKgr/yz90VViXp+u9F0oT3vea/b7OsZrLH/b/11CJ/zE9P8fklzAtJXAPFhhKcZ
         2yxA==
X-Gm-Message-State: AOAM533qoEhZmdXUwjHyQlRnFlNRg2XRyc+ErQogU2+D+8oP9yYfQNUY
        oFqPOVBD/26+RJrj2OZTTcQ0i0TWeLc=
X-Google-Smtp-Source: ABdhPJy/0wQh63srUUqljr8Czm3wNGm14zd1d3AoftrnveDI+VwYTPee4Ysht0HhZuSehhoyV4Zj7g==
X-Received: by 2002:adf:edc8:: with SMTP id v8mr5038846wro.374.1611144064770;
        Wed, 20 Jan 2021 04:01:04 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x17sm3747671wro.40.2021.01.20.04.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 04:01:04 -0800 (PST)
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
Subject: [PATCH v5 03/16] Drivers: hv: vmbus: skip VMBus initialization if Linux is root
Date:   Wed, 20 Jan 2021 12:00:45 +0000
Message-Id: <20210120120058.29138-4-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120120058.29138-1-wei.liu@kernel.org>
References: <20210120120058.29138-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There is no VMBus and the other infrastructures initialized in
hv_acpi_init when Linux is running as the root partition.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
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

