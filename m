Return-Path: <linux-hyperv+bounces-4636-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7E2A69A94
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 22:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B55189BB7A
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 21:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6D02135DE;
	Wed, 19 Mar 2025 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXh7tijh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A46720C47B
	for <linux-hyperv@vger.kernel.org>; Wed, 19 Mar 2025 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418592; cv=none; b=qe8mmHb8s8F2fqY6ca9L2XZlarfGQEWGE3mNCUeHm87eCjnPnBAobxluuKqzT8Dfjwj8wDUxB/8MNbMh8ZE4qESCsYw0sViVgKGiuPPizXKcHElxLmWxOzC99FAqaAxkCHry2IrY9GlRqmFK0QCFtCuvYWO537C2TZuxbEigt/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418592; c=relaxed/simple;
	bh=t0DQSzj76o+q28S/J/Q+aN0pxw+YPVtotQKrAVrAB6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFMmR5Ib5gbPFy5JTL8eHgtSFuXfcQDY337qE6JpwgD8dyCawcdd/Ik3/vFD0Dj/9TGX9gL2oxdxR/1GRdxuLrHVonRPWao0Xa/RG/kLh6SWyliOJSoazDL4UPbDcRE+CPlXRzBRXLebMN12pyrlu3yXA1+4JMaPpzDu7CASYLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXh7tijh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742418589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7HoSvSm7GM5yXTNBY3sCZv8nsyIwGMkLSsX5gJEiNY=;
	b=KXh7tijhQ2SyWwxeKP+y7Xt9PN/Oj8yMA88paJ3c3gGz5USuHtS+iBmyI45JsFbcB6lVrN
	feZqdLpBxsHR9IHY0PwlUoTYsyDAgTCkzQpLBja83fnOTSvQbpdiMnbyGCVegAPDy4zncZ
	NxS6OJq823GIiNppE4CbxWiN0v/9rHw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-nExgAh96NemW7ojHlatWoA-1; Wed, 19 Mar 2025 17:09:48 -0400
X-MC-Unique: nExgAh96NemW7ojHlatWoA-1
X-Mimecast-MFC-AGG-ID: nExgAh96NemW7ojHlatWoA_1742418587
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso824835e9.2
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Mar 2025 14:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742418587; x=1743023387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j7HoSvSm7GM5yXTNBY3sCZv8nsyIwGMkLSsX5gJEiNY=;
        b=SaWxkM1ieELkRPWXGsDMSmmxPD0u0V3yueZq4yF6MID9Jzkn2YXaod+RQfmaA8ocr5
         ZEVvW4FqL06yscJtMmApk8jIkhAiPnOMF+mIWPnrc9lv5x5icnTNKC69qX84HavhkcRq
         BDItqJmXawZSCSuHm2Kj4U4nSrPHgEqN/GrNvtdjCcDZNa9kgVIloMqcLTadi94ruFUA
         Hvq1H33+IJmpB5PTv+H6J0tCdGiVg7lqk+WOiJX7c+PUfPfDMVThRqpuMZuv1FH6r5pq
         wfixYkqiJvVYRSdlCAn+qOizMmQYNUpiELtz8vpXFCeBoqBqAk6aWYQv3RzB6LVyMQsl
         9MDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd3ED0jRkn5eZ+YYxVoMfVqglw9ZzYtCDxSOIAHsJ4GxLdqmUqqIjR+WnmZcJECAjZpLDf9NesL4nZ8LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywtxjZrSXBr1pW8IeAPvF/g6CseiK0Jm0DIfv478lOWmTrSRGe
	S9nKNP10ud/4ZFDiWqOMWWIAQTWQ2ok4TOTdaPVJf3CKjVwjiwz47Gsc29ZSwPDL3DX7N1kqzNr
	+vPy4h1L1uIMd1rqPfK6LfGNj7dlYpq33dvOghqBjC47VBGAfU+2hNkCA98JQHQ==
X-Gm-Gg: ASbGnctYs3c8z3YUNetIrpCcAvJSlt4kokpzZDuuNW459KQBpKfmaBIWNIrQxgxl/I+
	xw4fOp7CZMghOuIX9GAWZ1/JlDpEpBwK5NiLoFNe+4XTBX7h0gYNWemQWWXVPLUOkqAVkyL0Bxq
	Q+kYIV7IiWjC880ssDxEqE3qxFokGt5yTAhvhdMOsDp0Ta3iP38gEpn0ViL2ZV33iVJXnz0y67O
	0lBOmXK2UXZyO3v+pYgLQBb5GjSxjz1txwpK4S6q8DyFFccv48X9D0vlo0L8lrLQQJ/PiqOBhWy
	/xx62Hr8RIaM2SaKhVJH5L/eWoafCXXLWZz5gAsQzSx56g==
X-Received: by 2002:a5d:5f4f:0:b0:38f:231a:635e with SMTP id ffacd0b85a97d-399795c2ademr966966f8f.25.1742418587028;
        Wed, 19 Mar 2025 14:09:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUNp5m5kg5nT9dIUi3KyGpUUwGQCEZhhXoTguvu2e0VxM6ACwAq8iInQv4AfDuk3Kc6Z9FwQ==
X-Received: by 2002:a5d:5f4f:0:b0:38f:231a:635e with SMTP id ffacd0b85a97d-399795c2ademr966951f8f.25.1742418586581;
        Wed, 19 Mar 2025 14:09:46 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df35ecsm22151312f8f.16.2025.03.19.14.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 14:09:46 -0700 (PDT)
Message-ID: <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>
Date: Wed, 19 Mar 2025 22:09:44 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] vhost/vsock: use netns of process that opens the
 vhost-vsock-netns device
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Bryan Tan <bryan-bt.tan@broadcom.com>,
 Vishnu Dasa <vishnu.dasa@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-3-84bffa1aa97a@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250312-vsock-netns-v2-3-84bffa1aa97a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 9:59 PM, Bobby Eshleman wrote:
> @@ -753,6 +783,8 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
>  	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>  
>  	vhost_dev_cleanup(&vsock->dev);
> +	if (vsock->net)
> +		put_net(vsock->net);

put_net() is a deprecated API, you should use put_net_track() instead.

>  	kfree(vsock->dev.vqs);
>  	vhost_vsock_free(vsock);
>  	return 0;

Also series introducing new features should also include the related
self-tests.

Thanks,

Paolo


