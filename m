Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DFC269412
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Sep 2020 19:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgINRuo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Sep 2020 13:50:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41788 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgINL2P (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Sep 2020 07:28:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id w5so18280538wrp.8;
        Mon, 14 Sep 2020 04:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bM8OhnZ3b+dwZKNqc64uC9sPdBGDvgCJmyqFODoUC+8=;
        b=p2HQTdJqOXepgC06X0t5gZoKDdQRGp2gb8+pNQoGU1U4C2TYndEWJfMzE5ewpkp/cp
         XQFktz5kU0WY20VJ49mvmoRiDiGWoRuPjZ9l3t3vH+magb+YI7ITFZdZeiztsxmvgBT3
         MSJoRFoRQNBV/BDkFqf6Hjjsu/GdyRmBOq/5Om5wtVcRh1ofLOKSukn2k3vhrjLUpFRV
         c4UMJQw3dJzpOFsaxuA5FKqLiYm4hROTI2kqRLgPbvyIpj0HzhujMe9pI5YziPUhxZtH
         QfPKTTL2KlMbg+plfMqgO2d7qyOjZpXIpg9MsR2p9cgLfiRchBwSLO9f2XGlBtSp8wad
         a2/A==
X-Gm-Message-State: AOAM530A6Gi/uegfT3AGD4jc4JeJM2dzB6zXYf9Fq25txEKcI337i2DC
        HJ9WhQ2PWbIQMJ0xCSHr0ZcLUMhBSqY=
X-Google-Smtp-Source: ABdhPJyXQ7JbMPXhnduOmF9GwhPMah3tAfW4aIE2/oumf4ffYByURENvXM+nn7osAsc+tRkWeCIn6Q==
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr15461492wrk.108.1600082893627;
        Mon, 14 Sep 2020 04:28:13 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s12sm12024606wmd.20.2020.09.14.04.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:28:13 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH RFC v1 03/18] Drivers: hv: vmbus: skip VMBus initialization if Linux is root
Date:   Mon, 14 Sep 2020 11:27:47 +0000
Message-Id: <20200914112802.80611-4-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There is no VMBus and the other infrastructures initialized in
hv_acpi_init when Linux is running as the root partition.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/vmbus_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index d69f4efa3719..da4a5660f915 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2586,6 +2586,9 @@ static int __init hv_acpi_init(void)
 	if (!hv_is_hyperv_initialized())
 		return -ENODEV;
 
+	if (hv_root_partition)
+		return -ENODEV;
+
 	init_completion(&probe_event);
 
 	/*
-- 
2.20.1

