Return-Path: <linux-hyperv+bounces-11047-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Km3AvxWDWpuwQUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11047-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 08:38:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7925883E9
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 08:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7DFA3006791
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 06:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F179B33DEDF;
	Wed, 20 May 2026 06:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i1uYBkAJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA467313E1D;
	Wed, 20 May 2026 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259037; cv=none; b=tHBiywK2zYYu82tdUcK8StRJr/iLJNiv9f2bBzSZc5uaAwsR5csO8WEURy898oVMKqE3+OdF0V4AMP4KKSf/eBnNJz3JRBl8RMI/4r1Q/Ulbxxcv3U1IYRlIxFvZ7RVyg9Gx8BlZzW9Lvftljv9O2WcB/sFKHFBgLR/GxzkqGJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259037; c=relaxed/simple;
	bh=/sOFqdnNN1q7PSctirpbRVYXU7v4FpVdPrI8aW6vtI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqWMcg2L2BII7i79kWSBg6biE1cD5c+6JpiZVbvEfVfK0mrl12/01djQOg2dqsRvTGcqgaC0gvS96evIW4Gpjf7gbaCh97VQr/ynWe9UnhF3r8vxLbWDCjXSyRVmZ3hcMenE626mKPSi3gE2pyMrOREg4/64l8q7eLJqjKybHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i1uYBkAJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [167.220.233.27])
	by linux.microsoft.com (Postfix) with ESMTPSA id E60D220B7168;
	Tue, 19 May 2026 23:36:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E60D220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779259019;
	bh=8Ngqkw2thvBqYAgsBsjetBoFBTscucgcMsW6KQBIFVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1uYBkAJuNnJvac035dYyhtMH6SfKn6TNcdadz+a/HnH9znc4eof0uw9nvlbKGU2O
	 GJXc2EOckZ55fbvrkTP+YMI4nOlxrspkjeC0pOoiesY2DXcgQIjSuQSd04Ncum/Nw7
	 nXlks+775aOCJ2V7rM18HJ07vmGdIfBxuAlOAQ1I=
Date: Wed, 20 May 2026 14:37:03 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, 
	wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, 
	longli@microsoft.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org, mani@kernel.org, 
	robh@kernel.org, arnd@arndb.de, mhklinux@outlook.com, 
	jacob.pan@linux.microsoft.com, tgopinath@linux.microsoft.com, 
	easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v1 1/4] iommu: Move Hyper-V IOMMU driver to its own
 subdirectory
Message-ID: <elo7enhxk5m7x4rc4quiqnkgbwsqa3ex7di2ksv7szu75xqe6x@zum5nwmkl6kn>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-2-zhangyu1@linux.microsoft.com>
 <20260515221918.GJ7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515221918.GJ7702@ziepe.ca>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11047-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,outlook.com,linux.microsoft.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BB7925883E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026 at 07:19:18PM -0300, Jason Gunthorpe wrote:
> On Tue, May 12, 2026 at 12:24:05AM +0800, Yu Zhang wrote:
> > From: Easwar Hariharan <eahariha@linux.microsoft.com>
> > 
> > The Hyper-V IOMMU driver currently only supports IRQ remapping.
> > As it will be adding DMA remapping support, prepare a directory
> > to contain all the different feature files.
> 
> Any possibility we could put the irq remapping thing under the irq
> directory?
> 
> The other drivers have it here because they are co-mingled with their
> iommu HW, will hyperv have the same issue?
> 

Good question. I don't think Hyper-V have the same co-mingling issue.

But from a code organization perspective, I think drivers/iommu/hyperv/
is still the most natural place:

- The IRQ remapping framework itself (drivers/iommu/irq_remapping.c
  and its internal header irq_remapping.h) lives under drivers/iommu/,
  and all three backends (intel/, amd/, hyperv/) sit there today.
  hyperv/irq_remapping.c includes that internal header directly.

- irq_remapping_prepare() references the extern hyperv_irq_remap_ops
  declared in that header, so the provider naturally belongs in the
  same tree.

Moving it to e.g. drivers/irqchip/ would break that symmetry.

Yu

> Jason
> 

