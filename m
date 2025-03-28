Return-Path: <linux-hyperv+bounces-4722-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C373A74E7A
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Mar 2025 17:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4869B1882719
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Mar 2025 16:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD0C1DA10C;
	Fri, 28 Mar 2025 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9lMybHR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B621D88CA
	for <linux-hyperv@vger.kernel.org>; Fri, 28 Mar 2025 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743178797; cv=none; b=mXST4qk3muaodd+SCi1KnKT1pKViCH7g+0A82OTHxekInTD4eZXjOZWBRxdvxsyjzjTgIwuDnzgfBbzpkuk1exAW1e1FZafPDloJHlvMVA5GNa6hmhMgUchQVnibnYPzvvOKkD1PcXRWvlkObIKjly45Di/ROhQsXwVHyOZvnqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743178797; c=relaxed/simple;
	bh=Whw68NHJ0hBotbZLWHPLaLlBo9SwCWGnXSqmyMoyaU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ff2wP+NqXmWzmZX2ulGw/xEikOAzA9GRKEEzyJ4efrXZATgMzKjFM+/hl07f/+bQe83x0tM2rAcN+AVGNYjf8ImCGsIoy0r8zNjv414LaN8xmJBsrPZv9k0ADdRD7h3BL23AxOkuFBv4wT/plQvOa/bbe7F0eG1VxOd1E1Kytvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T9lMybHR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743178794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1bv4vSlZ+ZgT91/khCHsXspSBzkGUyxwvtb8olODOX8=;
	b=T9lMybHRzD1OqTM5jHrDsY40ZnY8lcUaxGUAUmXTzjl7IBPG9ji5TpC7wHI5tf4fA6hhBc
	vUSkNuX2Mu4Qk4CoDyHZaWmJSwZ4xREc6nOObqoIlU4IHj4JhMclkRmIfNILcBGhD+RusB
	2OtvSAZXloEQEMsCk7awqTXz1bWS+ZU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-GMJ4OxJlMOO4Jq_D-FkL-w-1; Fri, 28 Mar 2025 12:19:53 -0400
X-MC-Unique: GMJ4OxJlMOO4Jq_D-FkL-w-1
X-Mimecast-MFC-AGG-ID: GMJ4OxJlMOO4Jq_D-FkL-w_1743178792
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab68fbe53a4so276910166b.2
        for <linux-hyperv@vger.kernel.org>; Fri, 28 Mar 2025 09:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743178792; x=1743783592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bv4vSlZ+ZgT91/khCHsXspSBzkGUyxwvtb8olODOX8=;
        b=xIDHuzN3SFWdCtmebbl8wd9uq5bmmYTEYzn8BFU9AFObw8/JbO5ppB/DcmIrx28G0D
         VxGnHp7TW+Rd6xMTcooMFzQ1bdyk2rbutDoYX7oFLQt4WGkQ9NSVPVx0SqOr7hcxXnzR
         FQWL16Zb8PjryznCh98AFNZij5KJKjO4ESRlv8spOrnH+fP2+0GcWNq5gKLvDvWZAFXD
         TCKyP72YkKbC1VTJuZtAQjfS+LXqMi2E0tw2WTvBQ2F9VmBefE+6hlBr+TpSmDTppRRC
         1KbMGSNDD8+754Z1sFIoqn90KuSfNplNMxNUBjVgm/L5ebWksFSuUg0WzZ2I8poDp0nG
         O+2g==
X-Forwarded-Encrypted: i=1; AJvYcCUZIIVjvE1EU5skfI6DrZctugLPCHKMUqOS8sR6xOIzN2be2a911MFX23QNBjL0MKTp0+rHWUMAZDHKTs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq1BSP/nyfIjZZvcfr25Arfy/Ofp3sH6EZ/IA1kyn/HOKrOKPu
	xL3u6Tm4Os1//hYBXQ4KNjfO+YCdyoNbr5aicFCw+UEaTz1ZmoDkNMTFp7BfLjNFBDRS7996wP4
	pElFuD2eNyethwdFrtGO3UdJ2KzZSVsMT9bGXayinKktt6pPkCX2/QEmRutnrDQ==
X-Gm-Gg: ASbGncuxHDPIq5zY7sTXFcQsFhvJMpl1jsaxrKmZuaN2LOH0qqesLwdrwCSj66po6cU
	U/6R8VOAfv3UDJ2tHYHr6KGUZj6RafAc7vDUBROVSHClo4z/TegH5IPB+ZCu8qufrnujYhaJTWK
	Fj7P6jqocZo0KsUljBFTvVjHyyeXVRCW1NlK1YImLoXrEKqOYKduNj7BmVUckOzmGYf852zLcqV
	eZhmu1v24e+ozyjR/jClBUsn4fDiDxsKWzTi0hfqhEDrjgwMaAh0oGp25Sv1hpiblpdZs8+wY9M
	mNh9N4+8JUGZGan4IdZ8JBqiW39n++ES2hhWLF4f7Mw7u92VJaiBxRQCTzi3wKUG
X-Received: by 2002:a17:906:f5a4:b0:ac3:b50c:c95b with SMTP id a640c23a62f3a-ac6fb15674amr880699466b.56.1743178791626;
        Fri, 28 Mar 2025 09:19:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOVwDFv2G5whldI68ZF2fstheYGaVbwdj4Strjz0nJgWz5XlzWG1eNLgBEm3hj5FiuUFxS2g==
