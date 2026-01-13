Return-Path: <linux-hyperv+bounces-8238-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9785CD1615B
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 01:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38C543014AE3
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 00:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65F123817F;
	Tue, 13 Jan 2026 00:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9eszdTu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD4F222560
	for <linux-hyperv@vger.kernel.org>; Tue, 13 Jan 2026 00:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768265556; cv=none; b=m5za42kYGzxG5FnJeT2O/YEOW71P+memm+ZvPrVkUO97WZ6sobac5wbkuXy/TzRQfC3418xc+wHZFk+w6sbR8GwEl9zkG+mMbvNxP6ywwJV5gd7Gu0jnvpjqClFasNI+cpv+BSwgKRsciaaqrgbOIhy31rqWwXol1BigCEud6tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768265556; c=relaxed/simple;
	bh=8Vraf+SBhLrmdt2HV0wDbrQyiKEkmpXLCy5Y9glMNTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efVu0pcu/yZCb4nZ7w/v33noMjeaNGBF6duX1jTPwpENaNhhlqn+RxRMUKfAmWpXqEpsxIp4xkIfyM/FYRRRHRH56pGpNVdQLlPiwJPuOBY2TlEpX0UZfW7CSSqGNocxBmChIZVvw/8zQGPmT8Gq5V5xXk5K5aX6zQKD4o0RT3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9eszdTu; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-640e065991dso6396066d50.3
        for <linux-hyperv@vger.kernel.org>; Mon, 12 Jan 2026 16:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768265554; x=1768870354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2NF4AyKrauIjTRva3WFey87OryHOgZb6vovp7zFMW8c=;
        b=V9eszdTuH3osVdklP4dNlFpJPv2lwVTU5MPTYgRziA77Vo1Dj9VXF8t+q2nAh/PuMk
         6qL6tk/fozLXWqD29QxP+9pS6tXhQpBHO2yGmLXZmtlfENfWs7LHxvXLtJq1fbOIC8Dc
         3Gt4LyuuaGeR7x0Q7kuD3MCBGpIkxe2OwRzNIjo/+kI39YA4+zbZPp958BQx5Rl2w1Th
         wcMse2kQ0NF7LKwml8/lUbNhPzP58Szn7kk98A+rj8dOPiWVIPOgqLAvvDPE/K7FdUZ8
         ZFvjARvjBhj7d0BQvcm8ay/T0Yimdxtvtea/49f5E4rJGVysB2w8EhjsPdNthBJNQNYb
         iQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768265554; x=1768870354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NF4AyKrauIjTRva3WFey87OryHOgZb6vovp7zFMW8c=;
        b=t7Kfw25x3waRfer8AFQK1Ev+fQ75EhjYQTtZ8xecEFfADKGHADtN8IkTCDC3fVpujS
         VPKnJaYVteqz4eJRQUPRPNqFlkgEdO0vc5YGfmItho9wbWJfjDCmDwHGfdNvNBNCowM6
         ATkg6+O3saP5wK2b5ULQ0Lw1YDc2G1Ucj/VrzhTZDJJ1HVSuXR7XAPFE4O2tOcYubzgW
         iVlDsFSa7siOQPAfovhH/ugOKQmEsXpep9hk1qQIwoJrE+4BgDGg5gIixooy74XZHHK9
         Nn2XXd0IJi1P9KpBqwTN39wuCk5rkxpnS0bLEGt7Xp9aX3BUF9WP4ddqDCL6Gj4CQYul
         k/TA==
X-Forwarded-Encrypted: i=1; AJvYcCW24jucA3EmJ/5bWUmiuhsIOuWVko/Jex7Ut4P1DJkXhA7vimfa/toj5qKxPx6sZO0dKwSG1EqbprVYfmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJVnV2Ltqgp3CpWIj8Av8blFq/cyqcPt53stEOTg0ikOGlSqL2
	ktFEhAc3PRTK6JRDdKem4cl+7P6UYUOAyDu8rsQxBwl2wWpxUwfAxD1t
X-Gm-Gg: AY/fxX5LA1Pd2jwDP7NNcM59Mkjk1DfBedKV3BFpPx6LcJa19C+Z8l6QScW+6z6MtYQ
	9/iisgy59u9xWGQU7eDhaMNwy/rLGJ2u/mWlbxGq4fL6uR5qrOQG9ErQL8qSTleHOZg1jEpzoMY
	aHy87nOtSKWu1T6MltmSIinRUG+ljZZTlIcy7CFREakPb9DSfuhLAo7N049yBoGqAXG9Lr4B23w
	B2pjPSWvSBMgmjgeyHUZCEQxBvG2UNSNFNAYCAJB1NYvxi8nJiWuoL6v7NEjfe3mEstc84gQGOO
	Oc2/5bjyWfVtxOuiud1hXd2murJsNFJyz7xD+CcuwuDlcvLdZh0IfUx0zHC/8KRwfx2RrTfRhMZ
	oxVOnOkoVKyAhuJut8jRv01y52NjRjRWcgH/UemlgsDT2pBdoXoxjfPFLtWImwlOyTanoMnrXEa
	P1VVYw3TSqwBclIzQLLj3SMAEysHe8WwFHNCg=
