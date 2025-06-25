Return-Path: <linux-hyperv+bounces-6000-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0871AAE84C6
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Jun 2025 15:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8165164CC9
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Jun 2025 13:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E118725F980;
	Wed, 25 Jun 2025 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvNJLhMF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAF8188715
	for <linux-hyperv@vger.kernel.org>; Wed, 25 Jun 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858345; cv=none; b=DTGdd4pp8EGtayp9wxMl6LTKBCSSlQ1fAEU0KqvTVA0r8m1s8IIwh+t1R4ITCdZK0tNDc7gcnznIbEBqHVTZIqsI1eIC3GbPOLm916j+1nCOHpRqQlZgGwH/1SGmDSE3pthFS8KB/1+VaS++RIVYVMyvBsz2A1pGJr+IziUrPcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858345; c=relaxed/simple;
	bh=tgyI93DqO+iceJu24PzG+d1oFJs9Iucz7h4dqyH8ohU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjNxXEKBoBVdBdb34FPw7ycywumXwM+jzXa2PcGyr+3E/fUoiZiok9+Pg0fZD6+CUSyj/cbc2HoKX7UgngMwEPwOAEZC8+BX+pd8aKXNdfMUqmzrERrJ/9gzGoXkaJyNf5xtQuv7WZcUQYfhnVebnFqWWznVgEpMaELNoxlhTp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvNJLhMF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750858343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Fwu8mDntzdWYt27Qd6IJlpVfWUrdOeVJ2HfrSFGosU=;
	b=RvNJLhMFo4t9URhkMU2FWO1v8VmZ13cfj/Y6EG2pDoy88qrevOS8AkalOm1cHSyeoVZc0I
	Cx/viQQmf2bqW3wiOCo1K7H9PMD0av5Sg+rQI5W6pvcgDD+v3EpS7qudVg8D1f3jMgZ6mD
	NotuyNeBtv83N7SuxsWTtemdY5/P9EI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-5OhsZoM_OFCXV1qyLMRsdw-1; Wed, 25 Jun 2025 09:32:21 -0400
X-MC-Unique: 5OhsZoM_OFCXV1qyLMRsdw-1
X-Mimecast-MFC-AGG-ID: 5OhsZoM_OFCXV1qyLMRsdw_1750858340
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450db029f2aso7172585e9.3
        for <linux-hyperv@vger.kernel.org>; Wed, 25 Jun 2025 06:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750858340; x=1751463140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Fwu8mDntzdWYt27Qd6IJlpVfWUrdOeVJ2HfrSFGosU=;
        b=n3Y6lpWGBtrMmHOiOn0WS4Vb0ZLBGAJMusP5av3Md3z/aacley7NVeZK41Agmkd3BR
         G37BVpZA+tdn2XB6mNS3hHLrTB/3Bx0bHm4WbGGHQYtm6o8TsWE6m4Kx+RvXFjAljj1R
         QpCczDqMFifAYnOSj5em2c2A/26Mp2ab1HiaNLYd+YWnjW7aMaPyRrCuY9gbXN4UUiKp
         cN6S166rAqe1vpDhd41cHLTWrKMQ0mTvP4O7k71cHlLukxRv9XZlEl8gzqV6DDOR0D9/
         QabnhFuY3Q9PfexN7+bWsFkJtFMbb1+K2knco63w1VhNzedunMrMqgeC1x7CQ+2Bj6DW
         eHtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTNG9Hwy3OcgfV9zREK0DYndu4+eOjnF4iRSqw9bWEGZK8gO7zQYvJPryKbZx7eaSj85+xFZflUfVB404=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6n6DdyJMgfsnEEjR9l6WpimhQ3lDI6O2C7iA6iIIq2oNZcsfB
	/cbyhzXn2Kyck8k97/6unEygfFgXk87sEAZnsDaxOLWIUaqLITu5Wzp8WQ6v26VsM5w0U86eQJ7
	B9EwHRbbLhcsyQ3ULIISTl/V2Bp0GCxEzmBm3LFNgxq1dmHxVKXiFFh6vNg0Mw5FJ+A==
X-Gm-Gg: ASbGnct4CQ/OOuf5xHqjKDBbrLsp+poHV6ttlBOua7iX9tPexCzpMc/7TCw0F/XLa/c
	WlowTiwoQ6ikEiW9DMpeUBplMGX+FQgJ66CjxevaKS0tK1Qybm3qh32L2HlX17iV5exlcg5tKnK
	ei2zOT+yC/vQiqUh7CW7XCIeDP6SW/uTOg8BWpGu1rdT+nxv9bPqKIhNZKTGSUTL5i6QRKlzJbk
	AfOfs0nZ0KdyFsIVO1e8Zb9up3JzAEaCR9otAsvRrmOm5B8UaARutIbE9IJv/jw+BYTycfPLyTC
	+MTBKeiCMusqMwmmN2lf4EFLVEVp
X-Received: by 2002:a05:600c:3b95:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-453879e27acmr3103755e9.6.1750858338479;
        Wed, 25 Jun 2025 06:32:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY//pCRPoC2EFYGzFZ4umPjaocK1G0vDEhyvr5hVoQgUAHwK1E7Yy9rAocwNi9NP80rjw6AQ==
