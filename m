Return-Path: <linux-hyperv+bounces-6064-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DF2AEF9B7
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Jul 2025 15:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6E2188DE08
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Jul 2025 13:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19C82749DE;
	Tue,  1 Jul 2025 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afL7244/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B80274658
	for <linux-hyperv@vger.kernel.org>; Tue,  1 Jul 2025 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375089; cv=none; b=aiWxC2APqZgGlPwadAkiVS2k3JTH6eVjl1ZHd5qd4DKnTbhJ/rXSnbQOdBfr18LNlOgSkcAyMMqJQFs6E0BFor+u75E6Wk35fRpowOMDXcRtTSJC8g9FAZcKNkCMd4ACXyHpZDS81oDpc8KNXp0H0SydtJtHOBAztPYZ7O/h79M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375089; c=relaxed/simple;
	bh=1u6LtBFBZpYRhcRKXCfqg8lwwnGpi9KXfabJfPSkfec=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eRyCDwAAjSMBiFRxJgj0atlkVzMJVPvj16TcK7OaJmH1hZyQahVXojr9ZKvYX8/DQohaUzz1IeCTeVMdIvvthRL7XwvgUiIuq3vPkz4vPqUz3yDr/LUNUHAcNu5UyYByvPXWxjZcx48aRB1ZMsHdYST6SgCHhwoMe3Shs0GF4nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=afL7244/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751375087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Qg+m2/pNVkQnC5aBRNuH+sXdMQvLaC9DgJfu+jNhg0=;
	b=afL7244/oFwyo55Ha1h2ii+ARcmLJSvO7vHZ9n3yu3lA/5MmtAHqt8tVQejr4YrrfwMEQv
	48SkhKxitODw3V0Cu7W8+7OncmHHmK87GkeCRnCgn6ay8St6NQ4kcIiJJHf5CpwJXNfm8W
	Pm0PSoG1B3LYDjcUsN51BZMP3wuZsBE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677--wIN6jv7N1eOyIGs1B7IZg-1; Tue, 01 Jul 2025 09:04:46 -0400
X-MC-Unique: -wIN6jv7N1eOyIGs1B7IZg-1
X-Mimecast-MFC-AGG-ID: -wIN6jv7N1eOyIGs1B7IZg_1751375085
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4530c186394so14912585e9.0
        for <linux-hyperv@vger.kernel.org>; Tue, 01 Jul 2025 06:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751375084; x=1751979884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Qg+m2/pNVkQnC5aBRNuH+sXdMQvLaC9DgJfu+jNhg0=;
        b=Wn6GMArJ4OT5L4NHwQ47VPeqe+yLllw1d1heI/Ndyfn9uogdEteWjbm67+QOtqSSBZ
         2oSmDbxWPapoU/k9y8ZcnuXpUQYM8tA2E597K8DQ0o91AW0TE/ng6q+19GxLaKViE7Go
         g459pgOYK5mDqS0ZaKSoyTEa9MPLar6efXz3bMM3z4i99qLkpr+BLFfBACSnusDEjll7
         Hczs6eibOmPQzUrcSETIF1TIbk+WUO41hZNLkxIa8fhmcxVzultO+hhxWF6YqQHMnjqf
         c0UU/6seR9c53ixOhZQAfKG+kW6aBKlt8egqcmKJVUur9M58VVo9ItzKUhb9n6EaYUmj
         Q4Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUq6zljkJt5u/oFvEX7rX9JIL5BZvQPTyAUecQkNANweFWK3103SKNE7qApQKfOGNGzXIZqFruxQ/LrDBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFAcwu/0YMAComWDenaK1Y/Bz2m56La80Gf7mTuyy6Cx5Wtvey
	lHvtAEZoEdNPVCeQD4/Isqzb/qPbr4/DzxSnDLRORHf0uGFiqVImXPYQaEjWSOQ+IkTmDxBobg2
	aMa6xuiPF0RyqIULHTTI8bQX8/DVQGe0m19byzmfmP8UXc84TyjD6xl0sarv9f6xc3EVUQmup6a
	Ww
