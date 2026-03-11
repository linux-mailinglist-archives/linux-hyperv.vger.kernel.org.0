Return-Path: <linux-hyperv+bounces-9327-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJm+IN3GsWnvFAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9327-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 20:47:41 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8D12699A9
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 20:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C434A30185B7
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 19:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58593090F4;
	Wed, 11 Mar 2026 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="q+e9l8gM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9484E20C029;
	Wed, 11 Mar 2026 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258457; cv=none; b=q4LQ8DJAPcyug6O1dc9QLnZFLFx5a0QzwoSluf5P+z0mZpvoGaUt8g5LTIsp/kT8aDGbT4rkRaDeRdFvIbqdoeeHG7ieuCSOD6cc2tDRijLOzp6akMmPv3WesZoDsDROQYx6fIZLnZnYxHaR9THshLxLfhzDrlXn+KFyGnFSal4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258457; c=relaxed/simple;
	bh=d0orctoNdQlyUbTNAhdFmQruWQlMOYeaidWzfI2MSt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uc+3El8XQMIlV5EXqvGv4xh3TNivtmByZFPsbzZG7B5vKGKZMtI1TkaedfGrWlpJuF5URqeRSJeSw5glniNw1J3C805y/VCmu0/rApTcJmKlyJNs/WvK9V1h5k17NRWTwjaBsBiu19NSDQb9hsG7/HMBE4TqIx5RH3/9Jz59JqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=q+e9l8gM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 7A12A20B710C; Wed, 11 Mar 2026 12:47:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A12A20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773258456;
	bh=mEJGxu7RvDWY3J5WSSTMNmpjoOu+wgT9zajIpsYmza0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+e9l8gMuh8mdjN6pDirPG/CcUHNkY7HAzwR62DHewMlm6faNDYIuZDYXA95xja6i
	 RewoBbEB9SftKU+TrEv6nEay1ykQhNMIOrD2Nb9JGDt7IQ+ZJoCGmAsuIAWh1WMltx
	 bOq4Gm7VS+/+yPbAAHyVVRSCF9/9tUUfnk/9PvGk=
Date: Wed, 11 Mar 2026 12:47:36 -0700
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
Subject: Re: [PATCH net-next] net: mana: Expose page_pool stats via ethtool
Message-ID: <abHG2NdwVvTntLeJ@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <aaFmRqjjOuPIEo5x@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260227092722.50a7e45f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227092722.50a7e45f@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9327-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: CB8D12699A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Feb 27, 2026 at 09:27:22AM -0800, Jakub Kicinski wrote:
> On Fri, 27 Feb 2026 01:39:18 -0800 Dipayaan Roy wrote:
> > MANA relies on page_pool for RX buffers, and the buffer refill paths
> > can behave quite differently across architectures and configurations (e.g.
> > base page size, fragment vs full-page usage). This makes it harder to
> > understand and compare RX buffer behavior when investigating performance
> > and memory differences across platforms.
> 
> Standard stats must not be duplicated in ethtool -S.
> ynl and ynltool provide easy access to these stats
> 
> # ynltool page-pool stats 
>     eth0[2]	page pools: 44 (zombies: 0)
> 		refs: 495680 bytes: 2030305280 (refs: 0 bytes: 0)
> 		recycling: 100.0% (alloc: 7745:2097593009 recycle: 379301630:1717888312)

Thanks Jakub for the feedback, and understood the generic page pool
stats should be combined with ethtool -S. I will drop this patch
and use ynltool page-pool stats.


Regards



