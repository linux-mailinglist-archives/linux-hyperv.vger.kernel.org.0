Return-Path: <linux-hyperv+bounces-8021-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C993CBE656
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Dec 2025 15:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07B553011BC7
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Dec 2025 14:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C3730C617;
	Mon, 15 Dec 2025 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K62vpGaI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RcPhzJ+i"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8E30DD16
	for <linux-hyperv@vger.kernel.org>; Mon, 15 Dec 2025 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807901; cv=none; b=IrmUmuNdL9whFkMkm9gchS91cnAcQinBIBFxFiaUzuEw5cwPUc/c2CL2UlsB1m5Q1yk7Yr5kPSyO/6YGQOVBypLoJYTY6KodL4Mmo3C6D4mk7M/0UmsESZ4XWuiSkTiBH4CKDcCMo3ySrwHviU9VrYdpWT7PZwO04vSHaIvIWr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807901; c=relaxed/simple;
	bh=9UhOxOYBAp/VSDR6aFOh9tRFhqEK+BtNWnc9VPwKxA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwWhOlaHxbxX9abKUOYNPa0yGL6bfmC5JGcV7Y3cs4R7mYmmischCkUINbjUzNCMWNH2aUWDeGO3DttjQBwJlfB7BHvKD58G6CHoXPUJrIpVJ4n0LV7b1ZwDCVTM0X+JpEzo1M4AOb9i3+nk3hn8WDavAkzxeAeUMZBoE7T3TBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K62vpGaI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RcPhzJ+i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765807897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J90UfQNlZ0RUz7+pu7rYaBkTu5UsQkqFR03KijVsXMk=;
	b=K62vpGaIV1sDbhxAMx5vgI38J3affxi2n63Sed3HPK+LqcAiKhS08+hqY+BOJyRebMFC0e
	Lfvit0eFFDkxS4igwjDkOgzDN4p/FnDkpxdr4zmLuIczIRqNkbICIDULFaxlvFBGZcwu8O
	llwZB+3RMtRohtnW7RYrIavaOPmTmNc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-7QrxZJKzN5qc1L3ky7HUbg-1; Mon, 15 Dec 2025 09:11:35 -0500
X-MC-Unique: 7QrxZJKzN5qc1L3ky7HUbg-1
X-Mimecast-MFC-AGG-ID: 7QrxZJKzN5qc1L3ky7HUbg_1765807894
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b2c8fb84fso1653986f8f.2
        for <linux-hyperv@vger.kernel.org>; Mon, 15 Dec 2025 06:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765807894; x=1766412694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J90UfQNlZ0RUz7+pu7rYaBkTu5UsQkqFR03KijVsXMk=;
        b=RcPhzJ+iqV7PU10/Q8vCnJRXHQ0FTPOu8UhazlwJh/691j6hBUMjC2rxA9aRWmumGx
         sOtR0eIhwHnIt/kBb/99rSNIg8UFfpSI5vWyDadDqiRwOz2D6AcTvQVwKXu+EwQMOMaG
         PUtUH5qEzkjy/jJyXqcaa4tv8PAZYgvocIAOPOpraIqXBc0lS3aKcx3X/5sfCUa2I78U
         c11wy02izPFsMkzpUCoPhqVZLUp6TH+D5yEyI3+bviO3EB0vuHReo19fwhsezNf85Gnk
         aa6M0huArKnms0C3w9jBUSXjlfQ6sNYYP2j/CfA71g/epmMM1+hXOWvopzEt+92gZ8o4
         Q/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765807894; x=1766412694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J90UfQNlZ0RUz7+pu7rYaBkTu5UsQkqFR03KijVsXMk=;
        b=W8msGtaFz7HYgZLb5UJQqxbcR8P3Md+TDFJNDgJMb5zByqUkLj7Cu8q4tXE4fNCO5H
         zPT8232/xl7czv6B1Q4R0RK/aNKf5UOtORb5EdYz6TrNpMhi2m+ytC5LVy8MPCgl2NdP
         a+1YUPF09gFne7yAWbIHQii7FtQ5RhT9LZr55rthbsUq1/lQAEQIGJnraoHNAD2bCPGa
         dEhfxruoYjJj84aPI3sMfqba4pF2rVlmmgT5UxTiaDfnQdUm8EvE1q1/GODq0lT+0/LN
         g0gfQuBq0mCkx5pou30XBdC0MmLpXjBZXH8Did4zmaoneCaPWLs60v0LSgWatjEZo8mb
         eobA==
