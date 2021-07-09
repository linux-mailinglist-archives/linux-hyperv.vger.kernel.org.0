Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD483C231A
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 13:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhGILqg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 07:46:36 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:41981 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhGILqf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 07:46:35 -0400
Received: by mail-wr1-f41.google.com with SMTP id k4so5465252wrc.8;
        Fri, 09 Jul 2021 04:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j4tacrTa1KYqq7lXg+mzF/CJt/1c6utpjoK8omTLZME=;
        b=IyWIghvTNCtH5oj+nTkZ0OUoubCPfiwpW7g6r3Wg7rpsWzhrIOqtaE8eK9VhXbvDqL
         oZTzauMGbl3fq2knIwxaChBq0UfHtThHBDIZQKOD4IeDAWoVXjCii4HnMZSDB4141IDw
         giiUDuSC30eJybRN+VwbhKbJCTzxnOyW7nB1vUXb4eycVNE1T8SxLRq1zvWXQPnHhNHn
         TBZcj3xCD9MZdNYt83VhqboVO8AcpanMpoD2ptAnqYhXDqXA0WgTQKboz0rWvCAvDN+p
         JUevyJNyKkavkvFyfFAecR/R87eFnTwQ6OtbR5V/TKYl+HQ11CWL07GSi3t8NehieTi5
         pL0g==
X-Gm-Message-State: AOAM530MUdKJcxNeAI6HTik7CTk3EpEZ/jEuh436uqr+mCAzotbTd+v3
        BSv3+vNKaShBw8wyX6ozcvEDMX8bER8=
X-Google-Smtp-Source: ABdhPJztHl+FRLzminSGKcuTXml3YN3c0TWOwZ359TNjOY2ZSLDSMfRm60riREUrEuDHG/5lHotzOg==
X-Received: by 2002:adf:dd0d:: with SMTP id a13mr20350802wrm.220.1625831030382;
        Fri, 09 Jul 2021 04:43:50 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z12sm4896849wrs.39.2021.07.09.04.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:43:50 -0700 (PDT)
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
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS)
Subject: [RFC v1 6/8] mshv: command line option to skip devices in PV-IOMMU
Date:   Fri,  9 Jul 2021 11:43:37 +0000
Message-Id: <20210709114339.3467637-7-wei.liu@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709114339.3467637-1-wei.liu@kernel.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Some devices may have been claimed by the hypervisor already. One such
example is a user can assign a NIC for debugging purpose.

Ideally Linux should be able to tell retrieve that information, but
there is no way to do that yet. And designing that new mechanism is
going to take time.

Provide a command line option for skipping devices. This is a stopgap
solution, so it is intentionally undocumented. Hopefully we can retire
it in the future.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/iommu/hyperv-iommu.c | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 043dcff06511..353da5036387 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -349,6 +349,16 @@ static const struct irq_domain_ops hyperv_root_ir_domain_ops = {
 
 #ifdef CONFIG_HYPERV_ROOT_PVIOMMU
 
+/* The IOMMU will not claim these PCI devices. */
+static char *pci_devs_to_skip;
+static int __init mshv_iommu_setup_skip(char *str) {
+	pci_devs_to_skip = str;
+
+	return 0;
+}
+/* mshv_iommu_skip=(SSSS:BB:DD.F)(SSSS:BB:DD.F) */
+__setup("mshv_iommu_skip=", mshv_iommu_setup_skip);
+
 /* DMA remapping support */
 struct hv_iommu_domain {
 	struct iommu_domain domain;
@@ -774,6 +784,41 @@ static struct iommu_device *hv_iommu_probe_device(struct device *dev)
 	if (!dev_is_pci(dev))
 		return ERR_PTR(-ENODEV);
 
+	/*
+	 * Skip the PCI device specified in `pci_devs_to_skip`. This is a
+	 * temporary solution until we figure out a way to extract information
+	 * from the hypervisor what devices it is already using.
+	 */
+	if (pci_devs_to_skip && *pci_devs_to_skip) {
+		int pos = 0;
+		int parsed;
+		int segment, bus, slot, func;
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		do {
+			parsed = 0;
+
+			sscanf(pci_devs_to_skip + pos,
+				" (%x:%x:%x.%x) %n",
+				&segment, &bus, &slot, &func, &parsed);
+
+			if (parsed <= 0)
+				break;
+
+			if (pci_domain_nr(pdev->bus) == segment &&
+				pdev->bus->number == bus &&
+				PCI_SLOT(pdev->devfn) == slot &&
+				PCI_FUNC(pdev->devfn) == func)
+			{
+				dev_info(dev, "skipped by MSHV IOMMU\n");
+				return ERR_PTR(-ENODEV);
+			}
+
+			pos += parsed;
+
+		} while (pci_devs_to_skip[pos]);
+	}
+
 	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
 	if (!vdev)
 		return ERR_PTR(-ENOMEM);
-- 
2.30.2

