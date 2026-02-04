Return-Path: <linux-hyperv+bounces-8700-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EtcD0/ngmlTegMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8700-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 07:29:35 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AC0E2549
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 07:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98BFF3013277
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 06:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CD637F11A;
	Wed,  4 Feb 2026 06:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDBA2RIU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F29B37F0F4;
	Wed,  4 Feb 2026 06:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770186570; cv=none; b=fcI1RzF9tgvL1cpJJwJJJwsVvEjMOXR2d0HEX/DOCw7bxBCZWR1wCzeKWVcR/jvKxUrj6SiQfIlpPuTqgL4eTTu1Bn87rHPzOVJMe4uGXXR/f0dqhyQ2sSW49MC0zCtiTrUwlhoshSdgW+4YfIlBAE+3jDnt25e3n8SD0vbOgr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770186570; c=relaxed/simple;
	bh=7AKbzS4TOkGFMBCClG/vjG+fOYrVhpVSPxQ5JLd+dZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESTz89Cbjb1zrIpNGAF4znH/m7ZjFiDxyJ2yH9EH/CwjYRE4gP95duXuRgIZgthg293Vn6ni3DStoIFKfQ8WXoDsdOVMxMPi1/KI4erjNeQKfDPELDKxSolaOAFlbsT162R3+9wiabXm9JiT2OnApunAfWWFktoEqLqsFbaOD1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDBA2RIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFADAC4CEF7;
	Wed,  4 Feb 2026 06:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770186570;
	bh=7AKbzS4TOkGFMBCClG/vjG+fOYrVhpVSPxQ5JLd+dZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDBA2RIUNvXy0GhWIPC/olWucOCr10nxmU9/p/9zYpkSdwwb7ocjZP6LmJlYc+L6/
	 SYs5VRmOJIwj0PMVycEIACTjNLU8jN9NVzpGd3z0/qXr0JnH9iZlrZOq1od12MXDE3
	 ICv+cCBTadQbejhFnRB7Q+GLs8JNW/kCqv0gJOkxoDAMkSBJKkqqE5YZSBz1wa10Q/
	 pLdkSbZAhgnJxFHxc+w30xr4SVmYFlzC1Kbicm8gtZaWN6Z4g09T7RTox0RYvEBimq
	 vaJXMzZc+IvvK9CiljUgoD73VtSC/nPK4MZ62koOFro29CZto05Z/amkgW261j1sjT
	 O/aYPD8EKmUrA==
Date: Wed, 4 Feb 2026 06:29:28 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: Use memremap()/memunmap() instead of
 ioremap_cache()/iounmap()
Message-ID: <20260204062928.GI79272@liuwe-devbox-debian-v2.local>
References: <20260119033435.3358-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119033435.3358-1-mhklinux@outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TAGGED_FROM(0.00)[bounces-8700-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: B2AC0E2549
X-Rspamd-Action: no action

On Sun, Jan 18, 2026 at 07:34:35PM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> When running with a paravisor or in the root partition, the SynIC event and
> message pages are provided by the paravisor or hypervisor respectively,
> instead of being allocated by Linux. The provided pages are normal memory,
> but are outside of the physical address space seen by Linux. As such they
> cannot be accessed via the kernel's direct map, and must be explicitly
> mapped to a kernel virtual address.
> 
> Current code uses ioremap_cache() and iounmap() to map and unmap the pages.
> These functions are for use on I/O address space that may not behave as
> normal memory, so they generate or expect addresses with the __iomem
> attribute. For normal memory, the preferred functions are memremap() and
> memunmap(), which operate similarly but without __iomem.
> 
> At the time of the original work on CoCo VMs on Hyper-V, memremap() did not
> support creating a decrypted mapping, so ioremap_cache() was used instead,
> since I/O address space is always mapped decrypted. memremap() has since
> been enhanced to allow decrypted mappings, so replace ioremap_cache() with
> memremap() when mapping the event and message pages. Similarly, replace
> iounmap() with memunmap(). As a side benefit, the replacement cleans up
> 'sparse' warnings about __iomem mismatches.
> 
> The replacement is done to use the correct functions as long-term goodness
> and to clean up the sparse warnings. No runtime bugs are fixed.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601170445.JtZQwndW-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202512150359.fMdmbddk-lkp@intel.com/
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied to hyperv-next. Thanks.

