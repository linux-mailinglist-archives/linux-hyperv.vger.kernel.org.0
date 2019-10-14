Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13131D6BDA
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 01:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfJNXCC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Oct 2019 19:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfJNXCB (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Oct 2019 19:02:01 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 272922133F;
        Mon, 14 Oct 2019 23:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571094120;
        bh=lBbbmwAEQI3qnBnwrKO0ydVqzS7N1AX5ibz6cNs7dOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eayu1VH51lfZ53nccdjmanQ1yptijzdV3BsCNtW45JAeEp8jeJFU8n3XchQRk0mV4
         v2ttpAJr6+Q4glS8WtbkjVo1B+qvhkFSB877tctm7sv/WcX7Ct9SJBSoBBLpzY3CHu
         pY8ccMrZFOSkWDU5CKw890WQnIZLbNdP4XUgAgMI=
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
Subject: [PATCH 4/7] PCI/PM: Run resume fixups before disabling wakeup events
Date:   Mon, 14 Oct 2019 18:00:13 -0500
Message-Id: <20191014230016.240912-5-helgaas@kernel.org>
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

pci_pm_resume() and pci_pm_restore() call pci_pm_default_resume(), which
runs resume fixups before disabling wakeup events:

  static void pci_pm_default_resume(struct pci_dev *pci_dev)
  {
    pci_fixup_device(pci_fixup_resume, pci_dev);
    pci_enable_wake(pci_dev, PCI_D0, false);
  }

pci_pm_runtime_resume() does both of these, but in the opposite order:

  pci_enable_wake(pci_dev, PCI_D0, false);
  pci_fixup_device(pci_fixup_resume, pci_dev);

We should always use the same ordering unless there's a reason to do
otherwise.  Change pci_pm_runtime_resume() to call pci_pm_default_resume()
instead of open-coding this, so the fixups are always done before disabling
wakeup events.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-driver.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 0c3086793e4e..55acb658273f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1345,8 +1345,7 @@ static int pci_pm_runtime_resume(struct device *dev)
 		return 0;
 
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
-	pci_enable_wake(pci_dev, PCI_D0, false);
-	pci_fixup_device(pci_fixup_resume, pci_dev);
+	pci_pm_default_resume(pci_dev);
 
 	if (pm && pm->runtime_resume)
 		rc = pm->runtime_resume(dev);
-- 
2.23.0.700.g56cf767bdb-goog

