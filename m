Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C2E6690A
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jul 2019 10:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfGLIV1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 12 Jul 2019 04:21:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34835 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfGLIV1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 12 Jul 2019 04:21:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so4428033plp.2;
        Fri, 12 Jul 2019 01:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=APl5dbgN+eZue0lzxfYmWgGhXRjD2NfOpuLfGcmFZXw=;
        b=jO/GNaSk2UOTfBD++EpjxqMFJzQ8oX3E9s+dIj/gF9+MD0EHK/GDpDSPXFMVBpaJyF
         csYANtV6AjwbySkV6a+itemJ4JdKAJ8V33jWZCZ80eIDHMhdhGKO1r4eafwpIPEEQ0rN
         C737aRqM/igEF8xhlc8LziTNe8o8uj99h0ccGc+v40q9+YWfI2hTzHAOaYQkAEdMhddq
         fmn805UtNk1hNEWlLC2gV6k0Ea0NlVsqxztx1bCcFFWHmAhJu9SfMY1n7zjfcRmNhmQ5
         OMvqaGYl9GUu88RkKjQN6jTcAIH2guD7sKIAG/7E1z+RaZqvJHkbvGS4JpUfQtHSLfpC
         ZltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=APl5dbgN+eZue0lzxfYmWgGhXRjD2NfOpuLfGcmFZXw=;
        b=McV2i23Lhrj9RnhCs8BTCp/72CPoufW1l7Z+pQ1Ckylj3KuggkTv1UqvTSXW4aCtoR
         4if8uabDKiIXStQ94ds0gccLDiBMa+rm5iCfqEYexubRYQWsGDCKHor9adORZIUxl6c1
         X09AivwbkS9OLJ8sgVOrqtMKy9Cea/uKhUKCJXr+G9kiaNBL9Sm/IT7OJGws6fFf6xOG
         X7Npu8jb7IME0OVi8BCNbtYbMaTJLpm9s/C2785Z9d87srfLlUAolqoNsjdrqISACEA7
         ZuwLkEyiT4UMP6Oae4BBT5RK32iYawAJfiTCGCbURKSIrGPieqvX6MQjLyqyH7HXZyyf
         WY1A==
X-Gm-Message-State: APjAAAWYZMas/Yj6zxJf5VDojOyb9xaMUSgr9VNchFYkAnM3Qoa0ZFTW
        2RnCXbOof1iI7qD1NWj0JY5Dv3glrRTg6Q==
X-Google-Smtp-Source: APXvYqzL7NuUDTwd1C14X5XazK8Cr13VnIx7ezBRx2v9qJ8kkhdXmwvxSYbMheoTuDNcOsxX/0+gGw==
X-Received: by 2002:a17:902:d:: with SMTP id 13mr9721990pla.153.1562919686310;
        Fri, 12 Jul 2019 01:21:26 -0700 (PDT)
Received: from maya190711 ([52.250.118.122])
        by smtp.gmail.com with ESMTPSA id a16sm8337649pfd.68.2019.07.12.01.21.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 01:21:26 -0700 (PDT)
Date:   Fri, 12 Jul 2019 08:21:25 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] x86: hv: Add functions to allocate/deallocate page
 for Hyper-V
Message-ID: <706b2e71eb3e587b5f8801e50f090fae2a00e35d.1562916939.git.m.maya.nakamura@gmail.com>
References: <cover.1562916939.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1562916939.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce two new functions, hv_alloc_hyperv_page() and
hv_free_hyperv_page(), to allocate/deallocate memory with the size and
alignment that Hyper-V expects as a page. Although currently they are
not used, they are ready to be used to allocate/deallocate memory on x86
when their ARM64 counterparts are implemented, keeping symmetry between
architectures with potentially different guest page sizes.

Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.1906272334560.32342@nanos.tec.linutronix.de/
Link: https://lore.kernel.org/lkml/87muindr9c.fsf@vitty.brq.redhat.com/
Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/hv_init.c       | 14 ++++++++++++++
 arch/x86/include/asm/mshyperv.h |  5 ++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 0e033ef11a9f..e8960a83add7 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
 u32 hv_max_vp_index;
 EXPORT_SYMBOL_GPL(hv_max_vp_index);
 
+void *hv_alloc_hyperv_page(void)
+{
+	BUILD_BUG_ON(PAGE_SIZE != HV_HYP_PAGE_SIZE);
+
+	return (void *)__get_free_page(GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
+
+void hv_free_hyperv_page(unsigned long addr)
+{
+	free_page(addr);
+}
+EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
+
 static int hv_cpu_init(unsigned int cpu)
 {
 	u64 msr_vp_index;
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 2a793bf6ebb0..32ec9df39a99 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -218,7 +218,8 @@ static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
 
 void __init hyperv_init(void);
 void hyperv_setup_mmu_ops(void);
-
+void *hv_alloc_hyperv_page(void);
+void hv_free_hyperv_page(unsigned long addr);
 void hyperv_reenlightenment_intr(struct pt_regs *regs);
 void set_hv_tscchange_cb(void (*cb)(void));
 void clear_hv_tscchange_cb(void);
@@ -241,6 +242,8 @@ static inline void hv_apic_init(void) {}
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline void hyperv_setup_mmu_ops(void) {}
+static inline void *hv_alloc_hyperv_page(void) { return NULL; }
+static inline void hv_free_hyperv_page(unsigned long addr) {}
 static inline void set_hv_tscchange_cb(void (*cb)(void)) {}
 static inline void clear_hv_tscchange_cb(void) {}
 static inline void hyperv_stop_tsc_emulation(void) {};
-- 
2.17.1

