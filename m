Return-Path: <linux-hyperv+bounces-6125-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B3FAFB4CA
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 15:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DBB3BCEF0
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978932BCF4A;
	Mon,  7 Jul 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKztURj2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F311229B79B
	for <linux-hyperv@vger.kernel.org>; Mon,  7 Jul 2025 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895647; cv=none; b=YBeixBxJNTXLA01+NEScwJmOUETHrLJ3EsUpq6BPJ926tsth7N3OgBDdNlY7hyQr5iwWi6Hm1JcTaMh3zqZCOSeoXWGgKTytco9QPJPZUgimw5R24CKRnmh++Y5mwibZsR9E39LDHrT5kR8q5wponsfPtQRCee/k6etBkHrdXp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895647; c=relaxed/simple;
	bh=ul3tvYiiYuyxmNUs6c6tGf8iXCr1hDf1jpTi6pw0cEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfkdGuKDGb2R9YpTYe0/wT5Z06Jkt301ZgLThG2ZAl1fg6/6bPyxcGuAh5V1HT6tR4sYXvr3I1cepKdztfK/ZhSlDPFTKr5Woo/IuhsXmAd9Wtkv11nOKj1gZMJsjrGeKRb3wAhqgjJBLgkWMAp/oiYwqEvEUmFu5g8i8olInmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKztURj2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751895644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W2KJ06Vv9jNgPK/f5x2D67o6F5iefXJHvVBymbKYkgw=;
	b=dKztURj2FL5x9836vVW2urQdzuM+bdMvz/wX0XF0eTsIJOJEplJXq4m2lA1uFta7UY5w7w
	upr0j99EBR5hTJslNz5N2bElBNFVXvRgHtEF04Rkt3xIVVEouL0XDTuZX2fCwrhwqUZd2/
	VF3qH5qGb+iikUaj1bqvcdWB6GA0Lo4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-Ho1rZcP2O3Kor8d5kMT-ZA-1; Mon, 07 Jul 2025 09:40:42 -0400
X-MC-Unique: Ho1rZcP2O3Kor8d5kMT-ZA-1
X-Mimecast-MFC-AGG-ID: Ho1rZcP2O3Kor8d5kMT-ZA_1751895642
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4539b44e7b1so19916515e9.1
        for <linux-hyperv@vger.kernel.org>; Mon, 07 Jul 2025 06:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751895641; x=1752500441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2KJ06Vv9jNgPK/f5x2D67o6F5iefXJHvVBymbKYkgw=;
        b=F6iSElwZoTGjE4zvDE/NbBoOIim7EgSSO04sZtXgj9vE4DX+Lz+S3v0VXKgOeuqlzM
         9Pw1vzSTcah0p+8BZhB/FB+mcpuSRVqQ1iCGQb7uhtYLF9lespmwrCsf84glxGqb/qXw
         WJr0sk9lTwgIj4JakQe+e6sXfKs6DQ5BeFSvfV1SeRPRIdivrqwjVvMmVqIuikvzivla
         /R1YM5cz7nFm5F6R+sC789zDl2vUR6vfGK7dvsg7/LKsreoigoL6ft93hjq5/KyYiKq7
         aMitpwB2zzTP80rrA67/QylWXBrL/TBfw1TlMnydp6++9HufPZ0f7uHkAR8DOVw572J9
         Nl8A==
X-Forwarded-Encrypted: i=1; AJvYcCUbcZbf9XjITrwb7tYIIvyvOl5WzZCaAsg3zFe9UL4BIinLHpcipDA5oXmwUQQkguKtZ1ntpvmTQJYGowI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN8oxV8xWnivc75BG8kXKIFcvGfstljwOMx8L9QPhOZDKUcAad
	baNJYoCJ+83WutvpKcBqjx29usP+KqhLLMT4Pgt3R2z0Fcvn9TwaTOc3NFnGE1LiiUkwpdLR9It
	bD4EFb2vXW27vIYNgXa+PIFd3mf15ykuD8MB6Oev1uyc1SFl5ITyFAXvkZleimK6wZw==
X-Gm-Gg: ASbGnctcF4CST0s9XP3TGL138Q15U4/GixdkM8YFDHdqjN+WlI9hXYUHY7EKR1iCXDJ
	bO7x4riiI7j4szxortpjwnOr/7rZ2yyiqg6Wifoz6C0DbxYvGdw0s6IoXC1icy7reWy3sdMvcDN
	FXJIaH7AFMV6YBPljZtSEu7kUrmKYnuuHFAkh9RqRl9dRi1jm/uQvvDifzw613J8DlmjXxL2Orx
	asM+TY40B2KvizPjJK0n/KhysLk1P2dprmvDKTAK22Vg5+ilkg7YYIM/GIlYTSzRpEeg4AH47km
	+xj5vVJM37LQNPWNe+E8eMnJazQ6
