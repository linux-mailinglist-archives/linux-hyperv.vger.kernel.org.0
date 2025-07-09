Return-Path: <linux-hyperv+bounces-6158-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 047EBAFED11
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 17:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6C35C26E0
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 15:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C4E2E6D02;
	Wed,  9 Jul 2025 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYVrFA5e"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434A2E5B21
	for <linux-hyperv@vger.kernel.org>; Wed,  9 Jul 2025 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073273; cv=none; b=jLvXBKR/5hV6F7XQRIEycC+k8uMIgQ8goGtmyz4YcxZn6Dg44j9yDYU1c1wRWQxVQoVEX2wx/Byo5OO9xcaTqkiCdoHpuearRmRVaghsdXJ4e4BZDM/exTXUU5emBZqM7PYv2Gl979G/ThAi7zEIFjF3IUZiWpTyUhhQmXx5ZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073273; c=relaxed/simple;
	bh=Y9ykHGirYpNqtGJXkqW0tDJEz7IdqI8cXIVyGrNiyQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFTqez9UD57ULo8jyhri/wslH1v+RXkx83S/oj+m8lGsJ4VG+11NkHQxkhAOCk9OoqCF/bmS6wOgFnO3ga0d6QYi3F5DPle+U1G4fwQfl+LJ7zKOTYT2LtR/N5ZcjaRXazdlrJCPi6mtmcE+cifVdqJXGrSrAMrQp+RjgHdDCI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYVrFA5e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752073270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+y5Mc7Ku9xFduFSvneUFDHlNdHuhrWh+oYLysJt700=;
	b=NYVrFA5e7RYdr0NFd0WiCkNuOnNfoY5502R05bIDOn1hCJVMRr8EZ4wnn+a1W5kRmcdAdA
	hzg5OzlCpLtWOq9KOY5QQ4i/aKuc5k/vdOK/FuYbqicM1Z2b+CXHAkWthMoFNE0a4ufq1S
	dmR8lzk4weuyv4MbYLkfoVA2qiP4mX4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-0B3bQERJNP6J6BFeh9K2jA-1; Wed, 09 Jul 2025 11:01:09 -0400
X-MC-Unique: 0B3bQERJNP6J6BFeh9K2jA-1
X-Mimecast-MFC-AGG-ID: 0B3bQERJNP6J6BFeh9K2jA_1752073265
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45320bfc18dso95985e9.1
        for <linux-hyperv@vger.kernel.org>; Wed, 09 Jul 2025 08:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752073265; x=1752678065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+y5Mc7Ku9xFduFSvneUFDHlNdHuhrWh+oYLysJt700=;
        b=N27ZApc1uEAgWKdeXIRstykWG7hmVd/tuHBCTNsQ+jUwrcKkUwRgWJ4KuXKPVTuxr1
         XHHsT9MrFHEXxEsU0ATAMTBp0WzJxsUHtjC5RwznDUR6SZo6g4YwBXP17Qeqv5340XQ3
         kTFIQOmqKUFNKfF43tVvn3CGVxpWnFGPyKPpuF0xH9zmmXoibOukDDrJU1V6Wktqvg1c
         vfinTRqGVJmsSqBRb+yp5rSQ5/ir2m31X5wgzadykIJaDJrc2SIQgUAVdyhlDUDibKoE
         EYC0wHYrtw/7XEdnhX/3Rhh0wTCMjlJzfFdQ35plr5Y0TTIZb5qA8S3yZ9QC96MazLBP
         vHJA==
X-Forwarded-Encrypted: i=1; AJvYcCU0PpGF2VSRgXgZO61OmTWnw96eLh/pnn5k6ThkCyJ/2+8b4CpQYYa23IXwLzr31NqqJx/IfEoaC6uyd10=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ70QSJKoyIH5zmtdDm4zyonX9jjQ3Otv+tamCiB7UKoI2MqLU
	FFprS28FRw7tp6FVHN5u6NE081xC3Jeu4+SvhhtE8JbWFFep/By3r2EdVvZ2IROzPQCYcL0JIdJ
	qnlS2/NtcgUQ9+b7T+/O3F8DPGpot+b028jlQ+wKMbAMJ1WH4eMHvav8jPN/xzjoSEQ==
X-Gm-Gg: ASbGncsBJKmCIhmIt+cs3fF/zSRMtwBLAWpQK2+Rm0X73sX6UkJdFv3Kn4aSSc3q7dP
	NboyV3zbbnmk01UeC3qSB9kIbz2Ot8OEsxNFHrL6OIPmBQfv3KG5oZ/n/ubsyZpw3g/nFTRtGxB
	S3igWSPsfKJAnqLZ9TO4M/hzqA4cTAtK4tcyB6JJWwTbPgZvWTL8BUToDC/NemEBpWO56tjHUPY
	7A5h2MiacYh2nDpZGg66u8wWmE/H1gNabuy59OSRbZsLgjUY0uXPftDCTiPTg0lB1BEHQ4KoObD
	A1i50GYhwaxo24lt7gEV8d3B7ao=
X-Received: by 2002:a05:600c:37ca:b0:453:5c7e:a806 with SMTP id 5b1f17b1804b1-454cd646fb2mr72509375e9.8.1752073262681;
        Wed, 09 Jul 2025 08:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxFA3JrFBZwnjsmUsRBbJZ6PJIlFVkCWBmo9J2d0qr9LD4rFkvuvX6RsAssbfW4rug3RVliA==
X-Received: by 2002:a05:600c:37ca:b0:453:5c7e:a806 with SMTP id 5b1f17b1804b1-454cd646fb2mr72507625e9.8.1752073261100;
        Wed, 09 Jul 2025 08:01:01 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d511cb48sm26116305e9.36.2025.07.09.08.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:01:00 -0700 (PDT)
Date: Wed, 9 Jul 2025 17:00:58 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	niuxuewei97@gmail.com
Subject: Re: [PATCH net-next v6 2/4] vsock: Add support for SIOCINQ ioctl
Message-ID: <h44zrd5qem6vzcmoc45kccx2xaex2lnx6ybf63h5tzc23yfppv@toywbfazwjri>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
 <20250708-siocinq-v6-2-3775f9a9e359@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250708-siocinq-v6-2-3775f9a9e359@antgroup.com>

On Tue, Jul 08, 2025 at 02:36:12PM +0800, Xuewei Niu wrote:
>Add support for SIOCINQ ioctl, indicating the length of bytes unread in the
>socket. The value is obtained from `vsock_stream_has_data()`.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2e7a3034e965db30b6ee295370d866e6d8b1c341..bae6b89bb5fb7dd7a3a378f92097561a98a0c814 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
> 	vsk = vsock_sk(sk);
>
> 	switch (cmd) {
>+	case SIOCINQ: {
>+		ssize_t n_bytes;
>+
>+		if (!vsk->transport) {
>+			ret = -EOPNOTSUPP;
>+			break;
>+		}
>+
>+		if (sock_type_connectible(sk->sk_type) &&
>+		    sk->sk_state == TCP_LISTEN) {
>+			ret = -EINVAL;
>+			break;
>+		}
>+
>+		n_bytes = vsock_stream_has_data(vsk);
>+		if (n_bytes < 0) {
>+			ret = n_bytes;
>+			break;
>+		}
>+		ret = put_user(n_bytes, arg);
>+		break;
>+	}
> 	case SIOCOUTQ: {
> 		ssize_t n_bytes;
>
>
>-- 2.34.1
>

LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


