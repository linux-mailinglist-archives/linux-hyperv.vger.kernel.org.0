Return-Path: <linux-hyperv+bounces-9164-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJMJItnVqmnQXgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9164-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 14:25:45 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E36A9221898
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 14:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60AAE305C6D2
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Mar 2026 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8665F396B9D;
	Fri,  6 Mar 2026 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mcy08fJV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECD226AA93;
	Fri,  6 Mar 2026 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772803541; cv=none; b=eJY4Tt7KYzJWZYp3Tw42ByW0CjCeb9GJlxcUqu1s8K+Fb0XvjtXDYT2fACooh6QJEJnGLqQnlI3yWMaj6Cy4tt4PceSwjBGtQiXvlkQZjtnm0TKPxnZwu0wtdO6ph4456PUS6HONDD2uBzZdW0xOmfyl99a1kPILlEKeytrMhb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772803541; c=relaxed/simple;
	bh=xq6tO3gq+ikYKg2htZ8zlQbx+y/xyU7f8Tpd/Y5KZ9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYrQ1sMuxenCU+2gyDszxgS+5t11cCVqBz3i2bIjXuNd7O+x+kv9vfZGznN4d3C6Gg8lHJw+GuYbD6riVF0zMfQk0LaQZGOB5xOJpJKcZ8krlvBlb2NeWmXWcwFAsmAHkU9dmcFjPhTPnWYoRRWaHkB5RW0nxolCDYzjKkZC+t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mcy08fJV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 290C620B6F02; Fri,  6 Mar 2026 05:25:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 290C620B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772803540;
	bh=2JyBmM4XaDYtax+ewR+/MhCjdk854J7BzbX25sdLujg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mcy08fJVWIULaR1M83szAlvRnMAiUZf0vaGrNVCZ3mpAbstYheUNiss2q+L29t6NY
	 6ork7SBDAnWJYUrs6squp2o5xoBi2xbRh6koz2zCft4rNHiwaxdwBciXW1IyqSU2l9
	 uijWD6VLuOWuDSOopv361J8hGiO77x926fTDEg6U=
Date: Fri, 6 Mar 2026 05:25:40 -0800
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, leon@kernel.org,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	dipayanroy@microsoft.com
Subject: Re: [PATCH net-next] net: mana: Force full-page RX buffers for 4K
 page size on specific systems.
Message-ID: <aarV1FOvDoYzvd4n@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <aaFusIxdbVkUqIpd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <03ac38dc-69c5-4641-98ea-5679465c0b7f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03ac38dc-69c5-4641-98ea-5679465c0b7f@redhat.com>
X-Rspamd-Queue-Id: E36A9221898
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9164-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 12:56:35PM +0100, Paolo Abeni wrote:
> On 2/27/26 11:15 AM, Dipayaan Roy wrote:
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 91c418097284..a53a8921050b 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -748,6 +748,26 @@ static void *mana_get_rxbuf_pre(struct mana_rxq *rxq, dma_addr_t *da)
> >  	return va;
> >  }
> >  
> > +static inline bool
> > +mana_use_single_rxbuf_per_page(struct mana_port_context *apc, u32 mtu)
> > +{
> 
> I almost forgot: please avoid the 'inline' keyword in .c files. This is
> function used only once, should be inlined by the compiler anyway.
>
Ack, will remove it in v2.
> > +	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
> > +
> > +	/* On some systems with 4K PAGE_SIZE, page_pool RX fragments can
> > +	 * trigger a throughput regression. Hence forces one RX buffer per page
> > +	 * to avoid the fragment allocation/refcounting overhead in the RX
> > +	 * refill path for those processors only.
> > +	 */
> > +	if (gc->force_full_page_rx_buffer)
> > +		return true;
> 
> Side note: since you could keep the above flag up2date according to the
> current mtu and xdp configuration and just test it in the data path.
> 
If not an issue, would like to keep it this way for better readability.
> /P
> 

Regrads

