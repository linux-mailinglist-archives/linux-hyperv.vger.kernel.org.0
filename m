Return-Path: <linux-hyperv+bounces-4773-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E64ACA78995
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Apr 2025 10:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613FE1893CB4
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Apr 2025 08:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870851A5BB0;
	Wed,  2 Apr 2025 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XScIf8hv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E162D233D86
	for <linux-hyperv@vger.kernel.org>; Wed,  2 Apr 2025 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743581637; cv=none; b=TsQaPbB3UzY0myT+GILkPBYz9ypdZ3rYYHAXrPY3ApxJ+lOPQx/ULfKVQyNiTWkEAIyUzb5iC4b3b7+bUYCMtcdav0wsibjOlofzpgS9Gkn2Yjxx6dUoWK7/P9kPenbBRzOhmpJhWL8ky8mIaOwXizUI51883uWz45DniMnqI3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743581637; c=relaxed/simple;
	bh=48FlInyRo/LcieLYsm6LfOtngY5tAk0z5mIkPODl/NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFK+m0Hav+Qkpk4uZUSjTXw4xOhA8iFW3KtndO4SvKM3OJ9Xe4tL1QcjsFpts5F0bDHoZQFM0G0UiJITqpTT9zhismtrF2PT+oe5X6paOCON3rg+NIN5R+Q5MmjMfSfHObe2R6Pu1Z0nddWXRE5YfPhrOLCyTbkzV0OC1S862Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XScIf8hv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743581633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73g+JdJov636Q7rPEyHIPPOimNTk/w2YX8KtCebrUU8=;
	b=XScIf8hvREFMARjeDTA96HRfRMGr7nD7kphxwL3gbGgMju8PeIImciTvT1+Vjk6Vqa2RPI
	AKGrNLxrSARtIt9mJxW3BzMvZPUOqe9trZEylGXSD3u00jFIzr1HrQO4sCc3lHI/BpmY1O
	BYiLcYA9ytg5idpiDCC7WIHwk+eg/cs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-lF2xe4E1MkSlgnnHq8OMyw-1; Wed, 02 Apr 2025 04:13:52 -0400
X-MC-Unique: lF2xe4E1MkSlgnnHq8OMyw-1
X-Mimecast-MFC-AGG-ID: lF2xe4E1MkSlgnnHq8OMyw_1743581631
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912fc9861cso2618146f8f.1
        for <linux-hyperv@vger.kernel.org>; Wed, 02 Apr 2025 01:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743581631; x=1744186431;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73g+JdJov636Q7rPEyHIPPOimNTk/w2YX8KtCebrUU8=;
        b=oXt3RmjKaoWgT4CojJYmPwoa8uzD61gSL557ohxuasLu+LUU0QATHWYJ/ePOLx2Br9
         vYopZfwV7I0ud+RtQm2Mdi6/msctrPqwa9lhKJy0sOcxjkh0rqJYjQ+EsS4oxJtGiGuq
         jHu3ivnviPjnO7z9NLZiahYTpwHdC5lofwh0yqE0z5HiNiyZIUlZrnQJJyhyz4Y+oZa0
         D7PN0DzcSoCVZsl6V5k3gqRSvVGz3Ynjf6YqJSqf0V5FCpRDAwfzyaEpMnQcT0iudDxz
         3rKMrWextHlP0A+6RR1drdKzPWD0/yL6J2W1a5qzlqIQM+d1lHKpYFhHTAUaFF/AKKkg
         WhBg==
X-Forwarded-Encrypted: i=1; AJvYcCUq+m023wvhDYy37PnrO0xQHJBE77whVgrjJRxZdhAPWyr4kcUELm3kzzWFMT8mMJrE+dQmSbZCCzi+ROk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2dtB9N/lyh9vuNkebYGnPGPALWjTAW9b1RckfU/2w35se+kAR
	CQaUgD1kel7U+nG6snI6sj8Uvid1jNJSUiXuD6RrJz1YB9jweyS4DtIn8VDc5bkKbHKQ1YR9r47
	Hg3az0ImjW1GSmOre74kjfSHyz0Uhq0zPJZZwb0zGI3VBQ1b09P98LlD2aooxLQ==
X-Gm-Gg: ASbGnctzQeXfFBOJCBphldnRp7/SYHx7SVWe3OLHkaNXLbdz8LdwvOyB2zElL3Z9Cns
	G/ZWSmNfPj0uR2xcgPw+LLPTAqbxwaukB2wF5b4cAD8h4cQOy9ZxstcSvfEYdI8UwxyzO+gAgRF
	L3i0e/GiEqeZYts3L4HV7DPg8aFOUlQn8iRNXYlUULvFiHAUtW0UOhdlyioCWJaDHDG+xKtAmul
	UcYexWzDteLWOGf9POLI4dGOCQ4yMZoc2Fu18mmg2vAKJbP7wE+uBSGlV+SQUL3/3nkBnoeoyHc
	FgVVRLbG1Mun6PSo+Wsb/zGztY2h+Y00C4idkNeXc1b3TdUqhyxb2aO2XVo=
