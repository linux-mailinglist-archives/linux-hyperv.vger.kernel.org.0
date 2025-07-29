Return-Path: <linux-hyperv+bounces-6434-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D7DB14DC8
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 14:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FDBE174683
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 12:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7746C291C00;
	Tue, 29 Jul 2025 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXzWKvF6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7459428EA70
	for <linux-hyperv@vger.kernel.org>; Tue, 29 Jul 2025 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753792861; cv=none; b=mNSfm4tKixt9FbmhwfsOZLTpR/uaJcHFrD6UpyLm8I4iZCog2KYp5FRt3Ojy7IogAH+zPPkfHC16fCb6HYuz+mH4k8Cjxz5ZeFht3S1lfDw8Mf0SnJrlnGEQh2DWQD8SPmKTwPCdoeSa9QVDXEk2wrcc+IV796h5TA7LMi828ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753792861; c=relaxed/simple;
	bh=UZDGhd/+rLzayX5aZ+vg8gEPGLMCsevSY+i2MYFbMCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzfzPyhwS9UgrIgNFt9UWkN+q997pAfdQ34qNvaq78sGq3m1ZB+hY8ZTRAQOpSwuZIiV1F7VFrZw94jd/5MsZ6zsf+/6QDry1p2LD/RtVIooBORyDdZ+jcwP77o5kKExxn95xB1VPAg2aDSxIAgSkv7Fm7Ii0AbHTtbKUzE9G6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MXzWKvF6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753792858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZV5EUUEtu0wYoF6c14HgKdxGyYYQj0FRgNzMPWXQSQ8=;
	b=MXzWKvF6KE6l6WFxC8CEMS9sVhfmkCKYpj9eElvAnnyZU2k7NpJLxLcbxY5uX+AdRLxoiF
	5o7W0fR3NVGxS2mINiLClAwFj21XhlM1L1y/ATn9qxUXtxJmvIGPQwKOyeWymrGW5jM2QT
	8WRHImFOpDxzGJPRU4MooWLf1+lw92M=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-PxHv4ZSGMQWCvl57yZdSug-1; Tue, 29 Jul 2025 08:40:57 -0400
X-MC-Unique: PxHv4ZSGMQWCvl57yZdSug-1
X-Mimecast-MFC-AGG-ID: PxHv4ZSGMQWCvl57yZdSug_1753792856
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-711136ed77fso73951777b3.0
        for <linux-hyperv@vger.kernel.org>; Tue, 29 Jul 2025 05:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753792856; x=1754397656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZV5EUUEtu0wYoF6c14HgKdxGyYYQj0FRgNzMPWXQSQ8=;
        b=YjAZt0rxGMvs3eD7m3hYtEHuX54DlDvJCoNXsqbZlteiXxWQGhmKQdZQDWTJIlc0aa
         QDNI3jX2fVgPQEz1ysFH+qMJnSSpyuSfVpT0OyNFO9nf/2ZTh5cnGsGgX8njLf+ALWPG
         RddAQltzg58QyLVIQ72VlxltXQfEnM70QIsjR1WGW92d7sdFfaGqwzSc4PLpdn02XWDf
         c4dN5BV9mPxOWWy/XKde7AZvOpoCuTO8J7kjqYO+06eYhEjE9WblrE+Xn0B+4J0/tZJk
         JU6/GPJE6DHBLnfTqK743swm6L+kZ7tdd7U1ACHzqzHAYNo/oNBEcZVp/n2m9E9rfsUY
         9PCg==
X-Forwarded-Encrypted: i=1; AJvYcCUa2h4xWwcVmBLAVlaLG1QaBZXXZ+oyakReJX1no5i3BxTOGBuHms8tBwPPzTm4Lk3j08JSPV07uOmr++k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv/yCF2iA+Yg9hVrXEN/rXeEN5MWQ0POwrmu0AFPOR/TK3JNRT
	vvjwqxeJujC6JwscL2TQ9xmLkKNpaaycRD07gvic2rLzkTk5AqDsFvDPlnVY+wkPz8seMc6LNpM
	sAt8pALlnlXpeKCKqm+LPEWORQWCxuJ+iv2KKzBnvG45uRz3KmNLiCW+00R1/9AzWh6YI0Mqzq6
	/ap1RadIn5I1dESnLagFDtczWMj2rxn6saTsmvnM00
X-Gm-Gg: ASbGncsPh+3en6y8pQ4iqDGeH4Qn1tDaWafcCk47avNlzSH+mpfSuO7adzli3js+XCt
	6DppLC14WvUFIpWGih65EsOnQmBmQKhCnqkalL5Chg0eJru+BcGLPQNrVNTLpJMhETScyibfnBO
	x18nLvA1MHEyvZHGP2iWF+
X-Received: by 2002:a05:690c:4b0a:b0:71a:41be:133 with SMTP id 00721157ae682-71a41be022dmr9012867b3.14.1753792856402;
        Tue, 29 Jul 2025 05:40:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExzXD78VZ4NrcWcboXVLgFWfObrbN+8Z2f+u0nM+qzWO61wtyD3iImlO5JbXTPxUvCLloIIb5LOzY9XjoHDwo=
