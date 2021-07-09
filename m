Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6EA3C230B
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 13:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhGILq3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 07:46:29 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:33603 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhGILq2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 07:46:28 -0400
Received: by mail-wr1-f42.google.com with SMTP id d2so11825056wrn.0;
        Fri, 09 Jul 2021 04:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLB71UQBhut/O7gbRyUf1JJbAPy0a4dWNhnwwecYDec=;
        b=c05Xd4VShegm1FJxbz/fSdELnVfTgSqpfj+RXfVjKt4Lf9QL+DBF6KpKLdYqmnit9L
         mSkG1M2Q+vwR106O3ZK+ZD+cRSJa3oxCzAh4F2Ud6EcYaFKhCaPcj+aR9kx7dqRSJDai
         4FR+hEB07gKo5+UjKv+cJuzCTu3D/qhENSGUuCyhpHKLbb62AoGd3YyuQ3U+ZeniAT8L
         1G/3njZ9qRaZeA8f2x2JP3WS5shqyqnWBgsF5SJw8nU47joNATyClUioXjNkawk1BvUa
         5XI6LjVU0Mj6IEOERDwDXbe+80A4gieH0bpDkQF9kyJDRFGF6SexT0fBLZ3sbEgsVtLn
         GH9w==
X-Gm-Message-State: AOAM5308oGz/sMAYJnwPKi2pxm9U0CWxpf3ScMHW7FsdizKvU1hFmZbu
        3nDtF4qQt+LO0rj2HNIbzdUZUzrlfrY=
X-Google-Smtp-Source: ABdhPJyoT9C2g7P7EXJlD3P+k7qsrZ/Mo8q9nCez2f3ooBdZFleSM21GL2l9yfiTptkP7mK5e1W4Mg==
X-Received: by 2002:a5d:66d1:: with SMTP id k17mr14365349wrw.110.1625831024563;
        Fri, 09 Jul 2021 04:43:44 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z12sm4896849wrs.39.2021.07.09.04.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:43:44 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        kumarpraveen@linux.microsoft.com, pasha.tatashin@soleen.com,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC v1 1/8] x86/hyperv: export hv_build_pci_dev_id
Date:   Fri,  9 Jul 2021 11:43:32 +0000
Message-Id: <20210709114339.3467637-2-wei.liu@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709114339.3467637-1-wei.liu@kernel.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/hyperv/irqdomain.c     | 3 ++-
 arch/x86/include/asm/mshyperv.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 514fc64e23d5..5ea7a5145ea9 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -110,7 +110,7 @@ static int get_rid_cb(struct pci_dev *pdev, u16 alias, void *data)
 	return 0;
 }
 
-static union hv_device_id hv_build_pci_dev_id(struct pci_dev *dev)
+union hv_device_id hv_build_pci_dev_id(struct pci_dev *dev)
 {
 	union hv_device_id dev_id;
 	struct rid_data data = {
@@ -168,6 +168,7 @@ static union hv_device_id hv_build_pci_dev_id(struct pci_dev *dev)
 
 	return dev_id;
 }
+EXPORT_SYMBOL_GPL(hv_build_pci_dev_id);
 
 static int hv_map_msi_interrupt(struct pci_dev *dev, int cpu, int vector,
 				struct hv_interrupt_entry *entry)
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 21edef600729..b8f6b21e1fa5 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -196,6 +196,7 @@ struct irq_domain *hv_create_pci_msi_domain(void);
 int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 		struct hv_interrupt_entry *entry);
 int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
+union hv_device_id hv_build_pci_dev_id(struct pci_dev *dev);
 
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
-- 
2.30.2