X-Received: by 2002:a05:6000:1a8e:b0:391:3cb7:d441 with SMTP id ffacd0b85a97d-39c120e16e3mr13848668f8f.25.1743581631283;
        Wed, 02 Apr 2025 01:13:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKec90Eug0+u/B8fubJMHRHw5+gTlflwfeHuzUsrEc1vi/3P99CVJqE6RcnW2VF+oxvK4X8Q==
X-Received: by 2002:a05:6000:1a8e:b0:391:3cb7:d441 with SMTP id ffacd0b85a97d-39c120e16e3mr13848624f8f.25.1743581630720;
        Wed, 02 Apr 2025 01:13:50 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eb6138f3esm12761035e9.36.2025.04.02.01.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 01:13:50 -0700 (PDT)
Date: Wed, 2 Apr 2025 10:13:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vsock: add namespace support to vhost-vsock
Message-ID: <CAGxU2F7=64HHaAD+mYKYLqQD8rHg1CiF1YMDUULgSFw0WSY-Aw@mail.gmail.com>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <r6a6ihjw3etlb5chqsb65u7uhcav6q6pjxu65iqpp76423w2wd@kmctvoaywmbu>
 <Z-w47H3qUXZe4seQ@redhat.com>
 <Z+yDCKt7GpubbTKJ@devvm6277.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z+yDCKt7GpubbTKJ@devvm6277.cco0.facebook.com>

