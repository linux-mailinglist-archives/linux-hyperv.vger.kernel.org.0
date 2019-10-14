Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F360D6BD3
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 01:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfJNXBy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Oct 2019 19:01:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfJNXBy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Oct 2019 19:01:54 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 952BD2133F;
        Mon, 14 Oct 2019 23:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571094113;
        bh=sLP8EMOf/N7TokrONFrqX6afHamtSzogwgMj4ILkroY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ce2ekGcUwC93LWPca74oS7cC+ApQ3uMMfWKQEU3S9Em7A4huSffnsw525WfIgrY6W
         6i412yWgRW/yhieR4PxzCet2fhnC3ZUBFIibZTq1z1kkDSWPrUal4H9x7Vgt9398tP
         a9YQahkdSNClqRUHf3CEDT2g749jdt3I12oCcm2Y=
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
Subject: [PATCH 2/7] PCI/PM: Correct pci_pm_thaw_noirq() documentation
Date:   Mon, 14 Oct 2019 18:00:11 -0500
Message-Id: <20191014230016.240912-3-helgaas@kernel.org>
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

According to the documentation, pci_pm_thaw_noirq() did not put the device
into the full-power state and restore its standard configuration registers.
This is incorrect, so update the documentation to match the code.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/power/pci.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
index 0e2ef7429304..1525c594d631 100644
--- a/Documentation/power/pci.rst
+++ b/Documentation/power/pci.rst
@@ -600,17 +600,17 @@ using the following PCI bus type's callbacks::
 
 respectively.
 
-The first of them, pci_pm_thaw_noirq(), is analogous to pci_pm_resume_noirq(),
-but it doesn't put the device into the full power state and doesn't attempt to
-restore its standard configuration registers.  It also executes the device
-driver's pm->thaw_noirq() callback, if defined, instead of pm->resume_noirq().
+The first of them, pci_pm_thaw_noirq(), is analogous to pci_pm_resume_noirq().
+It puts the device into the full power state and restores its standard
+configuration registers.  It also executes the device driver's pm->thaw_noirq()
+callback, if defined, instead of pm->resume_noirq().
 
 The pci_pm_thaw() routine is similar to pci_pm_resume(), but it runs the device
 driver's pm->thaw() callback instead of pm->resume().  It is executed
 asynchronously for different PCI devices that don't depend on each other in a
 known way.
 
-The complete phase it the same as for system resume.
+The complete phase is the same as for system resume.
 
 After saving the image, devices need to be powered down before the system can
 enter the target sleep state (ACPI S4 for ACPI-based systems).  This is done in
-- 
2.23.0.700.g56cf767bdb-goog

