Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A562FD19F
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Jan 2021 14:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388863AbhATM7h (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Jan 2021 07:59:37 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:41140 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733278AbhATMMt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Jan 2021 07:12:49 -0500
Received: by mail-ej1-f42.google.com with SMTP id g12so33219073ejf.8;
        Wed, 20 Jan 2021 04:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQMtgq3pUcrjj3NVCdkiQSStjiewGBjHdwkFAPCFR6A=;
        b=NjthebAkuSs6fArMRYIQbeZeoiI0WOi/p/enyzCB9a7pwX3ggTKxLrZi5YVBBVyW/L
         4c7C6WCkZzmYJADu0ZBBil4/m8Itqf5TUeQ0z1h2gV0oErinqSeKNzv2QoCSAz00o/lf
         YUxUmnRjbT7budrA5EyX4ws3ZiDdxs4b/yYDyJJ/0lMAD2GB7tIX8LwvtmEYZjdszPg9
         xMqwhOCLUXO8exID966SQqUbQ9r1BaQIJylhGvFJskN8T1ROiBYd4DEgzTAi9k3QHfSO
         nKtbiaQLjzEYbKmdcTwCzOwGorAkg3hA2ysXmXiB/CyBSMtLdn1LCqHGVER9AQCJQXRG
         9iRg==
X-Gm-Message-State: AOAM531MbSoy5uBGlzLB+WZhUNJMv65PEICaKN+AkDy1FrAGpyXFB5Kr
        W87NG4S+Wkh1VPQSDKBiAsYPA3qxKUo=
X-Google-Smtp-Source: ABdhPJz4rG0NJQ4emuqxUfLr2n1SVZFe7ESOJDiftil8vMTrjEnxmTX5UHX4Ncs5MrsulAjda8gL7g==
X-Received: by 2002:adf:e512:: with SMTP id j18mr8953978wrm.52.1611144065620;
        Wed, 20 Jan 2021 04:01:05 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x17sm3747671wro.40.2021.01.20.04.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 04:01:05 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, Wei Liu <wei.liu@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS)
Subject: [PATCH v5 04/16] iommu/hyperv: don't setup IRQ remapping when running as root
Date:   Wed, 20 Jan 2021 12:00:46 +0000
Message-Id: <20210120120058.29138-5-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120120058.29138-1-wei.liu@kernel.org>
References: <20210120120058.29138-1-wei.liu@kernel.org>
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

