Return-Path: <linux-hyperv+bounces-10139-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DB8ALQx3Wn1aQkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10139-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 20:11:00 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0F93F1D5A
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 20:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52E1E3016489
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 18:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EE53B635C;
	Mon, 13 Apr 2026 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Eour0WHn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4142417BB21;
	Mon, 13 Apr 2026 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776103855; cv=none; b=YY9m/IMbzFekUM7t1dw8f1s+tTa+QBF/n5k7VOX18tllvYP3fZoAReUBetQrpZ+9p9f8ErxANHUZie7SRIZlRUyJSXTTjgovKnHEgk6zvLsb5YS/9ztSsStnmaq0+cONWp/FHWlVFM26jwb1j5zzwXSY0s4evfYU29L4GObQUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776103855; c=relaxed/simple;
	bh=fUm1j1mUlx6MdbVJ6m8o5VQHDJvHgFu9nQfw6MYG4T0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=V3YrHFOcqgyzRU3WTMZdGYILedSfe0mHqvAA2PK1NNE9fuM7n/lp2efuPTwgvcH6GfgZxgCYmtK7mOaE4UKM8smQzJAgGOTcwW6ypiaoFdjWOd9gHVixX4esS10FLrtG7QdbC332A59z62h6RX0h73OY7oDrmeU52doOiZp84ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Eour0WHn; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fvb7F6zcRz9tlh;
	Mon, 13 Apr 2026 20:10:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1776103850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70+ZelzEcty5Bb4nZGDma9Zdvy58Ml4EgdM16174ImU=;
	b=Eour0WHnu6JyJ5E/AosZbvlFl1oI6cA1mPwYumbLLOQZClGkGvmZb9hoeEKn4ezo9ice13
	wVEXYcTmFw5ybJKwSNfpM1Xtyv3IEhc5L0I/wrHzpyp+JvDT996aF1RMMJFD6QY2Rovlo9
	xLMKJe+7Mhq2zQKNpu6phxu03goDkam99ykEBjqqWb+ao0mgL7DgP7QlN68jerGj2VecNm
	nDazTzeewGSgOcpfQw0gbrcjT04FkqgsFrT+EI7JGCG1YcNn90skm6/T9EI7phH9owvEiz
	84fh4sadoanwlPHyf+YKvoyYSbLFP+DmUYw1ic0liPRaIKCbgh23uRi/ET86bA==
Date: Mon, 13 Apr 2026 10:10:46 -0800 (PST)
From: vdso@mailbox.org
To: Junrui Luo <moonafterrain@outlook.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Muminul Islam <muislam@microsoft.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Jinank Jain <jinankjain@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Yuhao Jiang <danisjiang@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Message-ID: <1644495552.14476.1776103846016@app.mailbox.org>
In-Reply-To: <19EDB8B0-A6F4-460F-8ABA-E9D3E239511B@outlook.com>
References: <SYBPR01MB788138A30BC69B0F5C3316E5AF54A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <ac76zlXjXhPVkA6f@skinsburskii.localdomain>
 <89730D18-D9A3-4A18-87DD-E7A51625FF69@outlook.com>
 <319614096.43465.1775883935863@app.mailbox.org>
 <19EDB8B0-A6F4-460F-8ABA-E9D3E239511B@outlook.com>
Subject: Re: [PATCH v2] Drivers: hv: mshv: fix integer overflow in memory
 region overlap check
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-META: 99gp1th757sh7wsy5ngk1jpx7ssqa5pf
X-MBO-RS-ID: 7f88d59ebc95e303709
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_X_PRIO_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10139-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,linux.microsoft.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdso@mailbox.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email,mailbox.org:dkim,mailbox.org:email,app.mailbox.org:mid]
X-Rspamd-Queue-Id: 6D0F93F1D5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> On 04/13/2026 1:43 AM PDT Junrui Luo <moonafterrain@outlook.com> wrote:
> 
>  
> On Fri, Apr 10, 2026 at 09:05:35PM -0800, vdso@mailbox.org wrote:
> > All in all, from the three options of (generic check for overflow, simple check
> > for arch bad PFNs/GFNs, an elaborated check with all specifics) I suggested the simple check.
> > Fast and still more useful than checking for overflow in my opinion.
>  
> Thanks Roman for the thorough write-up. Since the original patch mixes
> host and hypervisor-side constants with an unclear unit, IMO we should
> do the bounds check in bytes instead.
> 
> For instance:
> 
> 	u64 start_gpa, end_gpa;
> 
> 	if (check_mul_overflow(mem->guest_pfn, HV_HYP_PAGE_SIZE,
> 						   &start_gpa) ||
> 		check_add_overflow(start_gpa, mem->size, &end_gpa) ||
> 		end_gpa > (1ULL << MAX_PHYSMEM_BITS))
> 		return -EINVAL;
> 
> Both sides of the final comparison are bytes, so no host-vs-hv page
> unit conversion is needed.

I like that better indeed!

> 
> In addition, it changes return value from -EOVERFLOW to -EINVAL.

I think that good, too: -EOVERFLOW originated iiuc and is more used
in VFS from my cursory glance.

> 
> Does this approach look reasonable? Happy to iterate if either of you
> would prefer a different choice.

I agree with all your points, feels like a better place now :)

I'd defer the final smell check to Stanislav. Stanislav maintains this code
as the daily job, and might have a better feel and perspective for it. I've
been happy to add my 2c!

> 
> Thanks,
> Junrui Luo

