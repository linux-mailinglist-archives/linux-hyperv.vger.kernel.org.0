Return-Path: <linux-hyperv+bounces-4670-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C04FA6C3BD
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Mar 2025 20:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F2617A8604
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Mar 2025 19:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32FD230BEF;
	Fri, 21 Mar 2025 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4BoVJ00"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CA21EEA2D
	for <linux-hyperv@vger.kernel.org>; Fri, 21 Mar 2025 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586593; cv=none; b=gfLdUWsqrv/F7zx8g+uAWMF72aOvv4B3oPUEoLC5GTUPSjX5WMHPjaVoXGBXlhEOQktRWTJ0zP/FBiL9nof5TuGtvU8KO/ediQ1kMk8575XYrR5iRxSu3OZNnmgZiJFnNL/WxKR67qPdKbM2E5xG0WuXIMsaxK+qLwtJNG1cmcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586593; c=relaxed/simple;
	bh=UFdqBVJRDVk8Hlcf3jTu50jsbpG+mU166GYiFitWazE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIbVjDFk4bitOHHS4YldPE5Zwtp8ChwGUMfdKhbVMCtpgFnk9jZ+/7y/Gi9b3EDP/8QTln7LkseubXR/olrtVexzQ8d9LkCCrrphTs9FLmBsOu7Uej4mWZae8So1woZWmOUztXCoM87LgH6P+3+I8qFX/rSN+Op/Z2LJvPDTNUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4BoVJ00; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742586589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ReERJAqHieSO06A2On5uvAOfqLYlr/FeJgCmLUNx8kQ=;
	b=O4BoVJ00Fs+0i/3ynJVBoLhMsI11msoBxLm3IbfwjsUTnZtjkOXXutG0ymCJlEFaNRlPcp
	Vv/8FqDoFUOeW+MH90yfyXsnPgwPSt6PixYC38JSNMhq8Dxdfp3IIXTgP2i7kOWlYk1Pic
	yBXOQYJVM+uTM2NrE1heehvz8Txp2zM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130--vHEi3M6OTqeOKFNwr2MTw-1; Fri, 21 Mar 2025 15:49:48 -0400
X-MC-Unique: -vHEi3M6OTqeOKFNwr2MTw-1
X-Mimecast-MFC-AGG-ID: -vHEi3M6OTqeOKFNwr2MTw_1742586587
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff68033070so3501054a91.2
        for <linux-hyperv@vger.kernel.org>; Fri, 21 Mar 2025 12:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742586587; x=1743191387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReERJAqHieSO06A2On5uvAOfqLYlr/FeJgCmLUNx8kQ=;
        b=bqFaMKBfMCdJlgU88w3b2gXyJaB2A+A3RZ+vmg3lG3nHpL02d+usFcdS3JYTy713Pt
         o/eH/yD2bXrC8GuuP0SgFvduGwe54laTBjmx0cFA7ZiKwv3cPEdWs6wLwgRKFKwZVM3u
         33HT5j+GhfUzwrSLlEX71gYqEjPVGaDGF4lghjw7ByCEgXR80orQBPriw4MgZBlpLAa/
         zO5wCATITUT72N0hAIoq9qA9p2rWKqhgkUleAEwifkcKigKFY+iW9uflYG1fn6nEuNgB
         8sboeYLyIzy1h/7FRdZFXBLY3Y8qm3VIsG6X4FcALFg1hDCBrKejIrA7aa0rJ2UBShCb
         7WVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe4CeP9/OHGAx7t84vBatIBiXdxOcmise6jc/Z18p6/MZNPUThQVfTszYCi8t4ibtqc8LATe4Fb0hEqa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKY3w3xoQIlbuxAzs/lKXW22LZaUjNiq7+x6X8M7vnPkBbtmba
	IqW4HSbAW/PZ2zmx+1K+QiR6oaAFOY1b7Vps1lf8+ycgMU+pxKzxUHzbGPceUA/ktBk3lMI4eAb
	vV08wTjcaW/4i+EVDIN15i/PYYKszF+QpSwXYlLotCH3g9DPMom/+5uXIJPJbYQ==
