Return-Path: <linux-hyperv+bounces-4222-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38293A4F6AC
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 06:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA3016F98E
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 05:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46CA1B041E;
	Wed,  5 Mar 2025 05:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9Ua2JXX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373DA191F75
	for <linux-hyperv@vger.kernel.org>; Wed,  5 Mar 2025 05:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741153637; cv=none; b=OAjyVPxVGccz2YaA2ijla6RuiR9qtdSjzYIXsyHWoAfFJ+cCOGb/m4vU4NCZJFs8WdxUAFoacbxyYX44JEHibOZf4GV5lkb/tHsT72tvF4XZGku+tzXYHOz8e+454uRtGH5/B1NWImEAoAor3XFrf6cOSSWdUg2PDG6tGh3YAFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741153637; c=relaxed/simple;
	bh=Yr2zEleQP5OB9VQnCOvN96Nz1sM+C0j+qfjDSd3R7qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olAviUGBMrrz3wKWGDDTu8mkg1/HnA4sKHQx+ysKG0NLLnQTqxALzn5GFrTUHB4MfJeJKzL2w1gOx2OHSZejsKeoLlpfCA3A07VK1CNTbAMyPr9U9XWEZbB72GAjdVrHmh3teEgczzPePa7jdFTe4QXqsx7srlEf93Krq01JrqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9Ua2JXX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741153635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TckiHzoidmvghQ6zu3pJdp/CUVWbSHOgWhuCociTv5w=;
	b=M9Ua2JXXTeyhucvywYqZy7In1fI/ijg9Q9eauxkHatp8dO5iWT2hbjw4ruKxJNatSIm6TU
	FhE/Kyzm6WCV1fXGkb7xQcSes4oo/069TNcTy2kjC8va0A7TtzCstrk4CJxTxLG5EC0wFh
	m16h1AR0kVczrIFJSVJ8qlBSIa37R/0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-urXMF3HsP2CeTULeU09EyA-1; Wed, 05 Mar 2025 00:47:08 -0500
X-MC-Unique: urXMF3HsP2CeTULeU09EyA-1
X-Mimecast-MFC-AGG-ID: urXMF3HsP2CeTULeU09EyA_1741153627
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fee7f85d03so11007267a91.3
        for <linux-hyperv@vger.kernel.org>; Tue, 04 Mar 2025 21:47:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741153627; x=1741758427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TckiHzoidmvghQ6zu3pJdp/CUVWbSHOgWhuCociTv5w=;
        b=wSFvedIlwZOFlASZ3Pg3tWqaEuZ8E0UsCvT/82tqrdksXbRhXAHpdLpHjIS+gvToaj
         PenStESJ8ikiC3GpaqEhGLz6IYc+j47MTWegBNyD8vIpU6NUspvx4Z0YfZdCuoKbjPOP
         8AGygbwNws5o47PCMY17ds16/AIpNEDYGeD19yvaDP0h/ZUh+1BfUhq5Zqlq3twjgrYQ
         1fuuRKG3zJovSD4/1FsBJuDJYLmUQtQzyY6HLWKeaku/NUdAyd5FqECq+mTpp2UzKc/h
         +Q8KN1ApeBWZ3ZGfHYQFAe4HwvARjzqF2nAdmNx3nUxWys1IL5Rp6NwKqZEkcvhwTkVk
         PPgg==
X-Forwarded-Encrypted: i=1; AJvYcCVMZMSQufWs8TxUBM4l+aVm53SMKzKP8ZSAV8XjTYb0h/OgTImRbrQ9kZuMxmf2dvPlkAXo+D6T7ivvr7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9k+a/AVBqm3TQlVikSKc246tJHzbBAxireLZGfNECJH8mFwb2
	LsD6l8z0ZOFMq27+DxoAez+eOoHTT3dHBefwl84yNH6WKP7RkLQGOp1j24kTCyBiWLfJgEFE5c+
	/zARYkrJDNDNB9btsso/YeGQt43oZ9inlp4lfsHj9yYhhF1hzNsKx0DbNcbEDjGWrPImN+YXTr0
	K0MRl8rSVpWBPzfabJWkJfPd12r/idMlWYsjHf
