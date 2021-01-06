Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236EA2EC51B
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 21:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbhAFUff (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 15:35:35 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:35707 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbhAFUej (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 15:34:39 -0500
Received: by mail-wr1-f53.google.com with SMTP id r3so3592665wrt.2;
        Wed, 06 Jan 2021 12:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQMtgq3pUcrjj3NVCdkiQSStjiewGBjHdwkFAPCFR6A=;
        b=OJvM+YLZ4lV7adtWlLZ5R+DfXBO16l1EmoyK/Qq3hUTUvARZHFnM5gONrwBiaO1pgn
         hKM7IgK/PeKPZJJj4El9ev3KRhmR94ruNkL8czj1ABryh9rlNCIjZEblGXexcOTZbVn1
         LtA144Cby4qPG9dcLR7EPIyU8RSSMGChHkKTOfpOU5RGRMkpjnNpbPYRnNWy74dTVHok
         ks69xc5pB8jgvnlUkP6xDoQf31+KsdHbdCyX3IMbIvbnBiYRW1FX8VZd40USeG5CCPfp
         AWvQezi5bPeholMTJ3IqZnnJdtXxGNvkOioQGEdl2FwBalz/uJ0kSD10qTJSoFT94ksd
         R6NQ==
X-Gm-Message-State: AOAM531fo43TD3APpdpmvktn23U2JMfmaVOsf0eSjVFdrDCf3o7SwLt6
        HIKV8TCgSLO8M77l2YztR5jSy6K7tcA=
X-Google-Smtp-Source: ABdhPJzua7u0Xi2cAQqaPz7tdaucPPPz5eFSOQ1Ul7ScWmk7+7JzInjstK7tIJXCPKNakTqmjaYS+A==
X-Received: by 2002:adf:a495:: with SMTP id g21mr6160651wrb.198.1609965237426;
        Wed, 06 Jan 2021 12:33:57 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u9sm4499456wmb.32.2021.01.06.12.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 12:33:57 -0800 (PST)
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
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS)
Subject: [PATCH v4 04/17] iommu/hyperv: don't setup IRQ remapping when running as root
Date:   Wed,  6 Jan 2021 20:33:37 +0000
Message-Id: <20210106203350.14568-5-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210106203350.14568-1-wei.liu@kernel.org>
References: <20210106203350.14568-1-wei.liu@kernel.org>
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
index 1d21a0b5f724..b7db6024e65c 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -20,6 +20,7 @@
 #include <asm/io_apic.h>
 #include <asm/irq_remapping.h>
 #include <asm/hypervisor.h>
+#include <asm/mshyperv.h>
 
 #include "irq_remapping.h"
 
@@ -122,7 +123,7 @@ static int __init hyperv_prepare_irq_remapping(void)
 
 	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
 	    x86_init.hyper.msi_ext_dest_id() ||
-	    !x2apic_supported())
+	    !x2apic_supported() || hv_root_partition)
 		return -ENODEV;
 
 	fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
-- 
2.20.1