X-Gm-Gg: ASbGncthx0CbayQbKWTFW/tYUynudt7gBiQgcuEWH9Fd/3uXUVA8GO5dXDlUtYsxsOk
	uNjdBLLnAVL2Hpw7BbzP7Kq6plGStUEo3ULgR2FxE1CvVQjySCwYBPP0S7jrcMSHzqzevW9yVIt
	bK4+UDmoN9FM+2C203sj6YyBE80MCRW8LRlsJS8trwLZ7UDWIvUID4jLb4vpNWoBv+leWY0Gi0H
	gnL0j2bltcow7ysWRorMjNcg+Uqr1J5JCXSLUEEsfcXmKDL7wwogfOPzN3Z83VCY5yNpPp/JIL6
	AmJBrFC1
X-Received: by 2002:a05:6a21:6182:b0:1f5:55b7:1bb4 with SMTP id adf61e73a8af0-1fe42f2ca16mr8343017637.11.1742586586909;
        Fri, 21 Mar 2025 12:49:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgaPER9WdLR23YdQNltOTaAZ+YfxNnRQHaimB6OsbRkGfsA5VnV3pJYV1//O3S4oQcK/34rw==
X-Received: by 2002:a05:6a21:6182:b0:1f5:55b7:1bb4 with SMTP id adf61e73a8af0-1fe42f2ca16mr8342982637.11.1742586586558;
        Fri, 21 Mar 2025 12:49:46 -0700 (PDT)
Received: from redhat.com ([195.133.138.172])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2841c02sm1900123a12.39.2025.03.21.12.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:49:46 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:49:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vsock: add namespace support to vhost-vsock
Message-ID: <20250321154922-mutt-send-email-mst@kernel.org>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>

On Wed, Mar 12, 2025 at 01:59:34PM -0700, Bobby Eshleman wrote:
> Picking up Stefano's v1 [1], this series adds netns support to
> vhost-vsock. Unlike v1, this series does not address guest-to-host (g2h)
> namespaces, defering that for future implementation and discussion.
> 
> Any vsock created with /dev/vhost-vsock is a global vsock, accessible
> from any namespace. Any vsock created with /dev/vhost-vsock-netns is a
> "scoped" vsock, accessible only to sockets in its namespace. If a global
> vsock or scoped vsock share the same CID, the scoped vsock takes
> precedence.
> 
> If a socket in a namespace connects with a global vsock, the CID becomes
> unavailable to any VMM in that namespace when creating new vsocks. If
> disconnected, the CID becomes available again.


yea that's a sane way to do it.
Thanks!

