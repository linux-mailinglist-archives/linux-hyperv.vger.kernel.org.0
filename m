Return-Path: <linux-hyperv+bounces-4245-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 273BAA53EFD
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Mar 2025 01:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FA8169A96
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Mar 2025 00:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191291373;
	Thu,  6 Mar 2025 00:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Md3Q9TmV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6582B10F9
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Mar 2025 00:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741220228; cv=none; b=owPJ6HDnY499zGhHehArLsocLS75xjjm4XJZA5tVTiDINQTBcDeKbd4az12b6hRzeN7wsv4dMp+zzID/CaZJCLTkYQS7wBb1J9llkPEcMDq4L42jhq1n8sx8DbFqG5RGi7QFZR5VmVptWvmbA8yljYPnp/cLgkRXj2H0DrIQhKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741220228; c=relaxed/simple;
	bh=+Wwm78y9BnVLdWm8RFuREOENXYM1SpKDISYy3wFQGr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEsOB04fJV2YehYv6gLP3FR2VxJJip/kNDk1mrWzU5HylxfdOLmreoKBmvepixHcaOq6j6Mat5in75Ht3LgK6ysVpr5LT4DiYol76cL1rh3ERgsZNCSAzW7djL1XKSSS4Rh02dBMoi0IVyTugzcRUPwZZZeQ5Jsvw1+lOnyvyKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Md3Q9TmV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741220225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYivC87WhRU5jPCfxZzkS7AXzckjBFGkdKstv7mfD7c=;
	b=Md3Q9TmVityAB2uhe8EQS9ZXZwbzRq5PZH1qqXY6T5FoKp/X53OZSgAwWUmdDsrUPzlaZd
	+rBfnVAy2YEUVxufdBKtYUs9VZFB7QZZ2ejNtf/d6cdbYx97imzsG2oFDv2mQ8BAsYMkFm
	p9mRg/ihuQ+iomn+dOCXM7e+pl0SW2o=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-1LPYDZPqPsmMPimNdjfkKQ-1; Wed, 05 Mar 2025 19:17:04 -0500
X-MC-Unique: 1LPYDZPqPsmMPimNdjfkKQ-1
X-Mimecast-MFC-AGG-ID: 1LPYDZPqPsmMPimNdjfkKQ_1741220223
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso381163a91.1
        for <linux-hyperv@vger.kernel.org>; Wed, 05 Mar 2025 16:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741220223; x=1741825023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYivC87WhRU5jPCfxZzkS7AXzckjBFGkdKstv7mfD7c=;
        b=hrgxeRWNHvZpxn8DIEYiOFvZLyrB73Ng8q5lyzvZVTHPCxxxjtTPh7ytcdUXiqSH1j
         6HgI7WR3mQ/Ngo1ZzmXKA6hyTVUNuYWavF8yYGNLdhH+cRqlB02Il6pA6AHR6EpikYWJ
         EwYONFQymrlzE2jICPoZToB5DTgv6AXxPDr4uy3MBMjDYx55l6Fiz4N53xO+BfaeB7qs
         HP4RL+Q4GYIEm+JU+rc10KTfvoMpKg1qB3AVFUl8vv+3GNXZhPQ0ZkkkuslWbjHNP3fx
         Bu+FRF5l1nDyJsleZGTWdkp91iarzyG26A0QgOW9/UYe7oNhfqz6ZFZg9JvIhVB0ic6V
         HMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3CjueohuM/N56QIsuUQgqdR3TBUkbFR1XEerabISEesyZlbMkYLVizwh0RdycrQ+A5a5SQXb0dylwm+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1dZm6qixwXLK0ckt3pYpaUrExxGJXm9g2/9adMJ29ysL7H8GM
	0YxOeCK99p09u/xaaP3heMC+UW5wFL7ZcHzIonNAn8uFroQsfUrEEY7zhjMsZrHiTiVtetxw/rH
	UKLGig59M4FkrGgSCtioEgUZG2LrJyE0uhyZ7HkzL7srAwVISabYfWfuNkKBcUwrFj0Ol9qkLDq
	60jacsBi9ilPiD6IvdbqJfQdzsvn3usnqK0oHs
