Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7847A52F
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jul 2019 11:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbfG3JuG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jul 2019 05:50:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37843 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbfG3JuF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jul 2019 05:50:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id y26so62369775qto.4;
        Tue, 30 Jul 2019 02:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9DjvcDg0UMTw/Qo0I1RSb4k+ACs5La7hPpr0+lfP19A=;
        b=HxXrNsOHqfC8209335cKwGVoe6a8Kh0sGxDQ2tcFq7/pLU+cKdWUaYJi6dTWanwmZE
         inGBNSrDH1U2/8tfilI15v+T0j7CTnUbx6tQpDXPq7FAm1ygm4ZezPCiRz2AAK3+0AB4
         v4JvEQMYuVviApBRbrsJ7wdVHSZJnGoneIcQRccgncx8HJ4uDCZRdznGvMe3FcGZfd3K
         VIKImWn9kV5QNUq0q0R2KTdAjG/MTD6h1n6AYfQHR04Y1hpOoFxhQf5Lt2UIZqLjhj8o
         mWXXgX07Tudv/h0UiYF6pCQrtIhmqH3WbqYBMikkxAeTkRRqSIKeVv2FBcE3bn+eKmbJ
         x9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9DjvcDg0UMTw/Qo0I1RSb4k+ACs5La7hPpr0+lfP19A=;
        b=DBnF/Ce60gHLKer/IfoNcZDJluRlb6UBbYncY1ETQzhy7VAu6eLOXX091wOJ1WuFRn
         Ia9iW4jxorZviMh463MDWsraX8uz4p+9llqRt5sKxmre6tM7JjBm66qjdjFLlgioAd/T
         NQKWwkZsS9pk7VZGrea6ihW4eYWsw701dfJio0HpTy6x+FGZ0r7FQ+HrU6S0JAJhARMi
         GwiFnZ1YyQ4jzvIiBeNzPn2ZjKlERefHycVERqLrVXBclaMBgBq15AS8rFAAFscyrX+G
         no+9pfbPqUMZKgPJ/ZNy5D2eD1HW0EzsXv9gPNkP72RnZaZTLJgNp+ihIX/EKVKVO+Jl
         bOkQ==
X-Gm-Message-State: APjAAAW2AsNKJzapT3VcJQdnLmkxKV1ELcXHShJ3UUAb1gacDkgM8xvN
        wiBKE1rITmTAPiTT2bX2iLM=
X-Google-Smtp-Source: APXvYqwwar7vwPiNc8oQEYFeveOePMFHWskdKnLKcZ2HB/WvyxxDN6m0nzMhO5BfrPpAqu4v21SbZw==
X-Received: by 2002:a0c:b88e:: with SMTP id y14mr79617765qvf.93.1564480204446;
        Tue, 30 Jul 2019 02:50:04 -0700 (PDT)
Received: from AzureHyper-V.3xjlci4r0w3u5g13o212qxlisd.bx.internal.cloudapp.net ([13.68.195.119])
        by smtp.gmail.com with ESMTPSA id d9sm28198078qke.136.2019.07.30.02.50.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 02:50:04 -0700 (PDT)
From:   Himadri Pandya <himadrispandya@gmail.com>
X-Google-Original-From: Himadri Pandya <himadri18.07@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Himadri Pandya <himadri18.07@gmail.com>
Subject: [PATCH 1/2] x86: hv: Add function to allocate zeroed page for Hyper-V
Date:   Tue, 30 Jul 2019 09:49:43 +0000
Message-Id: <20190730094944.96007-2-himadri18.07@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730094944.96007-1-himadri18.07@gmail.com>
References: <20190730094944.96007-1-himadri18.07@gmail.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V assumes page size to be 4K. While this assumption holds true on
x86 architecture, it might not  be true for ARM64 architecture. Hence
define hyper-v specific function to allocate a zeroed page which can
have a different implementation on ARM64 architecture to handle the
conflict between hyper-v's assumed page size and actual guest page size.

Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
---
 arch/x86/hyperv/hv_init.c       | 8 ++++++++
 arch/x86/include/asm/mshyperv.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index d314cf1e15fd..2d0b9b2bddf7 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -45,6 +45,14 @@ void *hv_alloc_hyperv_page(void)
 }
 EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
 
+void *hv_alloc_hyperv_zeroed_page(void)
+{
+        BUILD_BUG_ON(PAGE_SIZE != HV_HYP_PAGE_SIZE);
+
+        return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+}
+EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
+
 void hv_free_hyperv_page(unsigned long addr)
 {
 	free_page(addr);
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index f4138aeb4280..6b79515abb82 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -219,6 +219,7 @@ static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
 void __init hyperv_init(void);
 void hyperv_setup_mmu_ops(void);
 void *hv_alloc_hyperv_page(void);
+void *hv_alloc_hyperv_zeroed_page(void);
 void hv_free_hyperv_page(unsigned long addr);
 void hyperv_reenlightenment_intr(struct pt_regs *regs);
 void set_hv_tscchange_cb(void (*cb)(void));
-- 
2.17.1