> Testing
> 
> QEMU with /dev/vhost-vsock-netns support:
> 	https://github.com/beshleman/qemu/tree/vsock-netns
> 
> Test: Scoped vsocks isolated by namespace
> 
>   host# ip netns add ns1
>   host# ip netns add ns2
>   host# ip netns exec ns1 \
> 				  qemu-system-x86_64 \
> 					  -m 8G -smp 4 -cpu host -enable-kvm \
> 					  -serial mon:stdio \
> 					  -drive if=virtio,file=${IMAGE1} \
> 					  -device vhost-vsock-pci,netns=on,guest-cid=15
>   host# ip netns exec ns2 \
> 				  qemu-system-x86_64 \
> 					  -m 8G -smp 4 -cpu host -enable-kvm \
> 					  -serial mon:stdio \
> 					  -drive if=virtio,file=${IMAGE2} \
> 					  -device vhost-vsock-pci,netns=on,guest-cid=15
> 
>   host# socat - VSOCK-CONNECT:15:1234
>   2025/03/10 17:09:40 socat[255741] E connect(5, AF=40 cid:15 port:1234, 16): No such device
> 
>   host# echo foobar1 | sudo ip netns exec ns1 socat - VSOCK-CONNECT:15:1234
>   host# echo foobar2 | sudo ip netns exec ns2 socat - VSOCK-CONNECT:15:1234
> 
>   vm1# socat - VSOCK-LISTEN:1234
>   foobar1
>   vm2# socat - VSOCK-LISTEN:1234
>   foobar2
> 
> Test: Global vsocks accessible to any namespace
> 
>   host# qemu-system-x86_64 \
> 	  -m 8G -smp 4 -cpu host -enable-kvm \
> 	  -serial mon:stdio \
> 	  -drive if=virtio,file=${IMAGE2} \
> 	  -device vhost-vsock-pci,guest-cid=15,netns=off
> 
>   host# echo foobar | sudo ip netns exec ns1 socat - VSOCK-CONNECT:15:1234
> 
>   vm# socat - VSOCK-LISTEN:1234
>   foobar
> 
> Test: Connecting to global vsock makes CID unavailble to namespace
> 
>   host# qemu-system-x86_64 \
> 	  -m 8G -smp 4 -cpu host -enable-kvm \
> 	  -serial mon:stdio \
> 	  -drive if=virtio,file=${IMAGE2} \
> 	  -device vhost-vsock-pci,guest-cid=15,netns=off
> 
>   vm# socat - VSOCK-LISTEN:1234
> 
>   host# sudo ip netns exec ns1 socat - VSOCK-CONNECT:15:1234
>   host# ip netns exec ns1 \
> 				  qemu-system-x86_64 \
> 					  -m 8G -smp 4 -cpu host -enable-kvm \
> 					  -serial mon:stdio \
> 					  -drive if=virtio,file=${IMAGE1} \
> 					  -device vhost-vsock-pci,netns=on,guest-cid=15
> 
>   qemu-system-x86_64: -device vhost-vsock-pci,netns=on,guest-cid=15: vhost-vsock: unable to set guest cid: Address already in use
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
> ---
> Changes in v2:
> - only support vhost-vsock namespaces
> - all g2h namespaces retain old behavior, only common API changes
>   impacted by vhost-vsock changes
> - add /dev/vhost-vsock-netns for "opt-in"
> - leave /dev/vhost-vsock to old behavior
> - removed netns module param
> - Link to v1: https://lore.kernel.org/r/20200116172428.311437-1-sgarzare@redhat.com
> 
> Changes in v1:
> - added 'netns' module param to vsock.ko to enable the
>   network namespace support (disabled by default)
> - added 'vsock_net_eq()' to check the "net" assigned to a socket
>   only when 'netns' support is enabled
> - Link to RFC: https://patchwork.ozlabs.org/cover/1202235/
> 
> ---
> Stefano Garzarella (3):
>       vsock: add network namespace support
>       vsock/virtio_transport_common: handle netns of received packets
>       vhost/vsock: use netns of process that opens the vhost-vsock-netns device
> 
>  drivers/vhost/vsock.c                   | 96 +++++++++++++++++++++++++++------
>  include/linux/miscdevice.h              |  1 +
>  include/linux/virtio_vsock.h            |  2 +
>  include/net/af_vsock.h                  | 10 ++--
>  net/vmw_vsock/af_vsock.c                | 85 +++++++++++++++++++++++------
>  net/vmw_vsock/hyperv_transport.c        |  2 +-
>  net/vmw_vsock/virtio_transport.c        |  5 +-
>  net/vmw_vsock/virtio_transport_common.c | 14 ++++-
>  net/vmw_vsock/vmci_transport.c          |  4 +-
>  net/vmw_vsock/vsock_loopback.c          |  4 +-
>  10 files changed, 180 insertions(+), 43 deletions(-)
> ---
> base-commit: 0ea09cbf8350b70ad44d67a1dcb379008a356034
> change-id: 20250312-vsock-netns-45da9424f726
> 
> Best regards,
> -- 
> Bobby Eshleman <bobbyeshleman@gmail.com>


