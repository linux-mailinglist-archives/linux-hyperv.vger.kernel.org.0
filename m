Return-Path: <linux-hyperv+bounces-9638-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHOtLfWTvWnY+wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9638-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 19:37:41 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D85A2DF87E
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 19:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87772300A333
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 18:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B64D3E317D;
	Fri, 20 Mar 2026 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JR3mMW/3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39502D0C62;
	Fri, 20 Mar 2026 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774031857; cv=none; b=cYRFkIS9BCcFyyleD0jCB5/a7nCKEQg1Cx/eYjI7d5xvxMh+C0IGByNqwBf9miJRGdzfWlynYYdMGiHGH5yNqMmf1cpCKRd8KSJmK4oAtiay0dFxXJpegLdjcMDKOubiI2IUfOOHEAeLEne+n2tWFaWmvkjzC7fLaos1toP0wWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774031857; c=relaxed/simple;
	bh=ndUmG6D4N/t76wmcE/rj0yYFZUJjdZW7OKDiXnUnTKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFrd1uUJaf/g5cZl08HPFW3KwrDkvnvCeh4UwitnHHR+r2SctRF3Ck0XM2sDxsC3sGkAY900QCPr9ig4Y9+rxRyHM7lZRO2suni2hvkdMSTurtrUSSpcYzEiTlZ546u3p9J+hsjvqfxwz8RMgBlqtG/T/QUgEd2Wqb34TmEGGWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JR3mMW/3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id A29FB20B710C; Fri, 20 Mar 2026 11:37:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A29FB20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774031856;
	bh=8jpPXr+y+3KENB6W41376ggBj6+74FClsqh2tUuZIug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JR3mMW/3XjE+RSv1SuWsuNxVuWjbiFNQX3JEuSEoPj0eeUVtlHh4wYrAzU05/StIp
	 Ak32D828kLEtVhySGqhpLcmQLZkQt2EnsCYVgZyB8X11m3M2IUTqdn7j8u1XkY1GC/
	 VaRnxXufFAuziD1myFZ6o16h1RgUN+bwAGZxXuKM=
Date: Fri, 20 Mar 2026 11:37:36 -0700
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
Message-ID: <ab2T8LgRiDHDIUHV@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <abDo8XTu1EiQFC7T@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260314125053.41d6221b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260314125053.41d6221b@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9638-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.917];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 5D85A2DF87E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 12:50:53PM -0700, Jakub Kicinski wrote:
> On Tue, 10 Mar 2026 21:00:49 -0700 Dipayaan Roy wrote:
> > On certain systems configured with 4K PAGE_SIZE, utilizing page_pool
> > fragments for RX buffers results in a significant throughput regression.
> > Profiling reveals that this regression correlates with high overhead in the
> > fragment allocation and reference counting paths on these specific
> > platforms, rendering the multi-buffer-per-page strategy counterproductive.
> 
> Can you say more ? We could technically take two references on the page
> right away if MTU is small and avoid some of the cost.

There is a 15-20% shortfall in achieving line rate for MANA (180+ Gbps)
on a particular ARM64 SKU. The issue is only specific to this processor SKU —
not seen on other ARM64 SKUs (e.g., GB200) or x86 SKUs. Critically, the
regression only manifests beyond 16 TCP connections, which strongly indicates
seen when there is  high contention and traffic.

  no. of     | rx buf backed       | rx buf backed
 connections | with page fragments | with full page
-------------+---------------------+---------------
           4 |         139 Gbps    |     138 Gbps
           8 |         140 Gbps    |     162 Gbps
          16 |         186 Gbps    |     186 Gbps
          32 |         136 Gbps    |     183 Gbps
          48 |         159 Gbps    |     185 Gbps
          64 |         165 Gbps    |     184 Gbps
         128 |         170 Gbps    |     180 Gbps
 
HW team is still working to RCA this hw behaviour.

Regarding "We could technically take two references on the page right
away", are you suggesting having page reference counting logic to driver
instead of relying on page pool?

> 
> The driver doesn't seem to set skb->truesize accordingly after this
> change. So you're lying to the stack about how much memory each packet
> consumes. This is a blocker for the change.
> 
ACK. I will send out a separate patch with fixes tag to fix the skb true
size.

> > To mitigate this, bypass the page_pool fragment path and force a single RX
> > packet per page allocation when all the following conditions are met:
> >   1. The system is configured with a 4K PAGE_SIZE.
> >   2. A processor-specific quirk is detected via SMBIOS Type 4 data.
> 
> I don't think we want the kernel to be in the business of carrying
> matching on platform names and providing optimal config by default.
> This sort of logic needs to live in user space or the hypervisor 
> (which can then pass a single bit to the driver to enable the behavior)
> 
As per our internal discussion the hypervisor cannot provide the CPU
version info(in vm as well as in bare metal offerings).

On handling it from user side are you suggesting it to introduce a new
ethtool Private Flags and have udev rules for the driver to set the private
flag and switch to full page rx buffers? Given that the wide number of distro
support this might be harder to maintain/backport. 

Also the dmi parsing design was influenced by other net wireleass
drivers as /wireless/ath/ath10k/core.c. If this approach is not
acceptable for MANA driver then will have to take a alternate route
based on the dsicussion right above it.

> > This approach restores expected line-rate performance by ensuring
> > predictable RX refill behavior on affected hardware.
> > 
> > There is no behavioral change for systems using larger page sizes
> > (16K/64K), or platforms where this processor-specific quirk do not
> > apply.
> -- 
> pw-bot: cr

Thank you for your comments Jakub, and also pointing out the skb true
size issue. I am sending out a separate to fix the skb true size issue.

Regards
Dipayaan Roy


