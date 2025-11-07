Return-Path: <linux-hyperv+bounces-7450-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FC4C3E17E
	for <lists+linux-hyperv@lfdr.de>; Fri, 07 Nov 2025 02:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB9A64E3C80
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Nov 2025 01:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0CA2F0C66;
	Fri,  7 Nov 2025 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hw+9SazG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1FC2EDD62
	for <linux-hyperv@vger.kernel.org>; Fri,  7 Nov 2025 01:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762477774; cv=none; b=a9j1PQd5DZOJuqELmxxvLMfsNta+ni7FvC4dbvPSzwBYKThKf9pw9QcPS9X1s2n/waEPcJyFdtZBHnwRILLKe+6CpAQ6IoFHKNMEVjpV0HDiHYdTYG2YfJJwy/nNbgtYIpCYcTmklu287GzF30bHRzwK0lcuAzfxyvwWESbJlYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762477774; c=relaxed/simple;
	bh=y8GsXoMpZfP1FEGzB5PcqGcDnM/GiApM178nf5o2DdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giFxpG6R6QLKucS8K6uzPfI928xiV8Nrb+q6Ni2k/AyhKFNlZ/SdIIBXg7ftXoHBjJMzSLgGfjfWlqrTJdp8zMWSmuD+fXiahOmWVwPRzVb488zAcM2Gmh+GqSxv08ceKcZhvBImxir+PV/Te5VoN9FhrBhNywqD/RRWd/7S700=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hw+9SazG; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-786a317fe78so2127327b3.2
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Nov 2025 17:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762477772; x=1763082572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IvUJ3GAHgLW25cDlFG6h0rQPjnjrIg13OTjYu0f9NLQ=;
        b=hw+9SazGttaxASXszZn24cyY93Dgqbzee8SAZxh+YnQgF0OM+q/iDtOe02Uvp/p5Fe
         k51csJHvzBG006UTm/luMvEFtKOGH4azT1UnlZByYp4K0VH/3A2wZVJyX3F7wp9/gne+
         bSPlgyM2wOwSyJLQmi8tLjIowuDFAYljWRuOGubi/6LPjZZqkNApWnYXSjxMtEUoUJQL
         MHUn56SUjdMvwTK4DQGvHQnrtqA5nYegiwRuKbaWJlQKbeyUrMJKxI3W8hAXzPpEghdZ
         8ycZ9we9manbmrrdvRYNDHxYsBweWKyHvj07jRQOtAbfFSfhetvUCwWfJMY91FEaKpZ4
         Lp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762477772; x=1763082572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvUJ3GAHgLW25cDlFG6h0rQPjnjrIg13OTjYu0f9NLQ=;
        b=Kv3wj5uGEyR4FKzlVIHzDl6febKvdkfodrHmXctlE74fnANLdzLXgVA/XtanD2qpVa
         Ec5C5xnONRE2K1nGdsRt2R8+5Peb6Ntg/B8kOojSDC8BE1PbyI+njf9hQk2GHC9pv6yZ
         jDuhEKvAImvLt9IEuOmInJf2ViVJH0xaanonjNMbjTzN+vbcGEjm4OaJsYM+HdqY+19P
         y6TQrboXgE4Q5wcJ4ipl48xr6k/Xdzw34ErecEhgaD9AY2avIMD7xO0X/4PkMROuM7oF
         TxLarNqBSn+vw/ydkXyfW0vY6nZrq+jRSSkxS+s4Ygo+xwyLWbPBr6X04SAoTyAoEQr5
         Fj3g==
X-Forwarded-Encrypted: i=1; AJvYcCUB5GYiTqojzgFx4dLL9sHEW+2Ag1am8vIoCyxmYdc4f+xxFiwD0fbFP/EsRUQb7Zrse9xQVhusp1qpyfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP4Ufv1eqigKuU+KHhlLjwrQfn1DUnrx8kAXgvq6ZcDbNSdHdk
	H2T2Ix+nw4PjFM3rOi3JiYcGILFotUqVfrtq6Oszwe967YrQonIl9DPO
