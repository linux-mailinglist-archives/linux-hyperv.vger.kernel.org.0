Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0EF1B4DCD
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2020 21:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgDVT60 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Apr 2020 15:58:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56099 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgDVT6Z (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Apr 2020 15:58:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id e26so3865992wmk.5;
        Wed, 22 Apr 2020 12:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=orSoP8CVp+BTvk77nTO3bh1BFXcHR89DeR85JOv6qR4=;
        b=HG6hOP27SdCW233BPADQRHCYdvN/ehnURoovIFxe279mn//vGxl07X59ndyCCJnN2h
         f11rkiL0/9eEe25RbtD94fB33IOCBDptC86mNcSsc9zEHPaS+26AlrHqgQQEPAVi1aaB
         EIIpNIZczf9b+2tS2dzVnpseSnww+/+etmelvKrdaxcx5wM5kABbeuOphkS5/pP3eqmc
         KmzK7Av9MJ9UGbSp+l62BJn62zNTulX9h7eVp4qmpSZ3RD42jeRoRbx570LroGv41kfu
         eG814N3kUC0CRXMwcJDnnhG3HCfDpYk7CSdlAuOK7NVHWvQn8r//9JWspZuGb4sd68ch
         9VIQ==
X-Gm-Message-State: AGi0PuaaFUWqgMylp/0x3hhLZRJQeJcZVJclLeBgU3nXk1jQPnJ26lz4
        xxi3ZLkHGIbZFltBC4WwpIrLmWpEEI8=
X-Google-Smtp-Source: APiQypKXW+YBdVGKiF7M7cphAcClN7/OcR+JzG9JNQBF+KzYUkOXhg+iusfzbOxYCGbyh5ohfBD/jg==
X-Received: by 2002:a1c:9852:: with SMTP id a79mr130312wme.27.1587585501946;
        Wed, 22 Apr 2020 12:58:21 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m1sm314017wro.64.2020.04.22.12.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 12:58:21 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>
Subject: [PATCH] PCI: export and use pci_msi_get_hwirq in pci-hyperv.c
Date:   Wed, 22 Apr 2020 19:58:15 +0000
Message-Id: <20200422195818.35489-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There is a functionally identical function in pci-hyperv.c. Drop it and
use pci_msi_get_hwirq instead.

This requires exporting pci_msi_get_hwirq and declaring it in msi.h.

No functional change intended.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/include/asm/msi.h          | 4 ++++
 arch/x86/kernel/apic/msi.c          | 5 +++--
 drivers/pci/controller/pci-hyperv.c | 8 +-------
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/msi.h b/arch/x86/include/asm/msi.h
index 25ddd0916bb2..353b80122b2e 100644
--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -11,4 +11,8 @@ int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 
 void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc);
 
+struct msi_domain_info;
+irq_hw_number_t pci_msi_get_hwirq(struct msi_domain_info *info,
+				  msi_alloc_info_t *arg);
+
 #endif /* _ASM_X86_MSI_H */
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 159bd0cb8548..56dcdd912564 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -204,11 +204,12 @@ void native_teardown_msi_irq(unsigned int irq)
 	irq_domain_free_irqs(irq, 1);
 }
 
-static irq_hw_number_t pci_msi_get_hwirq(struct msi_domain_info *info,
-					 msi_alloc_info_t *arg)
+irq_hw_number_t pci_msi_get_hwirq(struct msi_domain_info *info,
+				  msi_alloc_info_t *arg)
 {
 	return arg->msi_hwirq;
 }
+EXPORT_SYMBOL_GPL(pci_msi_get_hwirq);
 
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg)
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index e6020480a28b..2b4a6452095f 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1520,14 +1520,8 @@ static struct irq_chip hv_msi_irq_chip = {
 	.irq_unmask		= hv_irq_unmask,
 };
 
-static irq_hw_number_t hv_msi_domain_ops_get_hwirq(struct msi_domain_info *info,
-						   msi_alloc_info_t *arg)
-{
-	return arg->msi_hwirq;
-}
-
 static struct msi_domain_ops hv_msi_ops = {
-	.get_hwirq	= hv_msi_domain_ops_get_hwirq,
+	.get_hwirq	= pci_msi_get_hwirq,
 	.msi_prepare	= pci_msi_prepare,
 	.set_desc	= pci_msi_set_desc,
 	.msi_free	= hv_msi_free,
-- 
2.20.1

