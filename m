Return-Path: <linux-hyperv+bounces-8213-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8E5D0E1C5
	for <lists+linux-hyperv@lfdr.de>; Sun, 11 Jan 2026 07:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5029300D33D
	for <lists+linux-hyperv@lfdr.de>; Sun, 11 Jan 2026 06:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6D221D3F5;
	Sun, 11 Jan 2026 06:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O10Je4S/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVQkdGxl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA9C194098
	for <linux-hyperv@vger.kernel.org>; Sun, 11 Jan 2026 06:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768114012; cv=none; b=QPNZ7D/6f0qT1ksbC+Wd/XY/LiD48rpVyVc6foyN06CNa/vaUH/AKgOG+qw3zQ/5TjgGDOqrANEp8JUxG5RpUQMHhB+lC0RDrPThy/vc05luLVq4RD5JNFvQjJSkUJapEbFLN5pq0VBrIGZ5Auh/ZTHVQ5aDrLhrMQIbWiE6/nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768114012; c=relaxed/simple;
	bh=oJg0P4BTaPqRMdngCealJvjnKfXREQ/BhzD4UuLebrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AY2WTjCzVp5rlO7kLo6mjxAAuvfLjxHK/+R+Uh3I/mC0iAn2/Tmq749wpsbE0M0oPRxB3RQANcdqW5b5Xy1ntzYxumcDjDlMB7XYD+7WuUeHyJAV2W4z+5FWNzTZEnDtM5f3HZqZB6+0m7qrrpEYigGUq6Tu0DcB1JfWpqkKBBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O10Je4S/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVQkdGxl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768114010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQ7hDBixKgHX7F8NTcaObvBvSlkQPDzeM4vIOMax5Nk=;
	b=O10Je4S/0mj3/LPejRBE7XpZW6dJZxWq7pdBqjSJ+NgpqtMdnLJa7kV148aeccSpUFP2ZL
	mfTtlZwZUnbujfXpqUHVVbEcM33Hnl53hNAIUIFn0gpF1N82jwnhhspOsD40Wk9KPeSkna
	etzSTUabdkMMByVjIfj1kCGJokTBzf4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-2puuoiAzOeKQhsvEK298AA-1; Sun, 11 Jan 2026 01:46:49 -0500
X-MC-Unique: 2puuoiAzOeKQhsvEK298AA-1
X-Mimecast-MFC-AGG-ID: 2puuoiAzOeKQhsvEK298AA_1768114008
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d3ffa98fcso36315925e9.3
        for <linux-hyperv@vger.kernel.org>; Sat, 10 Jan 2026 22:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768114008; x=1768718808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iQ7hDBixKgHX7F8NTcaObvBvSlkQPDzeM4vIOMax5Nk=;
        b=BVQkdGxlmes97/Xxz8ptRBGThZdXBaCNR0MDLkKbuAF+QAWaRq0aWy6rM5ANq0Ci8F
         ttKuQoJcdSZQ1K28OhZw520jH236Z1kKM63E9pHXMgmwg5S0jTZcCPyJ1l9kymFpk8og
         r0XSKqzB4ARKbQ7a2fy8jFmmIO2wzpmEDyldZtuEN4ahgEg9QA9y2UEtG8rV1Xz43BB2
         z/1wrmbU996DGFBmBP3s5unkBEen2DHH+khnjxTV43UQXvukTqjg8bAjBnPLjdrsxnNI
         eCrI6+RnKHWIF+7UTKptHPiL65vXp8VbyuBhTuzFiobXPBsK/QNUEaTKCgjSBFg/sPsk
         wktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768114008; x=1768718808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQ7hDBixKgHX7F8NTcaObvBvSlkQPDzeM4vIOMax5Nk=;
        b=N0SIUvOv/kdQXs9FpUKhI6YVxSzouRY3yclEi6/8AXARRIuHXNcd2KRsjZgf/6q3TX
         ju/6UejQux5wiriHVenmarW1I4EgetOfpBJAweUxJ4kMUbZuefFhJQ2zpD8qXotaHq+X
         YNtPl4DpcWkZcAk/DP+tl5aHJQpt1mHBvyxR40ldSGY3WBhcvl7Mx3kpfW+Hfn3+wsS5
         xcIleVTy15g0RtspiEigJ1tp18lr61+gjvYH0kV42Oc/4/j0oLztk0rnqs/SbHv05vXJ
         /VgO6ZoWev0Y0UMSvrH/U2AHZoMRYfZyM78ypduTbGTqdlDh3yNjHY9iEsG7Rh8Ag43Y
         Z2gA==