X-Gm-Gg: ASbGnctb+M+xO/bdV5ViqeJcObOCXQJwstiOJl9YHoTFi7FTiXvItlOj8CUB2QN1Nxz
	TORdAmmm9+vzpF1mIow5RXUKXnmFia9tI8vdskrdvVLtpUsCudJbz7t2glxDw491sPsxy4Kwy7h
	E3kvrFJCXUfRUEo9gtT+fG+c2qfLBYvuXZq9T2CmtNvmTTQIWwdNO+jkUAN70yIoIBfFsCut/Ej
	CK3Wqn42MKs66w2A9pzVL8/UTKV0vqQ195XUKh84524hYj3RPa9J9DbR4uwPTcDVVvHcp//TkBh
	nibodzwr/siIt80avOjocmxAHvgG8MXjm8m9+6n9T77Gc9NCJfxwIPCp7TM5/OBrlwjss5Mje9X
	7KfIlfUXhjOBelDoYweKosuLloYfNpgnG4Pa9XUpBab92SXmjdfGJXldjsn6Rd4nc4IPsL5xrhL
	/3cvfIBuDrOwk61mTnZ+Dj3cRUCsX9teXgRVHG
X-Google-Smtp-Source: AGHT+IGIiNSL9xH9R1nGKHm9qDA5dUwel2Gn4NDFwi23AY7T7XKy/BbtnkHOptWZ8jTsfq60FDuFzg==
X-Received: by 2002:a05:690c:6808:b0:786:a817:77a0 with SMTP id 00721157ae682-787c5346349mr13381347b3.31.1762477772177;
        Thu, 06 Nov 2025 17:09:32 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b1598d0asm13031717b3.29.2025.11.06.17.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 17:09:31 -0800 (PST)
Date: Thu, 6 Nov 2025 17:09:30 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 01/14] vsock: a per-net vsock NS mode state
Message-ID: <aQ1Gyp87UYnr/VAO@devvm11784.nha0.facebook.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-1-dea984d02bb0@meta.com>
 <iiakzdk7n7onhu5sncjd7poh5sk34nrtvusbiulsel5uswuekv@p2yzmblg6xx7>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iiakzdk7n7onhu5sncjd7poh5sk34nrtvusbiulsel5uswuekv@p2yzmblg6xx7>

On Thu, Nov 06, 2025 at 05:16:29PM +0100, Stefano Garzarella wrote:
> On Thu, Oct 23, 2025 at 11:27:40AM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>

[...]

> > @@ -65,6 +66,7 @@ struct vsock_sock {
> > 	u32 peer_shutdown;
> > 	bool sent_request;
> > 	bool ignore_connecting_rst;
> > +	enum vsock_net_mode net_mode;
> > 
> > 	/* Protected by lock_sock(sk) */
> > 	u64 buffer_size;
> > @@ -256,4 +258,58 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
> > {
> > 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
> > }
> > +
> > +static inline enum vsock_net_mode vsock_net_mode(struct net *net)
> > +{
> > +	enum vsock_net_mode ret;
> > +
> > +	spin_lock_bh(&net->vsock.lock);
> > +	ret = net->vsock.mode;
> 
> Do we really need a spin_lock just to set/get a variable?
> What about WRITE_ONCE/READ_ONCE and/or atomic ?
> 
> Not a strong opinion, just to check if we can do something like this:
> 
> static inline enum vsock_net_mode vsock_net_mode(struct net *net)
> {
>     return READ_ONCE(net->vsock.mode);
> }
> 
> static inline bool vsock_net_write_mode(struct net *net, u8 mode)
> {
>     // Or using test_and_set_bit() if you prefer
>     if (xchg(&net->vsock.mode_locked, true))
>         return false;
> 
>     WRITE_ONCE(net->vsock.mode, mode);
>     return true;
> }
> 

I think that works and seems worth it to avoid the lock on the read
side. I'll move this over for the next rev.

[...]

Best,
Bobby

