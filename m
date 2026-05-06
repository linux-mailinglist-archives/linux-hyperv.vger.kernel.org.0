Return-Path: <linux-hyperv+bounces-10657-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBgcDfnK+2lsEwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10657-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 01:12:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4944E176D
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 01:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1AB83009F27
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 May 2026 23:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26133B8945;
	Wed,  6 May 2026 23:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="WJzGvsI0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E385362156
	for <linux-hyperv@vger.kernel.org>; Wed,  6 May 2026 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778109170; cv=none; b=eqBiCU5P70tm+s9fJaCX+0U1KgEAGlO8/pXq5/zSkRQmDc0oip7AA/jsVPkkPm44CcJAcHRvYgogJmV8qX+Mk6BCzSYsxyTZ9Ov/rM6a/cFjQn4QHJcQChTDR7wSKvk7USKKUmJlXxtxVLEE586l/VELywlSPg1WE8viFHLpBLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778109170; c=relaxed/simple;
	bh=oMuo8Rnq8w2p7inyiM35ATP0XNTOcpCTuRYP0cYEHys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUknrTDx/hkyrNUUE5HKPRrntckfFu22szOcy4m0o+kASH09MkDCyNaL/6tN8V4qwEiSg2wo34k+wkpmapoNCS7vHOGHK7DxX4BkJwfaOhWmj+J7k6VLKkF2cFZkIyhTMrPLEznqR0BiZc+D8hs2qeyxXoJ4HW5TcqFl1lrOOzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=WJzGvsI0; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
Date: Wed, 6 May 2026 16:12:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=key1; t=1778109166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPryY3JxDMD7g2hwNJDxssCyQbAmb4ZMfyj6+Mo6obc=;
	b=WJzGvsI0WczjYmCyTpUjd8mTU9HDgch3azN6cpi0mh82FakQab2YISb2gDHMoOqc+tmhCA
	/Di6qMZ6wyYWcEidT/eiavcLkAWh6Wv/fhiOLfkFpFR0f+TbETNElpabNVeExEV6OIqMG+
	OXs8nSI6dtHudDEw91vnaRflAs2k2HljWqXFLYc4t0xnXL5VdCgr0c3EfdgA0CjXctZYla
	NAmrU0faKfIT5E009mjFvcryoHcE3RF1rovFT47TlCb4K/MuGG6tGLU7fC2Phf460UnGfp
	xm4eKUXgKj5sBdmm2PeTul3mOtYp4w9vxYEWKI5Bxt5oF5k5IoPLK1zawcn1PA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Krister Johansen <kjlx@templeofstupid.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	longli@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhklinux@outlook.com,
	matthew.ruffell@canonical.com, hargar@linux.microsoft.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Drivers: hv: vmbus: Improve the logic of reserving
 fb_mmio on Gen2 VMs
