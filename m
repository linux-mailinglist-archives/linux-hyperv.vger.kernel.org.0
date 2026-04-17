Return-Path: <linux-hyperv+bounces-10204-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNpkAHGX4mlS7wAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10204-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2026 22:26:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 389AD41E7BA
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2026 22:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93B54303204B
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2026 20:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAFF2EFDA4;
	Fri, 17 Apr 2026 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="E9oCxsqk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32142DC77F
	for <linux-hyperv@vger.kernel.org>; Fri, 17 Apr 2026 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776457455; cv=none; b=c++78ByE1duhS2K73+wVX/esjeue5NGPyjsolLuzP9tG/+8yqcAFpdCPOPCwbNNEhSPkNC2YEIC5RdLtYv4v6G7ALaY+TrfsKTvhjqAwr2C0xyfqsUA7RiDp6+pxOGUekxCw2CmnsBjLpmR0iHukCLu/8ZORylugdmghdxUPyww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776457455; c=relaxed/simple;
	bh=r+dgAylW4MBqoMdsspuP2/8KF3Es0vUNdRyadGUudIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIUaw3stH6VDnBCuoHjExlpC8qz0LxbdDUg00TJDPdrX9IxvjzMwIkrkp8+0cO9mI6zAr/8VJ2FbaOR4b4BR+SLgXPZurKHribsx3jHuPXNS67GX9PQOOZZes/xe+UJvKl7LIVIg5vhghapTpi4ncYw7L2miGfeudBfyg/XqJFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=E9oCxsqk; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
Date: Fri, 17 Apr 2026 13:24:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=key1; t=1776457450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jSZ0x56idMTe5CHt/WVa/3C6qz89U2/0YVG7mwJSoeE=;
	b=E9oCxsqkYWleeFWyQpnHXOOXavAM1aj4uTIyDuoE+8Xe5iIFQBR2vL6s/By/2FD8HEqgW1
	hAIFtCr7rKRlqvwoM002198vvgoDIp5EM3tMV+qPFrxG65Vnbaz8qDibca84wNmLGcd0PD
	1rTHolmyzHi351AB2r2+CE94GKQM7BGM7N83csjs8Y5QAaVbseWdm+/gkDfRokHB6en9BA
	AtrSXQsKyGEWkp1jt215FkXO1LDg2SwufRgYwL28vgj0XMzD7L9J4nG6kBOFnmAj9LLiz0
	O3WhQ23fvZw6Z8QhzyVeM0jVaR4IsN3MH4a4FjcvRHkOi8yEW/fMzZE/ADFp/Q==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Krister Johansen <kjlx@templeofstupid.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	longli@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhklinux@outlook.com,
	matthew.ruffell@canonical.com, stable@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Improve the logc of reserving
 fb_mmio on Gen2 VMs
Message-ID: <aeKW4ESwsoK5La-t@templeofstupid.com>
References: <20260416183529.838321-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416183529.838321-1-decui@microsoft.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[templeofstupid.com,none];
	R_DKIM_ALLOW(-0.20)[templeofstupid.com:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,vger.kernel.org,outlook.com,canonical.com];
	TAGGED_FROM(0.00)[bounces-10204-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[templeofstupid.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kjlx@templeofstupid.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,templeofstupid.com:email,templeofstupid.com:dkim,templeofstupid.com:mid]
X-Rspamd-Queue-Id: 389AD41E7BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 11:35:29AM -0700, Dexuan Cui wrote:
> If vmbus_reserve_fb() in the kdump kernel fails to properly reserve the
> framebuffer MMIO range due to a Gen2 VM's screen.lfb_base being zero [1],
> there is an MMIO conflict between the drivers hyperv_drm and pci-hyperv.
> This is especially an issue if pci-hyperv is built-in and hyperv_drm is
> built as a module. Consequently, the kdump kernel fails to detect PCI
> devices via pci-hyperv, and may fail to mount the root file system,
> which may reside in a NVMe disk.
> 
> On Gen2 VMs, if the screen.lfb_base is 0 in the kdump kernel, fall
> back to the low MMIO base, which should be equal to the framebuffer
> MMIO base (Tested on x64 Windows Server 2016, and on x64 and ARM64 Windows
> Server 2025 and on Azure) [2]. In the first kernel, screen.lfb_base
> is not 0; if the user specifies a high resolution, it's not enough to
> only reserve 8MB: in this case, reserve half of the space below 4GB, but
> cap the reservation to 128MB, which is the required framebuffer size of
> the highest resolution 7680*4320 supported by Hyper-V.
> 
> Add the cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) check, because a CoCo
> VM (i.e. Confidential VM) on Hyper-V doesn't have any framebuffer
> device, so there is no need to reserve any MMIO for it.
> 
> While at it, fix the comparison "end > VTPM_BASE_ADDRESS" by changing
> the > to >=. Here the 'end' is an inclusive end (typically, it's
> 0xFFFF_FFFF).
> 
> [1] https://lore.kernel.org/all/SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@SA1PR21MB6921.namprd21.prod.outlook.com/
> [2] https://lore.kernel.org/all/SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1PR21MB6921.namprd21.prod.outlook.com/
> 
> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
> CC: stable@vger.kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
 
Thanks for the updated patch.  I tested this on the arm64 instances that
had been failing and was able to confirm that without it present the
failure still occurred, but with the new patch networking was able to
attach correctly in the dump environment and kdumps were successful.

Tested-by: Krister Johansen <kjlx@templeofstupid.com>

-K

