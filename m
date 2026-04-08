Return-Path: <linux-hyperv+bounces-10082-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONtOKkgr1mkUBggAu9opvQ
	(envelope-from <linux-hyperv+bounces-10082-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 12:17:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF873BA67C
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 12:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A2B130087CD
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 10:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3193A3B27C4;
	Wed,  8 Apr 2026 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="e4m2O7H3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41B43A8727;
	Wed,  8 Apr 2026 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775643458; cv=none; b=Zf+5Mto2Km7wF+DObFTzlBWpdfN0209G/BvMLIXpEG59aFHFrXloH92jAZw4iLqco8AwIveiFBrw/l0HIN6CdEp79EX2OR093ltQtQYNkO0TmhL8wwWbn0AhB7l2IRVyyPz6EF2/8gQe1tqcs9c9B/WWI6KEwGzJ6PNUpvquJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775643458; c=relaxed/simple;
	bh=nEWVxVo+iN8auGoFh3rJ37Bps2pjZM/MQxKy+f604JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNXLlKtLmA/xlhvKuPxgOjLGn+l4Huo08mNTy36JCa4bOojicJuDqTMU6e55m51CEe2MJkULBFjBNwQatSX3cqlbltchmNMd8bMXMtO99Bb8uLDMDqigGNTGzq2ljJF3MOmoZitC7g4eGU/SHbVm5Ve41+TQEl7WFdSLRPpN9rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=e4m2O7H3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 1B55C20B710C; Wed,  8 Apr 2026 03:17:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B55C20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775643455;
	bh=FO68JFl1wL0TA6SrGQxonaUygrw8wFIRivcI+knoWPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e4m2O7H3aZh7M2EzH+r7qvwTxYfL1d8S+1MJfu0KaE10qX2TKAXaXkWCSy1xj3OkG
	 IVKdtOEpIdUcpdx1DFXCMoprR4KvgJJC5nGl/6NquQ5wHXlplHDYfVFt9MoVOZ+098
	 T36AbLln5UCqdmQhTd1jhR+KvvsWUVhKTI4DsMZY=
Date: Wed, 8 Apr 2026 03:17:35 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, gargaditya@linux.microsoft.com,
	shirazsaleem@microsoft.com, kees@kernel.org,
	kotaranov@microsoft.com, leon@kernel.org, shacharr@microsoft.com,
	stephen@networkplumber.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] net: mana: Fix probe/remove error path bugs
Message-ID: <adYrP2G3erPOCwp5@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260403070948.9225-1-ernis@linux.microsoft.com>
 <62c3fcc1-6758-47c4-984e-f6940139de0c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62c3fcc1-6758-47c4-984e-f6940139de0c@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10082-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 3EF873BA67C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 11:28:34PM -0700, Mohsin Bashir wrote:
> 
> 
> On 4/3/26 12:09 AM, Erni Sri Satya Vennela wrote:
> > Fix four pre-existing bugs in mana_probe()/mana_remove() error handling
> > that can cause warnings on uninitialized work structs, masked errors,
> > and resource leaks when early probe steps fail.
> > 
> > Patches 1-2 move work struct initialization (link_change_work and
> > gf_stats_work) to before any error path that could trigger
> > mana_remove(), preventing WARN_ON in __flush_work() or debug object
> > warnings when sync cancellation runs on uninitialized work structs.
> > 
> > Patch 3 prevents add_adev() from overwriting a port probe error,
> > which could leave the driver in a broken state with NULL ports while
> > reporting success.
> > 
> > Patch 4 changes 'goto out' to 'break' in mana_remove()'s port loop
> > so that mana_destroy_eq() is always reached, preventing EQ leaks when
> > a NULL port is encountered.
> > 
> > Erni Sri Satya Vennela (4):
> >    net: mana: Init link_change_work before potential error paths in probe
> >    net: mana: Init gf_stats_work before potential error paths in probe
> >    net: mana: Don't overwrite port probe error with add_adev result
> >    net: mana: Fix EQ leak in mana_remove on NULL port
> > 
> >   drivers/net/ethernet/microsoft/mana/mana_en.c | 28 +++++++++----------
> >   1 file changed, 14 insertions(+), 14 deletions(-)
> > 
> I believe mana is already in the mainline so fixes go to the net tree?

Thanks for the correction Mohsin.
I'll make this chaneg in the next version.

- Vennela

