Return-Path: <linux-hyperv+bounces-10071-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOTqM2/E1Wkx9gcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10071-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 04:58:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE84B3B667E
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 04:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36F2B3030AD1
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 02:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D25136606A;
	Wed,  8 Apr 2026 02:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bFjt2KCF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB42F3624D3;
	Wed,  8 Apr 2026 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775616910; cv=none; b=cN1n47abb/tENlFAKPzYA0pRgVu8FuLlP2Y4R+gnnsb+MlKS8VG5hS5F4kwc/F0gQFOR8HS+WaEnL/TY91tWi/GajiSYSPV/I4A4yV9CjFYuRAk9kYuMG6q+/X9usYvpV1wbOw3woCr9IF+hL4PRmrCZNMduLCipr+xp+621UBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775616910; c=relaxed/simple;
	bh=wmAOs9XJh4ziApC5SLGMiJtDFYL0cuNyEF98xXNt+DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1549sHsSrxn15FYNeGWl1MtRkJLPSoqWU2EAAzhXY1fNZicLqziNCCreFDkVCwq+DwwOsmBWcQKIED1hBViiF4ya8qcsiZPYy2jkW/6+JJ1PVxzHr8/F19teNdxTevXKp/6SKIbbbe9dzYFWOwGGslYMxde95dTKj0yFmFwyCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bFjt2KCF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 8E33620B7128; Tue,  7 Apr 2026 19:55:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E33620B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775616908;
	bh=tvnLjFUq8zggoXE4pCPWv5YdNILg71v4/gJOkvRpX0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bFjt2KCF05TXatIoSlAnJPoHFFdyqW81J6X0N4mva8UgMTMlX+BF6hH+wnZ44sdKB
	 qqpBOgWGVulnI1Q+i3m6F+EMXxUo/k9EfDJ2YEo6OPRhIoOEC/86HTjFKpwvHiuQAe
	 TYOjdej5e3HnghNgsMk7ERYs/wySWzvAIbWLp9AU=
Date: Tue, 7 Apr 2026 19:55:08 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, leon@kernel.org, longli@microsoft.com,
	kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	stephen@networkplumber.org, jacob.e.keller@intel.com,
	dipayanroy@microsoft.com, leitao@debian.org, kees@kernel.org
Subject: Re: [PATCH net-next v5 0/2] net: mana: add ethtool private flag for
 full-page RX buffers
Message-ID: <adXDjGN0rcahx+wt@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <adHaF6DloRthctRb@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <e80b603d-8be0-4aee-8a31-c9cbb4a8ab00@intel.com>
 <20260407185128.605dcacf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407185128.605dcacf@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10071-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: CE84B3B667E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 06:51:28PM -0700, Jakub Kicinski wrote:
> On Tue, 7 Apr 2026 15:10:45 +0200 Alexander Lobakin wrote:
> > > On some ARM64 platforms with 4K PAGE_SIZE, utilizing page_pool 
> > > fragments for allocation in the RX refill path (~2kB buffer per fragment)
> > > causes 15-20% throughput regression under high connection counts  
> > > (>16 TCP streams at 180+ Gbps). Using full-page buffers on these  
> > > platforms shows no regression and restores line-rate performance.
> > > 
> > > This behavior is observed on a single platform; other platforms
> > > perform better with page_pool fragments, indicating this is not a
> > > page_pool issue but platform-specific.
> > > 
> > > This series adds an ethtool private flag "full-page-rx" to let the
> > > user opt in to one RX buffer per page:
> > > 
> > >   ethtool --set-priv-flags eth0 full-page-rx on  
> > 
> > Sorry I may've missed the previous threads.
> > 
> > Has this approach been discussed here? Private flags are generally
> > discouraged.
> > 
> > Alternatively, you can provide Ethtool ops to change the Rx buffer size,
> > so that you'd be able to set it to PAGE_SIZE on affected platforms and
> > the result would be the same.
> 
> Actually, hm. Now that you spoke up I wonder how much this is
> an inherent ARM problem vs problem in whatever ARM Microsoft's
> management empire-built themselves into.
> 
> Do you have access to any ARM servers? Google says GCP offers ARM
> instances with idpf NICs. So if idpf benefits from the same
> "tuning" we should totally push for a proper API not priv flags.

Hi,

Sharing an observation from earlier, with a different ARM64 fabric/platfrom
when configured with base size of 4Kb and the smae MANA NIC, did not show
this behaviour. In fact, it showed better performance with page fragments
in single as well as multiple connections. Thats why initial version this
patch we wanted to apply the work around only to this specific chip where
the issue is seen with page fragments.



Regards

