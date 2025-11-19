Return-Path: <linux-hyperv+bounces-7699-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0A1C6E1F3
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Nov 2025 12:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 181642E2A1
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Nov 2025 11:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F21035389A;
	Wed, 19 Nov 2025 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAxaz9si";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a34AVZsN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3532F352F91
	for <linux-hyperv@vger.kernel.org>; Wed, 19 Nov 2025 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763550284; cv=none; b=dDJZAiJvWoo4waVwz1XFhFP5Qh6gLC7RJ1rSHPAqEOcTGy4RNPiX0YXysfka+3zPz/L/Xdm4ysrtCe+cNGwELzf7fR92Hnt581jDNpMaqTIS5KQnJpve7dh6Vz523+vU5L2b2kbgu57R/hxrQZz6G8Jg2hIrw1CYAS0yrZ3HOUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763550284; c=relaxed/simple;
	bh=QJRpxNJ6nM55oUProzvGLMXrymnGB0HzC7vMJLxqOVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKpToUS6drgCMIp1jGIn9sGAkBzolQjouGJlQuW3/xbE3f2NdYtE4I7o73sGbG+apzfBTTZ++THZ+05ttwkIo3GXifakMvi1E4WB84SVIhlsrQh2Z6nPToV9a1TdfUYX0xm2Gk5XGrmArWSOyV34fKV5714+hr3MAJJ3Kfwq4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAxaz9si; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a34AVZsN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763550280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=42XSTDD+Tw2WVGrVsFAsxHT5sZ/yd8/fKSBACD6leIQ=;
	b=XAxaz9siEu3dufMJtmuP2Lkb8OtZenxaH9Ko5MrLjkpsJNqwEpli5c/qSu5vUW5ZFqRrKR
	z7IcJvqDdtkpB/S0pmp8ejyHHLH9Nrte5J03RX7sgcx69Lrrb8Mm9NiJMby06Nj7gu1tXT
	fQIIl68vG83Bjh5SNp1xy8IP2ATt9k8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-LF2ICQJNOuKZiZ_pwulRXA-1; Wed, 19 Nov 2025 06:04:38 -0500
X-MC-Unique: LF2ICQJNOuKZiZ_pwulRXA-1
X-Mimecast-MFC-AGG-ID: LF2ICQJNOuKZiZ_pwulRXA_1763550278
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8804823b757so21598026d6.0
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Nov 2025 03:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763550278; x=1764155078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=42XSTDD+Tw2WVGrVsFAsxHT5sZ/yd8/fKSBACD6leIQ=;
        b=a34AVZsNXjM+XWUSGb+JUGfhIezMxetxPfQJ0LdxM7JD1Gl+NCL5TmaahNwA3W51ns
         /EaCg9C+LnFwmXWUyuQ2u/ddDQZ3Y+1dHaj4amrNQcxJQ/ky7nJeUoGMTAsHdzvbLFpy
         t5TW7is2qMykSe024ldj23RxSkrKEUx3Bjrz7O54avbzCBWBc5JsMGjG7C4XNsARb1S1
         OeM7bIuYZlkofsxLfG2rrWrWyGuHCPSGYysxJtoijUYtYMupPQTXmtvRl9VwLAsga2CY
         HZTki6YU50vGVV/0wYNFdWStCDWEzzWEnY/ZaJHzuontkR7MRF3EcBhKTaExzUV08q6C
         wZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763550278; x=1764155078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42XSTDD+Tw2WVGrVsFAsxHT5sZ/yd8/fKSBACD6leIQ=;
        b=QRbB/gz7ZBeP8DlyAu5XNwdA21jMcu67ANZCbQ5dpkRFOeSd0qxmU3CAMr4Wu/V3EH
         d3W3lWtAsONnYHXVfUDu11fLaa/TgLDdLGPF62uVVHUARJK3pV7bX5/tIxcIQL/YvK/K
         UCY6arcsEAA4LuWQMwjhusX3wRhvMslqBuL3Uz9GH8GbeO1oy4URPu5bRpVCp4vL4hrg
         TGTomqZLPmlULeNLJyjobD582twuD4U5vEK6W9HiLy7Nc6Of+3+TQoaJchO43wH5+DFv
         cAXtoCU+RgjJfU5o6S91u3j6GdiHFDgypTjI5/vqIMtfiwXVy9w/qk5SJ6PprMLersc6
         y3Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUmVNRuYvNrpr4P416E/UxHmrECp1cAjFKZMoG+xOsuz/hUuv/Q2dJGmxxnDPLohWe8/3BqqF4Vb0elMDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJeFL83XCPYADIB4gY47P5cOo77mqIhE2Qj+vAvTdbsXeudVb
	uIkXc/cGwREqoZKQX78he86t0bo97goiMH7zrOaYra1jxZ56hiPhnWcmN80t8uhrpXMYeAVqBGu
	kCktiZf5RTlOl+p1EIlNcHblyFGWIJLPtbqVDUrufgm/x+D0pON6L08pTFZkqZpkh/g==
