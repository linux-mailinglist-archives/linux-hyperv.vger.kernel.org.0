Return-Path: <linux-hyperv+bounces-9940-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGj5LUz/zmlIsQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9940-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 01:44:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C255938F48D
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 01:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D12593013711
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 23:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A863845B5;
	Thu,  2 Apr 2026 23:44:07 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBD236B043;
	Thu,  2 Apr 2026 23:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775173447; cv=none; b=RhCPKo/BdFXkGGVKBuZ6xqOj6FzzQNw4tIh2AQss6qNeuyDrOOGiywk4YyjgEQy722dKQTN0l1+Ipaucs7TgrmBuknjpsM1cImAUY8chaCrVhSIgHhIQB6ychYz6CrusFE4WakbTEbCgOzWZbDfSjlKf8dXC1QM3EwTH/z2LrII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775173447; c=relaxed/simple;
	bh=t3GTXZP+Qx6sXooMZV8eBLTayxLudqq1llwsAayvvpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eRwaH7jFqLEs7FIb4Yl8OrzEjywMPAvm8WVcDDoL5JWmJ/Oi7ZViW1XmSHLpa4ejKo3LPjSx8ODi4K0KOsluvzkRVbIBLXqx5esqmk/FN/zWNtKYUdeRBy/TR++HvAF/60PTkon/8V2f1xuRGDHNrAKlX00jy+ccEqE2rcHFdoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1009)
	id A64F420B7001; Thu,  2 Apr 2026 16:44:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A64F420B7001
From: Dexuan Cui <decui@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	jakeo@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhklinux@outlook.com,
	matthew.ruffell@canonical.com,
	kjlx@templeofstupid.com
Cc: Krister Johansen <johansen@templeofstupid.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] PCI: hv: Allocate MMIO from above 4GB for the config window
Date: Thu,  2 Apr 2026 16:43:13 -0700
Message-ID: <20260402234313.2490779-1-decui@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,google.com,vger.kernel.org,outlook.com,canonical.com,templeofstupid.com];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-9940-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FROM_NEQ_ENVFROM(0.00)[decui@microsoft.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,canonical.com:email]
X-Rspamd-Queue-Id: C255938F48D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There has been a longstanding MMIO conflict between the pci_hyperv
driver's config_window (see hv_allocate_config_window()) and the
hyperv_drm (or hyperv_fb) driver (see hyperv_setup_vram()): typically
both get MMIO from the low MMIO range below 4GB; this is not an issue
in the normal kernel since the VMBus driver reserves the framebuffer
MMIO range in vmbus_reserve_fb(), so the drm driver's hyperv_setup_vram()
can always get the reserved framebuffer MMIO; however, a Gen2 VM's
kdump kernel can fail to reserve the framebuffer MMIO in
vmbus_reserve_fb() because the screen_info.lfb_base is zero in the
kdump kernel due to several possible reasons (see the Link below for
more details):

1) on ARM64, the two syscalls (KEXEC_LOAD, KEXEC_FILE_LOAD) don't
initialize the screen_info.lfb_base for the kdump kernel;

2) on x86-64, the KEXEC_FILE_LOAD syscall initializes kdump kernel's
screen_info.lfb_base, but the KEXEC_LOAD syscall doesn't really do that
when the hyperv_drm driver loads, because the user-space kexec-tools
(i.e. the program 'kexec') doesn't recognize the hyperv_drm driver
(let's ignore the behavior of kexec-tools of very old versions).

When vmbus_reserve_fb() fails to reserve the framebuffer MMIO in the
kdump kernel, if pci_hyperv in the kdump kernel loads before hyperv_drm
loads, pci_hyperv's vmbus_allocate_mmio() gets the framebuffer MMIO
and tries to use it, but since the host thinks that the MMIO range is
still in use by hyperv_drm, the host refuses to accept the MMIO range
as the config window, and pci_hyperv's hv_pci_enter_d0() errors out,
e.g. an error can be "PCI Pass-through VSP failed D0 Entry with status
c0370048".

Typically, this pci_hyperv error in the kdump kernel was not fatal in
the past because the kdump kernel typically doesn't rely on pci_hyperv,
i.e. the root file system is on a VMBus SCSI device.

Now, a VM on Azure can boot from NVMe, i.e. the root file system can be
on a NVMe device, which depends on pci_hyperv. When the error occurs,
the kdump kernel fails to boot up since no root file system is detected.

Fix the MMIO conflict by allocating MMIO above 4GB for the config_window,
so it won't conflict with hyperv_drm's MMIO, which should be below the
4GB boundary. The size of config_window is small: it's only 8KB per PCI
device, so there should be sufficient MMIO space available above 4GB.

Note: we still need to figure out how to address the possible MMIO
conflict between hyperv_drm and pci_hyperv in the case of 32-bit PCI
MMIO BARs, but that's of low priority because all PCI devices available
to a Linux VM on Azure or on a modern host should use 64-bit BARs and
should not use 32-bit BARs -- I checked Mellanox VFs, MANA VFs, NVMe
devices, and GPUs in Linux VMs on Azure, and found no 32-bit BARs.

Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
Link: https://lore.kernel.org/all/SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@SA1PR21MB6921.namprd21.prod.outlook.com/
Tested-by: Matthew Ruffell <matthew.ruffell@canonical.com>
Tested-by: Krister Johansen <johansen@templeofstupid.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
---

Changes since v1:
    Updated the commit message and the comment to better explain
    why screen_info.lfb_base can be 0 in the kdump kernel.

    No code change since v1.


 drivers/pci/controller/pci-hyperv.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 2c7a406b4ba8..1a79334ea9f4 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3403,9 +3403,26 @@ static int hv_allocate_config_window(struct hv_pcibus_device *hbus)
 
 	/*
 	 * Set up a region of MMIO space to use for accessing configuration
-	 * space.
+	 * space. Use the high MMIO range to not conflict with the hyperv_drm
+	 * driver (which normally gets MMIO from the low MMIO range) in the
+	 * kdump kernel of a Gen2 VM, which may fail to reserve the framebuffer
+	 * MMIO range in vmbus_reserve_fb() due to screen_info.lfb_base being
+	 * zero in the kdump kernel:
+	 *
+	 * on ARM64, the two syscalls (KEXEC_LOAD, KEXEC_FILE_LOAD) don't
+	 * initialize the screen_info.lfb_base for the kdump kernel;
+	 *
+	 * on x86-64, the KEXEC_FILE_LOAD syscall initializes kdump kernel's
+	 * screen_info.lfb_base (see bzImage64_load() -> setup_boot_parameters())
+	 * but the KEXEC_LOAD syscall doesn't really do that when the hyperv_drm
+	 * driver loads, because the user-space program 'kexec' doesn't
+	 * recognize hyperv_drm: see the function setup_linux_vesafb() in the
+	 * kexec-tools.git repo. Note: old versions of kexec-tools, e.g.
+	 * v2.0.18, initialize screen_info.lfb_base if the hyperv_fb driver
+	 * loads, but hyperv_fb is deprecated and has been removed from the
+	 * mainline kernel.
 	 */
-	ret = vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, 0, -1,
+	ret = vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, SZ_4G, -1,
 				  PCI_CONFIG_MMIO_LENGTH, 0x1000, false);
 	if (ret)
 		return ret;
-- 
2.43.0