X-Forwarded-Encrypted: i=1; AJvYcCU+CjnaCpFLRswuIwfx8tz5bVo26e97yHBvmQJ87cH48YCLWwZSBDDC7d7FObzXcc0bxtMojUqneppfE+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHYUmwbzArBC6vx4MCRaj+R4xpDodGXlEtSQlbyKu/tExtmE16
	+PX72e6G9AiJHaTMP5q5nMC2SflwwGcAdR+KbPfY8+QCGcb0T6/wTgKL2mMoLf2HN1h7YY593xb
	tKpZVJTr2Kao/YsRz3pRuDNp/kj5sN1XnA9Vr+1Pf3kBnq4ZUInvTi/GdRq2mHFzUxA==
X-Gm-Gg: AY/fxX7IEYjR7/kAsOGvmM9rR9Za0I0K3lSHeXTMQTX6OGi+wvcFKTDQt+QM67ryzdi
	c2so+7Xrp3DB50Ys2cDKMml/STsyl0nZ69Kg4G71JiWHABs+EGVMGgRtlhnE1gBV3k5Sg6YE1LF
	h1a0+usc+9C4QYsStIsD46lRUIrqxjRSFbwJfx2OBGfEnOeR4rH3t98DeWXNNkN+u/ceBdTVP7H
	d7ON3hxJBLLF8nWFKtnh4lpcbBa6neP9okzlOvfFi61wWbOdaYvqqtIMpps7GEehvwdMyxqjHzh
	3fbrO9J7n857kDwLAQQxYJ8FKMNVuMGvmCzB9AbD7GKrRGqq2OMa3yCVtvZmeH4RZjlP0EO5UWc
	3XQnK2b7lqFQbvZq7TsS0z87+9bZsPgI=
X-Received: by 2002:a05:600c:444c:b0:477:7b16:5f77 with SMTP id 5b1f17b1804b1-47d84b0b303mr138047735e9.3.1768114008101;
        Sat, 10 Jan 2026 22:46:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2KhXxY5wNvI0FhPEnxgIqYrJLuszMdozjkRjhQaSurG33CO00c2A2r97DP2kFBqnSLT0brQ==
X-Received: by 2002:a05:600c:444c:b0:477:7b16:5f77 with SMTP id 5b1f17b1804b1-47d84b0b303mr138047395e9.3.1768114007653;
        Sat, 10 Jan 2026 22:46:47 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865e3d22sm102237315e9.1.2026.01.10.22.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 22:46:47 -0800 (PST)
Date: Sun, 11 Jan 2026 01:46:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 03/13] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Message-ID: <20260111014500-mutt-send-email-mst@kernel.org>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <20251223-vsock-vmtest-v13-3-9d6db8e7c80b@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223-vsock-vmtest-v13-3-9d6db8e7c80b@meta.com>

On Tue, Dec 23, 2025 at 04:28:37PM -0800, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Associate reply packets with the sending socket. When vsock must reply
> with an RST packet and there exists a sending socket (e.g., for
> loopback), setting the skb owner to the socket correctly handles
> reference counting between the skb and sk (i.e., the sk stays alive
> until the skb is freed).
> 
> This allows the net namespace to be used for socket lookups for the
> duration of the reply skb's lifetime, preventing race conditions between
> the namespace lifecycle and vsock socket search using the namespace
> pointer.
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
> Changes in v11:
> - move before adding to netns support (Stefano)

can you explain about the revert please?
I looked at feedback from Stefano and all he said
aparently was not to break bisect.

> Changes in v10:
> - break this out into its own patch for easy revert (Stefano)
> ---
>  net/vmw_vsock/virtio_transport_common.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index fdb8f5b3fa60..718be9f33274 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1165,6 +1165,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
>  		.op = VIRTIO_VSOCK_OP_RST,
>  		.type = le16_to_cpu(hdr->type),
>  		.reply = true,
> +
> +		/* Set sk owner to socket we are replying to (may be NULL for
> +		 * non-loopback). This keeps a reference to the sock and
> +		 * sock_net(sk) until the reply skb is freed.
> +		 */
> +		.vsk = vsock_sk(skb->sk),
>  	};
>  	struct sk_buff *reply;
>  
> 
> -- 
> 2.47.3


