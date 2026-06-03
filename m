Return-Path: <linux-hyperv+bounces-11461-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UDYpB1TXH2psqwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11461-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 09:27:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2070E635323
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 09:27:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=qiHtvPi6;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11461-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11461-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2233F30C93BF
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jun 2026 07:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF07030CDBC;
	Wed,  3 Jun 2026 07:08:28 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5A72EA173
	for <linux-hyperv@vger.kernel.org>; Wed,  3 Jun 2026 07:08:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470508; cv=none; b=qOfGEXYKO/2WZkWESEu+v8mxB2BNvO5v3ATyS5oLjWc1rgsVq9YUzHVY25QakuJ8KbwMwd+L90Tkcdxs0gckVTJv5dDOKZb+Fh+A4vzzA5q4YXy4yd1B36OvlOg3fQMfB0iDbppax0Ip0+IQXRF8HoVI8pK8Xz65BSOJMuDKqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470508; c=relaxed/simple;
	bh=Kbrvj/D4m44n+fVnPZMGjLwLQAVkrjvj4DoZ39oGgMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4YfG3r1/OTLe/Y56Bk1UP5YhcKzTNgqgy6xUbZq8r6cZUaKACuH3B+1A9dZAu5ZDKvpKz/Nl1py3lFmU8M0HPHnEftC/yvDCwBOAeteBWREbfx071Vhaw/B3kInHHXb2BD5M35PtfV794d7eXo7EUXMtf2jfmNo7sdhe/q6+XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qiHtvPi6; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 5485F20B7167; Wed,  3 Jun 2026 00:08:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5485F20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780470493;
	bh=pMpoimDnxQqeddLZUN8/Gi26Uji4c+dX4bVmvuEn19Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qiHtvPi6/hm6XEOztYMr71u+tyvLIXOq0BetZVa8IURExK5Z9jY6GqcLQssan8dUG
	 FNwfofXUpXD62nvBHSiKj9NvKJNQKl7TLL3HUvkZhe6VHtY5DQTadgY9PoaBXjgikW
	 jrYSjnIAiPC9vETQ0FLJ8u8Ed+IVn5AumPH88qxc=
Date: Wed, 3 Jun 2026 00:08:13 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
Subject: Re: [PATCH net v3] net: mana: Optimize irq affinity for low vcpu
 configs
Message-ID: <ah/S3W386bLstSZf@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260601102749.1768304-1-shradhagupta@linux.microsoft.com>
 <20260602102811.A83AD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260602102811.A83AD1F00893@smtp.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11461-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[shradhagupta@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shradhagupta@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2070E635323

On Tue, Jun 02, 2026 at 10:28:11AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing error check for xa_store() leads to resource leak and potential kernel oops on allocation failure.
> --
> 
> commit 853688f50dc4ca56dd74698a3ecfdfeaf857e716
> Author: Shradha Gupta <shradhagupta@linux.microsoft.com>
> 
> net: mana: Optimize irq affinity for low vcpu configs
> 
> This patch optimizes irq affinity in the mana driver for low vCPU
> environments. When the number of allocated irqs is greater than the vCPU
> count, it ensures that queue irqs are spread across all available vCPUs
> to prevent softirq handling imbalances.
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> [ ... ]
> > @@ -1767,13 +1784,42 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
> >  	 * first CPU sibling group since they are already affinitized to HWC IRQ
> >  	 */
> >  	cpus_read_lock();
> > -	if (gc->num_msix_usable <= num_online_cpus())
> > -		skip_first_cpu = true;
> > +	if (gc->num_msix_usable <= num_online_cpus()) {
> > +		err = irq_setup(irqs, nvec, gc->numa_node, true);
> > +		if (err) {
> > +			cpus_read_unlock();
> > +			goto free_irq;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but looking at the error handling
> path for goto free_irq, is there a potential resource leak if xa_store()
> fails earlier in the function?
> 
> When setting up the irqs in mana_gd_setup_dyn_irqs(), we call xa_store()
> with GFP_KERNEL:
> 
>     xa_store(&gc->irq_contexts, i, gic, GFP_KERNEL);
> 
> However, the return value is not checked. If this allocation fails, the gic
> pointer is not saved. If a subsequent operation like irq_setup() fails and
> we jump to the free_irq label, the cleanup loop attempts to retrieve it:
> 
>     gic = xa_load(&gc->irq_contexts, i);
>     if (WARN_ON(!gic))
>         continue;
> 
> Because the store failed, xa_load() will return NULL, causing the loop
> to continue without calling free_irq() or kfree(gic). Could this result
> in an un-freed irq handler that might trigger a panic later if the
> module is unloaded and the hardware raises an interrupt?
> 
> > +		}
> > +	} else {
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260601102749.1768304-1-shradhagupta@linux.microsoft.com?part=1

Since this isn't a bug introduced by this patch, I will fix it in a
seperate patch. Will submit the fix for this bug by next week.

Thanks,
Shradha.

