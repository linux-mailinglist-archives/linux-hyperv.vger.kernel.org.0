Return-Path: <linux-hyperv+bounces-10706-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ2zHzEE/WmIWgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10706-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 23:29:21 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F0E4EF45C
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 23:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECC713017516
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 21:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC77345736;
	Thu,  7 May 2026 21:29:18 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F32DF6F4;
	Thu,  7 May 2026 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189358; cv=none; b=bkIz4QgVzpllPL/FxHYxc5ujOgVosmmQ6unf36Nfsyo1rlTb8W61Fjq6jjJSZ0avJxVXDD+A9cR4iNTFw+KUc4ceisu05LBNbpxzJ+RsCuVrkrw+INDYjgCfuR3DblZ2PshmJ8ECmE3ZkAre2uQyJ5I1zCXJlGHnjrk2FK9CUpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189358; c=relaxed/simple;
	bh=3C/PBMFP4+dveG4Us5jGD12cNJJvy0fXewEZchMu2X0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zud+9WQMRmIun7ABrbHHtAJt32ihue6hsdb8+btBMtlw5ATlVJHiuwhuqg1fBEV3BlUrqaCYD1KUcTLRwuoqDGLQhyOfaVZ1acRqTRZZidtYxnpKVfCZ/0U7pjY/yuFUvh23tCrl/LdDnzlg33duMcdFtgG0UCQgVvRV9bBKtuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1009)
	id 5A27520B7165; Thu,  7 May 2026 14:29:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A27520B7165
From: Dexuan Cui <decui@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhklinux@outlook.com,
	matthew.ruffell@canonical.com,
	johansen@templeofstupid.com,
	hargar@linux.microsoft.com
Cc: stable@vger.kernel.org,
	Krister Johansen <kjlx@templeofstupid.com>
Subject: [PATCH v3] Drivers: hv: vmbus: Improve the logic of reserving fb_mmio on Gen2 VMs
Date: Thu,  7 May 2026 14:28:38 -0700
Message-ID: <20260507212838.448891-1-decui@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E7F0E4EF45C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,vger.kernel.org,outlook.com,canonical.com,templeofstupid.com,linux.microsoft.com];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-10706-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[decui@microsoft.com,linux-hyperv@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.930];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,canonical.com:email]
X-Rspamd-Action: no action

If vmbus_reserve_fb() in the kdump/kexec kernel fails to properly reserve
the framebuffer MMIO range (which is below 4GB) due to a Gen2 VM's
screen.lfb_base being zero [1], there is an MMIO conflict between the
drivers hyperv-drm and pci-hyperv: when the driver pci-hyperv's
hv_allocate_config_window() calls vmbus_allocate_mmio() to get an
MMIO range, typically it gets a 32-bit MMIO range that overlaps with the
framebuffer MMIO range, and later hv_pci_enter_d0() fails with an
error message "PCI Pass-through VSP failed D0 Entry with status" since
the host thinks that PCI devices must not use MMIO space that the
host has assigned to the framebuffer.

This is especially an issue if pci-hyperv is built-in and hyperv-drm is
built as a module. Consequently, the kdump/kexec kernel fails to detect
PCI devices via pci-hyperv, and may fail to mount the root file system,
which may reside in a NVMe disk. The issue described here has existed
for SR-IOV VF NICs since day one of the pci-hyperv driver, and has been
worked around on x64 when possible. With the recent introduction of
ARM64 VMs that boot from NVMe, there is no workaround, so we need a
formal fix.

On Gen2 VMs, if the screen.lfb_base is 0 in the kdump/kexec kernel [1],
fall back to the low MMIO base, which should be equal to the framebuffer
MMIO base [2] (the statement is true according to my testing on x64
Windows Server 2016, and on x64 and ARM64 Windows Server 2025 and on
Azure. I checked with the Hyper-V team and they said the statement should
continue to be true for Gen2 VMs). In the first kernel, screen.lfb_base
is not 0; if the user specifies a very high resolution, it's not enough
to only reserve 8MB: let's always reserve half of the space below 4GB,
but cap the reservation to 128MB, which is the required framebuffer size
of the highest resolution 7680*4320 supported by Hyper-V.

While at it, fix the comparison "end > VTPM_BASE_ADDRESS" by changing
the > to >=. Here the 'end' is an inclusive end (typically, it's
0xFFFF_FFFF for the low MMIO range).

Note: vmbus_reserve_fb() now also reserves an MMIO range at the beginning
of the low MMIO range on CVMs, which have no framebuffers (the
'screen.lfb_base' in vmbus_reserve_fb() is 0 for CVMs), just in case the
host might treat the beginning of the low MMIO range specially [3]. BTW,
the OpenHCL kernel is not affected by the change, because that kernel
boots with DeviceTree rather than ACPI (so vmbus_reserve_fb() won't run
there), and there is no framebuffer device for that kernel.

