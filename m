Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7E52A842A
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Nov 2020 17:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbgKEQ6Z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Nov 2020 11:58:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35821 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731654AbgKEQ6Y (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Nov 2020 11:58:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id n15so2605109wrq.2;
        Thu, 05 Nov 2020 08:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bh2EFPnmcn/x+bLcSdCEHI4hoqXZxmYUy4JjOwlCick=;
        b=Zst5k6LKhFFRyiyTPPMkyWD2odiAVL/zloARX2x4YWuietCHrh0PgGEx8ij8kjG8zy
         bcXLOZ56wRy8kqbz5EuugPO5g7feWuO5ZSrjL8QVq+eSRxvZ64om+OEEssyjmRggQYHP
         F+IWkPGcE4kOcdbCzdiZfr7D7Q87WXZ/eAoqf84w7ZszCn7Eib2iKJscf5S+R4Hxa22B
         ExGMRuqSj7/XLCb72UDL6unlm+GfvAEwOrC4PtKMKVoftpFJi/Ijw3NfwiLGkKbjJ9cy
         wTVf6dugSLcQE5cfwfj/UhKCxs3ZOewirk3PBzIGmUOI4EwRBqmty3TJVlZcDYf3+FBJ
         WR/w==
X-Gm-Message-State: AOAM533cnJ7DQSfm6OxCyKPzsAYMPtndgp8btTEU10MHDMXzvRFFdpQV
        JKV+YIzzmtZjn3mSAoEU0h+rKwGDIRA=
X-Google-Smtp-Source: ABdhPJwhViVved3GTCeWnOtr+DREAkL3iuMzaCD27vVobs1AMx4FxSw+xOpyOddCpw8z2HuMwtVW4Q==
X-Received: by 2002:adf:e447:: with SMTP id t7mr4024862wrm.384.1604595501442;
        Thu, 05 Nov 2020 08:58:21 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z5sm3350729wrw.87.2020.11.05.08.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:58:20 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS)
Subject: [PATCH v2 04/17] iommu/hyperv: don't setup IRQ remapping when running as root
Date:   Thu,  5 Nov 2020 16:58:01 +0000
Message-Id: <20201105165814.29233-5-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105165814.29233-1-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The IOMMU code needs more work. We're sure for now the IRQ remapping
hooks are not applicable when Linux is the root.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
Acked-by: Joerg Roedel <jroedel@suse.de>
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

