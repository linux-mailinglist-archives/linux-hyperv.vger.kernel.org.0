Return-Path: <linux-hyperv+bounces-9963-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zYyGMQfpz2kZ1wYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9963-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 18:21:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FC239646A
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 18:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F8AE308299A
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 16:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1A93CF02A;
	Fri,  3 Apr 2026 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hpDpctkb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAF53CEBA6;
	Fri,  3 Apr 2026 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232589; cv=none; b=AtpZycqSsfkI58RU0Jll/9ckzm840lcMq2suhHV9TIsTVEFF9qUq5J/v9bOU6i5lExHfmeBarF7sG0e62YkmG1uHyHjl8xGbdSwMy47opjTcLthVXj7ox/fdRxQmjKVEtJZXzfb26xRTumVQpTnE8SXpZ4KWByUV19RTZsRBpZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232589; c=relaxed/simple;
	bh=rM2i24uWsCksKPfZB6f6+pAgYWSaeaMhVg21cj4V1Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2dCK9FNe+uuwaKq/YVsiH3gO0DghRbUF1VvYMOkUd+z8NyJ/wKpeRaUnsqxnvKnqWONZFKTJ7WL3K+I+YvdpkuWwxxJM48BpwO7vzViRiJON7uLE/GKXeg8wLob8b3bQ6lOS5s9OA88dAa+7uUa2WgTlkjx+3uOO+YKaLNaS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hpDpctkb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9DF3520B6F08;
	Fri,  3 Apr 2026 09:09:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9DF3520B6F08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775232587;
	bh=NA/XwvlJ/WLuuyPh3ecrOKU/y2iruzVhRi1YIUFCc34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hpDpctkbQFQBOBktz6BvrWzH8Z5hKrvWKB4t9zdUK8l3nMrbA1a0QqMbydMSl0Y6b
	 pLL5HzlaWS7jHF/7WE1D1MjU84OVfdC+CJSarJ3ScWVTtMB/+azlXZwY2I/0TmyMNk
	 7KzVdwSVWMq+52dk4YKmbYKshsy7mV1td/8eVzVU=
Date: Fri, 3 Apr 2026 09:09:45 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] mshv: Rename mshv_mem_region to mshv_region
Message-ID: <ac_mSSU3uRaAewE7@skinsburskii.localdomain>
References: <177508151446.215674.7844504277869257435.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177508156067.215674.12361225930217655159.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260402-fervent-thick-boobook-45dba9@anirudhrb>
 <ac6t9d2CIvL469_t@skinsburskii.localdomain>
 <20260403-gainful-cerulean-asp-5a1a2d@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260403-gainful-cerulean-asp-5a1a2d@anirudhrb>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9963-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2FC239646A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 03:54:52AM +0000, Anirudh Rayabharam wrote:
> On Thu, Apr 02, 2026 at 10:57:09AM -0700, Stanislav Kinsburskii wrote:
> > On Thu, Apr 02, 2026 at 04:33:24PM +0000, Anirudh Rayabharam wrote:
> > > On Wed, Apr 01, 2026 at 10:12:40PM +0000, Stanislav Kinsburskii wrote:
> > > > The mshv_mem_region structure represents guest address space regions,
> > > > which can be either RAM-backed memory or memory-mapped IO regions
> > > > without physical backing. The "mem_" prefix incorrectly suggests the
> > > > structure only handles memory regions, creating confusion about its
> > > > actual purpose.
> > > > 
> > > > Remove the "mem_" prefix to align with existing function naming
> > > > (mshv_region_map, mshv_region_pin, etc.) and accurately reflect that
> > > > this structure manages arbitrary guest address space mappings
> > > > regardless of their backing type.
> > > 
> > > I don't think the "mem_" prefix automatically suggested the backing
> > > type.
> > > 
> > 
> > What else can it suggest?
> 
> To me it just suggested that the struct contained info or properties of
> a guest memory region. The name itself didn't suggest what backing type
> the memory has.
> 

Right, that’s what the old name suggested to me too. And that’s the
problem. It’s inaccurate for MMIO regions. They have nothing to do with
memory. They are never backed by it.

> > 
> > > Isn't mshv_region too vague now? Region of what?
> > > 
> > 
> > The region of address space, which can or can not be backed by memory.
> 
> Yeah but that's not obvious just from the new name. The new name just
> says mshv_region and doesn't what the region is of.
> 

I hear you, but what else can we do? Keeping mshv_mem_region isn’t good
for the reasons above. Renaming it to `mshv_gpa_region` also feels
redundant detailization.

To me, this is a good tradeoff. Yes, it’s a bit too generic. But it’s
concise, and we don’t have any other regions in the codebase. So I don’t
think it will cause confusion.

Thanks,
Stanislav

> Thanks,
> Anirudh.
> 
> > 
> > Thanks,
> > Stanislav
> > 
> > > Thanks,
> > > Anirudh.