X-Received: by 2002:a05:600c:8214:b0:450:d568:909b with SMTP id 5b1f17b1804b1-454b4e74957mr117204165e9.14.1751895641296;
        Mon, 07 Jul 2025 06:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ3sl8II9VgNMv0Hs+oc26TdXSoZydYWxbok3SEgKNUWhqxxpymtncK0H5qwe1x6+STsNFHw==
X-Received: by 2002:a05:600c:8214:b0:450:d568:909b with SMTP id 5b1f17b1804b1-454b4e74957mr117203465e9.14.1751895640329;
        Mon, 07 Jul 2025 06:40:40 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.144.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285c9f9sm10339166f8f.93.2025.07.07.06.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 06:40:39 -0700 (PDT)
Date: Mon, 7 Jul 2025 15:40:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuewei Niu <niuxuewei.nxw@antgroup.com>, fupan.lfp@antgroup.com
Subject: Re: [PATCH net-next v5 1/4] hv_sock: Return the readable bytes in
 hvs_stream_has_data()
Message-ID: <xhzslzuxrhdoixffmzwprn254ctolimj7giuxj4nfrfg23eesy@ycpe6kma5vih>
References: <20250706-siocinq-v5-0-8d0b96a87465@antgroup.com>
 <20250706-siocinq-v5-1-8d0b96a87465@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250706-siocinq-v5-1-8d0b96a87465@antgroup.com>

On Sun, Jul 06, 2025 at 12:36:29PM +0800, Xuewei Niu wrote:

Again, this patch should have `From: Dexuan Cui <decui@microsoft.com>` 
on first line, and this is done automatically by `git format-patch` (or 
others tools) if the author is the right one in your branch.
I'm not sure what is going on on your side, but you should avoid to 
reset the original author.
Applying this patch we will have:

     commit ed36075e04ecbb1dd02a3d8eba5bfac6469d73e4
     Author: Xuewei Niu <niuxuewei97@gmail.com>
     Date:   Sun Jul 6 12:36:29 2025 +0800

         hv_sock: Return the readable bytes in hvs_stream_has_data()

This is not what we want, right?

>When hv_sock was originally added, __vsock_stream_recvmsg() and
>vsock_stream_has_data() actually only needed to know whether there
>is any readable data or not, so hvs_stream_has_data() was written to
>return 1 or 0 for simplicity.
>
>However, now hvs_stream_has_data() should return the readable bytes
>because vsock_data_ready() -> vsock_stream_has_data() needs to know the
>actual bytes rather than a boolean value of 1 or 0.
>
>The SIOCINQ ioctl support also needs hvs_stream_has_data() to return
>the readable bytes.
>
>Let hvs_stream_has_data() return the readable bytes of the payload in
>the next host-to-guest VMBus hv_sock packet.
>
>Note: there may be multpile incoming hv_sock packets pending in the
>VMBus channel's ringbuffer, but so far there is not a VMBus API that
>allows us to know all the readable bytes in total without reading and
>caching the payload of the multiple packets, so let's just return the
>readable bytes of the next single packet. In the future, we'll either
>add a VMBus API that allows us to know the total readable bytes without
>touching the data in the ringbuffer, or the hv_sock driver needs to
>understand the VMBus packet format and parse the packets directly.
>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>

Your S-o-b was fine here, I was talking about the author.

Thanks,
Stefano

>---
> net/vmw_vsock/hyperv_transport.c | 17 ++++++++++++++---
> 1 file changed, 14 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 31342ab502b4fc35feb812d2c94e0e35ded73771..432fcbbd14d4f44bd2550be8376e42ce65122758 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -694,15 +694,26 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
> static s64 hvs_stream_has_data(struct vsock_sock *vsk)
> {
> 	struct hvsock *hvs = vsk->trans;
>+	bool need_refill;
> 	s64 ret;
>
> 	if (hvs->recv_data_len > 0)
>-		return 1;
>+		return hvs->recv_data_len;
>
> 	switch (hvs_channel_readable_payload(hvs->chan)) {
> 	case 1:
>-		ret = 1;
>-		break;
>+		need_refill = !hvs->recv_desc;
>+		if (!need_refill)
>+			return -EIO;
>+
>+		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
>+		if (!hvs->recv_desc)
>+			return -ENOBUFS;
>+
>+		ret = hvs_update_recv_data(hvs);
>+		if (ret)
>+			return ret;
>+		return hvs->recv_data_len;
> 	case 0:
> 		vsk->peer_shutdown |= SEND_SHUTDOWN;
> 		ret = 0;
>
>-- 
>2.34.1
>