Note: normally Gen1 VMs don't have the MMIO conflict issue because the
framebuffer MMIO range (which is hardcoded to base=4GB-128MB and
size=64MB for Gen1 VMs by the host) is always reported via the legacy PCI
graphics device's BAR, so the kdump/kexec kernel can reserve the 64MB
MMIO range; however, if the VM is configured to use a very high resolution
and the required framebuffer size exceeds 64MB (AFAIK, in practice, this
isn't a typical configuration by users), the hyperv-drm driver may need to
allocate an MMIO range above 4GB and change the framebuffer MMIO location
to the allocated MMIO range -- in this case, there can still be issues [4]
which can't be easily fixed: any possible affected Gen1 users would have
to use a resolution whose framebuffer size is <= 64MB, or switch to Gen2
VMs.

[1] https://lore.kernel.org/all/SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@SA1PR21MB6921.namprd21.prod.outlook.com/
[2] https://lore.kernel.org/all/SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1PR21MB6921.namprd21.prod.outlook.com/
[3] https://lore.kernel.org/all/SN6PR02MB415726B17D5A6027CD1717E8D4342@SN6PR02MB4157.namprd02.prod.outlook.com/
[4] https://lore.kernel.org/all/SA1PR21MB69213486F821CA5A2C793C81BF342@SA1PR21MB6921.namprd21.prod.outlook.com/

Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
CC: stable@vger.kernel.org
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Krister Johansen <kjlx@templeofstupid.com>
Tested-by: Matthew Ruffell <matthew.ruffell@canonical.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes since v1 (https://lore.kernel.org/all/20260416183529.838321-1-decui@microsoft.com/):
  Fixed a typo in the subject: s/logc/logic/.

  In the commit message, better explained fb_mmio_base is equal to
  low_mmio_base for Gen2 VMs.

  Addressed Michael Kelley's comments:

    In the commit message:
         Changed the "kdump" to "kdump/kexec" since the described
         issue is applicable to both kdump and kexec.

         Provided more detail about the MMIO conflict.

         Described an scenario where Gen1 VMs can also be affected.

    Added a pr_warn() in vmbus_reserve_fb() in case the 'start' is 0.

    Dropped the CVM check in vmbus_reserve(), meaning vmbus_reserve_fb()
    also reserves MMIO for CVMs.

  Changed "low_mmio_base >= SZ_4G" to "upper_32_bits(low_mmio_base)"
  to avoid a compilation warning for the i386 build.

  Changed "0x%pa" to "%pa", because %pa already adds a "0x" prefix.
  

Hi Krister, Matthew, sorry -- I'm not adding your Tested-by's since
the code changed, though the change is small. If the v2 looks good
to Michael, please test the patch again. 

Hi Hardik, I'm not adding your Reviewed-by since the patch changed.
Please review the v2. 


Changes since v2 (https://lore.kernel.org/all/20260505004846.193441-1-decui@microsoft.com/):
    Fixed the commit message:
        hv_pci_allocate_bridge_windows() -> hv_allocate_config_window()

    Changed the "kdump" in the comment to "kdump/kexec or CVM" [Michael Kelley]

    Fixed the order of the "[3]" and "[4]" in the commit message.

    Added Krister's Tested-by.
    Added Matthew's Tested-by.
    Added Michael's Reviewed-by.

 drivers/hv/vmbus_drv.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index f0d0803d1e16..d73ac5c8dd04 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2327,8 +2327,8 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 		return AE_NO_MEMORY;
 
 	/* If this range overlaps the virtual TPM, truncate it. */
-	if (end > VTPM_BASE_ADDRESS && start < VTPM_BASE_ADDRESS)
-		end = VTPM_BASE_ADDRESS;
+	if (end >= VTPM_BASE_ADDRESS && start < VTPM_BASE_ADDRESS)
+		end = VTPM_BASE_ADDRESS - 1;
 
 	new_res->name = "hyperv mmio";
 	new_res->flags = IORESOURCE_MEM;
@@ -2395,6 +2395,7 @@ static void vmbus_mmio_remove(void)
 static void __maybe_unused vmbus_reserve_fb(void)
 {
 	resource_size_t start = 0, size;
+	resource_size_t low_mmio_base;
 	struct pci_dev *pdev;
 
 	if (efi_enabled(EFI_BOOT)) {
@@ -2402,6 +2403,24 @@ static void __maybe_unused vmbus_reserve_fb(void)
 		if (IS_ENABLED(CONFIG_SYSFB)) {
 			start = sysfb_primary_display.screen.lfb_base;
 			size = max_t(__u32, sysfb_primary_display.screen.lfb_size, 0x800000);
+
+			low_mmio_base = hyperv_mmio->start;
+			if (!low_mmio_base || upper_32_bits(low_mmio_base) ||
+			    (start && start < low_mmio_base)) {
+				pr_warn("Unexpected low mmio base %pa\n", &low_mmio_base);
+			} else {
+				/*
+				 * If the kdump/kexec or CVM kernel's lfb_base
+				 * is 0, fall back to the low mmio base.
+				 */
+				if (!start)
+					start = low_mmio_base;
+				/*
+				 * Reserve half of the space below 4GB for high
+				 * resolutions, but cap the reservation to 128MB.
+				 */
+				size = min((SZ_4G - start) / 2, SZ_128M);
+			}
 		}
 	} else {
 		/* Gen1 VM: get FB base from PCI */
@@ -2422,8 +2441,10 @@ static void __maybe_unused vmbus_reserve_fb(void)
 		pci_dev_put(pdev);
 	}
 
-	if (!start)
+	if (!start) {
+		pr_warn("Unexpected framebuffer mmio base of zero\n");
 		return;
+	}
 
 	/*
 	 * Make a claim for the frame buffer in the resource tree under the
@@ -2433,6 +2454,8 @@ static void __maybe_unused vmbus_reserve_fb(void)
 	 */
 	for (; !fb_mmio && (size >= 0x100000); size >>= 1)
 		fb_mmio = __request_region(hyperv_mmio, start, size, fb_mmio_name, 0);
+
+	pr_info("hv_mmio=%pR,%pR fb=%pR\n", hyperv_mmio, hyperv_mmio->sibling, fb_mmio);
 }
 
 /**
-- 
2.34.1


