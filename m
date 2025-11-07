Return-Path: <linux-hyperv+bounces-7465-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 433C2C40A8F
	for <lists+linux-hyperv@lfdr.de>; Fri, 07 Nov 2025 16:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5D6189593F
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Nov 2025 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CFB32ABC2;
	Fri,  7 Nov 2025 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGrYbGPP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443052E7F1C
	for <linux-hyperv@vger.kernel.org>; Fri,  7 Nov 2025 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530452; cv=none; b=HX0LR2Xk9iJ0uew0ZA/YhfOdF9a94hl9hI4jC8dh2ub8aMRH0xTbPYWRNk7SegDq0IavreqyjAS3hBlBd/1uuSHiC/UEQK4jERGpx/5sdUXryCkhMSJZ9d4O37OE9ZdhGbCDmRlV5GPdwBFEKBzHwelt+JSgCCz9iXmgbgFVQMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530452; c=relaxed/simple;
	bh=AgQbQ+KSNY8EMVam7WimxKAMD+pVWQVs4PeEWZxxuTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXCpYJcoxeU6gjnPJT5mFtIP0st3PKrc1TdMCj0W21z1dVBz9nHy0vcWg5g55CTPxvN2/NX0WQwwwRfSpEDY6e/4qjvLBeT1HJUgz2TgowoLnYSsIMa9E8rOXP3sP1WJNv/Ou1gEuyBeomKG9RMYrj/9+V+WY/xk6DeZRMhC4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGrYbGPP; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63fc72db706so896958d50.2
        for <linux-hyperv@vger.kernel.org>; Fri, 07 Nov 2025 07:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762530449; x=1763135249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rNPUJeO0jfL+NoCnK5UCUnDeuVhOeT6TwUJCRr1zq70=;
        b=LGrYbGPPWMSYQo6Bl/fdlMThyPXwBeofW3UNDk+2BQy3lpnsCwC90fp5XoSfdZmjYX
         KA6rC+QZUxPdxjFPXRKU6Wke8qiUCwm5fFPQ5zHUSd8mhlJVOYeXYv8kIIKpQoJdDhw8
         sY6oZ2xI+MujHK3y666q0ZpEkWOw+fMW1qcJdf1w3AGdW/sYfXK79C+uV4i8ulLIsdhc
         8dvZZDsAfzChW0MTeNxb3eGUt2eeUYZxZZ/bXpc2yt0tdwLbt2F8okc68OnSWb7aN3Z7
         JfEmRqcQesnbt5hP4KNK3APnm+SPwthrl4kr7MWJaHdpXpaSrPYMBXc6h2EHuBzIzCUm
         O5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762530449; x=1763135249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNPUJeO0jfL+NoCnK5UCUnDeuVhOeT6TwUJCRr1zq70=;
        b=goH3toBlY1Fxfk1htp58g1RZiMO7ddHTc02Y9ztw4G42b/J3ClA42pSfOqyDTzV3uf
         QrYZcd8f3tIi5+gcTna+lcmNkSeXD1JLoVFml27PejAKC80VVorA0juB0hozm0xhF7OL
         gqCGdytg/EaFQLKgQUu8T5dSAQEQpY4ycJRqF1nEBQigCmmwjn9n0NQEM5Yb39WbjWVH
         jB78YyJu231qO+80igFwpRkKcpwR07P1JL6xqjGWZMXqei8j3/uNkkkyaibylKoKpYCE
         lQ8vcr+mOTDSeL/UKrrT38H9LfvaD2HWh7acBDK2vJ9OgZ7iIof24e8zPEY+oN3vXiQl
         yMUA==
X-Forwarded-Encrypted: i=1; AJvYcCWRhLap0+Maz8cQMffarRxpu17R09bcp9TQmOuuR4WpW1Y6LHSVzCrnnByj1gXlkY8xHfQA6SOWoBdBqt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiG84WTJCMFZcJnNA9cJkXiGBQEZpihHKoaaW1KeoiyaXDZg0t
	b2Wc0FyWMzpbzoymc/w7aB9OW/ITjusVQ+2oPidmFjfTHAdOc5B/Xiyz
