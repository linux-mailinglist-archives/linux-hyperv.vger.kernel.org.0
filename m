Return-Path: <linux-hyperv+bounces-8459-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIs8JihocmmrjwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8459-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 19:10:48 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 164D76C0C9
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 19:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 709AD3016814
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1E735DD07;
	Thu, 22 Jan 2026 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qf8iCYSS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B27033ADB4;
	Thu, 22 Jan 2026 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769103840; cv=none; b=BgLWuhwxkSVPhHCu29DqIA97nfUCDEIYbUyYqlom2F838cjhoUlb9n/hzGIng3JeT9eT0355EXy6Vxpevu4NQ97kilSE4XYhdJx/c61t5xm/Ed7zj5hnMF5MxyDs7tGjnAU5JU3ftZ5fOi2ynUb49dWHqt4kdR66dCNmRGWBEGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769103840; c=relaxed/simple;
	bh=R15x5nerWVdCAIWCpP/4jiHtFAbZzJEgrOoeGzqjuuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMd6iOtS5qrnww6gRili7P1LNKh3sBpJc81uY1x05u9JLxGI4ACyOxKljVRmvbOx/UQORueEY5VryZY6fUnxq6I9KkZm7/sPHv3Xu0ovrCVmflIbvaE04gT6jnGARPAbzQeUCLSAWdtHZSnWFeqt3LA+4MZlPJ8Kqd9tMCcA2cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qf8iCYSS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 6965E20B7167; Thu, 22 Jan 2026 09:43:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6965E20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769103822;
	bh=bYy6X22KFut3vdEWLqJgSovLX6somlWfz3DqoBUHNV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qf8iCYSSi4kqMGTo4tUEIIcLWXqFS0SnMJtItvvENVvIQ12Oqwcgt231Y5OYMMY3L
	 qEboCvp8E48WczxSlIpUYFxoY/XVnSEMSBXXEnbi2rg8OrgBp6C8TlxqChhKrnYi3c
	 +p5o4UBoaAjB4+VXk6NajfQzYn3WRFQ6p3nxU2dY=
Date: Thu, 22 Jan 2026 09:43:42 -0800
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	leon@kernel.org, kotaranov@microsoft.com,
	shradhagupta@linux.microsoft.com, yury.norov@gmail.com,
	dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
	ssengar@linux.microsoft.com, gargaditya@linux.microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mana: Improve diagnostic logging for
 better debuggability
Message-ID: <aXJhzi58GqLKtui4@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260121065655.18249-1-ernis@linux.microsoft.com>
 <20260121201412.179f9b37@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121201412.179f9b37@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8459-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.965];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 164D76C0C9
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 08:14:12PM -0800, Jakub Kicinski wrote:
> On Tue, 20 Jan 2026 22:56:55 -0800 Erni Sri Satya Vennela wrote:
> > Enhance MANA driver logging to provide better visibility into
> > hardware configuration and error states during driver initialization
> > and runtime operations.
> 
> > +	dev_info(gc->dev, "Max Resources: msix_usable=%u max_queues=%u\n",
> > +		 gc->num_msix_usable, gc->max_num_queues);
> 
> > +	dev_info(dev, "Device Config: max_vports=%u adapter_mtu=%u bm_hostmode=%u\n",
> > +		 *max_num_vports, gc->adapter_mtu, *bm_hostmode);
> 
> IIUC in networking we try to follow the mantra that if the system is
> functioning correctly there should be no logs. You can expose the debug
> info via ethtool, devlink, debugfs etc. Take your pick.

We discussed this internally and noted that customers often cannot
reliably reproduce the VM issue. In such cases, the only evidence
available is the dmesg logs captured during the incident. Asking them to
re-enable debug options later is not practical, since the problem may
not occur again. Similarly, exposing the information via ethtool,
devlink, or debugfs is less effective because the data is transient and
lost after a reboot. As these messages are printed only once during
initialization, and not repeated during runtime or driver load/unload,
we decided to keep them at info level to aid troubleshooting without
adding noise.

- Vennela

