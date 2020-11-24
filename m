Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4EB2C2DDB
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Nov 2020 18:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390644AbgKXRHy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Nov 2020 12:07:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36401 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390452AbgKXRHx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Nov 2020 12:07:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id a65so3645314wme.1;
        Tue, 24 Nov 2020 09:07:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y+NYsCm9tGc6GjBoEZ7bi5tfuxFZISDvGMwp4S/BObI=;
        b=EBgf8u8Lo/i6CX0Fc40uKpsu+VXWwCeaElDuH5kC/+5hCf4tqOmJ5xI4V0KZ/+EEXU
         jaVk1DiF14nLuwoeqsXntD8YPWMYBx4y+8R4dFlZcf0o3AvT4qeNqJSeTcnDbiy/oZeP
         At1CLjTm8xBnSSAZH9oe4BtZTPnzI0My5SFX8SCxvRpl1mVCZoDPG+meZgacOAqrtaiR
         r4NSzQPXlq5aT30dJBek/554PqWALrHj1njE2TfGr2MQWRFR+LLaDv7R/WmylXKz6AJ7
         Rb3UKgclJcIZNR2lTxl0P56RH5O55Az+GTP3rz3bfA57cZuVQad9N+26aspDznYGNcf8
         E66Q==
X-Gm-Message-State: AOAM531r/73vI5hkh9sZCVi9NIkoWY83RgqFF93aS+TYg3ByKWWirq50
        BHvIomKb8mV4Pq06FoU6fISrZiIWGeM=
X-Google-Smtp-Source: ABdhPJyRy4oNI+baboiLauOZ5kuNcIz+UESSkuC95WYwMV/AE323XjTDVKemQQJZv331EIMXSitBHg==
X-Received: by 2002:a1c:4b18:: with SMTP id y24mr5780733wma.154.1606237671954;
        Tue, 24 Nov 2020 09:07:51 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v20sm6419874wmh.44.2020.11.24.09.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:07:51 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS)
Subject: [PATCH v3 04/17] iommu/hyperv: don't setup IRQ remapping when running as root
Date:   Tue, 24 Nov 2020 17:07:31 +0000
Message-Id: <20201124170744.112180-5-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124170744.112180-1-wei.liu@kernel.org>
References: <20201124170744.112180-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The IOMMU code needs more work. We're sure for now the IRQ remapping
hooks are not applicable when Linux is the root partition.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
Acked-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/iommu/hyperv-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index e09e2d734c57..8d3ce3add57d 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -20,6 +20,7 @@
 #include <asm/io_apic.h>
 #include <asm/irq_remapping.h>
 #include <asm/hypervisor.h>
+#include <asm/mshyperv.h>
 
 #include "irq_remapping.h"
 
@@ -143,7 +144,7 @@ static int __init hyperv_prepare_irq_remapping(void)
 	int i;
 
 	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
-	    !x2apic_supported())
+	    !x2apic_supported() || hv_root_partition)
 		return -ENODEV;
 
 	fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
-- 
2.20.1

