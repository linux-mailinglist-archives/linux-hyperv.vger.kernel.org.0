Return-Path: <linux-hyperv+bounces-9975-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBB7G8cS0Gks3AYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9975-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 21:19:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11803397976
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 21:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E19D300989D
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 19:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3773B30C601;
	Fri,  3 Apr 2026 19:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KAu/Lsul"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261A2625;
	Fri,  3 Apr 2026 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775243972; cv=none; b=HPdYUnZT3KSsIeznxZ+bK21MUw/3fE6kpyAHQHzNnTsaXQFjSWprGN9Ld7RgVZd728DP7q+0lGvzK3E+OlIw8NdGTDpcFbBipM08uP+OWHzBtwVp2ok4eFZdi71JJPqfSImDawHSXQbK4tlnATwvpV5KmRiSE5WeVn+5be9/YAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775243972; c=relaxed/simple;
	bh=dJ3mJRFXJnl7zAHnkegxJZNmgTrI7QOk3TbHXVD6x6U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=N2/6VOQL8Uc/cpxc6pr0u8XiR63MZv4RL7XJA845lbM8jyuszA5AFDTIQ/ndhlcn80/xVER9Qi34mGYSZBYd0uwPfaDouHrw/XiBzW0A81RBiKdj/O2/18UpyyM901NqTWUrH4zZO+uSZgYbWVwNVLX/siM5dEpnIG8+PQX5mDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KAu/Lsul; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id C433C20B6F01; Fri,  3 Apr 2026 12:19:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C433C20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775243970;
	bh=dJ3mJRFXJnl7zAHnkegxJZNmgTrI7QOk3TbHXVD6x6U=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KAu/LsulqxDmflY/8MlzbVSDCiOPW4b/FkQf4N1h3oNEisn+ozH1Qg4aka+ZcE6s0
	 SfvOc1w0XLw2IqhaUd9Vb2wYjCJgtnNI+1l5seYcMLzVLcHddaeYphNId2SEmS+jt0
	 eBG1i1aR/HZe09233r/oWcRLiemAQkKdGjnqSkxg=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id BFA0D30705A5;
	Fri,  3 Apr 2026 12:19:30 -0700 (PDT)
Date: Fri, 3 Apr 2026 12:19:30 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
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
Subject: Re: [PATCH 4/6] mshv: limit SynIC management to MSHV-owned
 resources
In-Reply-To: <20260403-natural-fuzzy-kakapo-f5cbab@anirudhrb>
Message-ID: <72f015-f6f3-68e-58a8-c183f8341868@linux.microsoft.com>
References: <20260327201920.2100427-1-jloeser@linux.microsoft.com> <20260327201920.2100427-5-jloeser@linux.microsoft.com> <20260403-natural-fuzzy-kakapo-f5cbab@anirudhrb>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linux.microsoft.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-9975-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 11803397976
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 3 Apr 2026, Anirudh Rayabharam wrote:

> Actually, I believe VMBus does run on a nested root partition. Doesn't
> it? That would then be another case to handle in this patch.

Good catch, v2 series is out.

Best,
Jork

