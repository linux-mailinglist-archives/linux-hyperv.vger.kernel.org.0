Return-Path: <linux-hyperv+bounces-7690-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ED7C6B237
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 19:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 78F642BB7B
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 18:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B6C35FF47;
	Tue, 18 Nov 2025 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbSD2g4i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgobyGdq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B11035A12D
	for <linux-hyperv@vger.kernel.org>; Tue, 18 Nov 2025 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489566; cv=none; b=hbRQdfPnBcwPjbYISuPRCw3puOh1ALGiNH3FYchYJbl4zGEUEUneMcEwoYOPiAcWVPa0wwVbHMPu7tqixNI4N2dr4X5nlldpFs1o6GySsfa/htFQXoaGPrd+sjlxh/rNbf/HAGMqdkcWkyiDfUtxH0H8+ynEdHdGYDRBtliEW+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489566; c=relaxed/simple;
	bh=er1J307+KJnRBNUgsTZ17cqFXn2zardiLpzpxp0mLOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vi02hAKZVQKimF+pOdKBvLvtKQlBnVwGFh82tPF7SOa7tyLtMsH9nmo8r9U0nTWI/V/E/VeKNuvdurBYrq6ka6csafipqtroLGc9EJ13AC0HSd/FV9nM8MmO+gTWEkxR+88wfH6iIyODTFWj3wEtW/ReJTfQ4o0bs1QAtP1yma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gbSD2g4i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bgobyGdq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+h5sKZ9VJjMM8mERtb5Zt23BghZJxFGhKJW89VCOck8=;
	b=gbSD2g4iiIEB9AJFemhWr27zXXtkHP6FmT4PwYOBzzMjtFysavo332E3PD0FRKKTEyBUII
	eDAR/YXOgqACCBWPSaWDUgZrYrbmq/y4uXlwpa3Fh0BT58LAlunlms7R/rbi0lCCxgPn8c
	qyNWycF0aZWz/rTsPJpVxVKVZtaB/x0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-jNZ04AQIOse321ZXxcQk7g-1; Tue, 18 Nov 2025 13:12:42 -0500
X-MC-Unique: jNZ04AQIOse321ZXxcQk7g-1
X-Mimecast-MFC-AGG-ID: jNZ04AQIOse321ZXxcQk7g_1763489561
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so63650815e9.0
        for <linux-hyperv@vger.kernel.org>; Tue, 18 Nov 2025 10:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763489561; x=1764094361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+h5sKZ9VJjMM8mERtb5Zt23BghZJxFGhKJW89VCOck8=;
        b=bgobyGdqdIbD62/NuL81F0Tvj+BcEyw97DZXBgJNbFZAg0aeRiTWj+2OVIubV2pksc
         8iujT4+gm/6CqOV2YwO1Q+p6mZhGQFD0EtnuutRLco1NI/LtVnpJVsv2iBtsP4XzaaqG
         pH3PvZCsozAuKHOThSbGn06chBFgB+zEzbMyGfbcerFCevVKy+ictSQCw2CXnueqUIH0
         e1NUNI9PBgG1/8XFw+lT33XYdZoTvlka2X+6whpne1F4vCwQWozeHo3hKx+ADbmV1FH3
         MuHQ15MRDQEj+FQAM9InHW8gbDAjdrOWJQcoTTJxx9BSFanNlKiB0+vngx5lgnwdBYP6
         /WFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489561; x=1764094361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+h5sKZ9VJjMM8mERtb5Zt23BghZJxFGhKJW89VCOck8=;
        b=iGgldonewZRqf519JXaASfmPsipWjSuiLv3FGLcDDKHoBc9w5CKDJhiwKScX6BCbfG
         T0q4LVKvR+tzSBIp/af8jpHm0Yxn3CY/xfdQHVqgn0TSR8+HAF4E7EsvFp+zNPv+GgaQ
         XtEy6T4a4H/uGjLrrQQPKvzOrVJ+3mkfvmWdWfcly+ZUqWv7/s0K7r00WHHJJAuChF/P
         edFz0i0WqHn48tytsKugJNQ07QCJdtiQ7AtwmJ8N3rgURumjTJC+XVuRYbyc8yd75gUe
         Dg7owGAnoeNOJcNaGKeWQjM8LhUAszA5f3Twck4dbzI6KolScceq9TZMZI7EynRe7Fyi
         gf/w==