X-Gm-Gg: ASbGnctPDYwh8SgMOMU35td04IpGVuOjTq5rTJyf2GLYa00iT3It0tNlTuK3CZfinTB
	NVZd/Wt5floM8/MKdMKvPcDDjwDk85LK86FK6KlaKDguqW3pZmz3BJTkdUWNnNqrtoAdf7DxzAb
	cM1L+HHdfAS7GVbaJtZAnzAfO4BRdqJjk8WyArffVYpqCJLIwbuzdLjM0CY34oHWweFJfZIZMms
	LwAyrcJ2bc5N02aWYVCEyu8pATrRVm4/fQM+oNhQo9gF7V1OGtnL4hQ4gDSMEP7WJNZs2Yue8WB
	7LR1jfIC27i9ht4oTlvs8e7GV2VtOkrv4kBMP4pE4ftThOKHyjRU6EVUwF0ks8ZIg0mT18cUb7l
	W08uSF3Xh6Q5aMBFhsc+qGeffrTE35GtqTPIrygZtnYCILhKONqfA08jEa/VbVSsbHS89RNlq2b
	z704W1UFRdycMAMfTFWTSoltSbbWVT5kQ10l0=
X-Google-Smtp-Source: AGHT+IFXvS+IpNFgsgMywAgZqoOQibHP63Xuf6dTUbNtxkKzSlUYwHyXzkOlrbPYGdpQ0cshEmiYAw==
X-Received: by 2002:a53:acd5:0:10b0:63f:a7dc:5661 with SMTP id 956f58d0204a3-640c4177959mr2767546d50.12.1762530449193;
        Fri, 07 Nov 2025 07:47:29 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640b5c91334sm1890653d50.1.2025.11.07.07.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:47:28 -0800 (PST)
Date: Fri, 7 Nov 2025 07:47:27 -0800
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
Subject: Re: [PATCH net-next v8 06/14] vsock/virtio: add netns to virtio
 transport common
Message-ID: <aQ4Uj6z129htVqLk@devvm11784.nha0.facebook.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-6-dea984d02bb0@meta.com>
 <hkwlp6wpiik35zesxqfe6uw7m6uayd4tcbvrg55qhhej3ox33q@lah2dwed477g>
 <aQ1e3/DZbgnYw4Ja@devvm11784.nha0.facebook.com>
 <aQ4DPSgu3xJhLkZ4@devvm11784.nha0.facebook.com>
 <g34g7deirdtzowtpz5pngfpuzvr62u43psmgct34iliu4bhju4@rkrxdy7n2at3>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g34g7deirdtzowtpz5pngfpuzvr62u43psmgct34iliu4bhju4@rkrxdy7n2at3>

On Fri, Nov 07, 2025 at 04:07:39PM +0100, Stefano Garzarella wrote:
> On Fri, Nov 07, 2025 at 06:33:33AM -0800, Bobby Eshleman wrote:
> > > > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > > > index dcc8a1d5851e..b8e52c71920a 100644
> > > > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > > > @@ -316,6 +316,15 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> > > > > 					 info->flags,
> > > > > 					 zcopy);
> > > > >
> > > > > +	/*
> > > > > +	 * If there is no corresponding socket, then we don't have a
> > > > > +	 * corresponding namespace. This only happens For VIRTIO_VSOCK_OP_RST.
> > > > > +	 */
> > > >
> > > > So, in virtio_transport_recv_pkt() should we check that `net` is not set?
> > > >
> > > > Should we set it to NULL here?
> > > >
> > > 
> > > Sounds good to me.
> > > 
> > > > > +	if (vsk) {
> > > > > +		virtio_vsock_skb_set_net(skb, info->net);
> > > >
> > > > Ditto here about the net refcnt, can the net disappear?
> > > > Should we use get_net() in some way, or the socket will prevent that?
> > > >
> > > 
> > > As long as the socket has an outstanding skb it can't be destroyed and
> > > so will have a reference to the net, that is after skb_set_owner_w() and
> > > freeing... so I think this is okay.
> > > 
> > > But, maybe we could simplify the implied relationship between skb, sk,
> > > and net by removing the VIRTIO_VSOCK_SKB_CB(skb)->net entirely, and only
> > > ever referring to sock_net(skb->sk)? I remember originally having a
> > > reason for adding it to the cb, but my hunch is it that it was probably
> > > some confusion over the !vsk case.
> > > 
> > > WDYT?
> > > 
> > 
> > ... now I remember the reason, because I didn't want two different
> > places for storing the net for RX and TX.
> 
> Yeah, but if we can reuse skb->sk for one path and pass it as parameter to
> the other path (see my prev email), why store it?
> 
> Or even in the TX maybe it can be passed to .send_pkt() in some way, e.g.
> storing it in struct virtio_vsock_sock instead that for each skb.
> 
> Stefano
> 

That's a good point, the rx path only needs to pass to recv_pkt(), it is
not needed after the socket lookup there.

With TX, it does look like we could get rid of it via the
virtio_vsock_sock.

Best,
Bobby