X-Forwarded-Encrypted: i=1; AJvYcCUHsbq/H/YOaAlNQ2QXF8gyvntzddzY2qUNR8uyaASrVeSHLt/R1xDXKyM8srVkk9XInxMzKwlMy+24nPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiqn+UPxcwwuSsq84MeYD5sVe0nO4KcOYOFCjGD2f3VpTouvLG
	KGfIjBh22Q/UiTvFCmrlKwG2SZai2jJOq9V9zh+NTvJQB7rIpGiNnvYNn8/+S5+xv0AqqJ0ZOua
	EdFv+OdzdbGaRCRYNvt3i9V9BaYXXZZFb8VB0QCl5x9IF8s0dQGWrX34SZcEkh46ndg==
X-Gm-Gg: AY/fxX7zXfVTpPjWST2NcOkW3dSlDdHnxS3UwdThBdU47v/9SKxTtPbfDQnHi45N50X
	rxWvZsfHP9V6abyfwEsr5iRocb66dOqZ6wql/Uu1rLC/yrlxeNbjTE8k//BOUBFZ0cdyYEoQZ5Q
	ljmXxtLpe8KukE9l1lsQpFJqs2HHiq+HqntrpZdUT7ho0oQ5r+0B/67jmEobg2dSeTZ84GyYlYN
	nRHnJTozU1x572Ei1P2TBAQxiPRldPo+O+kK2yDOeGRDFsGHEHkwUAcv5f/OTuNBe2MT7WTYi5W
	ExQUmvlNJ8OzOkkCnxiYVp1Oc5RVIPAL4Yvw091H2pnQ7j57yej0W9C6AbvdXSPbtJZ3PsCEeph
	Ee7VvpRUcZi1DxNFK
X-Received: by 2002:a05:6000:2909:b0:42b:3b55:8929 with SMTP id ffacd0b85a97d-42fb44bb495mr11365667f8f.19.1765807894100;
        Mon, 15 Dec 2025 06:11:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjJ8SuWUiguDFoeMlrC0RUXN9FuGWx/+8j2dVxYD6YOL63XnaR5zt7GAKfr25wYST/+i8ycQ==
X-Received: by 2002:a05:6000:2909:b0:42b:3b55:8929 with SMTP id ffacd0b85a97d-42fb44bb495mr11365608f8f.19.1765807893485;
        Mon, 15 Dec 2025 06:11:33 -0800 (PST)
