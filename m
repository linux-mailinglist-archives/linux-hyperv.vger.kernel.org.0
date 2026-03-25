Return-Path: <linux-hyperv+bounces-9771-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLpSBrEexGmZwgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9771-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 18:43:13 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 681E232A054
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 18:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA3583041BDE
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E22405AAE;
	Wed, 25 Mar 2026 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kGRyhF+P"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC603E6DCD;
	Wed, 25 Mar 2026 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460155; cv=none; b=LntrgGBZNolwD8mPd0bhbLO9HQp0qAPOWVCc75EZtsbkTSphB1UQf9eH+sw3K68PiEbwSPo7FNZoiVpEVVTr9qFat9nbD7XdY7oY1n/lQoKxJfkhFxtsYYSrM+64CobACCqcq+jhxamvUQlzzHYIRyZZZc6wszLramWxoXeL53I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460155; c=relaxed/simple;
	bh=0ubDlpLeWqCVSi4aidKU6c0gQYsG7Fm/yEOk2Bmv8aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiUwQMUJfQe750gn9sL2O4aSiojD+PmACIBaL//z7613aw/TwgEXr5XDtDwi/77VPKsB1yGot/vB4JiwQL1gA7qYfQKnPIo8N4ubH96d3u5Aze+Pp0wNoRGU5ji8rbSqlxGJc3rjY1H4c+VLSW3CNGz87AV3NW0FmYfi0nw+nC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kGRyhF+P; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 096FF20B710C; Wed, 25 Mar 2026 10:35:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 096FF20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774460149;
	bh=D0gfVEdgt+irp9FbXwX1i322LXN+83xikAp6IdU+jq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGRyhF+PxKM1F+pGpi/pVzO8iRV5b3VOa9y+TwQEw1j4ymm0nv2K7RoXoJwXsjG+4
	 iEmOjncNwhQSvN0ZNd3cZJxHEpNz7EctAHV3pCKdQ+nSjVhiiuyJj/dMcnyOg4qwRj
	 dRUFn5T20fIkgMNBM/sI6UdZLt8MsmLuUVyMjHoY=
Date: Wed, 25 Mar 2026 10:35:49 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org,
	shradhagupta@linux.microsoft.com, dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com, kotaranov@microsoft.com,
	yury.norov@gmail.com, kees@kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: Use at least SZ_4K in doorbell ID
 range check
Message-ID: <acQc9d2zM09gC30A@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260320122107.1560839-1-ernis@linux.microsoft.com>
 <20260321100425.GX74886@horms.kernel.org>
 <c8fe221f-2e1c-47a0-970f-e7a1318a15bf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8fe221f-2e1c-47a0-970f-e7a1318a15bf@redhat.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9771-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,lunn.ch,davemloft.net,google.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 681E232A054
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 12:03:37PM +0100, Paolo Abeni wrote:
> 
> 
> On 3/21/26 11:04 AM, Simon Horman wrote:
> > On Fri, Mar 20, 2026 at 05:21:01AM -0700, Erni Sri Satya Vennela wrote:
> >> mana_gd_ring_doorbell() accesses doorbell offsets up to 0xFF8 + 8 = 4KB
> >> within a doorbell page. When db_page_size is zero, the validation check
> >> in mana_gd_register_device() reduces to:
> >>   db_page_off + 0 > bar0_size
> >> which passes, even though mana_gd_ring_doorbell() will access
> >> [db_page_off, db_page_off + 4KB) and may go beyond BAR0.
> >>
> >> Use max(SZ_4K, db_page_size) in the range check so that a zero or
> >> unexpectedly small db_page_size still results in a rejection when the
> >> doorbell page would fall outside BAR0.
> > 
> > Thanks Erni,
> > 
> > I understand the maths here. And to that extent this change makes sense to me.
> > But I am curious to know how a db_page_size of zero works. I was expecting
> > some space is required there.
> 
> To rephrase Simon's question, this feels like papering over a
> memory/state corruption. I think at best it deserves a cleaner explanation.
> 
> /P
Thanks for pointing it out Simon and Paolo.
Now I understand the real issue, when db_page_sz is zero my patch rejects
it, but doesn't explicitly point it out. Such case means something is
wrong in hardware, which is silently escaped in this patch.

I will create another patch where I will reject db_page_size < SZ_4K at
the source.

