Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8503136D4
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Feb 2021 16:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhBHPQJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Feb 2021 10:16:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232624AbhBHPOC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Feb 2021 10:14:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612797154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cl3oAHniZYvmE61bZxJR1DSVbEaXGjJGBlodlSQeSUQ=;
        b=LVYLow/09riSjh/IU2eeHkB4NqfKoRLexJfZttku22KV0f0mNcDu5pQ/twvl80thC/tb4n
        gZnQHgVXNMjJGyrQhIW+KXzgz6yfj8IHuPtZn1meJeGtvjSMkCnEmGvQR+qbrSsYRn88AP
        dX6Oi17On8DCdZRdd9RH0iPLC2bZTn8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-jSMfnY7VNzOu6R8Zy8gMVQ-1; Mon, 08 Feb 2021 10:12:32 -0500
X-MC-Unique: jSMfnY7VNzOu6R8Zy8gMVQ-1
Received: by mail-wr1-f69.google.com with SMTP id s18so13227376wrf.0
        for <linux-hyperv@vger.kernel.org>; Mon, 08 Feb 2021 07:12:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Cl3oAHniZYvmE61bZxJR1DSVbEaXGjJGBlodlSQeSUQ=;
        b=rKEbrfj8qWgRjMOjXdaENgSsDrmwvDysBRPZdlmyKX5aWxtnwhs+udX2tgAZqBInIW
         /mT7TBDzF/7WvRrjUIaX7ZHsvwgo7g/dL7flG0drEGVmXts/YizqcUF3rWHnHSF/2pAi
         YPNxj00P0z5L4x6f08bE4x+8g2TTrJRivKdklMTEgvw11n6q+bNSM7JJmgFoTYQqHpE7
         CG7WNE+WFWZdIW7GX/b/rDCBdL9TeBFK+x5mlZioW7sPASSBvhc1evPtM49RPaNtFf7/
         E4EM0KTRAyOFfkVEr/v0s+lLJD8ZnZ1Bt4/bA/o8u1SnlWEgYI7i6h1hkDADSxowad9Q
         kd7g==
X-Gm-Message-State: AOAM533bJiAjg60lZnbIQ66YXdkRvu3s0HlN49n/c5Zgn5cPBtUc8f8F
        KCJiJ1sao9WeNPDmqqHPbL/rcNUlG5zhqsQ9UKEZavBvI6C2/Bw0zEd4m9isU2SJqbVxOx9hRNY
        hQDDwcMhc+TTDTN+XlxTOssc5
X-Received: by 2002:a1c:1b12:: with SMTP id b18mr14619628wmb.157.1612796683154;
        Mon, 08 Feb 2021 07:04:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoKb+gxkOEG0jqY4GX8H5Cgl0BMI05v7tvt5vtO2d+9BUB98uAqlYTJNGX9S72vSypyNqkDA==
X-Received: by 2002:a1c:1b12:: with SMTP id b18mr14619225wmb.157.1612796675563;
        Mon, 08 Feb 2021 07:04:35 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id w11sm8297071wmi.37.2021.02.08.07.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 07:04:34 -0800 (PST)
Date:   Mon, 8 Feb 2021 16:04:31 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     kuba@kernel.org, davem@davemloft.net
Cc:     netdev@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Andy King <acking@vmware.com>, Wei Liu <wei.liu@kernel.org>,
        Dmitry Torokhov <dtor@vmware.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        George Zhang <georgezhang@vmware.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH net] vsock: fix locking in vsock_shutdown()
Message-ID: <20210208150431.jtgeyyf5qackl62b@steredhat>
References: <20210208144307.83628-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210208144307.83628-1-sgarzare@redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 08, 2021 at 03:43:07PM +0100, Stefano Garzarella wrote:
>In vsock_shutdown() we touched some socket fields without holding the
>socket lock, such as 'state' and 'sk_flags'.
>
>Also, after the introduction of multi-transport, we are accessing
>'vsk->transport' in vsock_send_shutdown() without holding the lock
>and this call can be made while the connection is in progress, so
>the transport can change in the meantime.
>
>To avoid issues, we hold the socket lock when we enter in
>vsock_shutdown() and release it when we leave.
>
>Among the transports that implement the 'shutdown' callback, only
>hyperv_transport acquired the lock. Since the caller now holds it,
>we no longer take it.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/af_vsock.c         | 8 +++++---
> net/vmw_vsock/hyperv_transport.c | 2 --
> 2 files changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 4ea301fc2bf0..5546710d8ac1 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -943,10 +943,12 @@ static int vsock_shutdown(struct socket *sock, int mode)
> 	 */
>
> 	sk = sock->sk;
>+
>+	lock_sock(sk);
> 	if (sock->state == SS_UNCONNECTED) {
> 		err = -ENOTCONN;
> 		if (sk->sk_type == SOCK_STREAM)
>-			return err;
>+			goto out;
> 	} else {
> 		sock->state = SS_DISCONNECTING;
> 		err = 0;
>@@ -955,10 +957,8 @@ static int vsock_shutdown(struct socket *sock, int mode)
> 	/* Receive and send shutdowns are treated alike. */
> 	mode = mode & (RCV_SHUTDOWN | SEND_SHUTDOWN);
> 	if (mode) {
>-		lock_sock(sk);
> 		sk->sk_shutdown |= mode;
> 		sk->sk_state_change(sk);
>-		release_sock(sk);
>
> 		if (sk->sk_type == SOCK_STREAM) {
> 			sock_reset_flag(sk, SOCK_DONE);
>@@ -966,6 +966,8 @@ static int vsock_shutdown(struct socket *sock, int mode)
> 		}
> 	}
>
>+out:
>+	release_sock(sk);
> 	return err;
> }
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 630b851f8150..5a3beef73461 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -479,9 +479,7 @@ static int hvs_shutdown(struct vsock_sock *vsk, int mode)
> 	if (!(mode & SEND_SHUTDOWN))
> 		return 0;
>
>-	lock_sock(sk);
> 	hvs_shutdown_lock_held(vsk->trans, mode);
>-	release_sock(sk);

Ooops, removing these lines, 'sk' is not used anymore in hvs_shutdown(), 
I'll send v2 ASAP:

../net/vmw_vsock/hyperv_transport.c: In function ‘hvs_shutdown’:
../net/vmw_vsock/hyperv_transport.c:477:15: warning: unused variable ‘sk’ [-Wunused-variable]
   477 |  struct sock *sk = sk_vsock(vsk);
       |               ^~

Since I'm here, I had a doubt whether to separate this modification or 
leave it in this patch.

What do you suggest?

I did it this way because by modifying only the caller, we would have a 
nested lock.

This way instead we are sure that if we backport this patch, we don't 
forget to touch hvs_shutdown() as well.

Thanks,
Stefano

