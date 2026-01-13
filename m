Return-Path: <linux-hyperv+bounces-8271-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 804E8D1A074
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 16:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F7F5300C362
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84C23451C8;
	Tue, 13 Jan 2026 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTkz7t1x";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZmInMJA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ACB2727E2
	for <linux-hyperv@vger.kernel.org>; Tue, 13 Jan 2026 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319619; cv=none; b=k+7NUDJE7bFvYd8ou52t6Gn3sP/JyGgBj/EP8GuRQlaE48kLc/NvLOXJFHePJMapu5G1WuQOAS8ZYjrFNxfV5eepXfzMaNwvuPdYi5irP7dpTBZmug3R+l6MOKhjaoZceS51klxVOlrTHv1cAcjj7COEfIySoBRhPJ5SuxkPQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319619; c=relaxed/simple;
	bh=Rr2crUz2DUI9okAYGgwFpuu8kDcfbmW4w4rvyQxofL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtfWKTXerG6A4Hw5OO3yLNxJF5X/mI2wOTfWxFr2pR5AAwFvinRnrU0jhQxaYciwJ5ylWzTg7zNnXB0lHNwuzGG+Io2NPXRL43fMozUzxl6ITx4TtzS2vrW7f9/k0AJsUq29euy5fvVUIzmncZ9fToaw25ss9OcWkcQUWTrHWNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTkz7t1x; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZmInMJA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768319613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TZoXydkaCbRzi/BpIgWSYmd+dDTH7DJWzt1xArcC9YQ=;
	b=XTkz7t1xNvqocMM7vFWA0GXBOARlFWTV+4S8wKv9Z+o44hevmVOa7t22dTw0UHghJmUaiC
	DbCpOhN810Ldmslkyjwaf29P4DdS1FcH7zwxeNDS6I0hvLjCpoRvoynx7RHM/KPISIsHjy
	WXxs21wRI6ulUZ1uSGt+h9BEkfs7ELA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-fIm4U6g7MK-54OtzWsWz1g-1; Tue, 13 Jan 2026 10:53:31 -0500
X-MC-Unique: fIm4U6g7MK-54OtzWsWz1g-1
X-Mimecast-MFC-AGG-ID: fIm4U6g7MK-54OtzWsWz1g_1768319610
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47edee0b11cso3112455e9.1
        for <linux-hyperv@vger.kernel.org>; Tue, 13 Jan 2026 07:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768319610; x=1768924410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZoXydkaCbRzi/BpIgWSYmd+dDTH7DJWzt1xArcC9YQ=;
        b=AZmInMJAKFbIrBf7UToa72AxvvcyYT/ZyN9qd+0NBs/qY1lbUWeo/SM3iFJijD8Wnn
         CV+rTPczW3bJ2SJWrIGHjz5A5pONIjqR09iBr0+aToxIIL9/lfrBR/8OemiJ4j2fp1Ty
         xHZQUKwYmlLSkkOcZj56yBNMcn5ZoULiYtVnawOfn+fdTAMOq7MAoI+R1crh2pzMQPdf
         CW0JHR5Pf8w14iHiPH7835uPvYSY0Kp+WXVbFALOVIQwF7hmZpw9VGr9fe5p0nszDLBT
         31MntioOtNFIK/Um3yb2GqAjTyGGmw0kuXj68/XA1qzD3VHml60CVmPMmOql+8vXgh43
         b84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768319610; x=1768924410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZoXydkaCbRzi/BpIgWSYmd+dDTH7DJWzt1xArcC9YQ=;
        b=nt9TmN6eiSbNsuWueCBuTCcseRkNf9kLUGNKccJ60OUUCKqP8fELC+TiErs3JVLVeB
         X1oRaGhY/uyC3djiE7LcSAmN4XHLD3BIRVSTZyW0QbvaN1kja40la0P5kTJV+oITt9KL
         acJT/WAysGUM6OvDLHtyFaf3Rfo6TqbWD2puHWGvSvq6EQyTeJAhkLOg9tVjC7ATM0vu
         6dB59OGtqRTs0MIYpO8jTnmp2tTAjuqTXADHXa1kJdJqtUas5lAiO4pRcHJq/y7bqaTk
         KQYC1rFepf720+nrwih/Prl5euZ7sQ+EFSvNd+nO16nvefY/+yhFu9ONIjuWWHVPQj53
         8xCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjoIiZwGRFCc6S7pQoQct2gFWkQpA2/bAhQ1oNHHEk5Cw3mwxtGeaLwGGijHND5Z8odaUCYr/GTmzDRFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4bHImimfCYAPPKFbhvNpNIwYiUBWuz9U1IuLOF5+I9+M0cpSc
	lHtCgmiD7y5Jk2Cns2T1unH8JyfdbfeAEihbB/qjVHFQ/8Tk0plJGZcLWxTXa2kZlDBk+tD/eLu
	Qvz/AF9zmnEVDY1xldzA/bI9blP8WgjQyMaVG9V6b5IYEijad98iI7D5FDvjWo6Dz2Q==
