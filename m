Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A20BECD2
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2019 09:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbfIZHrz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Sep 2019 03:47:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfIZHrz (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Sep 2019 03:47:55 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E16625859E
        for <linux-hyperv@vger.kernel.org>; Thu, 26 Sep 2019 07:47:54 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id h6so573442wrh.6
        for <linux-hyperv@vger.kernel.org>; Thu, 26 Sep 2019 00:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N2DZb0BJXpZgcpAahgI3rSwj96ykbSLsI5Vmg6oXhCM=;
        b=Ajal7mrhABNbh6oaZIhrAjegcGWFhkAq2mbqMKCdr9yf6MEp+0zOQOH0C59K6Np/uG
         GzQiLUQqQwdF4lBVQwPSWZHZEkz+pMqGHPkxycFjQOZYaZs8ubfy2peSzgcxTysyNDIf
         /OyH+EUiuovSDex5qqIxlWadSuRLj9HhPJP4lLuimu6GpCoM56BR1okk1ucjcsp1xhAn
         gX05x0FATbyb/miA7ZeSESHe+iPRILRFtZCSjBL3S/saeLqlkj/bKBG13JIptJk7Pw7c
         EWb9AxbOrsvY8ocwKHl8tZwX/l7tpM1YIRapGOZQBfAlos8NaDAvK0YE3qh9UWYwg7nz
         DiRg==
X-Gm-Message-State: APjAAAVjpl6zceYodPbThlADJ2xPmRIWVWcLnPHBcNqZZBkF0aKkokaP
        5+MTzINLk4y2cwilIkRuLNy++OEb0J9m50TWoZYhQRndW9cpMeVUYC3pAyGBZFxXxmLBhWidfpP
        qiWZ8dFLIq2lXZyxH8s7cm4N+
X-Received: by 2002:a5d:4c48:: with SMTP id n8mr1704085wrt.192.1569484073637;
        Thu, 26 Sep 2019 00:47:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzBHt91YivEK0i/YWPbwqxZI+CfJHbdKfyUlCW3lfvnleM1OckVhOwguQ/vgIrujXG4TLOX2g==
X-Received: by 2002:a5d:4c48:: with SMTP id n8mr1704043wrt.192.1569484073321;
        Thu, 26 Sep 2019 00:47:53 -0700 (PDT)
Received: from steredhat.homenet.telecomitalia.it (host174-200-dynamic.52-79-r.retail.telecomitalia.it. [79.52.200.174])
        by smtp.gmail.com with ESMTPSA id b7sm1269406wrj.28.2019.09.26.00.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 00:47:52 -0700 (PDT)
Date:   Thu, 26 Sep 2019 09:47:49 +0200
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
Message-ID: <20190926074749.sltehhkcgfduu7n2@steredhat.homenet.telecomitalia.it>
References: <1569460241-57800-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569460241-57800-1-git-send-email-decui@microsoft.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Dexuan,

On Thu, Sep 26, 2019 at 01:11:27AM +0000, Dexuan Cui wrote:
> Lockdep is unhappy if two locks from the same class are held.
> 
> Fix the below warning for hyperv and virtio sockets (vmci socket code
> doesn't have the issue) by using lock_sock_nested() when __vsock_release()
> is called recursively:
> 
> ============================================
> WARNING: possible recursive locking detected
> 5.3.0+ #1 Not tainted
> --------------------------------------------
> server/1795 is trying to acquire lock:
> ffff8880c5158990 (sk_lock-AF_VSOCK){+.+.}, at: hvs_release+0x10/0x120 [hv_sock]
> 
> but task is already holding lock:
> ffff8880c5158150 (sk_lock-AF_VSOCK){+.+.}, at: __vsock_release+0x2e/0xf0 [vsock]
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(sk_lock-AF_VSOCK);
>   lock(sk_lock-AF_VSOCK);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 2 locks held by server/1795:
>  #0: ffff8880c5d05ff8 (&sb->s_type->i_mutex_key#10){+.+.}, at: __sock_release+0x2d/0xa0
>  #1: ffff8880c5158150 (sk_lock-AF_VSOCK){+.+.}, at: __vsock_release+0x2e/0xf0 [vsock]
> 
> stack backtrace:
> CPU: 5 PID: 1795 Comm: server Not tainted 5.3.0+ #1
> Call Trace:
>  dump_stack+0x67/0x90
>  __lock_acquire.cold.67+0xd2/0x20b
>  lock_acquire+0xb5/0x1c0
>  lock_sock_nested+0x6d/0x90
>  hvs_release+0x10/0x120 [hv_sock]
>  __vsock_release+0x24/0xf0 [vsock]
>  __vsock_release+0xa0/0xf0 [vsock]
>  vsock_release+0x12/0x30 [vsock]
>  __sock_release+0x37/0xa0
>  sock_close+0x14/0x20
>  __fput+0xc1/0x250
>  task_work_run+0x98/0xc0
>  do_exit+0x344/0xc60
>  do_group_exit+0x47/0xb0
>  get_signal+0x15c/0xc50
>  do_signal+0x30/0x720
>  exit_to_usermode_loop+0x50/0xa0
>  do_syscall_64+0x24e/0x270
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x7f4184e85f31
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> NOTE: I only tested the code on Hyper-V. I can not test the code for
> virtio socket, as I don't have a KVM host. :-( Sorry.
> 
> @Stefan, @Stefano: please review & test the patch for virtio socket,
> and let me know if the patch breaks anything. Thanks!

Comment below, I'll test it ASAP!

> 
> Changes in v2:
>   Avoid the duplication of code in v1: https://lkml.org/lkml/2019/8/19/1361
>   Also fix virtio socket code.
> 
>  net/vmw_vsock/af_vsock.c                | 19 +++++++++++++++----
>  net/vmw_vsock/hyperv_transport.c        |  2 +-
>  net/vmw_vsock/virtio_transport_common.c |  2 +-
>  3 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index ab47bf3ab66e..dbae4373cbab 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -638,8 +638,10 @@ struct sock *__vsock_create(struct net *net,
>  }
>  EXPORT_SYMBOL_GPL(__vsock_create);
>  
> -static void __vsock_release(struct sock *sk)
> +static void __vsock_release(struct sock *sk, int level)
>  {
> +	WARN_ON(level != 1 && level != 2);
> +
>  	if (sk) {
>  		struct sk_buff *skb;
>  		struct sock *pending;
> @@ -648,9 +650,18 @@ static void __vsock_release(struct sock *sk)
>  		vsk = vsock_sk(sk);
>  		pending = NULL;	/* Compiler warning. */
>  
> +		/* The release call is supposed to use lock_sock_nested()
> +		 * rather than lock_sock(), if a sock lock should be acquired.
> +		 */
>  		transport->release(vsk);
>  
> -		lock_sock(sk);
> +		/* When "level" is 2, use the nested version to avoid the
> +		 * warning "possible recursive locking detected".
> +		 */
> +		if (level == 1)
> +			lock_sock(sk);

Since lock_sock() calls lock_sock_nested(sk, 0), could we use directly
lock_sock_nested(sk, level) with level = 0 in vsock_release() and
level = SINGLE_DEPTH_NESTING here in the while loop?

> +		else
> +			lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
>  		sock_orphan(sk);
>  		sk->sk_shutdown = SHUTDOWN_MASK;
>  
> @@ -659,7 +670,7 @@ static void __vsock_release(struct sock *sk)
>  
>  		/* Clean up any sockets that never were accepted. */
>  		while ((pending = vsock_dequeue_accept(sk)) != NULL) {
> -			__vsock_release(pending);
> +			__vsock_release(pending, 2);
>  			sock_put(pending);
>  		}
>  
> @@ -708,7 +719,7 @@ EXPORT_SYMBOL_GPL(vsock_stream_has_space);
>  
>  static int vsock_release(struct socket *sock)
>  {
> -	__vsock_release(sock->sk);
> +	__vsock_release(sock->sk, 1);
>  	sock->sk = NULL;
>  	sock->state = SS_FREE;
>  
> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> index 261521d286d6..c443db7af8d4 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -559,7 +559,7 @@ static void hvs_release(struct vsock_sock *vsk)
>  	struct sock *sk = sk_vsock(vsk);
>  	bool remove_sock;
>  
> -	lock_sock(sk);
> +	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
>  	remove_sock = hvs_close_lock_held(vsk);
>  	release_sock(sk);
>  	if (remove_sock)
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 5bb70c692b1e..a666ef8fc54e 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -820,7 +820,7 @@ void virtio_transport_release(struct vsock_sock *vsk)
>  	struct sock *sk = &vsk->sk;
>  	bool remove_sock = true;
>  
> -	lock_sock(sk);
> +	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
>  	if (sk->sk_type == SOCK_STREAM)
>  		remove_sock = virtio_transport_close(vsk);
>  

Thanks,
Stefano
