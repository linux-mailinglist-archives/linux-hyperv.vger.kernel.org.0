Return-Path: <linux-hyperv+bounces-8701-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOWKHW3ngmlTegMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8701-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 07:30:05 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E23B4E2558
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 07:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C52C7300D932
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 06:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A871C366802;
	Wed,  4 Feb 2026 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXEuDQOJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A92264B0;
	Wed,  4 Feb 2026 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770186602; cv=none; b=oD1TFTAGEJFQgTHEIOenK4+9pdJW1Q5EzTax/z/ey+WsoKgMSldk3dn14VRLYNy1wRDBIxJWod4rdut5mJ81dmD121fyZHhx6TGi3xUre8KEvpPNSNFm1nV2oENsBS8zd1zWzS0+92sk8QzErkjdxnwA70+KjfFYBvI2bS8Ei8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770186602; c=relaxed/simple;
	bh=W6obNCQykAG10M15SMmvYCUFjcyCCfNa8V6CIY2hFuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gszRNfkMJBIAbZkrwSGMyDzArIzFzkEwxVzqrdUNV/bWMkiOqTDTxwUonKOX3e8MOe4JJfx8q18MHk9vpstSQypoLXSS7/NNQm7ELRWpo3UKTNSKZCE1AWALUIYuddkJA2Gu8hh1yxecDuaxmz97OlCxYmaDQmoevk2MWuYCYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXEuDQOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CA8C4CEF7;
	Wed,  4 Feb 2026 06:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770186602;
	bh=W6obNCQykAG10M15SMmvYCUFjcyCCfNa8V6CIY2hFuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CXEuDQOJgBjiRWjjNe8Hdgt14QSmjuLgVtCZxNsLfLLO9JMah8FbZf4jX5piIM8OI
	 35rQXNHgNtK7HiUmpuXumQJ7SJG1PUpJK+cyP/l5ez0K3VoRiIDZ5gbaGU7dMUO7wu
	 4Ol6vHJvMdqn7Bl0a1GxPrLgFyMJRjI7joD493pTUrnR/HfmjmPWYZ3KbihrIIF/aM
	 HegLWQZveFVP3fmLAGpx5Gs4LddUhZH3Ag6CYq/V8iqj0ALUVQYb1mCd5MCljpWs7a
	 YcONaJ0T+y7VcrftLyf/gwso1KbFyQfDZgrthmSZ3mP4SCeX7WVZjxw3dB58hAnnLE
	 dWEkXPlFncF6w==
Date: Wed, 4 Feb 2026 06:30:00 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/hyperv: Use memremap()/memunmap() instead of
 ioremap_cache()/iounmap()
Message-ID: <20260204063000.GJ79272@liuwe-devbox-debian-v2.local>
References: <20260119155937.46203-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119155937.46203-1-mhklinux@outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8701-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[liuwe-devbox-debian-v2.local:mid,outlook.com:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E23B4E2558
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 07:59:37AM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> When running with a paravisor and SEV-SNP, the GHCB page is provided
> by the paravisor instead of being allocated by Linux. The provided page
> is normal memory, but is outside of the physical address space seen by
> Linux. As such it cannot be accessed via the kernel's direct map, and
> must be explicitly mapped to a kernel virtual address.
> 
> Current code uses ioremap_cache() and iounmap() to map and unmap the page.
> These functions are for use on I/O address space that may not behave as
> normal memory, so they generate or expect addresses with the __iomem
> attribute. For normal memory, the preferred functions are memremap() and
> memunmap(), which operate similarly but without __iomem.
> 
> At the time of the original work on CoCo VMs on Hyper-V, memremap() did not
> support creating a decrypted mapping, so ioremap_cache() was used instead,
> since I/O address space is always mapped decrypted. memremap() has since
> been enhanced to allow decrypted mappings, so replace ioremap_cache() with
> memremap() when mapping the GHCB page. Similarly, replace iounmap() with
> memunmap(). As a side benefit, the replacement cleans up 'sparse' warnings
> about __iomem mismatches.
> 
> The replacement is done to use the correct functions as long-term goodness
> and to clean up the sparse warnings. No runtime bugs are fixed.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311111925.iPGGJik4-lkp@intel.com/
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied to hyperv-next. Thanks.

