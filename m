Return-Path: <linux-hyperv+bounces-4618-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F94CA68DC6
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 14:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4234D421791
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 13:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3425E2571A8;
	Wed, 19 Mar 2025 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/jTHkpf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B810256C70
	for <linux-hyperv@vger.kernel.org>; Wed, 19 Mar 2025 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390780; cv=none; b=AVMkEc5Dd0CY21SNWgMASkTwbYS6xAjPT8FkI/9J6tICWxrPDoLFBQA6qDIEzqv9z7nakM/mj0/HPpA68v+YDiNdr060gGvN+p8dMhQ1wX7pM/IxkRl4FWwsX26dmLcxUQJwb7/5lOIjhiaVGCOGt5VYbK57gu42IxVciw0LFhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390780; c=relaxed/simple;
	bh=ld5eJNWi/v1i0gmIRHdZaRFv9fDwhRMDqEbIo4PLTEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rx8kmmnuqyqoTOTWjGYthl/5na+Q12LIjwSUBlLuB9aG0SWkAK/ft8rHzHp7Fv8r9GVcfH8C6zw1KZyFGGYnszk4N0Feq7xgJ35AHTqxgSrCU4xgSNxTKLwUlD1JaaciCx+PK6hOUGt8NJdLxF0HHTBEapUys6svvaYvBMj2HsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/jTHkpf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742390777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jaUUXRh1EbOiBGq2k3FaF6z5tXEmrMKUqLsPsZxaMf4=;
	b=Q/jTHkpfBCZoKa2KR2uxteMWMdChbnFQk+41hnWSn3JIPIZW6Kq6/Lw7hAhsbNTOXFPvEc
	n9UZFNGC41zh1tc9QSo5PoJDU4sAfYrz1rG1+jjDgF2aNCQgH1kIo1j4bR8nyg2SeVOnTc
	rabcnqaciwBJ96Qg6YXa9Q+HESOi6cA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-3Rirjd8pNMa3xrBHOuxsnA-1; Wed, 19 Mar 2025 09:26:16 -0400
X-MC-Unique: 3Rirjd8pNMa3xrBHOuxsnA-1
X-Mimecast-MFC-AGG-ID: 3Rirjd8pNMa3xrBHOuxsnA_1742390775
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e623fe6aa2so7945722a12.2
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Mar 2025 06:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742390774; x=1742995574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaUUXRh1EbOiBGq2k3FaF6z5tXEmrMKUqLsPsZxaMf4=;
        b=VBsO+fWVw3CojzbEQF1GiYHSiNX8ByHKUXZwqGFx/BVLzYwHXrhnZBp9uJFJ/uhQSs
         mWnG4HNpdr/s3r/Lyqacf57bKpnZug6I7YGxkEW5/DZN5+rRBat57/SR5nxGdcLbqfeH
         gkKx1FxFGR0tAmLrsIdr+cS+qmllIc1atFhTO7OzxzLoQMs8ikxIpj8mz/tDf5kdxmPT
         3NFV82XftEHdLnKP/qGzShydbVO3FWqVI6c2zZRGcgLjrrJNgJjvtCdTMWhTjWnsc+xZ
         jkXudGs/VOas/3v1Jv7DtUHDXYkDvb8jrEd5/e5Inue479uNTdTBv4BlmLqVKQ6XVXvO
         5g6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWh1WEkPYHaERM/m1ktbsJrIQDfSQBJkxDXOJC5XJJleH5+JXcY2mCnNqvIRdOFUM2aSjwqmHBWoqDW1Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3I0jdoc71oJSsBYb363iLZgrgEH0+In3UYGI+dVO5uIktIx/R
	TGJB5aVH6ozdJTt404Gc+Y8Dhjgfr4KHJZSdZRYkGksOT8kyqE3dyFoHDwPdk0x3U2p8Wq6nlvx
	yLoZRYy/6eQVcAeFbE4UohEQgRxVMFI7PTF32pN1c+LC9kAe/7KYatE/IrmwmMdijrHHr1g==
X-Gm-Gg: ASbGnctHWIAbZFrHlEioMJ4SCfUZYteDBvjlOXqSLBJR0sOv4mDJsKHhaeo7Y8Pzdqk
	f9j5d4BP6e6CiiEBMLEsX8nF4WrZD/uEYc5+RLolzCOeBHNvzne1SDdwHFCyBSH+UICsFIHmust
	A3tf6R1X4LntzOVs4FCEI60SIxB7ZZlRgpxuTqRCHS6TizrG9oWlKyolJc4TWTMF4Ean9UoBWgO
	cH68wGbb5acWB/AFDPoezOKhjaJtyaGznSsJfyKtcfqCMkjHfto/ty4TtOCdB7oUqSfi5007fUd
	VnPpLAWGRTKC4gJV/Bv6ZCWoiNfV71KRS3Z3X2yrsFXo21vMlEUvvr6tSFnl+A==
