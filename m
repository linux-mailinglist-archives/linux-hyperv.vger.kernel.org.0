Return-Path: <linux-hyperv+bounces-7809-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5F9C8218E
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Nov 2025 19:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83FD134A0A0
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Nov 2025 18:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1C2319614;
	Mon, 24 Nov 2025 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYs2SJEg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081913176E4
	for <linux-hyperv@vger.kernel.org>; Mon, 24 Nov 2025 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008761; cv=none; b=JHjxs6v79eTYmcnFwIrXNswAEBUm43bVL51C62xatTXF87eUBJETrsKqNAoOrUyu2/7ZXiIzsR+yE7btYjrPPZgfsZ6FmAe8llh1Iet8gVG6a6LOK0FPlQ4QSATUnlAJcMc8+lFvpAinXmKVUqOucr2GIGqCZrMA1MJnctOeyqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008761; c=relaxed/simple;
	bh=6AZSCjx0be8QNYc1b9ABiliBH6YVQDDfi0R5FIkWxp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFULZDogi+9gZr78UF+JcxKt3gRG6GcO6ytvkieJXU5n6vz07FpVpYqtmfI/SGsZaqFRGOlfDnuNPmYfkLxIF42+aq/qlIOKm5+rfMv7I1OOqtgOVivMxiFlsjwRvscz0pegOdv47Utcl9EBLORVI2+zFigiEAxVzqfhUVp+9sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYs2SJEg; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7895017c722so43377587b3.2
        for <linux-hyperv@vger.kernel.org>; Mon, 24 Nov 2025 10:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764008758; x=1764613558; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TEB0IVYhYkoeWOmDLi9JAiu4Bvgo6alBDSG0PHHn3mY=;
        b=aYs2SJEgbdLftah9Q6DJVJMu6BeScc9QWlcEvA6WBeSJbZt72ixRMCvqjg49a4U6HS
         po3S4QhcWgXgsItovmDpnS4GN+d8mVirwSlG8YGNP0vaFVWkyxdzsd2fTFjxj/6PwO2x
         PgNvChWqHkDfKQJShotCcbqiWH9aVU/fKVjIYxVGGkEy9GhWqxJgcxt+hKxir0Cj+6fV
         tNmCFMofRG1t1gexRmZtrp1xBZT/uHTzxRphTvnZpTzBa8fqtKaNbuBI+nx+yW5ywjVi
         hk/TEX7d50YeaiRxicbV8xT4sh4zK/bvsPEf/ZUCJKF/AAKx4glQmOPC8JVvsGihApKw
         Ei2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764008758; x=1764613558;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEB0IVYhYkoeWOmDLi9JAiu4Bvgo6alBDSG0PHHn3mY=;
        b=MB3ciWWYVDQxqB1DxkZWul8gAd+DiXNhnW8v8OMITWk5oTu6zmY2AUxs26F7UnFisb
         Dsof6l0qVkeEHWrrthJaTCEMwfSCj/ygtsn/qjeI1uWRKzr9hLJSHdjKkO/Ke07AWvW+
         Ly31Via3Gdzf7ykP76gJ1OdzXO7D+ciKev+FDjntCRCHUPTzcJ4IVRweE1Hvj+0N0nfR
         UyZkxPLgtA1uQvhsvmxr203IC95mtXjoe2hxfud7qxhesDLX0QkZ19A2n9TIiE2LtL0U
         7x6rPRI/W8K1R0VJtjjFaMXwQtdPZ5NtfAnsG3OzSsvv1oDsdfjjngfrr3Bd7Z77rb77
         l2/A==
X-Forwarded-Encrypted: i=1; AJvYcCVDDbe5wPYxOOvM++F9Uqparbofj8jZ1w7jaeFcszrP2GRlhV7HonV08daB4GBSTlE0R9KMrY0hdbgdfag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoGot6gvLey59p8u5pCWqnUP4PC0PaEqh8b9F53Zm4XGYx5pJi
	sQA1o7ceKDgpMr4DwbDy0lBvhrBdsB8atF2SQ8uJ+7T37gVaZzZEAgIc