X-Gm-Gg: ASbGncslvgZOrfIoktRwW6ci67vM4yEAY0dVNfrLiZYstrHhz8ASOxPnRur0bMvMJBD
	OTU2vWDHXvi8biSDhVTMLf5ghbkVnhElvR0cNa3kGnznHhEVV5oNbTPFGTCrdMAR+NrNrFgkzBe
	9YCgp4+k5N2uDt16pFqY4gK2xLHuFVGsKPiluet2nGZzl5SosoPe7V055GM+OKXoXV6smVWlm35
	RHH7c727ZfFVyob0WEat7tLAweBNZRofb8zuxUyg4BvGeoCAB3ITInbQAxsa5T7aU39+hP/Ox8K
	4bF+dKkZ6xzmBo0ryLe7w5SL+h9TmqdTAuzw7mBGqIbmLLanVY9RDtaimN4DJ0rKnfbMCA==
X-Received: by 2002:a05:600c:6218:b0:453:6ca:16a6 with SMTP id 5b1f17b1804b1-4538ee3996cmr207008595e9.10.1751375082774;
        Tue, 01 Jul 2025 06:04:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC9ko9vvQce71TOy0RBCS6sjywmO9bKtkGNw+DoVv+ofxTAO7zJYiibP6bcuGbZwr39XyKgA==
X-Received: by 2002:a05:600c:6218:b0:453:6ca:16a6 with SMTP id 5b1f17b1804b1-4538ee3996cmr207005335e9.10.1751375080189;
        Tue, 01 Jul 2025 06:04:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247b:5810:4909:7796:7ec9:5af2? ([2a0d:3344:247b:5810:4909:7796:7ec9:5af2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a5b7fsm169229505e9.10.2025.07.01.06.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 06:04:39 -0700 (PDT)
Message-ID: <346e4b8a-2e62-420b-9816-6a35b8b63da1@redhat.com>
Date: Tue, 1 Jul 2025 15:04:37 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hv_sock: Return the readable bytes in
 hvs_stream_has_data()
To: Dexuan Cui <decui@microsoft.com>, niuxuewei97@gmail.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1751013889-4951-1-git-send-email-decui@microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1751013889-4951-1-git-send-email-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 10:44 AM, Dexuan Cui wrote:
> When hv_sock was originally added, __vsock_stream_recvmsg() and
> vsock_stream_has_data() actually only needed to know whether there
> is any readable data or not, so hvs_stream_has_data() was written to
> return 1 or 0 for simplicity.
> 
> However, now hvs_stream_has_data() should return the readable bytes
> because vsock_data_ready() -> vsock_stream_has_data() needs to know the
> actual bytes rather than a boolean value of 1 or 0.
> 
> The SIOCINQ ioctl support also needs hvs_stream_has_data() to return
> the readable bytes.
> 
> Let hvs_stream_has_data() return the readable bytes of the payload in
> the next host-to-guest VMBus hv_sock packet.
> 
> Note: there may be multpile incoming hv_sock packets pending in the
> VMBus channel's ringbuffer, but so far there is not a VMBus API that
> allows us to know all the readable bytes in total without reading and
> caching the payload of the multiple packets, so let's just return the
> readable bytes of the next single packet. In the future, we'll either
> add a VMBus API that allows us to know the total readable bytes without
> touching the data in the ringbuffer, or the hv_sock driver needs to
> understand the VMBus packet format and parse the packets directly.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> Hi maintainers, please don't take the patch for now.
> 
> Hi Xuewei Niu, please help to re-post this patch with the next version
> of your patchset "vsock: Introduce SIOCINQ ioctl support". See
> https://lore.kernel.org/virtualization/BL1PR21MB3115F69C544B0FAA145FA4EABF7BA@BL1PR21MB3115.namprd21.prod.outlook.com/#t
> https://lore.kernel.org/virtualization/20250626050219.1847316-1-niuxuewei.nxw@antgroup.com/
> Feel free to add your Signed-off-by, if you need.
> 
>  net/vmw_vsock/hyperv_transport.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> index 31342ab502b4..64f1290a9ae7 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -694,15 +694,25 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
>  static s64 hvs_stream_has_data(struct vsock_sock *vsk)
>  {
>  	struct hvsock *hvs = vsk->trans;
> +	bool need_refill = !hvs->recv_desc;
>  	s64 ret;

Minor nit: when reposting please respect the reverse christmas tree
order above moving 'need_refill' initialization after the following 'if'
statement.

/P