X-Gm-Gg: AY/fxX4CdGmx6ewE3632JhTqZRTj6qFBflUbLffxwfUtfKDwng4Z0RZomgq0BPUnumM
	RYykXyEXOvD/Je4BtvxEe++bhmK2L6cPz987mP6G4Z+pv/y//wDqiTwngvnaeW4+IOYNDwNKaPD
	MVUlw3iRzYJLNVRmRWLI5/x0P9pbXQsFshUXHLf9lkCN4EOhNiUJOGEQP/y1AYnJ50WT0UuvZ52
	bvdeVfRluBSpa3txYTUoporJtEQ/oFLcj87hTUx2TbvSS3JBEmiFw3J0yLY0wUDAYGVh9XPcoHE
	vwkfkgO+A1wVF/+x6IHSdXBnOUshma3oBtvTZeZMT9C3J+4xeuIzFWqfnlu7zcMlqDcPJgZCask
	pOOd8ab881n9VrtfFfOoK5I4Ay/vGojADifkICVYb8UPcZwd32RdOtbbM3y2B1A==
X-Received: by 2002:a05:600c:4449:b0:477:aed0:f401 with SMTP id 5b1f17b1804b1-47d84b368f6mr258282585e9.23.1768319610406;
        Tue, 13 Jan 2026 07:53:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQfC7/NeIeIlU44iVNxdFG3KKUWSQZIDiswxSwdGso26nsC4+3O4KhbxqfJ82+1Ys/KVNR7A==
X-Received: by 2002:a05:600c:4449:b0:477:aed0:f401 with SMTP id 5b1f17b1804b1-47d84b368f6mr258282215e9.23.1768319609956;
        Tue, 13 Jan 2026 07:53:29 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f69e802sm419650175e9.8.2026.01.13.07.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:53:29 -0800 (PST)
Date: Tue, 13 Jan 2026 16:53:20 +0100
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
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v14 05/12] selftests/vsock: add namespace
 helpers to vmtest.sh
Message-ID: <aWZqYWzhGf9gQgHk@sgarzare-redhat>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
 <20260112-vsock-vmtest-v14-5-a5c332db3e2b@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260112-vsock-vmtest-v14-5-a5c332db3e2b@meta.com>

On Mon, Jan 12, 2026 at 07:11:14PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add functions for initializing namespaces with the different vsock NS
>modes. Callers can use add_namespaces() and del_namespaces() to create
>namespaces global0, global1, local0, and local1.
>
>The add_namespaces() function initializes global0, local0, etc... with
>their respective vsock NS mode by toggling child_ns_mode before creating
>the namespace.
>
>Remove namespaces upon exiting the program in cleanup(). This is
>unlikely to be needed for a healthy run, but it is useful for tests that
>are manually killed mid-test.
>
>This patch is in preparation for later namespace tests.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v13:
>- intialize namespaces to use the child_ns_mode mechanism
>- remove setting modes from init_namespaces() function (this function
>  only sets up the lo device now)
>- remove ns_set_mode(ns) because ns_mode is no longer mutable
>---
> tools/testing/selftests/vsock/vmtest.sh | 32 ++++++++++++++++++++++++++++++++
> 1 file changed, 32 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