X-Gm-Gg: ASbGncv6eV+BOMUDGcAmDGxF31VUxpLvbEXMUyPhjNDZV58Xf5keJZ0lT2sARd8Yhs+
	yHQTLM0oMaafU2XlqaPXNC7+OsRa44hM7t8M/i8W801ZUunDzrYvmyDTJNdvp3tGwThMbt1adme
	xAEJ0PYi8HMiZ7cCXRYbk3MAcWmrc2SUssdb78NnYcQl1HjV6XrGagZDUp7LF25dG5EbsLJ1i6p
	F+Gl0sIKpoKLKdfmxyK4VOuK2R+nWIm1ktmtXMm2u7imN5SWdGP6hVtgUvh0o352dTMHzKLt2Sq
	WrS6kBh2SA7VQnfBmXjdeqBZOPdBcB5Swc72GFuqiMiIO6exq5/B5tChmMw3cT42LLs1iafcht+
	W443zbITIgaNvDDLC8GYdHF7fFEIh+OoSrQ/4wNdN76oW+dArJKB2Tt7xEsSumgeyBq4crNUmhP
	TgF56EUHBaOp/6FozouGh4HHoDk6PkVPYZp87tP7/9YSh6jg==
X-Google-Smtp-Source: AGHT+IE0ZjSbPsIZXUiMdmSARGNpUZsggdBivDiPOdxixaSe4XdXku94FoT+/xG3xq+0F2N/k+75ZA==
X-Received: by 2002:a05:690c:6c0a:b0:787:eca1:50cf with SMTP id 00721157ae682-78a8b55dafemr91578177b3.50.1764008757922;
        Mon, 24 Nov 2025 10:25:57 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a8106sm46963977b3.19.2025.11.24.10.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:25:57 -0800 (PST)
Date: Mon, 24 Nov 2025 10:25:56 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org, berrange@redhat.com,
	Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v11 03/13] vsock: reject bad
 VSOCK_NET_MODE_LOCAL configuration for G2H
Message-ID: <aSSjNLrRmaOLkuBN@devvm11784.nha0.facebook.com>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-3-55cbc80249a7@meta.com>
 <swa5xpovczqucynffqgfotyx34lziccwpqomnm5a7iwmeyixfv@uehtzbdj53b4>
 <aSC3IX81A3UhtD3N@devvm11784.nha0.facebook.com>
 <g4xir3lupnjybh7fqig6xonp32ubotdf3emmrozdm52tpaxvxn@2t4ueynb7hqr>
 <aSSV4RlRcW+uGy+n@devvm11784.nha0.facebook.com>
 <qvu2mgxs7scbuwcb2ui7eh3qe3l7mlcjq6e2favd4aqcs52r2r@oqbrlp4gxdwl>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qvu2mgxs7scbuwcb2ui7eh3qe3l7mlcjq6e2favd4aqcs52r2r@oqbrlp4gxdwl>

