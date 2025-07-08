Return-Path: <linux-hyperv+bounces-6149-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C02BAFC8DB
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 12:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B89A1BC409F
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 10:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD0B2D8764;
	Tue,  8 Jul 2025 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWg6xLdo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B526CE05
	for <linux-hyperv@vger.kernel.org>; Tue,  8 Jul 2025 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971791; cv=none; b=E78cwBK3Q4RXKVN1TSO6zS8PuViB16qrMNbS4WF8gWx5RSfv1A4vFLdG9OCRephNqV6H7Cz0wOwainveQ5eOhgOCye/dyvjv6ro5kakzJyDKUgq15r/wJSHJJ+kcvw1tAm4AyGYfZes+Kc1FoEosh4GbwWitvoyUgvug1cz9n4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971791; c=relaxed/simple;
	bh=O7wwD7eSFM539CC00ixDKAsR7sbvVfXkvwV0BcTBHvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/dNjmWwjpl7u2V5H/76VDo3VmJYwRbdyaO44Pq0Uh8O5ZwiUQ/Fyu44hLmnbtogOiCHejSlFzRx+QTpyIIV2xB0MELwDKvd/8yS6pApMUSv0aVVp/jwhGZKixRHizgxP2yis91kSj+YNQBYscFSPoQrtkAK40pMxr4GUQI8VsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWg6xLdo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751971787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5iL4j1/i/5cwMCBnyJHYMariApq+4KsGPMs67Fmf6qo=;
	b=BWg6xLdoRbxP4T3tJhhEp46STTZMqBYI/kuPElw5vu1e5Q8f45HcRfffvVXmJxo7GJ+6tE
	wyOfMHdGsdOFn+ru36ViKjE2qzXYeBnZEFSg2IXuRXT36x19r2rgt77VGE/DgJlV9wAtJ0
	YfO1reIm7XQciw4/CU+pSCPbrOQL3Vw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-M-Hh5lgONjS2ldG6LdIsvA-1; Tue, 08 Jul 2025 06:49:46 -0400
X-MC-Unique: M-Hh5lgONjS2ldG6LdIsvA-1
X-Mimecast-MFC-AGG-ID: M-Hh5lgONjS2ldG6LdIsvA_1751971786
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a587c85a60so85409291cf.2
        for <linux-hyperv@vger.kernel.org>; Tue, 08 Jul 2025 03:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751971786; x=1752576586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iL4j1/i/5cwMCBnyJHYMariApq+4KsGPMs67Fmf6qo=;
        b=tkdCkRoCvv82JTZu5hvRtp2rooC121pniYoKkjGZ2guIPWvgjYvEXn1oVGXaS5cX9u
         qRApsIixKib35b//d0m2MAQdyRdXYJyQ35TtiQBFdUQ+GL7//cPGqu3TajguZ4mXWSr5
         eXYwXSQPkGGTSoF1N4+7f08lmt2r7gNBn1i2bJzriijIaezcOViZIDtEKAoP1tR4mx4s
         G0QdXJXpfo0t0Rc5LQYA1Zv/FGGqCpSDogGbE3g1QUKGyCqffJHDZLnZ3iymN0i57wVq
         glY0yVNf8uUqwePlU0F+HIJGszd28Lk1n02RUziBAyKugpvTWX6t2pl54ovtQmDnjLta
         4Ugg==
X-Forwarded-Encrypted: i=1; AJvYcCUMH/u5s0nY/Q2UVSUour+zgLNJPh7adMQz7+R35MdlJie++VSVSR1xd3xp4Z38PVjsiVJHM+//A4wEK4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW3Iz55UF3JbSL7BEZCG5aOKlmUSR+VkV58DIz3bBurbs1DRCy
	3jRqOaLwL80m6rWjj8QC+KmGYll0qVkFASnBsOSep4PilQ/VcO5ekd/Vpyl/yAKeCaI0giATRO2
	L3FFBOH5W+7U/xs7gFOi8Nfl6RGRTCGPa3K1AE1q5hh8M2mGCma+fXbJcIzqu28T/pQ==
X-Gm-Gg: ASbGncsoEPQft5z36igERldktk7kWBPycgwz+iu9IOEycezvZbpFB5aX2hynjn5qMsQ
	87FAS5Uyuab86lAiGyvSPgYW6ElMX6zoOzVO+NclWZmHoRCEHqmopX7Wm6rRe+KTgqcB8AGpy7E
	c+LCyL2Opt5QmU9+4ijflwjWCHwA028z69BPC/xH4zJFQ+RCb5I0ecQ5OBbbSmeuk5CVrXVXZye
	Ssp7T1H/oN2F4/y/4ZrJCsgsxS8YemeHJvcX38Moj6jhUfllMRaZUwBdwYLnan214eZVkFIjMwp
	sFEQxpXq6OvVGU1tSvIcQRmYJ3wM
X-Received: by 2002:a05:622a:d07:b0:4a7:6e08:6294 with SMTP id d75a77b69052e-4a9cdeeddf0mr40374071cf.19.1751971785756;
        Tue, 08 Jul 2025 03:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhYlU0uqUvfcleoNVAAhyRWfQZX9q6ookm+/i8X2MtWsxRCFgVRxkOKlEb0p2JpI6O3Qdagg==
X-Received: by 2002:a05:622a:d07:b0:4a7:6e08:6294 with SMTP id d75a77b69052e-4a9cdeeddf0mr40373621cf.19.1751971785234;
        Tue, 08 Jul 2025 03:49:45 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.147.103])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a8e527sm78690641cf.67.2025.07.08.03.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 03:49:44 -0700 (PDT)
Date: Tue, 8 Jul 2025 12:49:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, niuxuewei97@gmail.com
Subject: Re: [PATCH net-next v6 1/4] hv_sock: Return the readable bytes in
 hvs_stream_has_data()
Message-ID: <o2u6lj6m7ro73vmza4zlrwwlvonjzkgdtd4xxrjn57xpa2lmpb@yik2rrzp2sos>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
 <20250708-siocinq-v6-1-3775f9a9e359@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250708-siocinq-v6-1-3775f9a9e359@antgroup.com>

On Tue, Jul 08, 2025 at 02:36:11PM +0800, Xuewei Niu wrote:
>From: Dexuan Cui <decui@microsoft.com>
>
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
>Note: there may be multiple incoming hv_sock packets pending in the
>VMBus channel's ringbuffer, but so far there is not a VMBus API that
>allows us to know all the readable bytes in total without reading and
>caching the payload of the multiple packets, so let's just return the
>readable bytes of the next single packet. In the future, we'll either
>add a VMBus API that allows us to know the total readable bytes without
>touching the data in the ringbuffer, or the hv_sock driver needs to
>understand the VMBus packet format and parse the packets directly.
>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> net/vmw_vsock/hyperv_transport.c | 17 ++++++++++++++---
> 1 file changed, 14 insertions(+), 3 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

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


