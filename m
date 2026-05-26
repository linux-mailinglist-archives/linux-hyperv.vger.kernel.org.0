Return-Path: <linux-hyperv+bounces-11198-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFdrImGzFWpxYAcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11198-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 16:51:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E65285D7F33
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 16:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30086303FAB7
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00424028CD;
	Tue, 26 May 2026 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FrFggD3/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A724C402442;
	Tue, 26 May 2026 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806621; cv=none; b=O6T0FrbPXyKg4nrC2tE+UXMXdMnsnJXfVZVnSKEA79dr54DQeLm+nQv7FlTXgskaQtEoh9+A0oID/4K/ZT0yatIMyrZziOjrlIAxpmejoqtdT/QbKffQHkboxDZ6ARIiFfBrxe9XaC8bZE3UAThpBeqZNzSdPmbBSkJfA0Q7k0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806621; c=relaxed/simple;
	bh=hZvvN0oBfdzwQ/sjgOKpDYLeU3Uo+CRREWp4kYRbAIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8aX7LJ6G88rJigbFGalfjkFNv8BsEoNvXq+WgG0gl9V5Rozv4g2O/vsFNnjp/x6KcjgWgBMjoY+RYdHRRQy8F3Z+k0Hx2ZOapBh/dBH1z15WIoX9TLVMZAp/SivxafH2OHFY4S574x+Q9itKx/teL1c0zuR/NxinaH/5i1m3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FrFggD3/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 9B04A20B7168; Tue, 26 May 2026 07:43:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B04A20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779806610;
	bh=6+tmVNDyxF9HD3+7YnlVRkDsRoAC36scvoAFEWcFK04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrFggD3/X0T92vrZM8xnRx20Ni9VTv5GPuJyRpoAKD/ow4pKSS/zbdw4dreaceIzB
	 uMHu5A5vI0zdrNQHWxWSquGG/e2B+VLfCqbRaqa7Y7VX2lKm8MefRE2VVsYwCZJ2b1
	 ZpcSb2sXl/nwyKvzFdA67tvzS3gWOnBIUBTCaLgY=
Date: Tue, 26 May 2026 07:43:30 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Long Li <longli@microsoft.com>, Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening:
 Clamp adapter capability values from MANA_IB_GET_ADAPTER_CAP
Message-ID: <ahWxkgvRqL8V13fO@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260312181642.989735-1-ernis@linux.microsoft.com>
 <20260316194929.GI61385@unreal>
 <SA1PR21MB66832D25A93394735624F454CE40A@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260317094408.GR61385@unreal>
 <SA1PR21MB66833EBAF447BA0B102862FCCE4DA@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260410154327.GA2551565@ziepe.ca>
 <LV0PR21MB66700DC2FB827B93ED6A5714CE592@LV0PR21MB6670.namprd21.prod.outlook.com>
 <20260413134602.GL3694781@ziepe.ca>
 <ahSbyYcq0sgfJnmZ@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260525230155.GB2487554@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525230155.GB2487554@ziepe.ca>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11198-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E65285D7F33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 08:01:55PM -0300, Jason Gunthorpe wrote:
> On Mon, May 25, 2026 at 11:58:17AM -0700, Erni Sri Satya Vennela wrote:
> > > “There is no reason they should be signed, you should just fix the
> > > type.”
> > 
> > It is not allowed to change sign in props, so clamping is the best bet.
> 
> Why not? Fix the core code, it is just old junk they are signed, they
> should't never have been.
> 
> Jason

Thanks for the feedback, Jason.

I sent the v3 before your comments in v2.
I'll be sending a v4 which drops the clamping entirely.

- Vennela

