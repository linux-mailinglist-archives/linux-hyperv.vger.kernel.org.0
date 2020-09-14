Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E983268A97
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Sep 2020 14:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgINLi7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Sep 2020 07:38:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38387 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgINL2U (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Sep 2020 07:28:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id l9so10863762wme.3;
        Mon, 14 Sep 2020 04:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3d4JMvjpduBqCz6k+QE3NkfxQ9su5/24VCmbJg/2Vm4=;
        b=TXnFyoqEwYFTSUpA8DPAX8bstot46vmXpVt/XL3yRjgUstcqjhLPCm2DieF+VkZ/Q7
         8rDnG8K++UMPDIsU7IyFqYgxyPurcsIEjcvAZKGfxPfgLMREHR5Wh838iGg49jXXMT2Z
         b+/0jdMNHcSa6m7fL46kcQItMyN5Qbki/nZ5skR6VMleRYofe7z8bO2s9IUqxLmE5FZt
         t8J7Z76o1tF/1SFoaILUgMHVx5BwaGKJHz8UbZq0Gy0oqnYJtPFeonBU0oUynCPx7vwZ
         O1vfOosLOcCJU16DBVuKY0okhHKR8ZTc43fVq7Y7LsgoQkhIVOarvKX9+d6tbd6ZH4rs
         vXew==
X-Gm-Message-State: AOAM531EOk8QfztQSJu/mdi9Kx4+oYNUYLjvx03Ib5aFHo7yfG7L07bc
        hgiXeDBkQbED0dpTyqNYk/azA3YRgRo=
X-Google-Smtp-Source: ABdhPJystUif1wRjcF7mRpnR+zmeWbWgyHyEK47dCztPMpjeOrLJ9raORZNTohyNmiK+Y3KwzAGL8A==
X-Received: by 2002:a1c:a557:: with SMTP id o84mr14199501wme.96.1600082897536;
        Mon, 14 Sep 2020 04:28:17 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s12sm12024606wmd.20.2020.09.14.04.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:28:17 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RFC v1 08/18] x86/hyperv: handling hypercall page setup for root
Date:   Mon, 14 Sep 2020 11:27:52 +0000
Message-Id: <20200914112802.80611-9-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When Linux is running as the root partition, the hypercall page will
have already been setup by Hyper-V. Copy the content over to the
allocated page.

The suspend, resume and cleanup paths remain untouched because they are
not supported in this setup yet.

Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Co-Developed-by: Nuno Das Neves <nudasnev@microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/hyperv/hv_init.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 0eec1ed32023..26233aebc86c 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -25,6 +25,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
+#include <linux/highmem.h>
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
@@ -448,8 +449,29 @@ void __init hyperv_init(void)
 
 	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 	hypercall_msr.enable = 1;
-	hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
-	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+
+	if (hv_root_partition) {
+		struct page *pg;
+		void *src, *dst;
+
+		/*
+		 * Order is important here. We must enable the hypercall page
+		 * so it is populated with code, then copy the code to an
+		 * executable page.
+		 */
+		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+
+		pg = vmalloc_to_page(hv_hypercall_pg);
+		dst = kmap(pg);
+		src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
+				MEMREMAP_WB);
+		memcpy(dst, src, PAGE_SIZE);
+		memunmap(src);
+		kunmap(pg);
+	} else {
+		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
+		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	}
 
 	/*
 	 * Ignore any errors in setting up stimer clockevents
-- 
2.20.1

