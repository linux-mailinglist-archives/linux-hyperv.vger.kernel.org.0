Return-Path: <linux-hyperv+bounces-6126-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0496AFB4EE
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 15:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58777165C4E
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 13:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CAB2BEC3A;
	Mon,  7 Jul 2025 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfWPSwXp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF5D2BE7CC
	for <linux-hyperv@vger.kernel.org>; Mon,  7 Jul 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895779; cv=none; b=pmRW/55HAKoee16TrblPIpHoC+K5nAlj8iKwBEFTcb1G8HG9qdHmBh/jXyPOtgS8J6vcy97X9QYt8EAQKTTFJXCUMPKOI2THktMsOPbtWuznaDGT64afmyUQzcIfiCdd2va4e8t1SOU9Znjt9FnbViJSIZkD2qkAJ+QxrlISkBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895779; c=relaxed/simple;
	bh=xltTqBYmsiirVvBdNqG5/Fyy6AbHsBrBr+WSXMtuttA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AijZKl/u1+h6L1EMofZLckbMgTSQFfq6SI/UMicfh+tkERrkX3zXPJ+HJzfWca8QzsJ7+XImEe4AztK/w3Mo+W4hNIdA59o1bf8r9VP4APzmTx/h7JBEzNYcUdJZBmMbkq2R3AH5RQwtZpuqRDv7jXZAYlNf/JnbAvQDe73owJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfWPSwXp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751895775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VsmgUKFf5I0+AJIsgxdkjg4irOxBPoSgMLTf3OScQaQ=;
	b=EfWPSwXp05NXrm2v/aYMfa1IuuwV1PXaIoxucJqf6VrhpnkC/4Qic/Kra0y7szowIhsKUS
	NHOXG8fTtFo6IgjYg0KAEJLW7Ig85doQZYQCgleHFkAnrodB5wFzYNTTZvnAHFsTUkvsYL
	4ba2LUUV8G8aYL5Qqnr2JZ4RgS8Q05k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-ClWoICupMWm5kZBphiBQpQ-1; Mon, 07 Jul 2025 09:42:54 -0400
X-MC-Unique: ClWoICupMWm5kZBphiBQpQ-1
X-Mimecast-MFC-AGG-ID: ClWoICupMWm5kZBphiBQpQ_1751895773
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a5281ba3a4so1274249f8f.0
        for <linux-hyperv@vger.kernel.org>; Mon, 07 Jul 2025 06:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751895773; x=1752500573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsmgUKFf5I0+AJIsgxdkjg4irOxBPoSgMLTf3OScQaQ=;
        b=RJ7GDax73E5WBgf3f5EnA2aygChIdbu4JCREH/IInkA+wuLK2IpAIz12sR/D11k5Hg
         PZlhhjPH0RCQfySjHD6DH4cTe6WVzIDwA/+J0I7AJMd5lJifoujvR/rbaKu+5VD3dgMQ
         nMzLtlY5CQLJBlgKIZJr5PDC/MyIzIHbt6XQFJcyCM88b31kyr2JfEeiAeWgLJ2Dvc+V
         3y58PZb9JD9gNyKHPB+H6pmhEGBtGmBVpIwLcmm3ohOmVk8n8EXr8qWddox8Id5FNP2c
         mq1Tf1kwtxm+VkuwmSVGyTelgRbAcZnKjIM0Ec01Xcrym1PL++RztAeUtULrztX5gAU+
         fGSw==
X-Forwarded-Encrypted: i=1; AJvYcCX7jO1u/7aHMgeDM5zyregiaGRrlMiyHIFrdGMF3HSAPRyDjk11ynnSglRrcfU7q82nYf0CcCHM4uTUQcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmQ8sEiy5vLcBk/KW0ZOa2tvoq0rqX7/klbPAbCEE6OxBLvBDK
	BY/HLy2CkFKCB8mzcmVlWo4L5HmQxLjORsX2mKwUBkRPAvjbp8BMpOcSSqwJz30+v2r4AFDTYm0
	0P6AMoV5M7KiVfGmvVsEO5LSI2Auqim7H4QZjbbbyGZLEXi3KhFIg9T05ckiud+AJ/A==
X-Gm-Gg: ASbGncsZh3eW3OHrTZB3lmrDmFRjJ96IohUgsIR+i83jceFIHw8omt/5mBmMmmfU9BU
	TK+9Sh1WlBN3gmvTkSyNp3Nvrz/tLBXo9nDVntc5pOs7MpWbG9f2vIWNrqUGJy9xkqbdgox0yvC
	6oYYodpEVSCCa9FehA5QpZGcoiIjeV2Zj/bU3VcH4rM6H/mtyJET987ivDspQV7PcSIDU/3sbQN
	69Pz0zTaiZBtUynbzBBmcqF21hQo+fgyXvUBeG/lHpn9h7DXFKTk8h106Ft5kA/y4Hi5fiWI1Eh
	V1q0wYSBET5yV8y/LBwl9aHm+QRz
X-Received: by 2002:a05:6000:400b:b0:3a5:1cc5:4a17 with SMTP id ffacd0b85a97d-3b49aa7d51dmr6564061f8f.42.1751895773415;
        Mon, 07 Jul 2025 06:42:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY8SiQF+6f5+bf4//S2AtBghoAdxNERSqvvMXKZJvwoNLtCvWhRhxkkv/MOEbunhybnSwajg==
X-Received: by 2002:a05:6000:400b:b0:3a5:1cc5:4a17 with SMTP id ffacd0b85a97d-3b49aa7d51dmr6564020f8f.42.1751895772808;
        Mon, 07 Jul 2025 06:42:52 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.144.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a997b492sm140318785e9.13.2025.07.07.06.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 06:42:52 -0700 (PDT)
Date: Mon, 7 Jul 2025 15:42:45 +0200
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
Message-ID: <xphwpqqi42w5b3jug3vfooybrlft3z5ewravl7jvzci7ogs3nh@5i7yi66dg7fa>
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

s/multpile/multiple

>VMBus channel's ringbuffer, but so far there is not a VMBus API that
>allows us to know all the readable bytes in total without reading and
>caching the payload of the multiple packets, so let's just return the
>readable bytes of the next single packet. In the future, we'll either
>add a VMBus API that allows us to know the total readable bytes without
>touching the data in the ringbuffer, or the hv_sock driver needs to
>understand the VMBus packet format and parse the packets directly.
>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
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