Message-ID: <afvK6A0W21PVJpUE@templeofstupid.com>
References: <20260505004846.193441-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505004846.193441-1-decui@microsoft.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 2E4944E176D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[templeofstupid.com,none];
	R_DKIM_ALLOW(-0.20)[templeofstupid.com:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,vger.kernel.org,outlook.com,canonical.com,linux.microsoft.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[templeofstupid.com:+];
	TAGGED_FROM(0.00)[bounces-10657-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kjlx@templeofstupid.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, May 04, 2026 at 05:48:46PM -0700, Dexuan Cui wrote:
> If vmbus_reserve_fb() in the kdump/kexec kernel fails to properly reserve
> the framebuffer MMIO range (which is below 4GB) due to a Gen2 VM's
> screen.lfb_base being zero [1], there is an MMIO conflict between the
> drivers hyperv-drm and pci-hyperv: when the driver pci-hyperv's
> hv_pci_allocate_bridge_windows() calls vmbus_allocate_mmio() to get a
> 32-bit MMIO range, it may get an MMIO range that overlaps with the
> framebuffer MMIO range, and later hv_pci_enter_d0() fails with an
> error message "PCI Pass-through VSP failed D0 Entry with status" since
> the host thinks that PCI devices must not use MMIO space that the
> host has assigned to the framebuffer.
> 
> This is especially an issue if pci-hyperv is built-in and hyperv-drm is
> built as a module. Consequently, the kdump/kexec kernel fails to detect
> PCI devices via pci-hyperv, and may fail to mount the root file system,
> which may reside in a NVMe disk. The issue described here has existed
> for SR-IOV VF NICs since day one of the pci-hyperv driver, and has been
> worked around on x64 when possible. With the recent introduction of
> ARM64 VMs that boot from NVMe, there is no workaround, so we need a
> formal fix.
> 
> On Gen2 VMs, if the screen.lfb_base is 0 in the kdump/kexec kernel [1],
> fall back to the low MMIO base, which should be equal to the framebuffer
> MMIO base [2] (the statement is true according to my testing on x64
> Windows Server 2016, and on x64 and ARM64 Windows Server 2025 and on
> Azure. I checked with the Hyper-V team and they said the statement should
> continue to be true for Gen2 VMs). In the first kernel, screen.lfb_base
> is not 0; if the user specifies a very high resolution, it's not enough
> to only reserve 8MB: in this case, reserve half of the space below 4GB,
> but cap the reservation to 128MB, which is the required framebuffer size
> of the highest resolution 7680*4320 supported by Hyper-V.
> 
> While at it, fix the comparison "end > VTPM_BASE_ADDRESS" by changing
> the > to >=. Here the 'end' is an inclusive end (typically, it's
> 0xFFFF_FFFF for the low MMIO range).
> 
> Note: vmbus_reserve_fb() now also reserves an MMIO range at the beginning
> of the low MMIO range on CVMs, which have no framebuffers (the
> 'screen.lfb_base' in vmbus_reserve_fb() is 0 for CVMs), just in case the
> host might treat the beginning of the low MMIO range specially [4]. BTW,
> the OpenHCL kernel is not affected by the change, because that kernel
> boots with DeviceTree rather than ACPI (so vmbus_reserve_fb() won't run
> there), and there is no framebuffer device for that kernel.
> 
> Note: normally Gen1 VMs don't have the MMIO conflict issue because the
> framebuffer MMIO range (which is hardcoded to base=4GB-128MB and
> size=64MB for Gen1 VMs by the host) is always reported via the legacy PCI
> graphics device's BAR, so the kdump/kexec kernel can reserve the 64MB
> MMIO range; however, if the VM is configured to use a very high resolution
> and the required framebuffer size exceeds 64MB (AFAIK, in practice, this
> isn't a typical configuration by users), the hyperv-drm driver may need to
> allocate an MMIO range above 4GB and change the framebuffer MMIO location
> to the allocated MMIO range -- in this case, there can still be issues [3]
> which can't be easily fixed: any possible affected Gen1 users would have
> to use a resolution whose framebuffer size is <= 64MB, or switch to Gen2
> VMs.
> 
> [1] https://lore.kernel.org/all/SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@SA1PR21MB6921.namprd21.prod.outlook.com/
> [2] https://lore.kernel.org/all/SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1PR21MB6921.namprd21.prod.outlook.com/
> [3] https://lore.kernel.org/all/SA1PR21MB69213486F821CA5A2C793C81BF342@SA1PR21MB6921.namprd21.prod.outlook.com/
> [4] https://lore.kernel.org/all/SN6PR02MB415726B17D5A6027CD1717E8D4342@SN6PR02MB4157.namprd02.prod.outlook.com/
> 
> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
> CC: stable@vger.kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
 
Thanks for the updated patch.  I re-tested this on a D2pdsv6 and was
able to confirm that without the patch the NIC drivers in the dump
environment didn't attach because of a PCI conflict. With the patch the
drivers attached and it was possible to successfully collect a kdump.

Tested-by: Krister Johansen <kjlx@templeofstupid.com>

-K

