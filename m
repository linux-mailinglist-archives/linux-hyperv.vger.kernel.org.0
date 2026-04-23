Return-Path: <linux-hyperv+bounces-10322-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDrrOOb66WnkpwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10322-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 12:56:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E57C9450F95
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 12:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A6BF3007B30
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 10:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E44A3E5EDD;
	Thu, 23 Apr 2026 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4kgi2vV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mOroCPqh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6D73E3DB7
	for <linux-hyperv@vger.kernel.org>; Thu, 23 Apr 2026 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941575; cv=none; b=QxoGBr3CqerZF44iYP68KLlSIFvwHMYtoNjrtRJEDtJBVRB6A/fzfXDue3Noyx8mtMlTSq5W5EEOzs+ZbQPqg/QHvWWkbXXhUw88/vd1I34UpPtB+LECySeuqhBbybviXz0pHzF4wJK9q8WZsggv3Z3zFg/JR5IxEo1uG9ECVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941575; c=relaxed/simple;
	bh=m101j43P5lzRFczyB45ahCNexSnh1DduvS39dTm8j24=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KQTxFd+jbjZgv9DnWTN9oAYqnO+EL+1UlawjF/fzxkmnt9mKI3TFhn+8vTVAyi7E+enqIFnat8gbWpZuw84Pb7/pFUQ/r7y9LI4QLefya9JsLLCT01+stzjzZ/TryU/vApvRossM0E0SaYLGvGsxl4xTeuOxNFjldhmz6XTeC9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W4kgi2vV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mOroCPqh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776941573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xC8tXl/B81gFeHZNp2utQBvI0XuSwkdb9RxGKsRnn8I=;
	b=W4kgi2vVaYn5QzB854oQbytmq6lKYPbL4cgsRWCIcOcI9kLuOnUziO1wNMm+vwrViX8yrx
	DuvcMCfhFCHMPsE49K1f61DzUgmmCK1ALj9aYmK9eXY97MUvnd9q4f8v0akaw5z4V1ITct
	28BWH9PdAr9W47sKXYgVdDIBJ7oBD/Q=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-vgXAO4e7PZ2NAtJf52mTNQ-1; Thu, 23 Apr 2026 06:52:50 -0400
X-MC-Unique: vgXAO4e7PZ2NAtJf52mTNQ-1
X-Mimecast-MFC-AGG-ID: vgXAO4e7PZ2NAtJf52mTNQ_1776941569
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b2e06219cbso83614395ad.3
        for <linux-hyperv@vger.kernel.org>; Thu, 23 Apr 2026 03:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776941569; x=1777546369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xC8tXl/B81gFeHZNp2utQBvI0XuSwkdb9RxGKsRnn8I=;
        b=mOroCPqheaaqKJ5+iHKdrC2TUFvjdhj8u4L8JDh7nm2LqvVYa4JjbKsaeiJCdyguq6
         w+yIazrrhxNxEAyo4nXD7tcNF+U/aYkpL+qfE5FodjLobeAqMV/X+L823nOrHdyB3sJo
         NRFwqKdpMUKsCOSwmWe9Yys9GFXEA7Yb5B1M01j4VFQSrR0tzrAwsT8Zd+as6tYlPGZP
         45W9U1V0cI9ZlDPmYDxR2XqmGdiNKe+DvocTJORUOzNn4qKyXOTvbIlN5L1ot8UC8guM
         0xCBlbEwQkcneTHCRw5v0IPpt6xhQT1i4UC5qZrpb404RW+5rQE6nTcjU62bsFEVIAGY
         ZVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776941569; x=1777546369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xC8tXl/B81gFeHZNp2utQBvI0XuSwkdb9RxGKsRnn8I=;
        b=XkclGgJFztUe38TSIvtkIqrR0HDSVdJet3bs7iJxpMBTNZ8JEXXem7BFXqvXCtwmNc
         5Hec4rn/+5xLZsHowMnnsRBG7Ye4oZM4DDvUWLnssU93r18/HtiddhZUxqSu9SHwsWzB
         Lq85yaX6+hxZMvODzdbinL+vnU9Y9B/YouRINdUENhBsMmHzd3gLkMg3uR2ZzvYoIeii
         QTOTaIhGMNJZs4VdaGGLakNEf/Gk4i39o7G4h/WQgjRN7lXlyv0RUlts40Pp17B0Vov+
         BwpA8M1Zenm0TWszItqHsi/sKRloHJCogV11d+UYirPcLK8LG0XG5b6Y5hReaTpRV0Km
         kt6g==
