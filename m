Return-Path: <linux-hyperv+bounces-9883-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLEGBtxczWkRcQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9883-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 19:58:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 739FC37EEE8
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 19:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E0533010DAD
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 17:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02BD3090CC;
	Wed,  1 Apr 2026 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WRjtVjXu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D132A2FD1AA;
	Wed,  1 Apr 2026 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065637; cv=none; b=j1N52cJRcjTUen+NYKSIonC88OQMwJnh9PEjHtGYaFtssSI2Grz8JZDfnAJXhwFKJAxUS9N6S4RxikXfpFDNXIt1HN/LTVw+iMArpLThwpZgR2q5zzWvTBaJkaxQASqH7zFtFLK5ntnhfzcYHCxsxxIaF+GlAYDlhdXGVEoQxmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065637; c=relaxed/simple;
	bh=2HWNGN087gz7GE251OyfR94/6I847zuQQ59q4IfndXY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TOFHfR3w1wYcmThkjjMtRggIUhy6RIVt4OVeGgodO3mWfhYPhKcvgBVpEo/HJifAzBtUVtPb5Z+MFUwa2H3GpFccBMpNwo3FLaIJaFr8Xs3iaVdl/Dbau1t4j2YUFrPI+8e+ukGgT/eQbCjs5qGcaJ5p3+1ARGQWvub70t4D2mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WRjtVjXu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 044CD20B710C; Wed,  1 Apr 2026 10:47:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 044CD20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775065637;
	bh=GVZ6AfYHfFQdP8AbVauKGzQ4QHfyPw/mi+D6kmLBC1k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=WRjtVjXuq5Y5pDEIrJcVF3AAunv0f72pPS/qmrhKlkMTyARW1vrpPV2eqUNKIkmWQ
	 iL8kXJgcvL2GnycIfPtvJZea6Gd5FdZst+70y/OEGUdCC+V5acoLP++MJXR7Di8HmC
	 TLk/j2PYIWutxk6fZNj7hmn+vO+ryq3u0QubKlDs=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id 029E4307050E;
	Wed,  1 Apr 2026 10:47:17 -0700 (PDT)
Date: Wed, 1 Apr 2026 10:47:16 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
cc: linux-hyperv@vger.kernel.org, x86@kernel.org, 
    "K . Y . Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
    Roman Kisel <romank@linux.microsoft.com>, 
    Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org, 
    linux-arch@vger.kernel.org
Subject: Re: [PATCH 6/6] mshv: unmap debugfs stats pages on kexec
In-Reply-To: <acrxBOLaHdku6kdZ@skinsburskii.localdomain>
Message-ID: <47e5a81-a2d6-b59d-f087-26b148fdb43@linux.microsoft.com>
References: <20260327201920.2100427-1-jloeser@linux.microsoft.com> <20260327201920.2100427-7-jloeser@linux.microsoft.com> <acrxBOLaHdku6kdZ@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linux.microsoft.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-9883-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 739FC37EEE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026, Stanislav Kinsburskii wrote:

>> diff --git a/drivers/hv/mshv_debugfs.c b/drivers/hv/mshv_debugfs.c
[...]
>> +++ b/drivers/hv/mshv_debugfs.c
>> @@ -676,8 +676,10 @@ int __init mshv_debugfs_init(void)
> nit: this should allow to avoid setting mshv_debugfs to NULL in the
> error path of mshv_debugfs_init():
>
> if (!IS_ERR_OR_NULL(mshv_debugfs))

Yes, of course one could. Though a permanent ERR_PTR in a global variable 
to indicate init-problems feels off to me. NULL for "not there" seems more 
canonical, no?

Best,
Jork

