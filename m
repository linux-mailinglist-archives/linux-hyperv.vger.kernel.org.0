Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD17268AC2
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Sep 2020 14:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgINMSe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Sep 2020 08:18:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43320 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgINMGq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Sep 2020 08:06:46 -0400
Received: by mail-ed1-f65.google.com with SMTP id n13so17250293edo.10;
        Mon, 14 Sep 2020 05:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCmCr3SdPqpCYBFfCy32K6SA3OwSEdGb0+Meki4uGYs=;
        b=kK0ciLyjYydx60XVlIMFH6mwZkVbgsETXC5ojtNHdsqrOIUKbGYFpTW7cXqQdH/DT1
         WAvUGkjemCNEwCEBFJKofu+2LE3aJoBlRCugwtB/+FeC7AdYu5Q/uyO7NX/RZTxigkXJ
         uOCodSWJKEM94/7WEHE1TD/THklM10Pi7MRg6ydIHdnBlUM4lPJGtLX0/GTcHmYQwd+R
         ROCYRofveEdZjCH1jRl2LYIfujneUPPHfiIrl3fM9b515kPGqD9ypCYMbQ3vJ6kobFqe
         NTKWZrn6sYo7KAUF6u7RW2w5P5B0CeDHHNLE5ZrbtCOSWVZuEZjO3WHEkhC9eUhQyW9D
         6Ffw==
X-Gm-Message-State: AOAM533Nqv5XCQcvgi0LdWk8SO3IKmZHlFth6kP9WgrpSDplMcPM12Iv
        AiH5Vx9ictgzm3dlXCc3Lwta90Zqiuc=
X-Google-Smtp-Source: ABdhPJyQNJpXSr0hMQ+ZfM4z3CZgTbzR/tyeK9YgRWDSv4RBHJx5N+rqQy/8lZ9Clih7wyhmwTCUNw==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr14965362wrt.13.1600084782684;
        Mon, 14 Sep 2020 04:59:42 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c205sm18764809wmd.33.2020.09.14.04.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:59:42 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH RFC v1 15/18] x86/apic/msi: export pci_msi_get_hwirq
Date:   Mon, 14 Sep 2020 11:59:24 +0000
Message-Id: <20200914115928.83184-7-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Linux will implement an MSI domain for MSI/MSI-X when running as root on
Microsoft Hypervisor. It will be using this function to reduce code
duplication.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/include/asm/msi.h | 3 +++
 arch/x86/kernel/apic/msi.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msi.h b/arch/x86/include/asm/msi.h
index 25ddd0916bb2..5c0e102c03ec 100644
--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -11,4 +11,7 @@ int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 
 void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc);
 
+struct msi_domain_info;
+irq_hw_number_t pci_msi_get_hwirq(struct msi_domain_info *info, msi_alloc_info_t *arg);
+
 #endif /* _ASM_X86_MSI_H */
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index c2b2911feeef..dc9693a73933 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -205,11 +205,12 @@ void native_teardown_msi_irq(unsigned int irq)
 	irq_domain_free_irqs(irq, 1);
 }
 
-static irq_hw_number_t pci_msi_get_hwirq(struct msi_domain_info *info,
+irq_hw_number_t pci_msi_get_hwirq(struct msi_domain_info *info,
 					 msi_alloc_info_t *arg)
 {
 	return arg->msi_hwirq;
 }
+EXPORT_SYMBOL_GPL(pci_msi_get_hwirq);
 
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg)
-- 
2.20.1

