Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132182A8449
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Nov 2020 17:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbgKEQ6X (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Nov 2020 11:58:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45969 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgKEQ6W (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Nov 2020 11:58:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id p1so2576036wrf.12;
        Thu, 05 Nov 2020 08:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xor6Yeu/LEqrjLJLHrdphwSvoy/1CWzWUiEk9TBV47w=;
        b=GywPjhnn37VC9Siw4VGlTRzqvRYpkVkyYtal80QUWeAiJ+Pye8KA0LTqsIpp/Lrl7B
         beoqN6tn6stJ4nKY9pNUAsz8qj1iOCSjO/LY18vYYTGMeoMFWBNQkJ2ixtz6F24OXY98
         +9KyNLIYxBYob7R2GeIH/Xi8vH9hqRV4R9HWC4sALFay3HKhFrEGs+jNjUjN7YgvQW8X
         so23g3Pju7bd2XEbLdmL/E0YWgbWeUuv5oKmBkHI1KuDnLBWYMx6K9qPrdzhSm1rYWxm
         RwhBlXRUK/XtHUOYEsPiFIq4VTZ5JtnrpOMBbFwcGpYTczWNqMzNiXtXob+TLmku9/Wl
         eF6A==
X-Gm-Message-State: AOAM532mHrGxHJR5y5nuG8OCrZnsZbaD5Krk/FnZDEU8YoCmsp0G6SYL
        dku7fTnD8sFtfEuRjgjx5D84AK1tsRo=
X-Google-Smtp-Source: ABdhPJzF77yL+P8AJRCFQ8y4Jm/ar+3a7uJirMdHconCMFkFkT/nXvusc0GxAsCtAYM3NU0G68ZaDA==
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr4124682wrx.83.1604595500373;
        Thu, 05 Nov 2020 08:58:20 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z5sm3350729wrw.87.2020.11.05.08.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:58:19 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH v2 03/17] Drivers: hv: vmbus: skip VMBus initialization if Linux is root
Date:   Thu,  5 Nov 2020 16:58:00 +0000
Message-Id: <20201105165814.29233-4-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105165814.29233-1-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 4fad3e6745e5..37c4d3a28309 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2612,6 +2612,9 @@ static int __init hv_acpi_init(void)
 	if (!hv_is_hyperv_initialized())
 		return -ENODEV;
 
+	if (hv_root_partition)
+		return -ENODEV;
+
 	init_completion(&probe_event);
 
 	/*
-- 
2.20.1

