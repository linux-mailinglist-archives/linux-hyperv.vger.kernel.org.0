Return-Path: <linux-hyperv+bounces-8269-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0D4D19F6A
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 16:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1E133020CDF
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 15:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635993939A4;
	Tue, 13 Jan 2026 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBwl8Ahy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrmS9Uxv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DEC29AB15
	for <linux-hyperv@vger.kernel.org>; Tue, 13 Jan 2026 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318940; cv=none; b=IO3HNEMIGglocCgOTlaYTdVFB0PPOgy3gTRk6xIy3f7LJjQu3sCMApuNwngCWgZNXLCoAcS8DPi8ure+Ni+7gyla+imkrlAacr8k/Dfwuy2pFnMLS+y72SVIGqIMT6cc/4nEmbD9Xhe/cD4UosikS6wWwp33KaXj6u+FXFyAkj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318940; c=relaxed/simple;
	bh=z0ktrf9THh1+HjKG5G+Ar30QQHeNINGUrFDEbpyqHsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ww1DOMMc2mQHGzXcG66x0CoJBCYgGCVHUvuKTD40S6TKE0Zo19g/6ILtbplv20078/DgJWe+MVVl1/UZoGR1VBYgNAfOej7UT+UIaojqBL6+FZo7uUQX56HiuetgiWWLIRBS0r7GSmOFUBRnBsNKxieuqXLAphbiabB+/Y+4yOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBwl8Ahy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JrmS9Uxv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768318937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VJEPhbiWRGNl7Jboc5mq3GBmXz9jBXvM23UB3dUFjRY=;
	b=VBwl8AhyOMQBDmI0szaR2ecWm5UqIs8eYGza4Up2dnS/XY3E69U2poOmcMccfLd3DVx9CA
	OomfVKL7tgUnXHArXu+eilkCMZVDDClHSA9bEqzwr8ptZ2UnKWF/KWtogZhbcAWmqJqUeV
	fzxXabDM3rLuwutsQZ8MrvFRRDtkzBA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-oqFr8MubPI2su7R5IIWGDA-1; Tue, 13 Jan 2026 10:42:16 -0500
X-MC-Unique: oqFr8MubPI2su7R5IIWGDA-1
X-Mimecast-MFC-AGG-ID: oqFr8MubPI2su7R5IIWGDA_1768318935
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477a11d9e67so51460775e9.2
        for <linux-hyperv@vger.kernel.org>; Tue, 13 Jan 2026 07:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768318935; x=1768923735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJEPhbiWRGNl7Jboc5mq3GBmXz9jBXvM23UB3dUFjRY=;
        b=JrmS9UxvNExe9f0SxaMLZoIqNBf7wtmAt8LITJYbNiw8wcDm6muI6r2os8ZOKn0Ca6
         6WO9MVzG9DOZulAg4srR9tXLbN3f9YohQoXAZ9nBFl8dVw20k1mSwxkOX8w0dTQMliaC
         sOypnMmVoneA9NqPRZEPqV4c3JRZ+QQpTqFsh3Ve7qzdbEvI0ubsOpaDN6KWOxd1mKfa
         k0+ns9Tv3H9VxsrLEMWAUjj5fJt4fdvlxq/kUgGWGhzMPjPS4qxw3rNwXYBqtiGEFRt5
         7o39St8tnHHvicCO5whiI7kF/E/yOR5la0T2nmv3ZTyZhdr4B9mZZNQj7KcyVnk6qM6V
         5NdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768318935; x=1768923735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJEPhbiWRGNl7Jboc5mq3GBmXz9jBXvM23UB3dUFjRY=;
        b=n2UIgLukGDfGEWTNhUCmZgAh7XLJiGQ0WUkRJYuciJkqkviSCnoR/hOhQWJ8X2OuMa
         3A8vsWcVAaHvXUqwgFzS1B6dOG8SLDE4oqsBlumjKImSylxM16YF4WFgjAYXvrDmaAX1
         aSevcwyK9ji3pYPV32CTV3Z0EofsJ4g5VJcw61wRm4tBfXlA9M78qsTc0ReEFM6j7uZY
         AcMM8ot1Ac4wvcAZRLlJnY5k1phLpKwl/3wf8Jhmysj/JJZ+Mr+88azlE0NEU/SXAkD+
         X6cNkO3CGDz+lpOv71diD6u2JIBRwqZ3qUZVS9sTVrQb/ZRZRcnqV+S6ei9cqJRhi65k
         W9jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLoJ2bqYgI+cMwDKlfKn+20m1A5fjiJw7CbMBOTVcbtLIRvdtM+bW2+zHpnnKGtgQ9RwOcvhLzPHDXmPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVnM3eWS97Ci89cnuYyUiBNVt9BosW1aak5YBQ6OC/GPAvA+oy
	a/w4InQp5hTLWssaPhuUUOzjea2BNciA1XThgEUGDCxk7uOdDb4mBkkNXA86GfsgDJdZFbz+tBw
	+eLOZcKYcfTA5IL7qBmI38GNZIRA72wdt5gTj2h3Zpra6ecSzG26y/zgYCVfNzERqUg==
