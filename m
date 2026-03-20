Return-Path: <linux-hyperv+bounces-9630-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jvu/AnrYvGm13gIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9630-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 06:17:46 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCD62D5ED9
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 06:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D23AF303DAAB
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 05:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F95B2C029C;
	Fri, 20 Mar 2026 05:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYo2F9KU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2B2F9E8;
	Fri, 20 Mar 2026 05:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773983863; cv=none; b=gjqUSplp9FtO0WDZIWkh9X+znFEOyDpDZkbdhipyxIRJEFdPsGEVp4UKVSFukt8F7fY9ZEyw/24oxCHeap3FbeDXP4jNlu5dAxk4GS6CO8OFEm9+AgeszsPft2x2D5yleBTa3ZA09xC0khD4EZ5X4YvlCTsQ3vEJwUiH2wu6CJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773983863; c=relaxed/simple;
	bh=U0+Jv7w3arSeAENRnGjozUWCzU9b9ga4gHpw/eDLYNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htNHEJRLDLgqBMzWzeRehLodl/YilmTb8nxorEMzTCImp0bONA7jkzkQFlKMcnsn/nkTpS41x2VBsvt/f8UFGTpR6pb/j4gWE/ZUCjSMEW8BUL6EOlxQ+VnHNUtczCeOJfPvIWIajlkGtejyuVUnY6QPcIhAcO1Ew+kOJPHipVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYo2F9KU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D99C4CEF7;
	Fri, 20 Mar 2026 05:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773983863;
	bh=U0+Jv7w3arSeAENRnGjozUWCzU9b9ga4gHpw/eDLYNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JYo2F9KUhRdP4tg6O6F+/mKn8bYiYGOZLtZowMQhvreq1IyyHX28OHlMmmpnIEWgh
	 E/I63Qy94pU4WSRIg+2K+lmHhzkYTOqhqAzBkguBxQ0SEzvfs/HH0B10TwpNEWlJkR
	 sm+oxc/omtyuH4o9Elgg3+mXXoKVy7kzMTNjBcNe38MeCe/2GY6uYPcqf1swv2xosJ
	 G2yBk5PNrO6NLpX7R0kPM8fL+aiUj8MxKNJglEyEGxNVmrG677Wa3viNGEtpo4y+bT
	 Zkd1x2xIaAvntSHZ76eRv//44lq8yOmR4ow6kb8k5VYUoLOl7HaVi3OXtcIPSjnWBX
	 VJjkfjuictXtw==
Date: Fri, 20 Mar 2026 05:17:41 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Michael Kelley <mikelley@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: hv: Set default NUMA node to 0 for devices
 without affinity info
Message-ID: <20260320051741.GA761114@liuwe-devbox-debian-v2.local>
References: <20260316210742.1240128-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316210742.1240128-1-longli@microsoft.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9630-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.928];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[liuwe-devbox-debian-v2.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CCD62D5ED9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 02:07:42PM -0700, Long Li wrote:
> When hv_pci_assign_numa_node() processes a device that does not have
> HV_PCI_DEVICE_FLAG_NUMA_AFFINITY set or has an out-of-range
> virtual_numa_node, the device NUMA node is left unset. On x86_64,
> the uninitialized default happens to be 0, but on ARM64 it is
> NUMA_NO_NODE (-1).
> 
> Tests show that when no NUMA information is available from the Hyper-V
> host, devices perform best when assigned to node 0. With NUMA_NO_NODE
> the kernel may spread work across NUMA nodes, which degrades
> performance on Hyper-V, particularly for high-throughput devices like
> MANA.
> 
> Always set the device NUMA node to 0 before the conditional NUMA
> affinity check, so that devices get a performant default when the host
> provides no NUMA information, and behavior is consistent on both
> x86_64 and ARM64.
> 
> Fixes: 999dd956d838 ("PCI: hv: Add support for protocol 1.3 and support PCI_BUS_RELATIONS2")
> Signed-off-by: Long Li <longli@microsoft.com>

I can pick this up next week. PCI maintainers, if you want this to go
through your tree instead, please let me know.

Wei

> ---
> Changes in v2:
> - Rewrite commit message to focus on performance as the primary
>   motivation: NUMA_NO_NODE causes the kernel to spread work across
>   NUMA nodes, degrading performance on Hyper-V
> 
>  drivers/pci/controller/pci-hyperv.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 2c7a406b4ba8..38a790f642a1 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2485,6 +2485,14 @@ static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
>  		if (!hv_dev)
>  			continue;
>  
> +		/*
> +		 * If the Hyper-V host doesn't provide a NUMA node for the
> +		 * device, default to node 0. With NUMA_NO_NODE the kernel
> +		 * may spread work across NUMA nodes, which degrades
> +		 * performance on Hyper-V.
> +		 */
> +		set_dev_node(&dev->dev, 0);
> +
>  		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY &&
>  		    hv_dev->desc.virtual_numa_node < num_possible_nodes())
>  			/*
> -- 
> 2.43.0
> 

