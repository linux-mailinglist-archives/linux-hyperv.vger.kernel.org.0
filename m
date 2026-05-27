Return-Path: <linux-hyperv+bounces-11259-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFToJSdwF2pDFAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11259-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:28:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E91845EAAAE
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90D9D3021712
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 22:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A213A6B9A;
	Wed, 27 May 2026 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhcHP1tt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45690F507;
	Wed, 27 May 2026 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920932; cv=none; b=V0kEg6o9c9iZdOv6ShkrObzq1NmqKrScLm14CHXScMVbeTEvUbBcj4R6jHO+zl7GNY3kE3AK8XxGBrlkhVFUOt4jgwmSGfB4TsgO+BzZZ4D27T98DCePn0TTezV/dBGyEtqqFU5DOakKZEQ3HTKty19CqfNGbIuNQ1iC+NvVEpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920932; c=relaxed/simple;
	bh=L8JffQKblOXC4lXmbhrTtEu5hpagAryjHRh6Xbbc99Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhSizhQjtaulUUF0wLLJs5G2jU7TAZzvamS+kYwk7DVwaFBp/KHtdSIHlyFq7RoGsHM22qfk0+gDeHE9pyH+7RmamRoAeWy/u/JV6jhSh62XXCqq3xXYc9m5yRY3rCBNphsiJqFMS0MNHy7thQTDzfT6WObkar+97T0Bm4IUtTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhcHP1tt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB541F000E9;
	Wed, 27 May 2026 22:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779920930;
	bh=Jb6Q6hQVUT8zax1SuTEMDyTWykmKTV3TpEatC15S7U0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mhcHP1ttNk0+ImEAcl8/Hz9O5VkYrXb8YsRikhMJYRlo+2xRml31dnbUPT9zU9ZDl
	 VyICrXl3LD9GqyQGOGqQ23sqMV4WhxwuSx1IgpCNMlsee6T0nupTA0+cHE6I5qLhU3
	 mQc6rVIKEfMy9k7JmHR/uRg0x+L7qTaA/CsdIJANBCzPUC34TxmbwMU/qH3onXIKEr
	 o02XEBzXtjkT07NZfJn3HS8XmyUUCBeDkQ8n/tlG1I4yB0vsFdND1lFBjpTZjDLMeL
	 k6Sz6ovfKyDZVmcU9mNwSCNUIrj456drgk3Bpn//xwTQeYD9BK25N+ybT21dwL3fQj
	 aOUNAJatSQ+7g==
Date: Wed, 27 May 2026 15:28:49 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	longli@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhklinux@outlook.com,
	matthew.ruffell@canonical.com, johansen@templeofstupid.com,
	hargar@linux.microsoft.com, stable@vger.kernel.org,
	Krister Johansen <kjlx@templeofstupid.com>
Subject: Re: [PATCH v3] Drivers: hv: vmbus: Improve the logic of reserving
 fb_mmio on Gen2 VMs
Message-ID: <20260527222849.GD3518940@liuwe-devbox-debian-v2.local>
References: <20260507212838.448891-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507212838.448891-1-decui@microsoft.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11259-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,vger.kernel.org,outlook.com,canonical.com,templeofstupid.com,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,liuwe-devbox-debian-v2.local:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,canonical.com:email]
X-Rspamd-Queue-Id: E91845EAAAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 07, 2026 at 02:28:38PM -0700, Dexuan Cui wrote:
> If vmbus_reserve_fb() in the kdump/kexec kernel fails to properly reserve
> the framebuffer MMIO range (which is below 4GB) due to a Gen2 VM's
> screen.lfb_base being zero [1], there is an MMIO conflict between the
> drivers hyperv-drm and pci-hyperv: when the driver pci-hyperv's
> hv_allocate_config_window() calls vmbus_allocate_mmio() to get an
> MMIO range, typically it gets a 32-bit MMIO range that overlaps with the
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
> to only reserve 8MB: let's always reserve half of the space below 4GB,
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
> host might treat the beginning of the low MMIO range specially [3]. BTW,
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
> to the allocated MMIO range -- in this case, there can still be issues [4]
> which can't be easily fixed: any possible affected Gen1 users would have
> to use a resolution whose framebuffer size is <= 64MB, or switch to Gen2
> VMs.
> 
> [1] https://lore.kernel.org/all/SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@SA1PR21MB6921.namprd21.prod.outlook.com/
> [2] https://lore.kernel.org/all/SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1PR21MB6921.namprd21.prod.outlook.com/
> [3] https://lore.kernel.org/all/SN6PR02MB415726B17D5A6027CD1717E8D4342@SN6PR02MB4157.namprd02.prod.outlook.com/
> [4] https://lore.kernel.org/all/SA1PR21MB69213486F821CA5A2C793C81BF342@SA1PR21MB6921.namprd21.prod.outlook.com/
> 
> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
> CC: stable@vger.kernel.org
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Krister Johansen <kjlx@templeofstupid.com>
> Tested-by: Matthew Ruffell <matthew.ruffell@canonical.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Applied. Thanks.

