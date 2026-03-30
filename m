Return-Path: <linux-hyperv+bounces-9832-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIieGU/SymmsAQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9832-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 21:43:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F178736094B
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 21:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24BCC304B375
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 19:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E04139B97D;
	Mon, 30 Mar 2026 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EiV/FnMy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2862239B4A9;
	Mon, 30 Mar 2026 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899698; cv=none; b=WF01tgtEBAEf2/tX0jsRE+A/yo3FY5FnmlbpVIs8okfyCevx0IIXDVg0i8n7N0qMlec9U3TMejXVdCD7PI2fHvhWp1x6aZm3j9Bk6ePrIbWadIqCjJ98rcBjBTh8FgHq95NFPOsQkxeF29/7p0ZAmQymEpKPUaDCqLsr95F1YaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899698; c=relaxed/simple;
	bh=2jzANB6Jpn7vyxL68LyAGHdLW1A45Ea8LNVNsMorZqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seShLyaTsReCUZhptYZp80a+ZYr4dRYOvCky2YrZfmqyQM8j702HJ5HuyHZYK8dm0DC0NNoTExLw8SzXJZRGBYFuavg24NlSXYYDgiXs1gh4C7y/MAOiR7vXNd2z7OvRZ+VDXUg5hWkJxebJEblyqbsrDZTZDkWjSNFLenBPsVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EiV/FnMy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 488B920B712B; Mon, 30 Mar 2026 12:41:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 488B920B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774899697;
	bh=uk7R0f7m1KNvPxqL1ALcZ6sp+sNRZBUIYD6HuBJP0Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EiV/FnMyauGCISrcSrJXLqykf5bMDOVmqCQMXOqW5jKZvcTfRWRw76fpfCO1CCQ/c
	 ducucJLSS6Xz5tSpfmHrNAO93xJ6TW6n8mCycCbiju/riYwDnLH3xHx2FCd0FjZ4d9
	 I1cTHGAhB1TUK4ZlYToM6N7KrQjhhniVcwf1fNcQ=
Date: Mon, 30 Mar 2026 12:41:37 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, leon@kernel.org,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	dipayanroy@microsoft.com
Subject: Re: [PATCH net-next, v3] net: mana: Force full-page RX buffers for
 4K page size on specific systems.
Message-ID: <acrR8fLQsIUkKRz7@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <abDo8XTu1EiQFC7T@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260314125053.41d6221b@kernel.org>
 <ab2T8LgRiDHDIUHV@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260320172908.1840229d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260320172908.1840229d@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9832-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: F178736094B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 05:29:08PM -0700, Jakub Kicinski wrote:
> On Fri, 20 Mar 2026 11:37:36 -0700 Dipayaan Roy wrote:
> > On Sat, Mar 14, 2026 at 12:50:53PM -0700, Jakub Kicinski wrote:
> > > On Tue, 10 Mar 2026 21:00:49 -0700 Dipayaan Roy wrote:  
> > > > On certain systems configured with 4K PAGE_SIZE, utilizing page_pool
> > > > fragments for RX buffers results in a significant throughput regression.
> > > > Profiling reveals that this regression correlates with high overhead in the
> > > > fragment allocation and reference counting paths on these specific
> > > > platforms, rendering the multi-buffer-per-page strategy counterproductive.  
> > > 
> > > Can you say more ? We could technically take two references on the page
> > > right away if MTU is small and avoid some of the cost.  
> > 
> > There is a 15-20% shortfall in achieving line rate for MANA (180+ Gbps)
> > on a particular ARM64 SKU. The issue is only specific to this processor SKU —
> > not seen on other ARM64 SKUs (e.g., GB200) or x86 SKUs. Critically, the
> > regression only manifests beyond 16 TCP connections, which strongly indicates
> > seen when there is  high contention and traffic.
> > 
> >   no. of     | rx buf backed       | rx buf backed
> >  connections | with page fragments | with full page
> > -------------+---------------------+---------------
> >            4 |         139 Gbps    |     138 Gbps
> >            8 |         140 Gbps    |     162 Gbps
> >           16 |         186 Gbps    |     186 Gbps
> 
> These results look at bit odd, 4 and 16 streams have the same perf,
> while all other cases indeed show a delta. What I was hoping for was
> a more precise attribution of the performance issue. Like perf top
> showing that its indeed the atomic ops on the refcount that stall.
> 
> >           32 |         136 Gbps    |     183 Gbps
> >           48 |         159 Gbps    |     185 Gbps
> >           64 |         165 Gbps    |     184 Gbps
> >          128 |         170 Gbps    |     180 Gbps
> >  
> > HW team is still working to RCA this hw behaviour.
> > 
> > Regarding "We could technically take two references on the page right
> > away", are you suggesting having page reference counting logic to driver
> > instead of relying on page pool?
> 
> Yes, either that or adjust the page pool APIs. 
> page_pool_alloc_frag_netmem() currently sets the refcount to BIAS
> which it then has to subtract later. So we get:
> 
>   set(BIAS)
>   .. driver allocates chunks ..
>   sub(BIAS_MAX - pool->frag_users)
> 
> Instead of using BIAS we could make the page pool guess that the caller
> will keep asking for the same frame size. So initially take
> (PAGE_SIZE/size) references.
> 
Ok I will be doing some expeimentation with this approach to see if it
helps the current scenario.

> > > The driver doesn't seem to set skb->truesize accordingly after this
> > > change. So you're lying to the stack about how much memory each packet
> > > consumes. This is a blocker for the change.
> > >   
> > ACK. I will send out a separate patch with fixes tag to fix the skb true
> > size.
> > 
> > > > To mitigate this, bypass the page_pool fragment path and force a single RX
> > > > packet per page allocation when all the following conditions are met:
> > > >   1. The system is configured with a 4K PAGE_SIZE.
> > > >   2. A processor-specific quirk is detected via SMBIOS Type 4 data.  
> > > 
> > > I don't think we want the kernel to be in the business of carrying
> > > matching on platform names and providing optimal config by default.
> > > This sort of logic needs to live in user space or the hypervisor 
> > > (which can then pass a single bit to the driver to enable the behavior)
> > >   
> > As per our internal discussion the hypervisor cannot provide the CPU
> > version info(in vm as well as in bare metal offerings).
> 
> Why? I suppose it's much more effort for you but it's much more effort
> for the community to carry the workaround. So..
>
As per the hypervisor team it is not solving the issue in the case of
bare metal offering, hence will work ahead with an alternate soultion
as suggested by you: "This sort of logic needs to live in user space..,
which can then pass a single bit to the driver to enable the behavior"

> > On handling it from user side are you suggesting it to introduce a new
> > ethtool Private Flags and have udev rules for the driver to set the private
> > flag and switch to full page rx buffers? Given that the wide number of distro
> > support this might be harder to maintain/backport. 
> > 
> > Also the dmi parsing design was influenced by other net wireleass
> > drivers as /wireless/ath/ath10k/core.c. If this approach is not
> > acceptable for MANA driver then will have to take a alternate route
> > based on the dsicussion right above it.
> 
> Plenty of ugly hacks in the kernel, it's no excuse.

Hi Jakub,

As we are still working on root causing the actual issue with HW team,
we would want the user a option to achieve the line rate by a tuneable
option to run with full page rx buffers. I will be sending out a next
version that would introduce an ethtool private flag for mana that
allows the user to force one RX buffer per page.


Regards

