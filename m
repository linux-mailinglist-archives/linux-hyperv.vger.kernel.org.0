Return-Path: <linux-hyperv+bounces-4246-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23487A5400C
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Mar 2025 02:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA62A3AF60B
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Mar 2025 01:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF2B18F2FB;
	Thu,  6 Mar 2025 01:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aR4C+v7a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C976A18DB1B
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Mar 2025 01:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741225064; cv=none; b=EBi1A6MEiIgkxtzkPOT/bYcju7Z2FGLrwD12b0NI4ne1HozMzoL7l2w5vUWJX6jiqlFGNBXKrQUISwqqT7NZ+llnkcAu6M0x9W4CkE3P2NiGN7GJaJGu8wI0eSc3CFy75suiyK2nIJK91H7hQrQOTnNoDnvsDQsgO39Zs1deo44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741225064; c=relaxed/simple;
	bh=jt8oE1DDukSHhfGAEncsuyQqx3ir3OOa0dHNqoKOelY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUd+BZfeyIKZzPs7RndHF9gU0SS6hVflEytKKO2KGU/9oQA7tfy0U3SraSMooz9JabWud07UXNi3exT+R3V6ZmJAtGNpl+ZiWXHEDD7L9u3+TfvQoem6nERAC3IvbfHBv0JtrH2nwnfk4/b4eEGA63jfCHgoS8l2JPCnnnIDzO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aR4C+v7a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741225061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwJDzSbLHHnbA7u1yktm23jopFFzMjn7g9N2Exf0cfw=;
	b=aR4C+v7aKOBmBONL2DT+dwqTOx22Z7y0kHlJ8rs/8GaGR37oTS3qRQ/SzzCtMEoVDw8zpk
	RTDxRqAytniuWMAF6tekPg6bgwfwnTWDQ1qdQVxVXyMC/cLOodTIPTo0pv+Bj2NMe37sG2
	XA9ZgO3Wl6be5P+skhsxDYzh/1Pb6qw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-eEMAQhg4PeOTzBOtQtPZ8g-1; Wed, 05 Mar 2025 20:37:35 -0500
X-MC-Unique: eEMAQhg4PeOTzBOtQtPZ8g-1
X-Mimecast-MFC-AGG-ID: eEMAQhg4PeOTzBOtQtPZ8g_1741225055
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac1dca8720cso16354866b.0
        for <linux-hyperv@vger.kernel.org>; Wed, 05 Mar 2025 17:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741225054; x=1741829854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwJDzSbLHHnbA7u1yktm23jopFFzMjn7g9N2Exf0cfw=;
        b=mPfhaRui0iZ3FfYbo/eTodNhJMRwx+rdaE7zjyGVP837XeWUzy3/Fe+SCzpSlpnMCw
         IU8i8g5now1sq8R/vjjpqcYtwZR3G+AF+o6Phia+GhQIzEGIfcPNBS/jdKbYj6HsE1b4
         mfG1Rq7EssrhCRzwEj6NHVzVjnXmz5HkJf4DH25LRLMG0nsgOpm7MXGk1ftgdwSdVPBq
         V8eDDl0AHI8gTeIrZRn1O0cJaFUHNsf1/zvN3wq/ozaY6nxk+RmV+NT+FFmUmy8NjJH6
         FC61cBhB/T0EzY4pybCuZc5b/jsyh5LWD1BLI7lrvufWLN4IamK8pdLGS7ayCUgOn2MJ
         9QcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+mo+RFb/KAR6KstO4KCfnJsKcrUtJ9G8IlNEhDWQ3fDza9TJKMYfmlpZX5awPSDArgeiSuBOPEpLezY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvjbyoptXvT2F4iWC3hMtO2sfspTLeb0lIs4HS8kNR6E8TlZPM
	dSl2dXPojsDjZKDb95XWFOK5QvtpV68twTltYijqPdHYXaClG0W+DdW+nIxU8G+bjXvLXku9M89
	tioEPdAy47QY9WjmuSBMS0BYO5GmWfkXsy2IZmW8Mv89tsg5PwC6wM0edYnmD1qFXzNCPTwl5wH
	o61OW2bpW3pW1rwvSlLawDj9n/kMgC1XLWw1ha
X-Gm-Gg: ASbGncsJjEJ9QUECvjidBG6h5kOoUvUQuANOD6sH98rAutG3dOKxW0UmiPU9bqqdXyN
	mFBF9L+SLhFCKRysm55CGnaA93sH7HCp32nyFbIjJd9I14vpYbbLGJgdMRYkCzmJk3jTff0xeZw
	==
X-Received: by 2002:a17:907:3f97:b0:abf:6225:c91d with SMTP id a640c23a62f3a-ac20db5625bmr437490766b.34.1741225054605;
        Wed, 05 Mar 2025 17:37:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9H1qhwvkDgDybNE5sW4VnwbCiQQmLm0SVfn0Ji7BN3QvZ4moN9FmVfiIH9jslgkkvztcXACeXl8wpC1dBMno=
X-Received: by 2002:a17:907:3f97:b0:abf:6225:c91d with SMTP id
 a640c23a62f3a-ac20db5625bmr437488266b.34.1741225054236; Wed, 05 Mar 2025
 17:37:34 -0800 (PST)
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
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 6 Mar 2025 09:36:57 +0800
X-Gm-Features: AQ5f1JoJEUufAEkLHWWULXhaNHkiqHvkFGZFpeTeSZ026lfQ3NJ0WwfBHHNypzs
Message-ID: <CAPpAL=xsDM4ffe9kpAnvL3AfQrKg9tpbDdbTGgSwecHFf5wSLA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, 
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, 
	Bobby Eshleman <bobbyeshleman@gmail.com>, linux-hyperv@vger.kernel.org, 
	Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series patch with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Mar 6, 2025 at 8:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
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
>
> >
> > I see vsock more as AF_UNIX than netdev.
>
> But you have a device in guest that differs from the AF_UNIX.
>
> >
> > I put in CC Jakub who was covering network namespace, maybe he has some
> > advice for us regarding this. Context [1].
> >
> > Thanks,
> > Stefano
> >
> > [1] https://lore.kernel.org/netdev/Z8edJjqAqAaV3Vkt@devvm6277.cco0.face=
book.com/
> >
>
> Thanks
>
>