X-Gm-Gg: ASbGncuTgRYrq4I3yQVyhHZ47NAhpKjn5UROQqqcWMri1xnDVPte7+gpNel3JjK0RNo
	2zD2bnbq/f4XBmAqVHtL8hrf6I6wWs2RP+GsBQJgPiYzv/YUux+Ky6z+z+Q45eMENOKPL8aPuz5
	lhlFV2N82P9Ps3IKjxnhesj+EwfQRcCiseJSUjRwIvS4TafyAeQagHL0Jdxc28yKh+Xydf0dqnQ
	E2siaURq+7YQ6/TTwDd4+oc63TLTQY8yJo2VeHF7ASP/GkGszkqoJvegGU+53azRTjPs3YkX4mi
	tADhxHFUcG4B5UH6p9TswiVNj3Mon4ppq7KDtMFaQU0tJqU6GLCw0nysmqbCps+ouMywFTVUqKd
	u6XVS4iJ8EhbDIKd9Ip4bu7EbdQ0iFD4cv5nWY0hdQJ68YbMpxucgvsjeDmUG5w==
X-Received: by 2002:a05:6214:5e88:b0:882:760e:822e with SMTP id 6a1803df08f44-8845ffd1671mr19255986d6.2.1763550278382;
        Wed, 19 Nov 2025 03:04:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUx18S7QU3TAKJCuch0iU57e5cRCXq8XDSG2cx+/NGC5m+qevE8BVa0OMVsBGaSQSjDNVFOQ==
X-Received: by 2002:a05:6214:5e88:b0:882:760e:822e with SMTP id 6a1803df08f44-8845ffd1671mr19255436d6.2.1763550277970;
        Wed, 19 Nov 2025 03:04:37 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828613962esm132823926d6.0.2025.11.19.03.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 03:04:36 -0800 (PST)
Date: Wed, 19 Nov 2025 12:04:12 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 03/11] vsock: reject bad
 VSOCK_NET_MODE_LOCAL configuration for G2H
Message-ID: <tfrb7l3cguctjl5jbd7ykon4aqav4ognxndtnohs7ukmvk7wkm@tpaaicknwwhq>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-3-df08f165bf3e@meta.com>
 <vsyzveqyufaquwx3xgahsh3stb6i5u3xa4kubpvesfzcuj6dry@sn4kx5ctgpbz>
 <aR0arw2F/DmbIrzY@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aR0arw2F/DmbIrzY@devvm11784.nha0.facebook.com>

On Tue, Nov 18, 2025 at 05:17:35PM -0800, Bobby Eshleman wrote:
>On Tue, Nov 18, 2025 at 07:10:28PM +0100, Stefano Garzarella wrote:
>> On Mon, Nov 17, 2025 at 06:00:26PM -0800, Bobby Eshleman wrote:
>> > From: Bobby Eshleman <bobbyeshleman@meta.com>

[...]

>> > diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>> > index 7eccd6708d66..da7c52ad7b2a 100644
>> > --- a/net/vmw_vsock/vmci_transport.c
>> > +++ b/net/vmw_vsock/vmci_transport.c
>> > @@ -2033,6 +2033,12 @@ static u32 vmci_transport_get_local_cid(void)
>> > 	return vmci_get_context_id();
>> > }
>> >
>> > +static bool vmci_transport_supports_local_mode(void)
>> > +{
>> > +	/* Local mode is supported only when no device is present. */
>> > +	return vmci_transport_get_local_cid() == VMCI_INVALID_ID;
>>
>> IIRC vmci can be registered both as H2G and G2H, so should we filter out
>> the H2G case?
>
>In fact, I'm realizing now that this should probably just be:
>
>static bool vmci_transport_supports_local_mode(void)
>{
>	return false;
>}
>
>
>... because even for H2G there is no mechanism for attaching a namespace
>to a VM (unlike w/ vhost_vsock device open).
>
>Does that seem right?

tl;dr   yes


vmci_transport.c has MODULE_ALIAS_NETPROTO(PF_VSOCK) for historical 
reasons. This means that the module is automatically loaded the first 
time PF_VSOCK is requested by the user if af_vsock is not loaded.

This was the case before vsock was generalized to support multiple 
transports and has remained so for historical reasons.

So today, we can have that module loaded, registered only for F_DGRAM 
but not registered for F_G2H and F_H2G, so maybe it could work for now 
and if the H2G is also not supporting it, maybe is the right thing to 
do. (with a better comment there on the reason why both G2H and H2G 
doesn't support it).

Sorry for the long reply, maybe just `yes` was fine, but I dumped what I 
thought because I feel it might be useful to you.

Thanks,
Stefano


