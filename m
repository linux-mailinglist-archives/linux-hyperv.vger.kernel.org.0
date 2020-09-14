Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37424269424
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Sep 2020 19:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgINRun (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Sep 2020 13:50:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39510 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgINL2Q (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Sep 2020 07:28:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id b79so10851136wmb.4;
        Mon, 14 Sep 2020 04:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5v500JUZm9W3PLeTFD54h3IRmGCm5u9hSoivPSmRPeA=;
        b=kRk+munPhmqq65aQMLLxzS5DWrKd80Nei154wTtqSvNNJA1L8EM6lOm3UsLTcjW/XF
         3WM5fiC1xfOp8j7ynEo0mvRbDUegaXb/8ECMtwjD90/OG5uLhgfMhTQ7z53O079xfFp0
         ewM7F8ToVaXlDMJLxKj8yPBO8ph1X9kNQQFjOC2l8MFogLD1u1bgPHJmt76RO+9ndy1v
         W7A4cxJZlN7/3N3ma4LeECWXnKtletTt2iG2nZbbxNXJE6xbpRomtTuZQAGts6u5lwgk
         qnXm08Kq+6uMj1FGEoY2xFwTXdODp8Dsu87EWNG/wFTLzEG6SLtGYl5SnY/pp2A0r5Ue
         RztQ==
X-Gm-Message-State: AOAM5309TPh4vP58hKfGTv/DOe/5CbQV3aVKgWvxUX+POSybRM4mjGRP
        og6WfDEe5HC/D0anPRgcMWXmviwMYrk=
X-Google-Smtp-Source: ABdhPJyUdJukSZQy+o144Nuc5JlcCGIDb5NRAgTLHhy3hhKD/5DE2/RETjp2sTOsMtnSstmDqgdghA==
X-Received: by 2002:a1c:a551:: with SMTP id o78mr3264122wme.4.1600082894396;
        Mon, 14 Sep 2020 04:28:14 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s12sm12024606wmd.20.2020.09.14.04.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:28:14 -0700 (PDT)
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
        Stephen Hemminger <sthemmin@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS)
Subject: [PATCH RFC v1 04/18] iommu/hyperv: don't setup IRQ remapping when running as root
Date:   Mon, 14 Sep 2020 11:27:48 +0000
Message-Id: <20200914112802.80611-5-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The IOMMU code needs more work. We're sure for now the IRQ remapping
hooks are not applicable when Linux is the root.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/iommu/hyperv-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 8919c1c70b68..4da684ab292c 100644
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

