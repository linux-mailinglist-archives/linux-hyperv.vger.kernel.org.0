Return-Path: <linux-hyperv+bounces-4334-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541C1A59741
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 15:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83637164842
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0356E22B8AA;
	Mon, 10 Mar 2025 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pvqy9ro0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C27718CC1D
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Mar 2025 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616115; cv=none; b=RjovIbk5uBq3vK+L2+Jmye0rnOomLua6tTG2I8nI9LQxy1DAKomnqkqLum2R/S8w5QjpLbUifavcAULEHVxLut5+lW1usPloOuSM+uH1fVQUBfjpzkFnXXGlNcx5U2N1+iALPFao026llcxchITIxk7kOBUWSDF9iMHRUEBqCEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616115; c=relaxed/simple;
	bh=jEa1MxsrpS1cHMT2RYO8VBbSWB07INDb5JSIrlBAMRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdzdDQpK2ZwlljIyTcwiV1VYEbis7Hh81Lqyh4RlM+7F61eFbvUr6cuPUWOryHU5gPheFri737ZvDbZrjP+1YHJOO5W820xj2kFLM1MTwVqZLpcTWdoPLb5ALVg/9sPYiSp0/+lyTPqOGQXVbydYE2kjpjDCWEb5ttmhtXj+41M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pvqy9ro0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741616113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMdCg2efbd0Qh20QNdOF7eXxFbnyvCBURzGryJnLYK4=;
	b=Pvqy9ro0SVzG5zXxSi6sYMDWApwuW42+xZeDpeFOpDFX2DJ4Q5bIu8e0HHLCaXt2SS3+jH
	Rqs7KZmqJLTQkbU0f4yIRYGJKPCnP5XOstwKil7q4fRKQpbOZl9nIllqBEijR6eBKGDkDM
	l1z28aRIvkdyRo293Vqq4BqZDHmmcm0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-UPQAS2T4POqLCUi7bRoVlw-1; Mon, 10 Mar 2025 10:15:12 -0400
X-MC-Unique: UPQAS2T4POqLCUi7bRoVlw-1
X-Mimecast-MFC-AGG-ID: UPQAS2T4POqLCUi7bRoVlw_1741616111
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e6372ccd355so3520473276.1
        for <linux-hyperv@vger.kernel.org>; Mon, 10 Mar 2025 07:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741616111; x=1742220911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMdCg2efbd0Qh20QNdOF7eXxFbnyvCBURzGryJnLYK4=;
        b=ntAB9Zn+BAFLGfI1BVRFLwsYf+nOwzcju9QVjMzRuKINxNjiHt2K/YVs5e22QvI/Ax
         bbeOjm4l+vIdWnnShU9ONJYztS+NcFNeo5lsOVORkAVqMk7fHK/W66sNQijaFn0zm/Sj
         RkZs+UFS5ndZSgx7tLjFUR67B/yiguYbnyyvzUhVLcwmBCSf43Uw2sCyQHFNDjC9bF/m
         6Fg1e6C+sLA1MMeDBWrly85i+EpXz70zECui7CCr3mXVolMZZH1sb/v2GgEPZqa/eyl8
         8HmJgUoht8u+EGIOWysWpCmon1p/ykj24JGZ6KXAJMsLXPD1kxbqOFDJja/FKerd1HG5
         F+Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXcFUHop1c++BqDY64IxX3bggDlh1R5HyLMFFWiQcLhMY5TnsHvdTzlGNLByjYGAueyIApvNt1PdXvH1MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMXVyq92PF4nP0FCRnz+b2s4C9fFgVtAg3UOvFT/iZ9a+6QySw
	TpOW1Y1pFC5SXPPkOWl938oBHrCyMb92kngOUyb7fxq/hqH3H/NxCHkkduLNg8Uc7KNdljFDE5V
	Hj+jxSFK2P3q4Q10AZfmmKKAEpCdHKkhg3as7rBFjSVxunNbvUSMnHbkzbT9y6YHMmoEhUEWxXS
	PwVZWWgSJdRMg5iYgjKDczCxASFzQba84+WKZfFEaSYqPNU/w=
X-Gm-Gg: ASbGncvv2O4VKpxBBIFQR0MhvMHkxMp4sYttSY7qlLZvBcIOA4vyVIBJaMIU6SU3orW
	1bBI4wfY6czSXEhay8qHRaDewO1eTUDeOvA+KbOVkko0mywt7ajZ3l4HlpjRpCD2o3bF2LkE=
