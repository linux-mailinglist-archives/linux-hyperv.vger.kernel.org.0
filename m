Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 694EEC0138
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Sep 2019 10:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfI0IdF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 27 Sep 2019 04:33:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfI0IdF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 27 Sep 2019 04:33:05 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC693C05AA52
        for <linux-hyperv@vger.kernel.org>; Fri, 27 Sep 2019 08:33:04 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id 190so2434430wme.4
        for <linux-hyperv@vger.kernel.org>; Fri, 27 Sep 2019 01:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8q/w5sAXzXN1dRT+MgNlQctaxYrMedzUaye5evRWr8c=;
        b=Tygc7LuzT9nwYKPYoW/nmV7RRvGYzSAcW+wMmc+DCCxCaOnA9Qpyj76CrOdio3Jrnj
         bexQQGda87kcna0eDtQNkWKY0OA6TLP8fBwuWPMbAJ0b2lzV8mZIRTWEmZYSCNPe/6UV
         6vofb+6T+PjYcybHFQIlYNtT5kTDkhL7o6f1QZa6/lPDU70lBWsk0Qy4fDGjTbLwYGSB
         uLAvz6EOkE7R4jexVA65vlIw+yoR0GML63qkGCxE8LYY4hMrkgHtG+T41AcVb2DoKuRh
         iz/mMrOHY4wRivlKT4p6cNUm8db9xs5HcOm/rqCHrCfkSEseSo9CFDfiPwCfpIEPtUvN
         Kq3g==
X-Gm-Message-State: APjAAAX8+U2RuwwWB1ZcztT+dARDM5L6H0DFlIAj7Ob0MJPRNMjG8HLr
        Mvn+JWOEQ6whEGP1+SFbShNyTrJRTX2EF/aYFFZgGwXZGC43RtN+S5b82pmYjxmhN8R0vX0e71X
        Q3PCm2Qp5hSmeC5PD0+ZsBAeP
X-Received: by 2002:adf:e9c5:: with SMTP id l5mr1966697wrn.40.1569573183635;
        Fri, 27 Sep 2019 01:33:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz1XqOwNHa9WBwgJ453lXOPmAttGZXlCqgWAiPmgeffopvvBWugkK9DmTJuCHziUY3/8n0+bQ==
X-Received: by 2002:adf:e9c5:: with SMTP id l5mr1966676wrn.40.1569573183304;
        Fri, 27 Sep 2019 01:33:03 -0700 (PDT)
Received: from steredhat.homenet.telecomitalia.it (host174-200-dynamic.52-79-r.retail.telecomitalia.it. [79.52.200.174])
        by smtp.gmail.com with ESMTPSA id 33sm2224730wra.41.2019.09.27.01.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 01:33:02 -0700 (PDT)
Date:   Fri, 27 Sep 2019 10:32:59 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "ytht.net@gmail.com" <ytht.net@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "jhansen@vmware.com" <jhansen@vmware.com>
Subject: Re: [PATCH net v2] vsock: Fix a lockdep warning in __vsock_release()
Message-ID: <20190927083259.zpzseatncogfdrv4@steredhat.homenet.telecomitalia.it>
References: <1569460241-57800-1-git-send-email-decui@microsoft.com>
 <20190926074749.sltehhkcgfduu7n2@steredhat.homenet.telecomitalia.it>
 <PU1P153MB01698C46C9348B9762D5E122BF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB01698C46C9348B9762D5E122BF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Sep 27, 2019 at 05:37:20AM +0000, Dexuan Cui wrote:
> > From: linux-hyperv-owner@vger.kernel.org
> > <linux-hyperv-owner@vger.kernel.org> On Behalf Of Stefano Garzarella
> > Sent: Thursday, September 26, 2019 12:48 AM
> > 
> > Hi Dexuan,
> > 
> > On Thu, Sep 26, 2019 at 01:11:27AM +0000, Dexuan Cui wrote:
> > > ...
> > > NOTE: I only tested the code on Hyper-V. I can not test the code for
> > > virtio socket, as I don't have a KVM host. :-( Sorry.
> > >
> > > @Stefan, @Stefano: please review & test the patch for virtio socket,
> > > and let me know if the patch breaks anything. Thanks!
> > 
> > Comment below, I'll test it ASAP!
> 
> Stefano, Thank you!
> 
> BTW, this is how I tested the patch:
> 1. write a socket server program in the guest. The program calls listen()
> and then calls sleep(10000 seconds). Note: accept() is not called.
> 
> 2. create some connections to the server program in the guest.
> 
> 3. kill the server program by Ctrl+C, and "dmesg" will show the scary
> call-trace, if the kernel is built with 
> 	CONFIG_LOCKDEP=y
> 	CONFIG_LOCKDEP_SUPPORT=y
> 
> 4. Apply the patch, do the same test and we should no longer see the call-trace.

Thanks very useful! I'll follow these steps!

> 
> > > -		lock_sock(sk);
> > > +		/* When "level" is 2, use the nested version to avoid the
> > > +		 * warning "possible recursive locking detected".
> > > +		 */
> > > +		if (level == 1)
> > > +			lock_sock(sk);
> > 
> > Since lock_sock() calls lock_sock_nested(sk, 0), could we use directly
> > lock_sock_nested(sk, level) with level = 0 in vsock_release() and
> > level = SINGLE_DEPTH_NESTING here in the while loop?
> > 
> > Thanks,
> > Stefano
> 
> IMHO it's better to make the lock usage more explicit, as the patch does.
> 
> lock_sock_nested(sk, level) or lock_sock_nested(sk, 0) seems a little
> odd to me. But I'm open to your suggestion: if any of the network
> maintainers, e.g. davem, also agrees with you, I'll change the code 
> as you suggested. :-)

Sure!

Just to be clear, I'm proposing this (plus the changes in the transports
and yours useful comments):

--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -638,7 +638,7 @@ struct sock *__vsock_create(struct net *net,
 }
 EXPORT_SYMBOL_GPL(__vsock_create);

-static void __vsock_release(struct sock *sk)
+static void __vsock_release(struct sock *sk, int level)
 {
        if (sk) {
                struct sk_buff *skb;
@@ -650,7 +650,7 @@ static void __vsock_release(struct sock *sk)

                transport->release(vsk);

-               lock_sock(sk);
+               lock_sock_nested(sk, level);
                sock_orphan(sk);
                sk->sk_shutdown = SHUTDOWN_MASK;

@@ -659,7 +659,7 @@ static void __vsock_release(struct sock *sk)

                /* Clean up any sockets that never were accepted. */
                while ((pending = vsock_dequeue_accept(sk)) != NULL) {
-                       __vsock_release(pending);
+                       __vsock_release(pending, SINGLE_DEPTH_NESTING);
                        sock_put(pending);
                }

@@ -708,7 +708,7 @@ EXPORT_SYMBOL_GPL(vsock_stream_has_space);

 static int vsock_release(struct socket *sock)
 {
-       __vsock_release(sock->sk);
+       __vsock_release(sock->sk, 0);
        sock->sk = NULL;
        sock->state = SS_FREE;

Thanks,
Stefano