X-Received: by 2002:a05:690c:4b0a:b0:71a:41be:133 with SMTP id
 00721157ae682-71a41be022dmr9012387b3.14.1753792855972; Tue, 29 Jul 2025
 05:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
 <dsamf7k2byoflztkwya3smj7jyczyq7aludvd36lufdrboxdqk@u73iwrcyb5am> <CAMB2axNKxW4gnd6qiSNYdm2zPxJkbbLgZz9P-Kh7SS0Sb1Yw=Q@mail.gmail.com>
In-Reply-To: <CAMB2axNKxW4gnd6qiSNYdm2zPxJkbbLgZz9P-Kh7SS0Sb1Yw=Q@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 29 Jul 2025 14:40:44 +0200
X-Gm-Features: Ac12FXx0AfUlrxkGal_IZT1J3PL02_FYYzLBRvPuEGsCQYHWQt-envTrILmUXG4
Message-ID: <CAGxU2F6aObcrixKnbp2PthJDpeQyhzVXwXtfkkQm-8Ni4xenTg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 00/14] virtio/vsock: support datagrams
To: Amery Hung <ameryhung@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>, 
	Tyler Fanelli <tfanelli@redhat.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, bryantan@vmware.com, 
	vdasa@vmware.com, pv-drivers@vmware.com, dan.carpenter@linaro.org, 
	simon.horman@corigine.com, oxffffaa@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	bpf@vger.kernel.org, bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, 
	amery.hung@bytedance.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amery,

On Sat, 26 Jul 2025 at 07:53, Amery Hung <ameryhung@gmail.com> wrote:
>
> On Tue, Jul 22, 2025 at 7:35=E2=80=AFAM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >
> > Hi Amery,
> >
> > On Wed, Jul 10, 2024 at 09:25:41PM +0000, Amery Hung wrote:
> > >Hey all!
> > >
> > >This series introduces support for datagrams to virtio/vsock.
> >
> > any update on v7 of this series?
> >
>
> Hi Stefano,
>
> Sorry that I don't have personal time to work on v7. Since I don't
> think people involved in this set are still working on it, I am
> posting my v7 WIP here to see if anyone is interested in finishing it.
> Would greatly appreciate any help.
>
> Link: https://github.com/ameryhung/linux/tree/vsock-dgram-v7
>
> Here are the things that I haven't address in the WIP:
>
> 01/14
> - Arseniy suggested doing skb_put(dg->payload_size) and memcpy(dg->payloa=
d_size)
>
> 07/14
> - Remove the double transport lookup in the send path by passing
> transport to dgram_enqueue
> - Address Arseniy's comment about updating vsock_virtio_transport_common.=
h
>
> 14/14
> - Split test/vsock into smaller patches
>
> Finally the spec change discussion also needs to happen.

Thanks for the update!
I CCed Sergio and Tyler that may be interested on completing this for
libkrun use case.

Thanks,
Stefano

