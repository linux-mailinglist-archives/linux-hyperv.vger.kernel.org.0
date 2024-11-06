Return-Path: <linux-hyperv+bounces-3266-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEB69BE2E0
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Nov 2024 10:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EF32810D5
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Nov 2024 09:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF911DA31D;
	Wed,  6 Nov 2024 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5NVAZQf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5842918C00E
	for <linux-hyperv@vger.kernel.org>; Wed,  6 Nov 2024 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886125; cv=none; b=PJkRkgQR2NiiRb/r4hxmzrmV4bn05mkYFjGFs4xw3kIfSZA2DEop7owPvtNYCJI7eqqDRVjTPMePl6EnuIUsWP8JcWqPOV/otr63XO+A+GBgOHO28/YOcOfWLDs1CEuyW9LsDOx/2Qq6D35QJUaeyKZ/OTbq22xPDVYv/4a8UwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886125; c=relaxed/simple;
	bh=Bvl36VOmpCQxv3IEs3k+665K4+jeHl2Dl/E6Fh3bEOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcMg1gPUgIiYSbevfKhFwb4TzLCpxFkwGo5DJy2SEoJFNSSxnndyp0H1eKxAF7q7ezpthTwtHWDWZaQe61HNZhn0Jvhb5kA2A5aTiXUbjc+9bif9llCNznSCekcGwmPMeD+d+orlfQ3TyO1GjyFizp1hX9VsQEra6ZJnxBHZiAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5NVAZQf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730886123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5/m2B5XkqveJBUmDhsVEUtZ9/8cFuA0F3GzIlGJUsU0=;
	b=Z5NVAZQf9MvYo3SorCtXAvjHqXYyKzFM2781j0uiR+RqPtOd2Cs2F+ja70AyCw4pngvkKa
	QblaerYC+HjtjRGZqyQioxZeu/4axAZ/aea8GWpeFzJkFpoQRdec/p2vhu3xFIYwY7QLJo
	z8rwjdcQUpqtj9R2Ln3pmLnxRVi++oU=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-gner-AbEPseA2gCN3Q0YeQ-1; Wed, 06 Nov 2024 04:42:02 -0500
X-MC-Unique: gner-AbEPseA2gCN3Q0YeQ-1
X-Mimecast-MFC-AGG-ID: gner-AbEPseA2gCN3Q0YeQ
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-84ffb72a4ffso1339702241.0
        for <linux-hyperv@vger.kernel.org>; Wed, 06 Nov 2024 01:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730886122; x=1731490922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/m2B5XkqveJBUmDhsVEUtZ9/8cFuA0F3GzIlGJUsU0=;
        b=IXb8T2FpgqZJmps2v9J8USGugvIZ3peek710MUsLHFlZ9NI9rX1ugsSBl/PhzBG1SF
         LV32dYcaoOMj7GWcfWJ5uc1MJc4Q1oyScxrSgbKFzK8UwH0NNac3/w0v5JaSMWleJwK7
         H6IwM/uZXcm536Fpdtm7iZ49uNX97u8r7mx6CVhGpPiQLclNZM8zaQsUXuKdSNpEhjj2
         rHChCW2D+nO4nic6+FRt23cDRP9sFDI5cuHNEsUfi62mDqg7DyOnqNPfUsosLK6mfoIt
         Hi74GPHwWO5PbR6LZGsDPoJG5P1kf+8Jfs/fTOHrAw/V9DgsVQlCeuoCLx03kLVxRrTl
         NEVg==
X-Forwarded-Encrypted: i=1; AJvYcCXJoHdin4JNnhj0qFr5ZtvUAP+JNPYvnTZRPRWhEzFaYPM46WjCAzN6EqlNuqbwJSJwmKMCAAH7sgOyizo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo3fGnlUG7Dyi3tRzCJW4+KMa8IEelsrUuBfgkYiviCidfnLda
	d7wT9RIM6qjE3ZMBNqq+JH8vTsiL9oHrv+lsU83H1xdmwE/Dkgnp33fQyYqyx2NBAc6H/0udFCh
	2Yu1cmLF5FxgXaWFuXyV/TqCiO/zHWrpq5Bl76phpEtSXzUZNahI6+dQkNUogfg==
X-Received: by 2002:a05:6102:548d:b0:4a3:d46a:3590 with SMTP id ada2fe7eead31-4a95425990amr23379997137.1.1730886120273;
        Wed, 06 Nov 2024 01:42:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmS9OYo4otT12nfkWmtHNvDCJx/YgNSZ/gBSMflzmUZlx87lhupACD1+p41aeETaeGNvH1KA==
X-Received: by 2002:a05:6102:548d:b0:4a3:d46a:3590 with SMTP id ada2fe7eead31-4a95425990amr23379910137.1.1730886118398;
        Wed, 06 Nov 2024 01:41:58 -0800 (PST)
Received: from sgarzare-redhat ([5.77.86.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39e992esm612199085a.25.2024.11.06.01.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:41:57 -0800 (PST)
Date: Wed, 6 Nov 2024 10:41:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	mst@redhat.com, jasowang@redhat.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, gregkh@linuxfoundation.org, 
	imv4bel@gmail.com
Subject: Re: [PATCH v2] hv_sock: Initializing vsk->trans to NULL to prevent a
 dangling pointer
Message-ID: <lnagtti6isffhiioeevmy5gzdmpiuy7zlztsipryw6brsg37ee@rhvuzi6kraff>
References: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>

On Wed, Nov 06, 2024 at 04:36:04AM -0500, Hyunwoo Kim wrote:
>When hvs is released, there is a possibility that vsk->trans may not
>be initialized to NULL, which could lead to a dangling pointer.
>This issue is resolved by initializing vsk->trans to NULL.
>
>Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")
>Cc: stable@vger.kernel.org
>Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
>---
>v1 -> v2: Add fixes and cc tags
>---
> net/vmw_vsock/hyperv_transport.c | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index e2157e387217..56c232cf5b0f 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -549,6 +549,7 @@ static void hvs_destruct(struct vsock_sock *vsk)
> 		vmbus_hvsock_device_unregister(chan);
>
> 	kfree(hvs);
>+	vsk->trans = NULL;
> }
>
> static int hvs_dgram_bind(struct vsock_sock *vsk, struct sockaddr_vm *addr)
>-- 
>2.34.1
>