X-Forwarded-Encrypted: i=1; AJvYcCUh6wXfqrnLyVZTHWjE+mEWX/wbVudz7jCK2MLYfr7gP5jGz2tRjWPVhAdpRgU9hlLbPBOjvUIi3+S+OiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLrIvu0CT2IzOlGYwgRkCQqTBgI/oOWHyMEqwVsohiEE23cZyg
	Gk3uU7Cyt+9aj0j3/QQ5KstznHmgP772udHQE+nmPvbfq4Rl5d2hi/+37knioByGOKM5WNrsfS4
	4FbpjY05s3qb/rfCndrOBgc54rc+0p7BJcfVbyvF5cjmkBDuHAC2tlNZWl/ZSOjVwuQ==
X-Gm-Gg: ASbGncuiEanlCu0z4YwH5XY4H2atYh026S2d+Y8RmLRdYaVUlC9hb5vq8A69JU6ceq/
	ZCSE3ICwQgkuj49ouz6T8/KSNXgPGjn0droqNHShYmoDYaMGOto2ct7Y6u2Xq3PwvsQH/LfuKeT
	w3O1e+a2gzPJC/duUha1U0V6uUiQxVVAbMF8gjzGYjMVpON9T46s6yXbSFfhzaTg6S2XP0cASVY
	E0fjpEZTCUUKk68wGhwuZB/JJSpe+Jfa1WliZiZ3v+jUdfaA8FsggXHQzAF9mHhLMdUZtoQ/PWI
	4IBVC94gPRF48uB1jRSxpplImm5xPV4Q57XCbQ4o0G/xtjkSSdcP2FoICRgCWN83NxaxCHzbt1c
	yzVqnf2gDmZu1DbZQjaD0xAUgFhPdsAgvlsktUmG2+to+XqJvNAQu+DviBOE=
X-Received: by 2002:a05:600c:a43:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-4778fea84e4mr144928495e9.32.1763489560854;
        Tue, 18 Nov 2025 10:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOpTmbeuBuF6OCuotMnf25yLK3sUbAbvYEMuVVlK2CBmGppKS9Ccp0DvA2VuQ7IZI1U9CwzQ==
X-Received: by 2002:a05:600c:a43:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-4778fea84e4mr144927985e9.32.1763489560327;
        Tue, 18 Nov 2025 10:12:40 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10142d3sm4356375e9.5.2025.11.18.10.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:12:39 -0800 (PST)
Date: Tue, 18 Nov 2025 19:12:22 +0100
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
Subject: Re: [PATCH net-next v10 05/11] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Message-ID: <zwpwgzf6opt2qiqrnpas7bwyphpvrpjmy4pee5w6e3um557x34@wnqbvwofevcs>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-5-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251117-vsock-vmtest-v10-5-df08f165bf3e@meta.com>

On Mon, Nov 17, 2025 at 06:00:28PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Associate reply packets with the sending socket. When vsock must reply
>with an RST packet and there exists a sending socket (e.g., for
>loopback), setting the skb owner to the socket correctly handles
>reference counting between the skb and sk (i.e., the sk stays alive
>until the skb is freed).
>
>This allows the net namespace to be used for socket lookups for the
>duration of the reply skb's lifetime, preventing race conditions between
>the namespace lifecycle and vsock socket search using the namespace
>pointer.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v10:
>- break this out into its own patch for easy revert (Stefano)
>---
> net/vmw_vsock/virtio_transport_common.c | 6 ++++++
> 1 file changed, 6 insertions(+)

IIUC the previous patch only works well whit this one applied, right?

Please pay more attention to the order; we never want to break the 
bisection.

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 168e7517a3f0..5bb498caa19e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1181,6 +1181,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> 		.type = le16_to_cpu(hdr->type),
> 		.reply = true,
>
>+		/* Set sk owner to socket we are replying to (may be NULL for
>+		 * non-loopback). This keeps a reference to the sock and
>+		 * sock_net(sk) until the reply skb is freed.
>+		 */
>+		.vsk = vsock_sk(skb->sk),
>+
> 		/* net or net_mode are not defined here because we pass
> 		 * net and net_mode directly to t->send_pkt(), instead of
> 		 * relying on virtio_transport_send_pkt_info() to pass them to
>
>-- 
>2.47.3
>


