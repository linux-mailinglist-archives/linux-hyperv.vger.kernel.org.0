Return-Path: <linux-hyperv+bounces-7359-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A432BC15315
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Oct 2025 15:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43BA656315A
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Oct 2025 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFF522173A;
	Tue, 28 Oct 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGyFEA+2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EF221772A
	for <linux-hyperv@vger.kernel.org>; Tue, 28 Oct 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661896; cv=none; b=UAty3MzNqQ4t5YnLIG8YL4zGClxLp/svYyivdYoIAG69K6yRjV5qV/1ttm99pUcuI7DQ/IAG3p2OoHMvGJyhmYlBzSNhV7vsZO20/4NFj/7B78XBJ/1d47ym6VsTDDPQru7wcU58Pnwg+plScSA5dvLPvz7Jf5eMqkiJd/68Ly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661896; c=relaxed/simple;
	bh=lSvM53GFft+J8S+6HgqdJu8eZNoSNRi/6wce+FaPoNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHp1kkrld1uQpngJAkOosoHv2qCkoOZQ2ydwsPcf7M7zHYTuUPsRng+1GlctDo/DQCZNaKj5NBT1foWNwy9iuwnCxeTJX+/8gMviJWFvP91m7a/397bC7iNrKhVeUIJcyqS9pvrAvP8kSk0gKCtkf7Tjk3FKBmh4ji7doxY6JKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGyFEA+2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761661893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73/xPfC9sPKYuWBDNGOrntIS8v774C/e1wt54BijNYE=;
	b=hGyFEA+2qNou4Kab0bzN/De7BVeD2N4vPfemk2obMoAu5zyolB/b6i6x+6650VKtlxkwPd
	gL6gd7w0GEz5P4SAes75p83y8Wnk4rUsCaKGuGhldCzseLsd0f49LybvUZE4GTnfZFOezK
	N3QOnncFGfdzJzFsmGPtYEHbsJ7AGDI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672--FqLZOCOMtWpNH1YttV9Ow-1; Tue, 28 Oct 2025 10:31:32 -0400
X-MC-Unique: -FqLZOCOMtWpNH1YttV9Ow-1
X-Mimecast-MFC-AGG-ID: -FqLZOCOMtWpNH1YttV9Ow_1761661891
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4284525aecbso4002331f8f.1
        for <linux-hyperv@vger.kernel.org>; Tue, 28 Oct 2025 07:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761661891; x=1762266691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73/xPfC9sPKYuWBDNGOrntIS8v774C/e1wt54BijNYE=;
        b=nd1Jw7W0RKFBcX93vO3HHTJVpgfUq6wKyVc7/KflHtKhqsSkaW+z646Xg/K6sD18ia
         L6IEUlX3k3jWOMWY+pPISLQrCf45NatZT8RyJQZ77S1FFufmE3YSWqP4O43bq6fgBZ38
         EU8iuz5kPM2fvC5yf3GAooj0M3TjOp6wog3NJyCLAEGfTLaCr5SbAofohpd1Vcq0+vAR
         fGo+/oB6qO3zCAx2nJkDGbmGlhP3nY09vqq7UnQNWr4gKxXmnOJsHHoe3xEZxNuOuqzC
         d5c6WCHOF3NOamMD3Vnem/I9v1Yh0ZrBXWbl5TgpQ82qQSCZkq28IcsAeZYOmf3B/HCS
         l7ug==
X-Forwarded-Encrypted: i=1; AJvYcCVaVUnWqndGCOyaNmuPQzXO+2ytBW6tUhXTHq4ydQiKQmCKnhTVX7n14a/PMgkSIDZy5gHGR874Z0r+0eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytOC5Dp8pFsNt5lTF4Za9OiETPaEf2rtE070P5vFORciC5l4VO
	ODn6YGddY0FOlVRdtd1pxnElDPSiQALtjd4O3ewSusMMKWp9gUqt6EnF3TOsrJmdvCiEVPLrF05
	1z8zdu5QBbY64kUaJpifaocDWKG6MFL1E4MC1oTScXKUb98eLzca2ITGlFgIl79rpUw==
X-Gm-Gg: ASbGncukovUUvZVPxWw46Iy2Qnlqlxk9K9/7dyUUtWiLRiQXWmpTmM08Yh1g6nwF88r
	WiGdqeToVtg0D1BBHlI+1+YFQx0yiFUga+B/DDMNL4C/UmjKznTY3YS4KVNY47/mRU67kWs6hwX
	DrIMJzxqOc6agj5ZtNszL1oW0pEq+jJkGApFo8rS2FHk1dM6eFQhgKug+Uh20pc2lbg3sZsuNFI
	auBQ2Ic8QkltFc1WvuNFJ5by3/IOMwq1b2gmI0LmbaC22yKaLrRj3weskrm3siqIGRBmCJg8ESJ
	NTOy0/5lr1/HOjPaC08aFqVT8zxB1XZtCN9iRZhc/67J7S2tdhFwjCa3vrQ6K4wR+bTRyM/SiqV
	u4eO3Hu17xbtl5G5qPMAuTN5N4JxNlxSvkDIcsfYrvDHxaZE=
X-Received: by 2002:a5d:64c3:0:b0:427:928:78a0 with SMTP id ffacd0b85a97d-429a7e9cb6cmr3247933f8f.63.1761661891142;
        Tue, 28 Oct 2025 07:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMOTsGZSXAVq3SjJu/2WS9NseH84hxo6jnqAKfyR6/9FeNPp9QtVjNi6BEGt5SyDkugzoCAA==
X-Received: by 2002:a5d:64c3:0:b0:427:928:78a0 with SMTP id ffacd0b85a97d-429a7e9cb6cmr3247897f8f.63.1761661890726;
        Tue, 28 Oct 2025 07:31:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a94sm24431112f8f.5.2025.10.28.07.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 07:31:30 -0700 (PDT)
Message-ID: <76598660-8b8e-4fe6-974b-5f3eb431a1ec@redhat.com>
Date: Tue, 28 Oct 2025 15:31:28 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next, v3] net: mana: Support HW link state events
To: Haiyang Zhang <haiyangz@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org
Cc: haiyangz@microsoft.com, paulros@microsoft.com, decui@microsoft.com,
 kys@microsoft.com, wei.liu@kernel.org, edumazet@google.com,
 davem@davemloft.net, kuba@kernel.org, longli@microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, leon@kernel.org, mlevitsk@redhat.com,
 yury.norov@gmail.com, shirazsaleem@microsoft.com, andrew+netdev@lunn.ch,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1761270105-27215-1-git-send-email-haiyangz@linux.microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1761270105-27215-1-git-send-email-haiyangz@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/25 3:41 AM, Haiyang Zhang wrote:
> @@ -3243,6 +3278,8 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
>  		goto free_indir;
>  	}
>  
> +	netif_carrier_on(ndev);

Why is  the above needed? I thought mana_link_state_handle() should kick
and set the carrier on as needed???

/P


