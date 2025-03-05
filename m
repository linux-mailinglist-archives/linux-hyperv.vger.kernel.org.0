Return-Path: <linux-hyperv+bounces-4230-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A92A4FA72
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 10:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2823A88E5
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 09:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F5F204F7C;
	Wed,  5 Mar 2025 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gb4HQq+H"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D8A204F76
	for <linux-hyperv@vger.kernel.org>; Wed,  5 Mar 2025 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167789; cv=none; b=dNTfvdaVxmJdegpeHGgBN0OsxbGnIu9iPpODpJDhAKe01KaClKVHDoZtPLMbunOvQi3nJCPaQet9Kgv2V+my5IvS41MkDKeaFCT7ptjhNWUVc2ANFcxuKUkx5dkQH22fgALJxp/oaZkVV2C94yRRaNsR/toWBnJ2THf9QrbrEEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167789; c=relaxed/simple;
	bh=imtuAnpaAXGOP6kzkiTdpwhJ9L3ewSs/OCqwVl5NK7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1Gx7yqpLomjURVllYmMBRIsZvRiVkyBAwuGIZD70CZ/HtvMvBLg/lBVDiCMZHCTZlQszhqqi3fiQ3XFCJNRTZanyyU6mkBK58cJpfKn/opZc9h+4F8Loz/YAfuOkFqUgPi2fdf9i60pJUPIN1ipDedW94n0Q0StAL+JTDpdIdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gb4HQq+H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741167785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vq2Dveu3Lu0iWioX9TM10BGhlOQ2RzAuJnxk7fM0ty0=;
	b=Gb4HQq+HkSDkprDdMiLlIqTJNTMMYjRcg/3v7Xs2wqTILHuNhjvUdqk5v9gfwa6DAUtLN0
	3rcXhY7DdLzy9n+v/lRsrhs2BIlDjLZCeTdQuc4Qg2ztkRsxIy5jKHjh1BfkQnTsdZZqwC
	HgpTPhKxfgzu7d9V/KSIT9TXzAvhB2A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-akJSZ_wHMe-3lvt85KVgQw-1; Wed, 05 Mar 2025 04:43:04 -0500
X-MC-Unique: akJSZ_wHMe-3lvt85KVgQw-1
X-Mimecast-MFC-AGG-ID: akJSZ_wHMe-3lvt85KVgQw_1741167783
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-abb9b2831b7so71705666b.1
        for <linux-hyperv@vger.kernel.org>; Wed, 05 Mar 2025 01:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741167783; x=1741772583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vq2Dveu3Lu0iWioX9TM10BGhlOQ2RzAuJnxk7fM0ty0=;
        b=YLhWEqYKtbJlc3z5nXDeg6I0hihrh44tweT90asTF93i0RNQYJ0wkPkCLnuaUJCGT4
         RJpMKa6fbuBH698wiVF7TJ7/FWpMfMq/cq0eWh8Lt/wZda8UiJW03W0NX2oI9WAzgVWZ
         gqHoddPfIRnTnXoVBRV2B3hLIntT8EAFWtVaQ3UyCTGdE7trLoStFSNszOkbMvrYbI+8
         qcx3gECJleMgJZFdf8yQ9p60xhInEepJTjn5k1Bz4imdcrrT41zF7ZiqlvLM/Zb40ivi
         +8U6zh+K/TUowg0oSMDrS53joANOl03DXsWfSmOluC+2dvcsxopFmjRF6QewoDN3Lo8w
         tPHg==
X-Forwarded-Encrypted: i=1; AJvYcCX1KmKyuP9h7giteLvYOKIeKXeOspkJU22S2+8rBhpMCrs3+4/ZQsXxpcbjzDNRbjqAmrCmeMkq7jgNs+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx532MkW58lQ5OErnfhJL1blgz/2dIsk93ZbroP7EeeRvWqiF2a
	9lVvgx7opZzkpIPGudn2IG17QFtuNY4M6/vNAicRzAZ03hsRsblvgnCDCY/KJC0M8LCJ1cThZbA
	9Igdy8hgepvuHNJsK6p5ZrMYf0NJkMTUFLkM034gM+R1dVX4m9iQOlAKarF973g==