>
>
>
> > Thanks,
> > Stefano
> >
> > >
> > >It is a spin-off (and smaller version) of this series from the summer:
> > >  https://lore.kernel.org/all/cover.1660362668.git.bobby.eshleman@byte=
dance.com/
> > >
> > >Please note that this is an RFC and should not be merged until
> > >associated changes are made to the virtio specification, which will
> > >follow after discussion from this series.
> > >
> > >Another aside, the v4 of the series has only been mildly tested with a
> > >run of tools/testing/vsock/vsock_test. Some code likely needs cleaning
> > >up, but I'm hoping to get some of the design choices agreed upon befor=
e
> > >spending too much time making it pretty.
> > >
> > >This series first supports datagrams in a basic form for virtio, and
> > >then optimizes the sendpath for all datagram transports.
> > >
> > >The result is a very fast datagram communication protocol that
> > >outperforms even UDP on multi-queue virtio-net w/ vhost on a variety
> > >of multi-threaded workload samples.
> > >
> > >For those that are curious, some summary data comparing UDP and VSOCK
> > >DGRAM (N=3D5):
> > >
> > >       vCPUS: 16
> > >       virtio-net queues: 16
> > >       payload size: 4KB
> > >       Setup: bare metal + vm (non-nested)
> > >
> > >       UDP: 287.59 MB/s
> > >       VSOCK DGRAM: 509.2 MB/s
> > >
> > >Some notes about the implementation...
> > >
> > >This datagram implementation forces datagrams to self-throttle accordi=
ng
> > >to the threshold set by sk_sndbuf. It behaves similar to the credits
> > >used by streams in its effect on throughput and memory consumption, bu=
t
> > >it is not influenced by the receiving socket as credits are.
> > >
> > >The device drops packets silently.
> > >
> > >As discussed previously, this series introduces datagrams and defers
> > >fairness to future work. See discussion in v2 for more context around
> > >datagrams, fairness, and this implementation.
> > >
> > >Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> > >Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > >---
> > >Changes in v6:
> > >- allow empty transport in datagram vsock
> > >- add empty transport checks in various paths
> > >- transport layer now saves source cid and port to control buffer of s=
kb
> > >  to remove the dependency of transport in recvmsg()
> > >- fix virtio dgram_enqueue() by looking up the transport to be used wh=
en
> > >  using sendto(2)
> > >- fix skb memory leaks in two places
> > >- add dgram auto-bind test
> > >- Link to v5: https://lore.kernel.org/r/20230413-b4-vsock-dgram-v5-0-5=
81bd37fdb26@bytedance.com
> > >
> > >Changes in v5:
> > >- teach vhost to drop dgram when a datagram exceeds the receive buffer
> > >  - now uses MSG_ERRQUEUE and depends on Arseniy's zerocopy patch:
> > >       "vsock: read from socket's error queue"
> > >- replace multiple ->dgram_* callbacks with single ->dgram_addr_init()
> > >  callback
> > >- refactor virtio dgram skb allocator to reduce conflicts w/ zerocopy =
series
> > >- add _fallback/_FALLBACK suffix to dgram transport variables/macros
> > >- add WARN_ONCE() for table_size / VSOCK_HASH issue
> > >- add static to vsock_find_bound_socket_common
> > >- dedupe code in vsock_dgram_sendmsg() using module_got var
> > >- drop concurrent sendmsg() for dgram and defer to future series
> > >- Add more tests
> > >  - test EHOSTUNREACH in errqueue
> > >  - test stream + dgram address collision
> > >- improve clarity of dgram msg bounds test code
> > >- Link to v4: https://lore.kernel.org/r/20230413-b4-vsock-dgram-v4-0-0=
cebbb2ae899@bytedance.com
> > >
> > >Changes in v4:
> > >- style changes
> > >  - vsock: use sk_vsock(vsk) in vsock_dgram_recvmsg instead of
> > >    &sk->vsk
> > >  - vsock: fix xmas tree declaration
> > >  - vsock: fix spacing issues
> > >  - virtio/vsock: virtio_transport_recv_dgram returns void because err
> > >    unused
> > >- sparse analysis warnings/errors
> > >  - virtio/vsock: fix unitialized skerr on destroy
> > >  - virtio/vsock: fix uninitialized err var on goto out
> > >  - vsock: fix declarations that need static
> > >  - vsock: fix __rcu annotation order
> > >- bugs
> > >  - vsock: fix null ptr in remote_info code
> > >  - vsock/dgram: make transport_dgram a fallback instead of first
> > >    priority
> > >  - vsock: remove redundant rcu read lock acquire in getname()
> > >- tests
> > >  - add more tests (message bounds and more)
> > >  - add vsock_dgram_bind() helper
> > >  - add vsock_dgram_connect() helper
> > >
> > >Changes in v3:
> > >- Support multi-transport dgram, changing logic in connect/bind
> > >  to support VMCI case
> > >- Support per-pkt transport lookup for sendto() case
> > >- Fix dgram_allow() implementation
> > >- Fix dgram feature bit number (now it is 3)
> > >- Fix binding so dgram and connectible (cid,port) spaces are
> > >  non-overlapping
> > >- RCU protect transport ptr so connect() calls never leave
> > >  a lockless read of the transport and remote_addr are always
> > >  in sync
> > >- Link to v2: https://lore.kernel.org/r/20230413-b4-vsock-dgram-v2-0-0=
79cc7cee62e@bytedance.com
> > >
> > >
> > >Bobby Eshleman (14):
> > >  af_vsock: generalize vsock_dgram_recvmsg() to all transports
> > >  af_vsock: refactor transport lookup code
> > >  af_vsock: support multi-transport datagrams
> > >  af_vsock: generalize bind table functions
> > >  af_vsock: use a separate dgram bind table
> > >  virtio/vsock: add VIRTIO_VSOCK_TYPE_DGRAM
> > >  virtio/vsock: add common datagram send path
> > >  af_vsock: add vsock_find_bound_dgram_socket()
> > >  virtio/vsock: add common datagram recv path
> > >  virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
> > >  vhost/vsock: implement datagram support
> > >  vsock/loopback: implement datagram support
> > >  virtio/vsock: implement datagram support
> > >  test/vsock: add vsock dgram tests
> > >
> > > drivers/vhost/vsock.c                   |   62 +-
> > > include/linux/virtio_vsock.h            |    9 +-
> > > include/net/af_vsock.h                  |   24 +-
> > > include/uapi/linux/virtio_vsock.h       |    2 +
> > > net/vmw_vsock/af_vsock.c                |  343 ++++++--
> > > net/vmw_vsock/hyperv_transport.c        |   13 -
> > > net/vmw_vsock/virtio_transport.c        |   24 +-
> > > net/vmw_vsock/virtio_transport_common.c |  188 ++++-
> > > net/vmw_vsock/vmci_transport.c          |   61 +-
> > > net/vmw_vsock/vsock_loopback.c          |    9 +-
> > > tools/testing/vsock/util.c              |  177 +++-
> > > tools/testing/vsock/util.h              |   10 +
> > > tools/testing/vsock/vsock_test.c        | 1032 ++++++++++++++++++++--=
-
> > > 13 files changed, 1638 insertions(+), 316 deletions(-)
> > >
> > >--
> > >2.20.1
> > >
> >
>


