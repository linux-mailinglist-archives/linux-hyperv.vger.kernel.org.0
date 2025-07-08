Return-Path: <linux-hyperv+bounces-6150-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 664EDAFC8F7
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 12:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417494A6BCD
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 10:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEE72D9EE5;
	Tue,  8 Jul 2025 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGyi8GX/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582CD2D9EC2
	for <linux-hyperv@vger.kernel.org>; Tue,  8 Jul 2025 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971984; cv=none; b=gG8yqB7oXQ0NOLOWXbliMFB5JFTBcOUsHi1nJKc8SpLgW1khneseqr3GBc4KAvHWLqkOtKiRr68k5o1hXvnaEn6dZyqqdZDWZcYzBZwITyZTUeZvyAYTrrCKHCLM4rQPM01ksmYbYxJM6e6gtzj8Z4Fpe5FmB17YG8VXQosxB1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971984; c=relaxed/simple;
	bh=1un7ouFwyBTSYIMY4zpatIXNYHrEz24iVPhqyQXJbbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbVND3tLEKSFoZNvKAIOwqdOSAu0Jh1nae/GgkBZ8TmyLvUjAUxn3TigzOT5VtSDbL/wyocMRqL+Npt7wAph2iw+spOdKl7zYiWlMwGP8Ly5y+M1JykTBM29sstGO4i2DEaUuGrDtTTXUFKZR/FszLvOF5ylNG5Vf6LW54UnpJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGyi8GX/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751971981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=315fIenJWHN1D0z1wGXcALO7wPGrPSPVrNC7//PcDEU=;
	b=XGyi8GX/BAF+tOmfHqd+RUxlCdsxzRVbD05HGxZ4kjHqn77OVe3cH1oDFRK3iEp19O6miC
	2iYcWQ5gEJbkXmhZcZg5rxFWU3tGzHXpC+KHzOz5S7HI46bCAzBuyNEOWIDBOcmME0ehI0
	4hpTPjKK1AOxhEM86Axbj1IeOsakvVs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-B5q4Vb6pMKuPOCTZ0trh0g-1; Tue, 08 Jul 2025 06:53:00 -0400
X-MC-Unique: B5q4Vb6pMKuPOCTZ0trh0g-1
X-Mimecast-MFC-AGG-ID: B5q4Vb6pMKuPOCTZ0trh0g_1751971980
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a9aa439248so31223861cf.1
        for <linux-hyperv@vger.kernel.org>; Tue, 08 Jul 2025 03:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751971980; x=1752576780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=315fIenJWHN1D0z1wGXcALO7wPGrPSPVrNC7//PcDEU=;
        b=TGUF6S1g0fbfeiYI2hyCbxrEGdp8XWPz/5CgEtmrH2JNoYj6Y3OjhBVklBeF5mbl/V
         FB0uzHjjUKw/Npo80/zm6kssV1kDntpA5f627g80d7oQi6Ae0z7STG9DG5ZyoytpZeFO
         kUnSGKvn2M8ZP5vnc1oyxB9IEXYtpF0Ah2HLOmPkpfyNVhRVbx31K0RHrvh6dh/pv562
         gA8YLqrTZcmzMZT2hd+HDm5zThPbBHGgAQvPKHWNxLRJV5ilrNEUqjENwqEPpCqqxEy5
         LzYHpe5PuZZ9XZrI5010dNCioy0vL9VLuNjbuXuRyzVhkk9bCvksUIrfc2uWonxPQjVN
         OrwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+GnMMfwsMmKjZUkYaHDycNXlplm71N9lRMaG6ooJBeROcYLlM6VQ/+NQLOa+LX0U9yp7aYPmvRitlR+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJFzxdyXORrlk1uQW5yDa2jKQ9dGJ74eG8JHwx6aWXYtohSmP9
	u5xT2+tYCGr7Y5A4CKOYwxnd5BJUtRT3WlKHReE3Zx7TnD4S49Wi3bRAbzRtaMXpblB2DgxizXp
	mZcbdabjSMZ0Yz2FbAMjjbXLTgL5nKZ2UGoPXf+G8IgwVCxs96eaXhQJFWbEI8ihNKA==
X-Gm-Gg: ASbGncuxOY2Od5/XCz03JEnE1GBocx0c0RXAWxJXK00esxBPpU+TgXvKKnEz/XzuxtZ
	xWdV00g3tj9tVUUJFr3pBsd9ZMPB933gtDVkj7DwzUqCIqLggFxVdyU8FmoA7/0JoE003UNLMzw
	PpGxECz3npsy1zgMZnT8HdV044rNpWx6ZaM5HIooOpH07aZ4wKIADjH8uFYARZOzdV4h9fqQxUl
	P3xfLlzuv2hwmYXNExzWZZ33ZyBCg+wOhcnqq3GZzacLOVTXVAMAq7eABeCkJ4DcguVPbyY4jyb
	KasD4xTDH9a2V6PQUPd6Pq6yS6Fd
X-Received: by 2002:ac8:7f95:0:b0:4a9:ae5a:e8a6 with SMTP id d75a77b69052e-4a9ae5afc23mr175966871cf.47.1751971979582;
        Tue, 08 Jul 2025 03:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzvc7u8j+WEd/fQJxoq873TigcJMGy49ozcWVyaqRVCjfg4qBqi9tMZtBOChGJAAMzAMDFrQ==
X-Received: by 2002:ac8:7f95:0:b0:4a9:ae5a:e8a6 with SMTP id d75a77b69052e-4a9ae5afc23mr175966551cf.47.1751971979134;
        Tue, 08 Jul 2025 03:52:59 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.147.103])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994aa85edsm77449631cf.74.2025.07.08.03.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 03:52:58 -0700 (PDT)
Date: Tue, 8 Jul 2025 12:52:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, niuxuewei97@gmail.com
Subject: Re: [PATCH net-next v6 2/4] vsock: Add support for SIOCINQ ioctl
Message-ID: <lh5vti5lmcxddhnfsz5pjhu7oepcbxcflqkyhlpwnwqzbe7tku@yw7bwfgafcby>
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

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

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
>-- 
>2.34.1
>