X-Received: by 2002:a05:6902:2805:b0:e60:9d12:c1e5 with SMTP id 3f1490d57ef6-e635c1d8d02mr14992233276.36.1741616111131;
        Mon, 10 Mar 2025 07:15:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUqWrvAukg1iFDpO6ExBXHje3cw437GoWuPupbevVNTptRCcjP/uO3Bp+OM9ocpYHlDfKvsiQX6/BEdrkJbTU=
X-Received: by 2002:a05:6902:2805:b0:e60:9d12:c1e5 with SMTP id
 3f1490d57ef6-e635c1d8d02mr14992171276.36.1741616110694; Mon, 10 Mar 2025
 07:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20200116172428.311437-1-sgarzare@redhat.com> <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com> <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com> <20250305022248-mutt-send-email-mst@kernel.org>
 <v5c32aounjit7gxtwl4yxo2q2q6yikpb5yv3huxrxgfprxs2gk@b6r3jljvm6mt> <CACGkMEvms=i5z9gVRpnrXXpBnt3KGwM4bfRc46EztzDi4pqOsw@mail.gmail.com>
In-Reply-To: <CACGkMEvms=i5z9gVRpnrXXpBnt3KGwM4bfRc46EztzDi4pqOsw@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 10 Mar 2025 15:14:59 +0100
X-Gm-Features: AQ5f1JosWWXY88zUmFjBrkclv9qmpGDLsUUZ5bj0pBV0c8sMAT4CMg2t-YayKWI
Message-ID: <CAGxU2F7SWG0m0KwODbKsbQipz6WzrRSuE1cUe6mYxZskqkbneQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, 
	Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Mar 2025 at 01:17, Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Mar 5, 2025 at 5:30=E2=80=AFPM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
> >
> > On Wed, Mar 05, 2025 at 02:27:12AM -0500, Michael S. Tsirkin wrote:
> > >On Tue, Mar 04, 2025 at 04:39:02PM -0800, Bobby Eshleman wrote:
> > >> I think it might be a lot of complexity to bring into the picture fr=
om
> > >> netdev, and I'm not sure there is a big win since the vsock device c=
ould
> > >> also have a vsock->net itself? I think the complexity will come from=
 the
> > >> address translation, which I don't think netdev buys us because ther=
e
> > >> would still be all of the work work to support vsock in netfilter?
> > >
> > >Ugh.
> > >
> > >Guys, let's remember what vsock is.
> > >
> > >It's a replacement for the serial device with an interface
> > >that's easier for userspace to consume, as you get
> > >the demultiplexing by the port number.
>
> Interesting, but at least VSOCKETS said:
>
> """
> config VSOCKETS
>         tristate "Virtual Socket protocol"
>         help
>          Virtual Socket Protocol is a socket protocol similar to TCP/IP
>           allowing communication between Virtual Machines and hypervisor
>           or host.
>
>           You should also select one or more hypervisor-specific transpor=
ts
>           below.
>
>           To compile this driver as a module, choose M here: the module
>           will be called vsock. If unsure, say N.
> """
>
> This sounds exactly like networking stuff and spec also said something si=
milar
>
> """
> The virtio socket device is a zero-configuration socket communications
> device. It facilitates data transfer between the guest and device
> without using the Ethernet or IP protocols.
> """
>
> > >
> > >The whole point of vsock is that people do not want
> > >any firewalling, filtering, or management on it.
>
> We won't get this, these are for ethernet and TCP/IP mostly.
>
> > >
> > >It needs to work with no configuration even if networking is
> > >misconfigured or blocked.
>
> I don't see any blockers that prevent us from zero configuration, or I
> miss something?
>
> >
> > I agree with Michael here.
> >
> > It's been 5 years and my memory is bad, but using netdev seemed like a
> > mess, especially because in vsock we don't have anything related to
> > IP/Ethernet/ARP, etc.
>
> We don't need to bother with that, kernel support protocols other than TC=
P/IP.

Do we have an example of any other non-Ethernet device that uses
netdev? Just to see what we should do.

I'm not completely against the idea, but from what I remember when I
looked at it five years ago, it wasn't that easy and straightforward
to use.

>
> >
> > I see vsock more as AF_UNIX than netdev.
>
> But you have a device in guest that differs from the AF_UNIX.

Yes, but the device is simply for carrying messages.
Another thing that makes me think of AF_UNIX is the hybrid-vsock
developed by Firecracker [1] that we also reused in vhost-user-vsock
[2], where the mapping between AF_VSOCK and AF_UNIX is really
implemented.

Thanks,
Stefano

[1] https://github.com/firecracker-microvm/firecracker/blob/main/docs/vsock=
.md#firecracker-virtio-vsock-design
[2] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock


