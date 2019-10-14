Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F9BD6BE7
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 01:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfJNXCK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Oct 2019 19:02:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfJNXCJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Oct 2019 19:02:09 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2007421882;
        Mon, 14 Oct 2019 23:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571094129;
        bh=OTdm4D5QsUvEdMjHsLdj8VxjE2uHi2PlTnEpkKDjENw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJpX+DtDtGu93cjz7aWAU+r0YiZOe+OmJdsx+pga9hftMJB73le99HTNGE7z14IOV
         JbvHPPe4J5+N6hMG9cWFCjhvVk/ee3JgHPYCr984TO4fMLtdTjflhGh324x65w/Sw3
         UvKsgBnky2lpCKVk0YkUH5ARDnXg8K3KYkqL2GRY=
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
Subject: [PATCH 7/7] PCI/MSI: Move power state check out of pci_msi_supported()
Date:   Mon, 14 Oct 2019 18:00:16 -0500
Message-Id: <20191014230016.240912-8-helgaas@kernel.org>
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

27e20603c54b ("PCI/MSI: Move D0 check into pci_msi_check_device()")
moved the power state check into pci_msi_check_device(), which was
subsequently renamed to pci_msi_supported().  This didn't change the
behavior, since both callers checked the power state.

However, it doesn't fit the current "pci_msi_supported()" name, which
should return what the device is capable of, independent of the power
state.

Move the power state check back into the callers for readability.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0884bedcfc7a..20e9c729617c 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -861,7 +861,7 @@ static int pci_msi_supported(struct pci_dev *dev, int nvec)
 	if (!pci_msi_enable)
 		return 0;
 
-	if (!dev || dev->no_msi || dev->current_state != PCI_D0)
+	if (!dev || dev->no_msi)
 		return 0;
 
 	/*
@@ -972,7 +972,7 @@ static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
 	int nr_entries;
 	int i, j;
 
-	if (!pci_msi_supported(dev, nvec))
+	if (!pci_msi_supported(dev, nvec) || dev->current_state != PCI_D0)
 		return -EINVAL;
 
 	nr_entries = pci_msix_vec_count(dev);
@@ -1058,7 +1058,7 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	int nvec;
 	int rc;
 
-	if (!pci_msi_supported(dev, minvec))
+	if (!pci_msi_supported(dev, minvec) || dev->current_state != PCI_D0)
 		return -EINVAL;
 
 	/* Check whether driver already requested MSI-X IRQs */
-- 
2.23.0.700.g56cf767bdb-goog