Received: from sgarzare-redhat ([193.207.203.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f984a268sm9673818f8f.1.2025.12.15.06.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:11:32 -0800 (PST)
Date: Mon, 15 Dec 2025 15:11:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v12 04/12] vsock: add netns support to virtio
 transports
Message-ID: <uidarlot7opjsuozylevyrlgdpjd32tsi7mwll2lsvce226v24@75sq4jdo5tgv>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
 <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>
 <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>
 <aTw0F6lufR/nT7OY@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aTw0F6lufR/nT7OY@devvm11784.nha0.facebook.com>

On Fri, Dec 12, 2025 at 07:26:15AM -0800, Bobby Eshleman wrote:
>On Tue, Dec 02, 2025 at 02:01:04PM -0800, Bobby Eshleman wrote:
>> On Tue, Dec 02, 2025 at 09:47:19PM +0100, Paolo Abeni wrote:
>> > On 12/2/25 6:56 PM, Bobby Eshleman wrote:
>> > > On Tue, Dec 02, 2025 at 11:18:14AM +0100, Paolo Abeni wrote:
>> > >> On 11/27/25 8:47 AM, Bobby Eshleman wrote:
>> > >>> @@ -674,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>> > >>>  		goto out;
>> > >>>  	}
>> > >>>
>> > >>> +	net = current->nsproxy->net_ns;
>> > >>> +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
>> > >>> +
>> > >>> +	/* Store the mode of the namespace at the time of creation. If this
>> > >>> +	 * namespace later changes from "global" to "local", we want this vsock
>> > >>> +	 * to continue operating normally and not suddenly break. For that
>> > >>> +	 * reason, we save the mode here and later use it when performing
>> > >>> +	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
>> > >>> +	 */
>> > >>> +	vsock->net_mode = vsock_net_mode(net);
>> > >>
>> > >> I'm sorry for the very late feedback. I think that at very least the
>> > >> user-space needs a way to query if the given transport is in local or
>> > >> global mode, as AFAICS there is no way to tell that when socket creation
>> > >> races with mode change.
>> > >
>> > > Are you thinking something along the lines of sockopt?
>> >
>> > I'd like to see a way for the user-space to query the socket 'namespace
>> > mode'.
>> >
>> > sockopt could be an option; a possibly better one could be sock_diag. Or
>> > you could do both using dumping the info with a shared helper invoked by
>> > both code paths, alike what TCP is doing.
>> > >> Also I'm a bit uneasy with the model implemented here, as 'local' socket
>> > >> may cross netns boundaris and connect to 'local' socket in other netns
>> > >> (if I read correctly patch 2/12). That in turns AFAICS break the netns
>> > >> isolation.
>> > >
>> > > Local mode sockets are unable to communicate with local mode (and global
>> > > mode too) sockets that are in other namespaces. The key piece of code
>> > > for that is vsock_net_check_mode(), where if either modes is local the
>> > > namespaces must be the same.
>> >
>> > Sorry, I likely misread the large comment in patch 2:
>> >
>> > https://lore.kernel.org/netdev/20251126-vsock-vmtest-v12-2-257ee21cd5de@meta.com/
>> >
>> > >> Have you considered instead a slightly different model, where the
>> > >> local/global model is set in stone at netns creation time - alike what
>> > >> /proc/sys/net/ipv4/tcp_child_ehash_entries is doing[1] - and
>> > >> inter-netns connectivity is explicitly granted by the admin (I guess
>> > >> you will need new transport operations for that)?
>> > >>
>> > >> /P
>> > >>
>> > >> [1] tcp allows using per-netns established socket lookup tables - as
>> > >> opposed to the default global lookup table (even if match always takes
>> > >> in account the netns obviously). The mentioned sysctl specify such
>> > >> configuration for the children namespaces, if any.
>> > >
>> > > I'll save this discussion if the above doesn't resolve your concerns.
>> > I still have some concern WRT the dynamic mode change after netns
>> > creation. I fear some 'unsolvable' (or very hard to solve) race I can't
>> > see now. A tcp_child_ehash_entries-like model will avoid completely the
>> > issue, but I understand it would be a significant change over the
>> > current status.
>> >
>> > "Luckily" the merge window is on us and we have some time to discuss. Do
>> > you have a specific use-case for the ability to change the netns 
>> > mode
>> > after creation?
>> >
>> > /P
>>
>> I don't think there is a hard requirement that the mode be change-able
>> after creation. Though I'd love to avoid such a big change... or at
>> least leave unchanged as much of what we've already reviewed as
>> possible.
>>
>> In the scheme of defining the mode at creation and following the
>> tcp_child_ehash_entries-ish model, what I'm imagining is:
>> - /proc/sys/net/vsock/child_ns_mode can be set to "local" or "global"
>> - /proc/sys/net/vsock/child_ns_mode is not immutable, can change any
>>   number of times
>>
>> - when a netns is created, the new netns mode is inherited from
>>   child_ns_mode, being assigned using something like:
>>
>> 	  net->vsock.ns_mode =
>> 		get_net_ns_by_pid(current->pid)->child_ns_mode
>>
>> - /proc/sys/net/vsock/ns_mode queries the current mode, returning
>>   "local" or "global", returning value of net->vsock.ns_mode
>> - /proc/sys/net/vsock/ns_mode and net->vsock.ns_mode are immutable and
>>   reject writes
>>
>> Does that align with what you have in mind?
>
>Hey Paolo, I just wanted to sync up on this one. Does the above align
>with what you envision?

Hi Bobby, AFAIK Paolo was at LPC, so there could be some delay.

FYI I'll be off from Dec 25 to Jan 6, so if we want to do an RFC in the
middle, I'll do my best to take a look before my time off.

Thanks,
Stefano