X-Gm-Gg: AY/fxX6bS79FEk+qnUwko3zYQBjiiG3Ctm7hVa39rPt+T9tTmmpJXdSbwQn48ebpNaA
	6xN2b/Jvi2n5TIjWzgF+8L+IehMv65a51ItTObY+IWnulbeLewlcAZUiiuu6ac8tUGOhAl1QpVK
	VijWSQIQ53mtEnK8VDbHjY0abJJY8RLtgbNpe1+3Qn+Ghs3u25iWiuBaKflO2D0G9jLtsi+zle+
	tIC52OAa23x6QEq2DZW85AMc5A/pKhqUf+YHANgFPEExkqFzN4reOCX6VCpOfBSkHkqkDIo4QKt
	F0LqaKxQ032sGwUm8WLtykXyivyTd9TeAwnJxqtrmUiQ9DrhMR6exeV88yuLIjirwzFQXTFY/Yf
	jNJ4ouDd/aoZCHc6wGgEqWrvRSdxQ7abP6Lfe598JPM96HhZnoLu0QNHYxabrvw==
X-Received: by 2002:a05:600c:620c:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-47d84b3be47mr241262975e9.32.1768318935379;
        Tue, 13 Jan 2026 07:42:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4paz0040d/vitY+T5rv1eo5WHxtcQ4X4vPvSUCFKLot5Wf40qNTKU1VjGBirJbB8u4247Wg==
X-Received: by 2002:a05:600c:620c:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-47d84b3be47mr241262525e9.32.1768318934958;
        Tue, 13 Jan 2026 07:42:14 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e1adbsm45281481f8f.17.2026.01.13.07.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:42:14 -0800 (PST)
Date: Tue, 13 Jan 2026 16:42:07 +0100
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
Subject: Re: [PATCH net-next v14 04/12] selftests/vsock: increase timeout to
 1200
Message-ID: <aWZnnHxzaV9pgwzb@sgarzare-redhat>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
 <20260112-vsock-vmtest-v14-4-a5c332db3e2b@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260112-vsock-vmtest-v14-4-a5c332db3e2b@meta.com>

On Mon, Jan 12, 2026 at 07:11:13PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Increase the timeout from 300s to 1200s. On a modern bare metal server
>my last run showed the new set of tests taking ~400s. Multiply by an
>(arbitrary) factor of three to account for slower/nested runners.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/settings | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/settings b/tools/testing/selftests/vsock/settings
>index 694d70710ff0..79b65bdf05db 100644
>--- a/tools/testing/selftests/vsock/settings
>+++ b/tools/testing/selftests/vsock/settings
>@@ -1 +1 @@
>-timeout=300
>+timeout=1200
>
>-- 
>2.47.3
>


