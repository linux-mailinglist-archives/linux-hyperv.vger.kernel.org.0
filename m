Return-Path: <linux-hyperv+bounces-9061-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL3JJM+YomlI4QQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9061-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 08:27:11 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA58F1C0F97
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 08:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B035C308DD80
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 07:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C5936C0B7;
	Sat, 28 Feb 2026 07:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lc2T9HXc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EA3247280;
	Sat, 28 Feb 2026 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772263602; cv=none; b=glH90Kvqn5rMBEsrNL/o7lwPxMRvGUUapcaQ/E7kZoFn8xVTDpFf0xn3Fqz2acZqntdL0F0dyXb/OAslzB4J2tzt5pCApkIoa6ULOCaPZMCuQQBj0681YPhV0Tilrzg53UZJqQw5cHwdEMm+MZPMwveZOV8llisdO+Ite5FVsW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772263602; c=relaxed/simple;
	bh=la1k0qVE7tEj6AhoorUZgvVmo+skx2MsfaJkg4YLLC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4xaMkC+7vncTDpqEVtpcKW7d1/ZhGjnypvOWMCQ+xzDmufTu7MB2+f+hPJBgTEd6k444tCa9MLkkxbnhPewyfSH7eNnDhLCqnB1+ToMz+Zzrhsv1N1j2TEm1yDzjo12XSiU1omNkKyHG5EBM++07FNE9YdPy41cm+N0Ww2yzZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lc2T9HXc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id D0CCE20B6F02; Fri, 27 Feb 2026 23:26:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D0CCE20B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772263600;
	bh=H7IgNxQhsQud3Cq9iabfbl9svkP+F0au7psQpfyqVTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lc2T9HXcGR8jfjlkOSiRptWj2kUbcf6TS+L45GtiT665cwUCj/SOE/D6zveWHX6Ok
	 q67Lvirddo8FWEPnkU6Flqd1AQImG/sjgtrmx6/XD5YpMJPVBAeNH9v0p7Y74CN2/3
	 5qcBEn2Lg7unNb9DVMzQaGnk2wtI0uZr306FRlZQ=
Date: Fri, 27 Feb 2026 23:26:40 -0800
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
	ssengar@linux.microsoft.com, shradhagupta@linux.microsoft.com,
	gargaditya@linux.microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: mana: Add MAC address to vPort logs and
 clarify error messages
Message-ID: <aaKYsC8mr40/nr1Y@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260225192252.943534-1-ernis@linux.microsoft.com>
 <aaHrN+spIIaswoX6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260227165226.07efbefd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260227165226.07efbefd@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9061-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EA58F1C0F97
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 04:52:26PM -0800, Jakub Kicinski wrote:
> On Fri, 27 Feb 2026 11:06:31 -0800 Erni Sri Satya Vennela wrote:
> > On Wed, Feb 25, 2026 at 11:22:41AM -0800, Erni Sri Satya Vennela wrote:
> > > Add MAC address to vPort configuration success message and update error
> > > message to be more specific about HWC message errors in
> > > mana_send_request.
> > > 
> > > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>  
> > 
> > Gentle ping — I sent this patch on 25/02/2026 and would appreciate any
> > feedback when you have time.  
> > Happy to rebase or add more details if needed, thanks for your review.
> 
> What are you trying to achieve with this ping? Just look at patchwork,
> there are 61 patches ahead of you in the queue.
> 
> These are Microsoft review contribution scores:
>   Author score negative (-42)
>   Company score negative (-1118)
> so you expecting that someone in the community will jump onto reviewing
> your patches is... odd. How about you review something?
> 
> Read the process documentation, and please have some basic
> understanding of what is consider good manners when communicating
> upstream.

I'm sorry for causing the trouble, and I appreciate you pointing this out.
I’ll be more patient with the review process and wait my turn in the
queue.

- Vennela