X-Gm-Gg: ASbGnctFT0dUc45vQkgwilUyFWrv8dp7GPVtTgYuB7Lq6Nz0XMVJ15w3ZdxgiQaCq8s
	FI5HoarpGqxErh31hsHXdGnoHXyvuslEHLTNBVSfmlC8DsTbB0MWTNEGBESsSO3JGhHsd6MljMN
	8=
X-Received: by 2002:a17:90b:3c87:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-2ff497cce78mr9640210a91.18.1741220222888;
        Wed, 05 Mar 2025 16:17:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFm03yuBJCzHipb+u+/vxkatspEkUc/vBoHzZ9SJCyh2hxYSRGDOjw00zbfIsnmQnxOyJi4dQOkxCDXWDyfOC0=
X-Received: by 2002:a17:90b:3c87:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-2ff497cce78mr9640168a91.18.1741220222504; Wed, 05 Mar 2025
 16:17:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20200116172428.311437-1-sgarzare@redhat.com> <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com> <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com> <20250305022248-mutt-send-email-mst@kernel.org>
 <v5c32aounjit7gxtwl4yxo2q2q6yikpb5yv3huxrxgfprxs2gk@b6r3jljvm6mt>
In-Reply-To: <v5c32aounjit7gxtwl4yxo2q2q6yikpb5yv3huxrxgfprxs2gk@b6r3jljvm6mt>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Mar 2025 08:16:51 +0800
X-Gm-Features: AQ5f1Jql0yqolE1p-RM3zEM6LJujZ0qsyX-vhJHsLFPVzV7f1_y-mNi6DKL8tMs
Message-ID: <CACGkMEvms=i5z9gVRpnrXXpBnt3KGwM4bfRc46EztzDi4pqOsw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, 
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, 
	Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 5:30=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Wed, Mar 05, 2025 at 02:27:12AM -0500, Michael S. Tsirkin wrote:
> >On Tue, Mar 04, 2025 at 04:39:02PM -0800, Bobby Eshleman wrote:
> >> I think it might be a lot of complexity to bring into the picture from
> >> netdev, and I'm not sure there is a big win since the vsock device cou=
ld
> >> also have a vsock->net itself? I think the complexity will come from t=
he
> >> address translation, which I don't think netdev buys us because there
> >> would still be all of the work work to support vsock in netfilter?
> >
> >Ugh.
> >
> >Guys, let's remember what vsock is.
> >
> >It's a replacement for the serial device with an interface
> >that's easier for userspace to consume, as you get
> >the demultiplexing by the port number.

Interesting, but at least VSOCKETS said:

"""
config VSOCKETS
        tristate "Virtual Socket protocol"
        help
         Virtual Socket Protocol is a socket protocol similar to TCP/IP
          allowing communication between Virtual Machines and hypervisor
          or host.

          You should also select one or more hypervisor-specific transports
          below.

          To compile this driver as a module, choose M here: the module
          will be called vsock. If unsure, say N.
"""

This sounds exactly like networking stuff and spec also said something simi=
lar

"""
The virtio socket device is a zero-configuration socket communications
device. It facilitates data transfer between the guest and device
without using the Ethernet or IP protocols.
"""

> >
> >The whole point of vsock is that people do not want
> >any firewalling, filtering, or management on it.

We won't get this, these are for ethernet and TCP/IP mostly.

> >
> >It needs to work with no configuration even if networking is
> >misconfigured or blocked.

I don't see any blockers that prevent us from zero configuration, or I
miss something?

>
> I agree with Michael here.
>
> It's been 5 years and my memory is bad, but using netdev seemed like a
> mess, especially because in vsock we don't have anything related to
> IP/Ethernet/ARP, etc.

We don't need to bother with that, kernel support protocols other than TCP/=
IP.

>
> I see vsock more as AF_UNIX than netdev.

But you have a device in guest that differs from the AF_UNIX.

>
> I put in CC Jakub who was covering network namespace, maybe he has some
> advice for us regarding this. Context [1].
>
> Thanks,
> Stefano
>
> [1] https://lore.kernel.org/netdev/Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebo=
ok.com/
>

Thanks