On Wed, 2 Apr 2025 at 02:21, Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
>
> On Tue, Apr 01, 2025 at 08:05:16PM +0100, Daniel P. Berrangé wrote:
> > On Fri, Mar 28, 2025 at 06:03:19PM +0100, Stefano Garzarella wrote:
> > > CCing Daniel
> > >
> > > On Wed, Mar 12, 2025 at 01:59:34PM -0700, Bobby Eshleman wrote:
> > > > Picking up Stefano's v1 [1], this series adds netns support to
> > > > vhost-vsock. Unlike v1, this series does not address guest-to-host (g2h)
> > > > namespaces, defering that for future implementation and discussion.
> > > >
> > > > Any vsock created with /dev/vhost-vsock is a global vsock, accessible
> > > > from any namespace. Any vsock created with /dev/vhost-vsock-netns is a
> > > > "scoped" vsock, accessible only to sockets in its namespace. If a global
> > > > vsock or scoped vsock share the same CID, the scoped vsock takes
> > > > precedence.
> > > >
> > > > If a socket in a namespace connects with a global vsock, the CID becomes
> > > > unavailable to any VMM in that namespace when creating new vsocks. If
> > > > disconnected, the CID becomes available again.
> > >
> > > I was talking about this feature with Daniel and he pointed out something
> > > interesting (Daniel please feel free to correct me):
> > >
> > >     If we have a process in the host that does a listen(AF_VSOCK) in a
> > > namespace, can this receive connections from guests connected to
> > > /dev/vhost-vsock in any namespace?
> > >
> > >     Should we provide something (e.g. sysctl/sysfs entry) to disable
> > > this behaviour, preventing a process in a namespace from receiving
> > > connections from the global vsock address space (i.e.      /dev/vhost-vsock
> > > VMs)?
> >
> > I think my concern goes a bit beyond that, to the general conceptual
> > idea of sharing the CID space between the global vsocks and namespace
> > vsocks. So I'm not sure a sysctl would be sufficient...details later
> > below..
> >
> > > I understand that by default maybe we should allow this behaviour in order
> > > to not break current applications, but in some cases the user may want to
> > > isolate sockets in a namespace also from being accessed by VMs running in
> > > the global vsock address space.
> > >
> > > Indeed in this series we have talked mostly about the host -> guest path (as
> > > the direction of the connection), but little about the guest -> host path,
> > > maybe we should explain it better in the cover/commit
> > > descriptions/documentation.
> >
> > > > Testing
> > > >
> > > > QEMU with /dev/vhost-vsock-netns support:
> > > >   https://github.com/beshleman/qemu/tree/vsock-netns
> > > >
> > > > Test: Scoped vsocks isolated by namespace
> > > >
> > > >  host# ip netns add ns1
> > > >  host# ip netns add ns2
> > > >  host# ip netns exec ns1 \
> > > >                             qemu-system-x86_64 \
> > > >                                     -m 8G -smp 4 -cpu host -enable-kvm \
> > > >                                     -serial mon:stdio \
> > > >                                     -drive if=virtio,file=${IMAGE1} \
> > > >                                     -device vhost-vsock-pci,netns=on,guest-cid=15
> > > >  host# ip netns exec ns2 \
> > > >                             qemu-system-x86_64 \
> > > >                                     -m 8G -smp 4 -cpu host -enable-kvm \
> > > >                                     -serial mon:stdio \
> > > >                                     -drive if=virtio,file=${IMAGE2} \
> > > >                                     -device vhost-vsock-pci,netns=on,guest-cid=15
> > > >
> > > >  host# socat - VSOCK-CONNECT:15:1234
> > > >  2025/03/10 17:09:40 socat[255741] E connect(5, AF=40 cid:15 port:1234, 16): No such device
> > > >
> > > >  host# echo foobar1 | sudo ip netns exec ns1 socat - VSOCK-CONNECT:15:1234
> > > >  host# echo foobar2 | sudo ip netns exec ns2 socat - VSOCK-CONNECT:15:1234
> > > >
> > > >  vm1# socat - VSOCK-LISTEN:1234
> > > >  foobar1
> > > >  vm2# socat - VSOCK-LISTEN:1234
> > > >  foobar2
> > > >
> > > > Test: Global vsocks accessible to any namespace
> > > >
> > > >  host# qemu-system-x86_64 \
> > > >     -m 8G -smp 4 -cpu host -enable-kvm \
> > > >     -serial mon:stdio \
> > > >     -drive if=virtio,file=${IMAGE2} \
> > > >     -device vhost-vsock-pci,guest-cid=15,netns=off
> > > >
> > > >  host# echo foobar | sudo ip netns exec ns1 socat - VSOCK-CONNECT:15:1234
> > > >
> > > >  vm# socat - VSOCK-LISTEN:1234
> > > >  foobar
> > > >
> > > > Test: Connecting to global vsock makes CID unavailble to namespace
> > > >
> > > >  host# qemu-system-x86_64 \
> > > >     -m 8G -smp 4 -cpu host -enable-kvm \
> > > >     -serial mon:stdio \
> > > >     -drive if=virtio,file=${IMAGE2} \
> > > >     -device vhost-vsock-pci,guest-cid=15,netns=off
> > > >
> > > >  vm# socat - VSOCK-LISTEN:1234
> > > >
> > > >  host# sudo ip netns exec ns1 socat - VSOCK-CONNECT:15:1234
> > > >  host# ip netns exec ns1 \
> > > >                             qemu-system-x86_64 \
> > > >                                     -m 8G -smp 4 -cpu host -enable-kvm \
> > > >                                     -serial mon:stdio \
> > > >                                     -drive if=virtio,file=${IMAGE1} \
> > > >                                     -device vhost-vsock-pci,netns=on,guest-cid=15
> > > >
> > > >  qemu-system-x86_64: -device vhost-vsock-pci,netns=on,guest-cid=15: vhost-vsock: unable to set guest cid: Address already in use
> >
> > I find it conceptually quite unsettling that the VSOCK CID address
> > space for AF_VSOCK is shared between the host and the namespace.
> > That feels contrary to how namespaces are more commonly used for
> > deterministically isolating resources between the namespace and the
> > host.
> >
> > Naively I would expect that in a namespace, all VSOCK CIDs are
> > free for use, without having to concern yourself with what CIDs
> > are in use in the host now, or in future.
> >
>
> True, that would be ideal. I think the definition of backwards
> compatibility we've established includes the notion that any VM may
> reach any namespace and any namespace may reach any VM. IIUC, it 
> sounds
> like you are suggesting this be revised to more strictly adhere to
> namespace semantics?
>
> I do like Stefano's suggestion to add a sysctl for a "strict" mode,
> Since it offers the best of both worlds, and still tends conservative in
> protecting existing applications... but I agree, the non-strict mode
> vsock would be unique WRT the usual concept of namespaces.

Maybe we could do the opposite, enable strict mode by default (I think 
it was similar to what I had tried to do with the kernel module in v1, I 
was young I know xD)
And provide a way to disable it for those use cases where the user wants 
backward compatibility, while paying the cost of less isolation.

I was thinking two options (not sure if the second one can be done):

  1. provide a global sysfs/sysctl that disables strict mode, but this
  then applies to all namespaces

  2. provide something that allows disabling strict mode by namespace.
  Maybe when it is created there are options, or something that can be
  set later.

2 would be ideal, but that might be too much, so 1 might be enough. In 
any case, 2 could also be a next step.

WDYT?

Thanks,
Stefano