X-Received: by 2002:a05:600c:3b95:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-453879e27acmr3101355e9.6.1750858336283;
        Wed, 25 Jun 2025 06:32:16 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.218.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f2a4csm4708245f8f.65.2025.06.25.06.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:32:15 -0700 (PDT)
Date: Wed, 25 Jun 2025 15:32:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: Xuewei Niu <niuxuewei97@gmail.com>, KY Srinivasan <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "stefanha@redhat.com" <stefanha@redhat.com>, 
	"leonardi@redhat.com" <leonardi@redhat.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "fupan.lfp@antgroup.com" <fupan.lfp@antgroup.com>, 
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [EXTERNAL] Re: [PATCH net-next v3 1/3] vsock: Add support for
 SIOCINQ ioctl
Message-ID: <wgyxcpcsnpsta65q4n7pekw2hbedrbzqgtevkzqaqkjrqfjlyo@6jod5pw75lyf>
References: <20250617045347.1233128-1-niuxuewei.nxw@antgroup.com>
 <20250617045347.1233128-2-niuxuewei.nxw@antgroup.com>
 <y465uw5phymt3gbgdxsxlopeyhcbbherjri6b6etl64qhsc4ud@vc2c45mo5zxw>
 <BL1PR21MB31158AE6980AF18E769A4E65BF7BA@BL1PR21MB3115.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <BL1PR21MB31158AE6980AF18E769A4E65BF7BA@BL1PR21MB3115.namprd21.prod.outlook.com>

On Wed, Jun 25, 2025 at 08:03:00AM +0000, Dexuan Cui wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>> Sent: Tuesday, June 17, 2025 7:39 AM
>>  ...
>> Now looks better to me, I just checked transports: vmci and virtio/vhost
>> returns what we want, but for hyperv we have:
>>
>> 	static s64 hvs_stream_has_data(struct vsock_sock *vsk)
>> 	{
>> 		struct hvsock *hvs = vsk->trans;
>> 		s64 ret;
>>
>> 		if (hvs->recv_data_len > 0)
>> 			return 1;
>>
>> @Hyper-v maintainers: do you know why we don't return `recv_data_len`?
>
>Sorry for the late response!  This is the complete code of the function:
>
>static s64 hvs_stream_has_data(struct vsock_sock *vsk)
>{
>        struct hvsock *hvs = vsk->trans;
>        s64 ret;
>
>        if (hvs->recv_data_len > 0)
>                return 1;
>
>        switch (hvs_channel_readable_payload(hvs->chan)) {
>        case 1:
>                ret = 1;
>                break;
>        case 0:
>                vsk->peer_shutdown |= SEND_SHUTDOWN;
>                ret = 0;
>                break;
>        default: /* -1 */
>                ret = 0;
>                break;
>        }
>
>        return ret;
>}
>
>If (hvs->recv_data_len > 0), I think we can return hvs->recv_data_len here.
>
>If hvs->recv_data_len is 0, and hvs_channel_readable_payload(hvs->chan)
>returns 1, we should not return hvs->recv_data_len (which is 0 here), 
>and it's
>not very easy to find how many bytes of payload in total is available right now:
>each host-to-guest "packet" in the VMBus channel ringbuffer has a header
>(which is not part of the payload data) and a trailing padding field, and we
>would have to iterate on all the "packets" (or at least the next
>"packet"?) to find the exact bytes of pending payload. Please see
>hvs_stream_dequeue() for details.
>
>Ideally hvs_stream_has_data() should return the exact length of pending
>readable payload, but when the hv_sock code was written in 2017,
>vsock_stream_has_data() -> ... -> hvs_stream_has_data() basically only needs
>to know whether there is any data or not, i.e. it's kind of a boolean variable, so
>hvs_stream_has_data() was written to return 1 or 0 for simplicity. :-)

Yeah, I see, thanks for the details! :-)

>
>I can post the patch below (not tested yet) to fix hvs_stream_has_data() by
>returning the payload length of the next single "packet".  Does it look good
>to you?

Yep, LGTM! Can be a best effort IMO.

Maybe when you have it tested, post it here as proper patch, and Xuewei 
can include it in the next version of this series (of course with you as 
author, etc.). In this way will be easy to test/merge, since they are 
related.

@Xuewei @Dexuan Is it okay for you?

Thanks,
Stefano

>
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -694,15 +694,25 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
> static s64 hvs_stream_has_data(struct vsock_sock *vsk)
> {
>        struct hvsock *hvs = vsk->trans;
>+       bool need_refill = !hvs->recv_desc;
>        s64 ret;
>
>        if (hvs->recv_data_len > 0)
>-               return 1;
>+               return hvs->recv_data_len;
>
>        switch (hvs_channel_readable_payload(hvs->chan)) {
>        case 1:
>-               ret = 1;
>-               break;
>+               if (!need_refill)
>+                       return -EIO;
>+
>+               hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
>+               if (!hvs->recv_desc)
>+                       return -ENOBUFS;
>+
>+               ret = hvs_update_recv_data(hvs);
>+               if (ret)
>+                       return ret;
>+               return hvs->recv_data_len;
>        case 0:
>                vsk->peer_shutdown |= SEND_SHUTDOWN;
>                ret = 0;
>
>Thanks,
>Dexuan
>