X-Received: by 2002:a17:906:f5a4:b0:ac3:b50c:c95b with SMTP id a640c23a62f3a-ac6fb15674amr880694966b.56.1743178790938;
        Fri, 28 Mar 2025 09:19:50 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71971b700sm180408966b.181.2025.03.28.09.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 09:19:50 -0700 (PDT)
Date: Fri, 28 Mar 2025 17:19:44 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] vhost/vsock: use netns of process that opens the
 vhost-vsock-netns device
Message-ID: <3qjjlbwyso22n4ziylbeunfwpc7gl3rcin6v5qsr2npjfkbfjh@c745sejq6rig>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-3-84bffa1aa97a@gmail.com>
 <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>
 <nwksousz7f4pkzwefvrpbgmmq6bt5kimv4icdkvm7n2nlom6yu@e62c5gdzmamg>
 <Z9yDIl8taTAmG873@devvm6277.cco0.facebook.com>
 <aqkgzoo2yswmb52x72fwmch2k7qh2vzq42rju7l5puxc775jjj@duqqm4h3rmlh>
 <Z+NGRX7g2CgV9ODM@devvm6277.cco0.facebook.com>
 <apvz23rzbbk3vnxfv6n4qcqmofzhb4llas27ygrrvxcsggavnh@rnxprw7erxs3>
 <Z+bJOsG457Vg/cUu@devvm6277.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z+bJOsG457Vg/cUu@devvm6277.cco0.facebook.com>

On Fri, Mar 28, 2025 at 09:07:22AM -0700, Bobby Eshleman wrote:
>On Thu, Mar 27, 2025 at 10:14:59AM +0100, Stefano Garzarella wrote:
>> On Tue, Mar 25, 2025 at 05:11:49PM -0700, Bobby Eshleman wrote:
>> > On Fri, Mar 21, 2025 at 11:02:34AM +0100, Stefano Garzarella wrote:
>> > > On Thu, Mar 20, 2025 at 02:05:38PM -0700, Bobby Eshleman wrote:
>> > > > On Thu, Mar 20, 2025 at 10:08:02AM +0100, Stefano Garzarella wrote:
>> > > > > On Wed, Mar 19, 2025 at 10:09:44PM +0100, Paolo Abeni wrote:
>> > > > > > On 3/12/25 9:59 PM, Bobby Eshleman wrote:
>> > > > > > > @@ -753,6 +783,8 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
>> > > > > > >  	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>> > > > > > >
>> > > > > > >  	vhost_dev_cleanup(&vsock->dev);
>> > > > > > > +	if (vsock->net)
>> > > > > > > +		put_net(vsock->net);
>> > > > > >
>> > > > > > put_net() is a deprecated API, you should use put_net_track() instead.
>> > > > > >
>> > > > > > >  	kfree(vsock->dev.vqs);
>> > > > > > >  	vhost_vsock_free(vsock);
>> > > > > > >  	return 0;
>> > > > > >
>> > > > > > Also series introducing new features should also include the related
>> > > > > > self-tests.
>> > > > >
>> > > > > Yes, I was thinking about testing as well, but to test this I think we need
>> > > > > to run QEMU with Linux in it, is this feasible in self-tests?
>> > > > >
>> > > > > We should start looking at that, because for now I have my own ansible
>> > > > > script that runs tests (tools/testing/vsock/vsock_test) in nested VMs to
>> > > > > test both host (vhost-vsock) and guest (virtio-vsock).
>> > > > >
>> > > >
>> > > > Maybe as a baseline we could follow the model of
>> > > > tools/testing/selftests/bpf/vmtest.sh and start by reusing your
>> > > > vsock_test parameters from your Ansible script?
>> > >
>> > > Yeah, my playbooks are here:
>> > > https://github.com/stefano-garzarella/ansible-vsock
>> > >
>> > > Note: they are heavily customized on my env, I wrote some notes on how to
>> > > change various wired path.
>> > >
>> > > >
>> > > > I don't mind writing the patches.
>> > >
>> > > That would be great and very much appreciated.
>> > > Maybe you can do it in a separate series and then here add just the
>> > > configuration we need.
>> > >
>> > > Thanks,
>> > > Stefano
>> > >
>> >
>> > Hey Stefano,
>> >
>> > I noticed that bpf/vmtest.sh uses images hosted from libbpf's CI/CD. I
>> > wonder if you have any thoughts on a good repo we may use to pull our
>> > qcow image(s)? Or a preferred way to host some images, if no repo
>> > exists?
>>
>> Good question!
>>
>> I created this group/repo mainily to keep trak of work, not sure if we can
>> reuse: https://gitlab.com/vsock/
>>
>> I can add you there if you need to create new repo, etc.
>>
>> But I'm also open to other solutions.
>>
>
>Sounds good to me. I also was considering using virtme-ng, which would
>avoid the need, at the cost of the dependency. What are your thoughts on
>that route?

I just saw that Paolo had proposed the same, but his response was 
off-list by mistake!

So I would say it is an explorable path. I have no experience with it, 
but it looks like it could do the job!

Thanks,
Stefano


