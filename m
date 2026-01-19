Return-Path: <linux-hyperv+bounces-8366-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E700D3B07A
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Jan 2026 17:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC6A9303769D
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Jan 2026 16:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5A82C0F6F;
	Mon, 19 Jan 2026 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Em19JCfs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD3288515;
	Mon, 19 Jan 2026 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839774; cv=none; b=CPDcLY8ORpRTA3FkaWSzve8ZCM0r4xqpaRg1yScVBLfkivbGRO+xShSmmHQuPDqF8DjXjSJDtL3qyo/Zm0ExG+JcyF8IkA+/lxZMecwXwK3tGlZmvfLfjgzX8I7RHiksWcQl5pfViw6+1E89GGxmc5tQOmTqoD3QYOrbtvwe4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839774; c=relaxed/simple;
	bh=OE5nC2VtQGiZDwOuAGWiJUCU99pZSv6oST5pt4IajBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZiSUhd9pOYBaZhHJbzSmzwblBbe0jpfDSkIHrDsftNufcekp72+6CFMAoMGdIJaNMqLcOuNzLWQeh2ne77q08Z0GWgjPQ7FZMRpsgpJyUtg46BxzPYO2BiwTsQPjsRgiji9KgbLnUUDgCc03bZ87C8a1/XFzcbQio4KOEcyGpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Em19JCfs; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9483:13a:c452:d5de:4aa7] ([IPv6:2601:646:8081:9483:13a:c452:d5de:4aa7])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60JGM6Vu3000388
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 19 Jan 2026 08:22:20 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60JGM6Vu3000388
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1768839741;
	bh=aVPE2blVoNHhOyOvLylvlo8Ll91bFtveKdcM/w6wPus=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Em19JCfsgP1GoIxHy9wHwYGalIpOKbEUnMHhIxL9rplu9h7sbmBDePfGzlq95Y1gR
	 lPA9XJgLSm7R1JhmNsmbQdA2F/1RyJwdNJm1OG50YjBiPdZLmTrQKXN63PzH2jMkuh
	 WznEPK87ChMgP/3125Do3HXwS+2p1k/FfdvJnQ4FWJoFt5EipWgDFtJO+BOzz5jCPr
	 i6XoKnuKhvW707LwygO+2EfLNGdErfpaSiEk3gngKxQdKEraga6qmpKOZvmSst1YLl
	 GXFS06dLOrkLhmaQnIqdnpxb9C34sEVAmjXidsL1BEExsWknc6r4q1YUg8ZjtCbQdz
	 WDtELbo6yGr8Q==
Message-ID: <40e224c7-3809-4c84-9819-cd7350365f0e@zytor.com>
Date: Mon, 19 Jan 2026 08:22:00 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 2/3] x86/hyperv: Use savesegment() instead of
 inline asm() to save segment registers
To: Uros Bizjak <ubizjak@gmail.com>, linux-hyperv@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20260105090422.6243-1-ubizjak@gmail.com>
 <20260105090422.6243-2-ubizjak@gmail.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260105090422.6243-2-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-01-05 01:02, Uros Bizjak wrote:
> Use standard savesegment() utility macro to save segment registers.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Acked-by: Wei Liu <wei.liu@kernel.org>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>  arch/x86/hyperv/ivm.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>

Looks good to me.

Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>

