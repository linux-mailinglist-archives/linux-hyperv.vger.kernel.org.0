Return-Path: <linux-hyperv+bounces-11649-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8KoQF44AOWrtlAcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11649-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jun 2026 11:29:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C274B6AE383
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jun 2026 11:29:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=Y2k20Rkl;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11649-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11649-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FFBC31274D3
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jun 2026 09:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FFC358384;
	Mon, 22 Jun 2026 09:22:57 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2BF1DF26E;
	Mon, 22 Jun 2026 09:22:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120177; cv=none; b=Itd2BrCQ9UBHdDRMwZ8+ZMnNvSzAcPZL6j8OkuCUCsZM6vQ/WbM2wsSNDjLd0TbsBtmEdErjmyKq5o1hDUp+WpZPUCkLkrREyOIIy1nSM4vYEVZRInSSiurqCyWIgN/prWSN2p9k5QRw3XNmncOMF9Q3k4akaZnknyRP033GpB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120177; c=relaxed/simple;
	bh=xVycPYykyw3Y0P2xXz0awhZzfh0Q1lkfzy4JSzhI4iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDqXmnryMC3jkHzQU44Sk8JHu0/tq+hr1TW/qZTOhRsgpLcVkk1kPPZtfjJrQQcORu9tznLXebHLd+4ZjQHtuZG0D1JiWVBBHLmUP3Tffb5GWaDXx93j/lyvkRxM9vpIvQkFu54tGS/nNRqup61+BXdcwXppbE2fT6AORj7zPrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y2k20Rkl; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 4CF9220B7169; Mon, 22 Jun 2026 02:22:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4CF9220B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782120166;
	bh=J5SP7ni7yTXEtYqDAz4nNpa5nvIK+uBx0r5BsVdU8Uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2k20Rkl3IQ3EqPPrmSwGcBRpAY+7lMQjr4d0Ub/mYIEmLy0UfXHdqRjdIQAiPZLI
	 geoYFZ+08BjiBZC/zI6fdO/kWf9guJHi2FiiY74DWqReJcOnZlb20v5iqMz4dCGxxj
	 xP7PxRuG8ZndYmJEXIZpTidGpfZkWvKfB1jPfM0A=
Date: Mon, 22 Jun 2026 02:22:46 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: mana: Fall back to standard MTU when PF reports
 adapter_mtu of 0
Message-ID: <ajj+5mhswcqhI2z7@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260619055348.467224-1-ernis@linux.microsoft.com>
 <20260620055406.C564C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260620055406.C564C1F000E9@smtp.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11649-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C274B6AE383

On Sat, Jun 20, 2026 at 05:54:06AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Preexisting error handling bug in XDP set path leaves apc->bpf_prog pointing to a freed BPF program, leading to a Use-After-Free/Double Free.
> --
> 
> commit 425f6bf5274f2172e13cdc649ea2288d8dc1ad72
> Author: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> 
> net: mana: Fall back to standard MTU when PF reports adapter_mtu of 0
> 
> This commit fixes a regression for older PF firmware versions by allowing
> an adapter_mtu of 0 to fall back to the standard ETH_FRAME_LEN. It also
> updates MTU bounds checks for XDP limits.
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
> > index b5e9bb184a1dd..53308e139cbe9 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
> > @@ -237,7 +237,8 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
> >  		bpf_prog_put(old_prog);
> >  
> >  	if (prog)
> > -		ndev->max_mtu = MANA_XDP_MTU_MAX;
> > +		ndev->max_mtu = min_t(unsigned int, MANA_XDP_MTU_MAX,
> > +				      gc->adapter_mtu - ETH_HLEN);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing the changes
> to mana_xdp_set(), I noticed a pre-existing issue on an error path earlier
> in this function.
> 
> Earlier in mana_xdp_set(), the program is assigned:
> 
>     apc->bpf_prog = prog;
> 
> If the port is up, it then allocates rx buffers:
> 
>     err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
>     if (err) {
>         ...
>         return err;
>     }
> 
> If mana_pre_alloc_rxbufs() fails, it returns directly rather than jumping
> to the err_dealloc_rxbuffs label. This bypasses the cleanup step that
> restores apc->bpf_prog = old_prog.
> 
> Since the networking core frees the bpf program on error, does this leave
> apc->bpf_prog pointing to a freed program?
> 
> If mana_xdp_set() is called again later, could fetching old_prog lead to a
> use-after-free or double-free when calling bpf_prog_put(old_prog)?
> 
> >  	else
> >  		ndev->max_mtu = gc->adapter_mtu - ETH_HLEN;
> >
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260619055348.467224-1-ernis@linux.microsoft.com?part=1

I'll take this up in a different patch.

Thankyou,
Vennela

