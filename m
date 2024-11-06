Return-Path: <linux-hyperv+bounces-3267-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A509BE2E4
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Nov 2024 10:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2CE1F23261
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Nov 2024 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFEA1DB37C;
	Wed,  6 Nov 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnDm0zCU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA5C1DA624
	for <linux-hyperv@vger.kernel.org>; Wed,  6 Nov 2024 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886135; cv=none; b=Gz8Bv9HVAqffIhgQsbvaBi3XfBYk7fKZpp+W6i0wfOEsdTWrS+L9U51sJW0dEHP77u44z334MXBBld+d5IEmYUaGG2r1HZy59SunZBrYd2Af6g7VGZ2gsM12ZjcHlblFU323qthLklkym6uw/I5I6RPGGwTpcyYhwtfcvYPfyaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886135; c=relaxed/simple;
	bh=eJnazqtfisg5f/3fPRDD9Fy2ZdH6bfCsFKpXlRHSPn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFFiEAFxQhOpDo5roy14GkiOaNq2YFasbtZVAoWLK35Dmb1kH4YvOscN/HYMC+v1BcDO5rk5/7lZQ8OtYHnhsB6N8HuFHse6+OIgpngmsJzT0MsZYgH7cWlGUqWT5xKQOewtQ++CRwOI47Aaqn8v93rwKezt7+QV8Mtpj67sSV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnDm0zCU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730886132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTb9RMAx8DKPix4c+Y4T2Jp1EEKIyizogKHRWnrW5Hk=;
	b=YnDm0zCUBfKR/vaXIM2kEPoLtXIp7DpbyEQPfs2vhbK2Fl7XgDfMzITPjsoXHfYXFxkfmW
	rbtZGVluqHY8rcQNyRAFiZlGW5qutMdTQ91Iev7WAtLdhUS+sAtrJGtf6/vqse/owv7i5f
	TJSCDZAQ400km/5FuvemfILqRR/CqNI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-nX-pxeqiNbafZz2axYHf1g-1; Wed, 06 Nov 2024 04:42:10 -0500
X-MC-Unique: nX-pxeqiNbafZz2axYHf1g-1
X-Mimecast-MFC-AGG-ID: nX-pxeqiNbafZz2axYHf1g
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43157e3521dso43743095e9.1
        for <linux-hyperv@vger.kernel.org>; Wed, 06 Nov 2024 01:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730886129; x=1731490929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTb9RMAx8DKPix4c+Y4T2Jp1EEKIyizogKHRWnrW5Hk=;
        b=DtmNvygMoBm+6ETV4DjCsGWmQxMN0mPzh214742eGmPYHhmdUrtY6mNcE5el8CsynN
         b3e0aZxiQG1WxUKLnWk+PN4X/SjOzrAxie6Df4wcoiumUwFBIdbNdlGx+j0zJk18nimU
         yQv1QiNIJsGXY3by3ieGDBZlvOsIVigsU0+Oyb3K93PoAeXqVlRk0NN/qXeoHt+S+e6R
         Z3jj2q8b/w2Jbhl1EnmidFW2L0epLrQJ3XZI+7641e0IV4Q3qxx6ghHDCKHRS6rpPjPD
         G3rn+MlkEnk5ilhYjMsIu7RbhvE5ySefw848Z/CMbc3Eiw6Re3hAAAXYSS4ce1kdGFbv
         yJjg==
X-Forwarded-Encrypted: i=1; AJvYcCVT8rYo3kEfrO7YvBQdyCn6Xd8sMAQeVxsZxLJ/CbaVP9IzSIMa2JzvpPNi3VKL5nFNyVTs9fCDa7uAeII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwOipb3k9cmJ3vYOr5zM2C5OKGw+Ys07uXzQXkHqzJNgTPq5Ac
	ZTzS6ylMe+rWIZdim7VXKEm3B4SENh6WD4o3VVes0UuKbpmi/AiiJGyJK6Z6uXe2FJC71OoEHGg
	roK7gzehlmeml/oL++n82GOT60V5bvqQBzYUuyHsNsH/pNVHMqg9olWIFvmLjdA==
X-Received: by 2002:a05:6000:1569:b0:37d:5103:8894 with SMTP id ffacd0b85a97d-381c7aa4a56mr16648304f8f.42.1730886129700;
        Wed, 06 Nov 2024 01:42:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhiTlCs5X+WxmoKrn9dj4wmjNiR44pmWH55V8O3pKkQuJK0IIZ3ybymz5MvkgSK1/I1NWjag==
X-Received: by 2002:a05:6000:1569:b0:37d:5103:8894 with SMTP id ffacd0b85a97d-381c7aa4a56mr16648281f8f.42.1730886129342;
        Wed, 06 Nov 2024 01:42:09 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116a7a6sm18566549f8f.92.2024.11.06.01.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:42:08 -0800 (PST)
Date: Wed, 6 Nov 2024 04:42:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, imv4bel@gmail.com
Subject: Re: [PATCH v2] hv_sock: Initializing vsk->trans to NULL to prevent a
 dangling pointer
Message-ID: <20241106044145-mutt-send-email-mst@kernel.org>
References: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>

On Wed, Nov 06, 2024 at 04:36:04AM -0500, Hyunwoo Kim wrote:
> When hvs is released, there is a possibility that vsk->trans may not
> be initialized to NULL, which could lead to a dangling pointer.
> This issue is resolved by initializing vsk->trans to NULL.
> 
> Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
> v1 -> v2: Add fixes and cc tags
> ---
>  net/vmw_vsock/hyperv_transport.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> index e2157e387217..56c232cf5b0f 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -549,6 +549,7 @@ static void hvs_destruct(struct vsock_sock *vsk)
>  		vmbus_hvsock_device_unregister(chan);
>  
>  	kfree(hvs);
> +	vsk->trans = NULL;
>  }
>  
>  static int hvs_dgram_bind(struct vsock_sock *vsk, struct sockaddr_vm *addr)
> -- 
> 2.34.1