On Mon, Nov 24, 2025 at 06:54:45PM +0100, Stefano Garzarella wrote:
> On Mon, Nov 24, 2025 at 09:29:05AM -0800, Bobby Eshleman wrote:
> > On Mon, Nov 24, 2025 at 11:10:19AM +0100, Stefano Garzarella wrote:
> > > On Fri, Nov 21, 2025 at 11:01:53AM -0800, Bobby Eshleman wrote:
> > > > On Fri, Nov 21, 2025 at 03:24:25PM +0100, Stefano Garzarella wrote:
> > > > > On Thu, Nov 20, 2025 at 09:44:35PM -0800, Bobby Eshleman wrote:
> 
> [...]
> 
> > > >
> > > > > Since I guess we need another version of this patch, can you check the
> > > > > commit description to see if it reflects what we are doing now
> > > > > (e.g vhost is not enabled)?
> > > > >
> > > > > Also I don't understand why for vhost we will enable it later, but for
> > > > > virtio_transport and vsock_loopback we are enabling it now, also if this
> > > > > patch is before the support on that transports. I'm a bit confused.
> > > > >
> > > > > If something is unclear, let's discuss it before sending a new version.
> > > > >
> > > > >
> > > > > What I had in mind was, add this patch and explain why we need this new
> > > > > callback (like you did), but enable the support in the patches that
> > > > > really enable it for any transport. But maybe what is not clear to me is
> > > > > that we need this only for G2H. But now I'm confused about the discussion
> > > > > around vmci H2G. We decided to discard also that one, but here we are not
> > > > > checking that?
> > > > > I mean here we are calling supports_local_mode() only on G2H IIUC.
> > > >
> > > > Ah right, VMCI broke my original mental model of only needing this check
> > > > for G2H (originally I didn't realize VMCI was H2G too).
> > > >
> > > > I think now, we actually need to do this check for all of the transports
> > > > no? Including h2g, g2h, local, and dgram?
> > > >
> > > > Additionally, the commit description needs to be updated to reflect that.
> > > 
> > > Let's take a step back, though, because I tried to understand the problem
> > > better and I'm confused.
> > > 
> > > For example, in vmci (G2H side), when a packet arrives, we always use
> > > vsock_find_connected_socket(), which only searches in GLOBAL. So connections
> > > originating from the host can only reach global sockets in the guest. In
> > > this direction (host -> guest), we should be fine, right?
> > > 
> > > Now let's consider the other direction, from guest to host, so the
> > > connection should be generated via vsock_connect().
> > > Here I see that we are not doing anything with regard to the source
> > > namespace. At this point, my question is whether we should modify
> > > vsock_assign_transport() or transport->stream_allow() to do this for each
> > > stream, and not prevent loading a G2H module a priori.
> > > 
> > > For example, stream_allow() could check that the socket namespace is
> > > supported by the assigned transport. E.g., vmci can check that if the
> > > namespace mode is not GLOBAL, then it returns false. (Same thing in
> > > virtio-vsock, I mean the G2H driver).
> > > 
> > > This should solve the guest -> host direction, but at this point I wonder if
> > > I'm missing something.
> > 
> > For the G2H connect case that is true, but the situation gets a little
> > fuzzier on the G2H RX side w/ VMADDR_CID_ANY listeners.
> > 
> > Let's say we have a nested system w/ both virtio-vsock and vhost-vsock.
> > We have a listener in namespace local on VMADDR_CID_ANY. So far, no
> > transport is assigned, so we can't call t->stream_allow() yet.
> > virtio-vsock only knows of global mode, so its lookup will fail (unless
> 
> What is the problem of failing in this case?
> I mean, we are documenting that G2H will not be able to reach socket in
> namespaces with "local" mode. Old (and default) behaviour is still allowing
> them, right?
> 
> I don't think it conflicts with the definition of “local” either, because
> these connections are coming from outside, and the user doesn't expect to be
> able to receive them in a “local” namespace, unless there is a way to put
> the device in the namespace (as with net). But this method doesn't exist
> yet, and by documenting it sufficiently, we can say that it will be
> supported in the future, but not for now.
> 
> > we hack in some special case to virtio_transport_recv_pkt() to scan
> > local namespaces). vhost-vsock will work as expected. Letting local mode
> > sockets be silently unreachable by virtio-vsock seems potentially
> > confusing for users. If the system were not nested, we can pre-resolve
> > VMADDR_CID_ANY in bind() and handle things upfront as well. Rejecting
> > local mode outright is just a broad guardrail.
> 
> Okay, but in that case, we are not supporting “local” mode too, but we are
> also preventing “global” from being used on these when we are in a nested
> environment. What is the advantage of this approach?
> 
> > 
> > If we're trying to find a less heavy-handed option, we might be able to
> > do the following:
> > 
> > - change bind(cid) w/ cid != VMADDR_CID_ANY to directly assign the
> > transport
> >  for all socket types (not just SOCK_DGRAM)
> 
> That would be nice, but it wouldn't solve the problem with VMADDR_CID_ANY,
> which I guess is the use case in 99% of cases.
> 
> > 
> > - vsock_assign_transport() can outright fail if !t->supports_local_mode()
> >  and sock_net(sk) has mode local
> 
> But in this case, why not reusing stream_allow() ?
> 
> > 
> > - bind(VMADDR_CID_ANY) can maybe print (once) to dmesg a warning that
> >  only the H2G transport will land on VMADDR_CID_ANY sockets.
> 
> mmm, I'm not sure about that, we should ask net maintainer, but IMO
> documenting that in af_vsock.c and man pages should be fine, till G2H will
> support that.
> 
> > 
> > I'm certainly open to other suggestions.
> 
> IMO we should avoid the failure when loading G2H, which is more confusing
> than just discard connection from the host to a "local" namespace. We should
> try at least to support the "global" namespace.
> 
> Thanks,
> Stefano


I'm 100% fine with that approach. I just wanted to make sure we landed
in the right place for how users may encounter places that there is no
local mode support.

So for next steps, we can drop this patch and add explicit logic in
->stream_allow() to allow local mode for vhost/loopback and reject for
others? Plus, add documentation about what happens for VMADDR_CID_ANY
(will only receive vhost/loopback traffic in local mode)?

Best,
Bobby

