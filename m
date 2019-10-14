Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5B22D6BD6
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 01:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfJNXB6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Oct 2019 19:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfJNXB6 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Oct 2019 19:01:58 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FA70217F9;
        Mon, 14 Oct 2019 23:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571094117;
        bh=XJ9gzZXljOyOpoX7//nZyyqSZxdlTYsADbIJ0lo74cY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zlZ+S4Y50FGS7rQCh37WY6JT5AAWnarto+5ZyhMg0rCtK88tuAFMhI1+LyEMfxroI
         HzFghLMGQdXK7ovjm5IT2HGwNymfK/tFesR4viPZB+MDH5GR9bEf4cqCXz5Bfs304g
         AdPZps68jMhC4DUK1XV8dKj8wxUZXeSajQkboqNg=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, olaf@aepfle.de,
        apw@canonical.com, jasowang@redhat.com, vkuznets@redhat.com,
        marcelo.cerri@canonical.com, jackm@mellanox.com,
        linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/7] PCI/PM: Clear PCIe PME Status even for legacy power management
Date:   Mon, 14 Oct 2019 18:00:12 -0500
Message-Id: <20191014230016.240912-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
In-Reply-To: <20191014230016.240912-1-helgaas@kernel.org>
References: <20191014230016.240912-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Previously, pci_pm_resume_noirq() cleared the PME Status bit in the Root
Status register only if the device had no driver or the driver did not
implement legacy power management.  It should clear PME Status regardless
of what sort of power management the driver supports, so do this before
checking for legacy power management.

This affects Root Ports and Root Complex Event Collectors, for which the
usual driver is the PCIe portdrv, which implements new power management, so
this change is just on principle, not to fix any actual defects.

Fixes: a39bd851dccf ("PCI/PM: Clear PCIe PME Status bit in core, not PCIe port driver")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-driver.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d4ac8ce8c1f9..0c3086793e4e 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -941,12 +941,11 @@ static int pci_pm_resume_noirq(struct device *dev)
 		pci_pm_default_resume_early(pci_dev);
 
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
+	pcie_pme_root_status_cleanup(pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
 
-	pcie_pme_root_status_cleanup(pci_dev);
-
 	if (drv && drv->pm && drv->pm->resume_noirq)
 		error = drv->pm->resume_noirq(dev);
 
-- 
2.23.0.700.g56cf767bdb-goog

