Return-Path: <linux-hyperv+bounces-4641-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44023A6A21A
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 10:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD08A7A732D
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 09:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F033321CFEC;
	Thu, 20 Mar 2025 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMUff2xb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FFB211710
	for <linux-hyperv@vger.kernel.org>; Thu, 20 Mar 2025 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461695; cv=none; b=BdfSJZRw6GP0Vymg73QMVq4rhZwDCL0o/hU/95Fz0zd6RqqhSItXk7a3cPcnui++8ySLyiZgFDWD0XPs34wFkIJ+hNHTIq5DZHa1/FyPL2cErzPiP1jlivrYL8Q29XjoA0g0e6qCNCwwIBiJu8llKLbrYEGtzFjeTKuIr46QFnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461695; c=relaxed/simple;
	bh=5W1uHTX0JS3ybfrgNeMmG6TgEZd4dU4vl69eG6Vq4OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULBE0UJ+HCLawNMzyK7M1vx5KVB6lx0NSObRtq7k1UXu134vJqEbhs95ZHSUV5As0PA3p/BheCThHGw6FrkNnlE41wRKtT9cta5mzjgHhuFtiZcoHmeCp1dm15MC5mF592eq2sq7ZX96FxnP3RKOHZaRfgKCAbMuWSaLZnyVJOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iMUff2xb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742461693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bDTq60/uptS/vYIusNxJ/yOQlPzuUR9or0TJgSxpmhw=;
	b=iMUff2xbcMVsZUkbgKSwbBzHicSNpA5LIqYyjHnuGJdO8bVfNuw5N7PRqYJbF9hB0a46wz
	fezjH9hdKJdUs0zWGtWSu5wUfdO9uLYHtQLNTOCnPmtxwVbN5SA611RLuMBm8J95BTpr1J
	IyvZS7Dya2r8vBDAa1UNqV8ZCFvcwIA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-vsXwd2o7MrGZUFph9a_0vA-1; Thu, 20 Mar 2025 05:08:11 -0400
X-MC-Unique: vsXwd2o7MrGZUFph9a_0vA-1
X-Mimecast-MFC-AGG-ID: vsXwd2o7MrGZUFph9a_0vA_1742461690
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d9e4d33f04so480201a12.0
        for <linux-hyperv@vger.kernel.org>; Thu, 20 Mar 2025 02:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742461690; x=1743066490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDTq60/uptS/vYIusNxJ/yOQlPzuUR9or0TJgSxpmhw=;
        b=XOHCVfoz4U0+IFnQ2vd+N9lsiLZOH/H4RQBfVOc4IFcZXO5n4o2ptBxVX3Dg+xBw4I
         Skw9qg3RBnOF4eWaI9AAWXlAyvcSUQRDUsatoZS2P0/D6r7OyzWcGzDwKqzXBb+bzRyG
         EVONk85JBFboR9vAumE9V0tn/L7xj4QcvNiPRMPUPHjPsispWzguObD16e42e2rF3CUN
         0L9DvXu/0Dzsh8MmOGp5U1xgfmN1BzTMZh73piMWzt+cWM4tzndhGLWg8Za3nYw/4Tfg
         YsM37lcLsiIEFAeqqJN8DT33vLv/HQnOlDZrm9eqPJKlBF+JElgABNL7Qe8uYvY//mqt
         OlOw==
X-Forwarded-Encrypted: i=1; AJvYcCWXGcJuQ5tjPwXM18r4i1VauKTYtfJVllqeqMw2iKCNB8WF3kJkFIZVgBB0g6slomvcfxA1x++g5JOlA6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcZqIs2DM9oPbBJjtipq2KSLBMbEit6Z81Vx5vFMVAaCVvlsEU
	wAnw5JlUpvp8OG5zID2gbDb1d5k/J9nDwHNennLstqvhi67KCRFINlQv8eSQ/s1dWXsfF70fUrc
	bDwFJ8kh1pbcVViKcMXTLKnfISIJoIjhbpZDv+vbfWC3Wcd6OrHVD5Ertx3CKRQ==
X-Gm-Gg: ASbGncsXoyFF2NYe2qWoR1rJPsY6Y1N8ZJfB+5pwRvv9FmIxbqnZrn6vRD3313tDYlQ
	EiZMjspfBxg9kMk/AH7/NpeelA95EurOlbAVq/UgA/JqFt6OAIRy/fmELUfq8ana2m/UqQ0BMGB
	Gsa19sOLyOnZPsoF8zRZn7yiDXin1mFo1lEogx679qs1flHz/O3Kz7Lko9I21xsw0SV8Vjo4lSm
	TE6mjn2A3u9AsAf1wPnX03d0XQ+lZAEiBXLF3Hicir6H9ch8uGt3DdWFlmEBcpNO3b198JkPfIQ
	3RpT8/FwfcezjNUG1rtXQYh3dcXXzAhYeb1zQhqOZmmenUtKkSPXgo9Y7k9bpbdk
X-Received: by 2002:a05:6402:13cf:b0:5e7:c779:85db with SMTP id 4fb4d7f45d1cf-5eb80cdea32mr5839722a12.4.1742461690249;
        Thu, 20 Mar 2025 02:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOQHfmcgMblKkiR1tHejD7TWeiNXKZXGZAyBKU76H5X4T1+QQ1dIB97fNyYdpVkDoNZIj46Q==
X-Received: by 2002:a05:6402:13cf:b0:5e7:c779:85db with SMTP id 4fb4d7f45d1cf-5eb80cdea32mr5839682a12.4.1742461689546;
        Thu, 20 Mar 2025 02:08:09 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afeaabsm10004728a12.69.2025.03.20.02.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 02:08:09 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:08:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] vhost/vsock: use netns of process that opens the
 vhost-vsock-netns device
Message-ID: <nwksousz7f4pkzwefvrpbgmmq6bt5kimv4icdkvm7n2nlom6yu@e62c5gdzmamg>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-3-84bffa1aa97a@gmail.com>
 <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>

On Wed, Mar 19, 2025 at 10:09:44PM +0100, Paolo Abeni wrote:
>On 3/12/25 9:59 PM, Bobby Eshleman wrote:
>> @@ -753,6 +783,8 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
>>  	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>>
>>  	vhost_dev_cleanup(&vsock->dev);
>> +	if (vsock->net)
>> +		put_net(vsock->net);
>
>put_net() is a deprecated API, you should use put_net_track() instead.
>
>>  	kfree(vsock->dev.vqs);
>>  	vhost_vsock_free(vsock);
>>  	return 0;
>
>Also series introducing new features should also include the related
>self-tests.

Yes, I was thinking about testing as well, but to test this I think we 
need to run QEMU with Linux in it, is this feasible in self-tests?

We should start looking at that, because for now I have my own ansible 
script that runs tests (tools/testing/vsock/vsock_test) in nested VMs to 
test both host (vhost-vsock) and guest (virtio-vsock).

Thanks,
Stefano