X-Gm-Gg: ASbGncuwBIm150XDOJA0uvTSrX3AJBtrIt5wxh9/nVYRKKRzQrXifvpyM0p86bZSox5
	mpQSXPcs8bqRYOxzOBsnOFK/oawfILb0N7xlewv1yjVcGsuBefbMo0WJYkBrgVrP+X3SqlEWKGw
	==
X-Received: by 2002:a17:90b:1d52:b0:2ee:dcf6:1c8f with SMTP id 98e67ed59e1d1-2ff497cb040mr4004282a91.16.1741153626852;
        Tue, 04 Mar 2025 21:47:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7tLwkzpVQv2Fhj6KJP/g5jr88+NKViP8f9P/MLEqloHXqeIoNFWMkg7gOLyvweXjBE7QjXpxFd7/tryglpqM=
X-Received: by 2002:a17:90b:1d52:b0:2ee:dcf6:1c8f with SMTP id
 98e67ed59e1d1-2ff497cb040mr4004247a91.16.1741153626527; Tue, 04 Mar 2025
 21:47:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20200116172428.311437-1-sgarzare@redhat.com> <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com> <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>
In-Reply-To: <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Mar 2025 13:46:54 +0800
X-Gm-Features: AQ5f1JrNByKY7PtEfXG0ORfP7FScyD2MAlIYCt0mdU5F_0VbeZRH2Dv5bfH1am0
Message-ID: <CACGkMEtTgmFVDU+ftDKEvy31JkV9zLLUv25LrEPKQyzgKiQGSQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, 
	Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 8:39=E2=80=AFAM Bobby Eshleman <bobbyeshleman@gmail.=
com> wrote:
>
> On Tue, Apr 28, 2020 at 06:00:52PM +0200, Stefano Garzarella wrote:
> > On Tue, Apr 28, 2020 at 04:13:22PM +0800, Jason Wang wrote:
> > >
> > >
> > > As we've discussed, it should be a netdev probably in either guest or=
 host
> > > side. And it would be much simpler if we want do implement namespace =
then.
> > > No new API is needed.
> > >
> >
> > Thanks Jason!
> >
> > It would be cool, but I don't have much experience on netdev.
> > Do you see any particular obstacles?
> >
> > I'll take a look to understand how to do it, surely in the guest would
> > be very useful to have the vsock device as a netdev and maybe also in t=
he host.
> >
>
> WRT netdev, do we foresee big gains beyond just leveraging the netdev's
> namespace?

It's a leverage of the network subsystem (netdevice, steering, uAPI,
tracing, probably a lot of others), not only its namespace. It can
avoid duplicating existing mechanisms in a vsock specific way. If we
manage to do that, namespace support will be a "byproduct".

>
> IIUC, the idea is that we could follow the tcp/ip model and introduce
> vsock-supported netdevs. This would allow us to have a netdev associated
> with the virtio-vsock device and create virtual netdev pairs (i.e.,
> veth) that can bridge namespaces. Then, allocate CIDs or configure port
> mappings for those namespaces?

Probably.

>
> I think it might be a lot of complexity to bring into the picture from
> netdev, and I'm not sure there is a big win since the vsock device could
> also have a vsock->net itself?

Yes, it can. I think we need to evaluate both approaches (that's why I
raise the approach of reusing netdevice). We can hear from others.

> I think the complexity will come from the
> address translation, which I don't think netdev buys us because there
> would still be all of the work work to support vsock in netfilter?

Netfilter should not work as vsock will behave as a separate protocol
other than TCP/IP (e.g ETH_P_VSOCK)  if we try to implement netdevice.

>
> Some other thoughts I had: netdev's flow control features would all have
> to be ignored or disabled somehow (I think dev_direct_xmit()?), because
> queueing introduces packet loss and the vsock protocol is unable to
> survive packet loss.

Or just allow it and then configuring a qdisc that may drop packets
could be treated as a misconfiguration.

> Netfilter's ability to drop packets would have to
> be disabled too.
>
> Best,
> Bobby
>

Thanks