X-Gm-Gg: ASbGncvuxc1Vf5wrF1/kd/at/Q/GepFJYtzzPNIC1YGBb59dnpVHx9jkotnJ8EEDGQ0
	CeFui1DLu7KSw7uUAOfItVvfFl9nJG/M04IpIYIkA0EMpJmluaDS7E5C4LpwujQsM1JlRfANFcS
	K/xcFdUBgglCq7UjSfYrrqGQ/j1lPRZRsA/2O8nDlb1X7fKoN97zcPmNOcQzeO+cvID/o6kjSvX
	me6AW0+SR4m61qNRHOM/6PPS2qTokPgNoO+THqsEYanBzV+oAQzMj4ATrScg4M3lRhSuesfIX7R
	zf47tbXtH5Os1mVOP7l/bfHYBUdYaZW+VbTSMs3tJha87SRTDqJJuhjPpPTWNOHq
X-Received: by 2002:a17:906:c148:b0:ac1:f247:69f5 with SMTP id a640c23a62f3a-ac20f0139aemr209685866b.28.1741167783284;
        Wed, 05 Mar 2025 01:43:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5B6S50i1HDHEaJU/jj+bI1k8KZTn2nF4k4C13v/0HHoQCH0wJ+1c900aMe64d5Ks6YGak+w==
X-Received: by 2002:a17:906:c148:b0:ac1:f247:69f5 with SMTP id a640c23a62f3a-ac20f0139aemr209681866b.28.1741167782581;
        Wed, 05 Mar 2025 01:43:02 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac21dd2c297sm28756566b.110.2025.03.05.01.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:43:02 -0800 (PST)
Date: Wed, 5 Mar 2025 10:42:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Dexuan Cui <decui@microsoft.com>, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <cmkkkyzyo34pspkewbuthotojte4fcjrzqivjxxgi4agpw7bck@ddofpz3g77z7>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <Z8eVanBR7r90FK7m@devvm6277.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z8eVanBR7r90FK7m@devvm6277.cco0.facebook.com>

On Tue, Mar 04, 2025 at 04:06:02PM -0800, Bobby Eshleman wrote:
>On Thu, Jan 16, 2020 at 06:24:25PM +0100, Stefano Garzarella wrote:
>> RFC -> v1:
>>  * added 'netns' module param to vsock.ko to enable the
>>    network namespace support (disabled by default)
>>  * added 'vsock_net_eq()' to check the "net" assigned to a socket
>>    only when 'netns' support is enabled
>>
>> RFC: https://patchwork.ozlabs.org/cover/1202235/
>>
>> Now that we have multi-transport upstream, I started to take a look to
>> support network namespace in vsock.
>>
>> As we partially discussed in the multi-transport proposal [1], it could
>> be nice to support network namespace in vsock to reach the following
>> goals:
>> - isolate host applications from guest applications using the same ports
>>   with CID_ANY
>> - assign the same CID of VMs running in different network namespaces
>> - partition VMs between VMMs or at finer granularity
>>
>> This new feature is disabled by default, because it changes vsock's
>> behavior with network namespaces and could break existing applications.
>> It can be enabled with the new 'netns' module parameter of vsock.ko.
>>
>> This implementation provides the following behavior:
>> - packets received from the host (received by G2H transports) are
>>   assigned to the default netns (init_net)
>> - packets received from the guest (received by H2G - vhost-vsock) are
>>   assigned to the netns of the process that opens /dev/vhost-vsock
>>   (usually the VMM, qemu in my tests, opens the /dev/vhost-vsock)
>>     - for vmci I need some suggestions, because I don't know how to do
>>       and test the same in the vmci driver, for now vmci uses the
>>       init_net
>> - loopback packets are exchanged only in the same netns
>
>
>Hey Stefano,
>
>I recently picked up this series and am hoping to help update it / get
>it merged to address a known use case. I have some questions and
>thoughts (in other parts of this thread) and would love some
>suggestions!

Great!

>
>I already have a local branch with this updated with skbs and using
>/dev/vhost-vsock-netns to opt-in the VM as per the discussion in this
>thread.
>
>One question: what is the behavior we expect from guest namespaces?  In
>v2, you mentioned prototyping a /dev/vsock ioctl() to define the
>namespace for the virtio-vsock device. This would mean only one
>namespace could use vsock in the guest? Do we want to make sure that our
>design makes it possible to support multiple namespaces in the future if
>the use case arrives?

Yes, I guess it makes sense that multiple namespaces can communicate 
with the host and then use the virtio-vsock device!

IIRC, the main use case here was also nested VMs. So a netns could be 
used to isolate a nested VM in L1 and it may not need to talk to L0, so 
the software in the L1 netns can use vsock, but only to talk to L2.

>
>More questions/comments in other parts of this thread.

Sure, I'm happy to help with this effort with discussions/reviews!

Stefano