X-Received: by 2002:a05:6402:4302:b0:5e5:827d:bb1c with SMTP id 4fb4d7f45d1cf-5eb80fa41c6mr2676001a12.25.1742390774225;
        Wed, 19 Mar 2025 06:26:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUtpdb4r2CtbTyHsr8WLwRcIUuXEpJ1mxKBLWGBT+tn/rPN0UQLhFx+xPQA07eNa19/oKOAQ==
X-Received: by 2002:a05:6402:4302:b0:5e5:827d:bb1c with SMTP id 4fb4d7f45d1cf-5eb80fa41c6mr2675817a12.25.1742390772409;
        Wed, 19 Mar 2025 06:26:12 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-53.retail.telecomitalia.it. [79.53.30.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e81692e583sm9064993a12.16.2025.03.19.06.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 06:26:11 -0700 (PDT)
Date: Wed, 19 Mar 2025 14:26:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] vsock/virtio_transport_common: handle netns of
 received packets
Message-ID: <6iepaq4rqd65lhpqfpplzurwkezdyrjolijrz4feqakh3ghbjy@fxoiw5yiyzp3>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-2-84bffa1aa97a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250312-vsock-netns-v2-2-84bffa1aa97a@gmail.com>

On Wed, Mar 12, 2025 at 01:59:36PM -0700, Bobby Eshleman wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>This patch allows transports that use virtio_transport_common
>to specify the network namespace where a received packet is to
>be delivered.
>
>virtio_transport and vhost_transport, for now, still do not use this
>capability and preserve old behavior.

What about vsock_loopback?

>
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
>---
>V1 -> V2
> * use vsock_global_net()
> * add net to skb->cb
> * forward port for skb
>---
> drivers/vhost/vsock.c                   |  1 +
> include/linux/virtio_vsock.h            |  2 ++
> net/vmw_vsock/virtio_transport.c        |  1 +
> net/vmw_vsock/virtio_transport_common.c | 11 ++++++++++-
> 4 files changed, 14 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 802153e230730bdbfbbb6f4ae263ae99502ef532..02e2a3551205a4398a74a167a82802d950c962f6 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -525,6 +525,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
> 			continue;
> 		}
>
>+		VIRTIO_VSOCK_SKB_CB(skb)->net = vsock_global_net();

I'd add an helper for that.

Or, can we avoid that and pass the net parameter to 
virtio_transport_recv_pkt()?

> 		total_len += sizeof(*hdr) + skb->len;
>
> 		/* Deliver to monitoring devices all received packets */
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 0387d64e2c66c69dd7ab0cad58db5cf0682ad424..e51f89559a1d92685027bf83a62c7b05dd9e566d 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -12,6 +12,7 @@
> struct virtio_vsock_skb_cb {
> 	bool reply;
> 	bool tap_delivered;
>+	struct net *net;
> 	u32 offset;
> };
>
>@@ -148,6 +149,7 @@ struct virtio_vsock_pkt_info {
> 	u32 remote_cid, remote_port;
> 	struct vsock_sock *vsk;
> 	struct msghdr *msg;
>+	struct net *net;
> 	u32 pkt_len;
> 	u16 type;
> 	u16 op;
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index f0e48e6911fc46cba87f7dafeb8dbc21421df254..163ddfc0808529ad6dda7992f9ec48837dd7337c 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -650,6 +650,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
>
> 			virtio_vsock_skb_rx_put(skb);
> 			virtio_transport_deliver_tap_pkt(skb);
>+			VIRTIO_VSOCK_SKB_CB(skb)->net = vsock_global_net();
> 			virtio_transport_recv_pkt(&virtio_transport, skb);
> 		}
> 	} while (!virtqueue_enable_cb(vq));
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 256d2a4fe482b3cb938a681b6924be69b2065616..028591a5863b84059b8e8bbafd499cb997a0c863 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -314,6 +314,8 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> 					 info->flags,
> 					 zcopy);
>
>+	VIRTIO_VSOCK_SKB_CB(skb)->net = info->net;
>+
> 	return skb;
> out:
> 	kfree_skb(skb);
>@@ -523,6 +525,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1061,6 +1064,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_REQUEST,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1076,6 +1080,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> 			 (mode & SEND_SHUTDOWN ?
> 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1102,6 +1107,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
> 		.msg = msg,
> 		.pkt_len = len,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1139,6 +1145,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
> 		.op = VIRTIO_VSOCK_OP_RST,
> 		.reply = !!skb,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	/* Send RST only if the original pkt is not a RST pkt */
>@@ -1159,6 +1166,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> 		.op = VIRTIO_VSOCK_OP_RST,
> 		.type = le16_to_cpu(hdr->type),
> 		.reply = true,
>+		.net = VIRTIO_VSOCK_SKB_CB(skb)->net,
> 	};
> 	struct sk_buff *reply;
>
>@@ -1476,6 +1484,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
> 		.remote_port = le32_to_cpu(hdr->src_port),
> 		.reply = true,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1590,7 +1599,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 			       struct sk_buff *skb)
> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>-	struct net *net = vsock_global_net();
>+	struct net *net = VIRTIO_VSOCK_SKB_CB(skb)->net;
> 	struct sockaddr_vm src, dst;
> 	struct vsock_sock *vsk;
> 	struct sock *sk;
>
>-- 
>2.47.1
>