X-Google-Smtp-Source: AGHT+IEEozBmQjMmBVEF6xh5ga3T6IlFOqAC0ZcZVHFGL77MYegZXmo8YOv/wpih8sNdKD89yTfvfQ==
X-Received: by 2002:a05:690e:1449:b0:646:6f6f:65e with SMTP id 956f58d0204a3-64716b0011cmr15860280d50.24.1768265553980;
        Mon, 12 Jan 2026 16:52:33 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:44::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8b2623sm8674363d50.20.2026.01.12.16.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 16:52:33 -0800 (PST)
Date: Mon, 12 Jan 2026 16:52:31 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 02/13] vsock: add netns to vsock core
Message-ID: <aWWXTx6SSNiV3a+v@devvm11784.nha0.facebook.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <20251223-vsock-vmtest-v13-2-9d6db8e7c80b@meta.com>
 <20260111013536-mutt-send-email-mst@kernel.org>
 <aWWFB2K5H5OXGWP8@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWWFB2K5H5OXGWP8@devvm11784.nha0.facebook.com>

On Mon, Jan 12, 2026 at 03:34:31PM -0800, Bobby Eshleman wrote:
> On Sun, Jan 11, 2026 at 01:43:37AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Dec 23, 2025 at 04:28:36PM -0800, Bobby Eshleman wrote:
> > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > 
> > > Add netns logic to vsock core. Additionally, modify transport hook
> > > prototypes to be used by later transport-specific patches (e.g.,
> > > *_seqpacket_allow()).
> > > 
> > > Namespaces are supported primarily by changing socket lookup functions
> > > (e.g., vsock_find_connected_socket()) to take into account the socket
> > > namespace and the namespace mode before considering a candidate socket a
> > > "match".
> > > 
> > > This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode to
> > > report the mode and /proc/sys/net/vsock/child_ns_mode to set the mode
> > > for new namespaces.
> > > 
> > > Add netns functionality (initialization, passing to transports, procfs,
> > > etc...) to the af_vsock socket layer. Later patches that add netns
> > > support to transports depend on this patch.
> > > 
> > > dgram_allow(), stream_allow(), and seqpacket_allow() callbacks are
> > > modified to take a vsk in order to perform logic on namespace modes. In
> > > future patches, the net will also be used for socket
> > > lookups in these functions.
> > > 
> > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > ...
> > 
> > 
> > >  static int __vsock_bind_connectible(struct vsock_sock *vsk,
> > >  				    struct sockaddr_vm *addr)
> > >  {
> > > +	struct net *net = sock_net(sk_vsock(vsk));
> > >  	static u32 port;
> > >  	struct sockaddr_vm new_addr;
> > >
> > 
> > 
> > Hmm this static port gives me pause. So some port number info leaks
> > between namespaces. I am not saying it's a big security issue
> > and yet ... people expect isolation.
> 
> Probably the easiest solution is making it per-ns, my quick rough draft
> looks like this:
> 
> diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
> index e2325e2d6ec5..b34d69a22fa8 100644
> --- a/include/net/netns/vsock.h
> +++ b/include/net/netns/vsock.h
> @@ -11,6 +11,10 @@ enum vsock_net_mode {
>  
>  struct netns_vsock {
>  	struct ctl_table_header *sysctl_hdr;
> +
> +	/* protected by the vsock_table_lock in af_vsock.c */
> +	u32 port;
> +
>  	enum vsock_net_mode mode;
>  	enum vsock_net_mode child_ns_mode;
>  };
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 9d614e4a4fa5..cd2a47140134 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -748,11 +748,10 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>  				    struct sockaddr_vm *addr)
>  {
>  	struct net *net = sock_net(sk_vsock(vsk));
> -	static u32 port;
>  	struct sockaddr_vm new_addr;
>  
> -	if (!port)
> -		port = get_random_u32_above(LAST_RESERVED_PORT);
> +	if (!net->vsock.port)
> +		net->vsock.port = get_random_u32_above(LAST_RESERVED_PORT);
>  
>  	vsock_addr_init(&new_addr, addr->svm_cid, addr->svm_port);
>  
> @@ -761,11 +760,11 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>  		unsigned int i;
>  
>  		for (i = 0; i < MAX_PORT_RETRIES; i++) {
> -			if (port == VMADDR_PORT_ANY ||
> -			    port <= LAST_RESERVED_PORT)
> -				port = LAST_RESERVED_PORT + 1;
> +			if (net->vsock.port == VMADDR_PORT_ANY ||
> +			    net->vsock.port <= LAST_RESERVED_PORT)
> +				net->vsock.port = LAST_RESERVED_PORT + 1;
>  
> -			new_addr.svm_port = port++;
> +			new_addr.svm_port = net->vsock.port++;
>  
>  			if (!__vsock_find_bound_socket_net(&new_addr, net)) {
>  				found = true;
> 
> 
> 

Another option being to follow inet's path and use
siphash_4u32() the way that secure_ipv4_port_ephemeral() does...