X-Forwarded-Encrypted: i=1; AFNElJ9jU0gPC3oYdct9odzt2705e/7rFJWZ31sXDS3SqouCPW+J1fC0Wlykwpop1+x1E6toAMFW6V79Kfyt3ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTVWMt6mQbb2Vsl8vcebzp+dsDeHGyJ411XU6lqZI8GTP3b63J
	0fR0aId5n6kD4Tin5ixsna+bKYwIgfa2/6LdGNZjvPgGgUoasVPp1HG6HEHJlZTc1g21tN/DrBU
	yL2eg+e73yleQl778ewsMc0ubfnvq2Q1dPGZ2HBMiwJG3ShOS5vlDHaXkU0UwXn69yA==
X-Gm-Gg: AeBDievKtop40LwkfhlI5hKef7x6mfKoDqX3ee3yp0Jxq9eU3WiQALtJxvqInh3yBij
	UomINey2P5fe3FiOO2/KlffH0Vza7erz/DB3yw9+aRuj896TLCm0PwpEWSnb0N+aD71774S+g0v
	XH2TIoLIynGtSvKlDPzP04eBfZGjJqqzLmi2Abyz60QbjUZHb5wU4tJ+kX0g+d+fGkZtc0e4N8y
	5VI2dGYyjfEV3t2iNQUq2k6SdHgg/De7Rff8keBwo4Oi49GZtI4pM29XULRVoRuoerl1zQ1q58f
	vL7/NTo+2PxEVggOpcTaDl9HWaRXzMW/JAQbl5eutpRfGWxH9KKVqZEFoTlEz4E1UIVYOH+QIrE
	QpU0y6HOeIOtOhUd5KHOoY4UVhPb0rRR2ZYTq4rZ8cYMVsD9bnVSud9zkz0g4aEDPfyM=
X-Received: by 2002:a17:903:2c5:b0:2b2:4697:4370 with SMTP id d9443c01a7336-2b5f9e8cac7mr273755045ad.3.1776941569011;
        Thu, 23 Apr 2026 03:52:49 -0700 (PDT)
X-Received: by 2002:a17:903:2c5:b0:2b2:4697:4370 with SMTP id d9443c01a7336-2b5f9e8cac7mr273754785ad.3.1776941568531;
        Thu, 23 Apr 2026 03:52:48 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff71esm198582245ad.8.2026.04.23.03.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 03:52:48 -0700 (PDT)
Message-ID: <d47894f2-4af2-47d5-9961-51ba07441212@redhat.com>
Date: Thu, 23 Apr 2026 12:52:32 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 3/5] net: mana: Guard mana_remove against double
 invocation
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, ssengar@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, gargaditya@linux.microsoft.com,
 shirazsaleem@microsoft.com, kees@kernel.org, kotaranov@microsoft.com,
 leon@kernel.org, shacharr@microsoft.com, stephen@networkplumber.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260420124741.1056179-1-ernis@linux.microsoft.com>
 <20260420124741.1056179-4-ernis@linux.microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260420124741.1056179-4-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10322-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E57C9450F95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 2:47 PM, Erni Sri Satya Vennela wrote:
> If PM resume fails (e.g., mana_attach() returns an error), mana_probe()
> calls mana_remove(), which tears down the device and sets
> gd->gdma_context = NULL and gd->driver_data = NULL.
> 
> However, a failed resume callback does not automatically unbind the
> driver. When the device is eventually unbound, mana_remove() is invoked
> a second time. Without a NULL check, it dereferences gc->dev with
> gc == NULL, causing a kernel panic.
> 
> Add an early return if gdma_context or driver_data is NULL so the second
> invocation is harmless. Move the dev = gc->dev assignment after the
> guard so it cannot dereference NULL.
> 
> Fixes: 635096a86edb ("net: mana: Support hibernation and kexec")
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
> Changes in v4:
> * Update Fixes tag to 635096a86edb
> Changes in v3:
> * Add this patch to the patchset
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 468ed60a8a00..ce1b7ec46a27 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3731,11 +3731,16 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
>  	struct gdma_context *gc = gd->gdma_context;
>  	struct mana_context *ac = gd->driver_data;
>  	struct mana_port_context *apc;
> -	struct device *dev = gc->dev;
> +	struct device *dev;
>  	struct net_device *ndev;
>  	int err;
>  	int i;

The above breaks the reverse christmas tree order. I'll apply the patch
as-is to avoid additional traffic for very little to no gain, but should
you touch again this code in the future for other reasons, please
restore the above.

/P


