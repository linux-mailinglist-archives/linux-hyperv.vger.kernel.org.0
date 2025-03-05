Return-Path: <linux-hyperv+bounces-4226-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD51A4F9DC
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 10:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E262188CC31
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 09:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA4E2045AC;
	Wed,  5 Mar 2025 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAa/WpjB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12458204F73
	for <linux-hyperv@vger.kernel.org>; Wed,  5 Mar 2025 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166604; cv=none; b=tWOhuHqeNuWI6nq+FLI5iwlussRsZHlo4JI8rL2J/45tLQ+FFpzgP1aBaYG5mQR2c/RhDX4LJ0dmUOAYFPpz4F3Egm2ACc6NTh7C2oAT5M6n4gqcUbaLH4wfJ2FVPcaGH16aRnw/ahiIswwQTVq7MrYFF4kEuG1meQebnJybv/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166604; c=relaxed/simple;
	bh=+QfPm6bqrG0OcdOxhTC1BYzGGpBGfOp64hZJsZUGa8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqSYzIPCg/i6RP1KBOiXW1fMgTHPdD1ehNGNfbA/bd5PJmajiHFLum5RatPTzMGNGK2yCXI8UX+8NdzRqGK7udOeNkBEKDb7u+RmN7EuO9JeCFuKO6ICD+n9f+xWzaRqcffdZt94ivs0sjwYgYKJFxm3KxZaRUXVoEl3y1Je9uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZAa/WpjB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741166602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Fz/47DT/bcZQibct8BTl8FGEvkFXwI/p/JU2LZO+88=;
	b=ZAa/WpjBYxjPanQUkwF9kma8zizpQ3BauhS5vtElNOmWKWXBX35ac/xkUEgvqA4WLP0dpi
	IBaEtHFdf9FSVDAYDvzOcWfyHCHBRGWdBJ+rjzX1W4KW5fihehlACGTssIYnx3x5Vfbrpp
	2yOzhW2asbKOigtu/jmndhX3Wkcr4Ok=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-UcxpkFhpPsS6T-wF14p_Lg-1; Wed, 05 Mar 2025 04:23:16 -0500
X-MC-Unique: UcxpkFhpPsS6T-wF14p_Lg-1
X-Mimecast-MFC-AGG-ID: UcxpkFhpPsS6T-wF14p_Lg_1741166595
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e550e71d33so3739657a12.1
        for <linux-hyperv@vger.kernel.org>; Wed, 05 Mar 2025 01:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741166595; x=1741771395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Fz/47DT/bcZQibct8BTl8FGEvkFXwI/p/JU2LZO+88=;
        b=Lkhj99+8g2aCOljPN4h1nYzJDe75XJVDRRHaU2PftAVObqDRADP4lSk+tcRlv7hjFV
         Tb8EN0xHZkbhqG3FLIUTNm3BFqs2v/WLCCdL4j0SJyByoih19VwynvXvTPG05JJLhnjI
         5ms+KiW/ImxeCTzzBK1EK6A42kjET191kpcEYY/impozxVpmqQfZjq0ewX5hYPI6PmCm
         90WVFCc6mC55GjT0f+OTSDKlrtwlJ95MYBsE44AMtPbkOBajnUGWGOFBnYzb2GQgqQdB
         nhi8zszVp+caxTVxXHTsZVGp1alAOWWrVZwadHvz6GdIH1D1fLoO1hWqzvGFjJY5Ekf+
         Mk+g==
X-Forwarded-Encrypted: i=1; AJvYcCVUhv9faTo1qMccp0ymXy+tpV1dK6ZaeXWsuh/o0SoA4Z+rzYcUsuvrcCfwRhCVTjfNmEX4XZrGrK8D34Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy499hAMI/a9BHT8ETWWbHwt0/uV/mYhN0Tp6CWea5Os8ILdTTU
	fIrKmj2la7ig9fIszeXXwjdmH26LGmKlAoiahQWUbVY2lAalU3LlwOxrB2T6ZoEwK/bFeC5g0CQ
	IKTxWMub6Fu3tsGCC/tYgf7O90hhUl1jfO74BGuNLSjyLRUbwu2th3K9i51GR8A==
X-Gm-Gg: ASbGnct5W6o3LXjSKHE7XSUfv0a53wXOYncGZ4mMzVnGY+5t2SMK2Zhlo0lZ3KfA2pL
	aU5ZOWyOItAdeHD7NxuLGHB4uPaYr1/YysYna1sM9HWZ3ZcCKu8k7FfiaMMbFHHuegqDWz8uDPA
	Yf7AehaJj1dLC03M7PA6CIywjuPUb/ruZFLS5G9AU7K5I6TRgA3efAajFcK9wE+7ainN8ocwWff
	MT3GyGaLAGbqrX6uRR0CQN+sIGsDkAk2fcDR2vmo2Pbf5rusROqj6pCTTVWm0SHStEuyqtvaXfs
	scW4ISVR+D786tSZQoEXAunm0P0Do9Dw5VGSwZrR9ox8KhQ0u0Q0QfaOU89zkcYL
X-Received: by 2002:a05:6402:5214:b0:5dc:8ed9:6bc3 with SMTP id 4fb4d7f45d1cf-5e59f467cd0mr2334224a12.26.1741166594691;
        Wed, 05 Mar 2025 01:23:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrT/jfbwSVjoA3FYJOR2RrQw1bBL1x20n/7XdsK3C0UVX0BQZe2DpbudtEjt/UHC5wEkkQDw==
X-Received: by 2002:a05:6402:5214:b0:5dc:8ed9:6bc3 with SMTP id 4fb4d7f45d1cf-5e59f467cd0mr2334183a12.26.1741166593907;
        Wed, 05 Mar 2025 01:23:13 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4aa46sm9297702a12.1.2025.03.05.01.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:23:13 -0800 (PST)
Date: Wed, 5 Mar 2025 10:23:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Message-ID: <CAGxU2F5C1kTN+z2XLwATvs9pGq0HAvXhKp6NUULos7O3uarjCA@mail.gmail.com>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200116172428.311437-2-sgarzare@redhat.com>
 <20250305022900-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305022900-mutt-send-email-mst@kernel.org>

On Wed, 5 Mar 2025 at 08:32, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jan 16, 2020 at 06:24:26PM +0100, Stefano Garzarella wrote:
> > This patch adds a check of the "net" assigned to a socket during
> > the vsock_find_bound_socket() and vsock_find_connected_socket()
> > to support network namespace, allowing to share the same address
> > (cid, port) across different network namespaces.
> >
> > This patch adds 'netns' module param to enable this new feature
> > (disabled by default), because it changes vsock's behavior with
> > network namespaces and could break existing applications.
> > G2H transports will use the default network namepsace (init_net).
> > H2G transports can use different network namespace for different
> > VMs.
>
>
> I'm not sure I understand the usecase. Can you explain a bit more,
> please?

It's been five years, but I'm trying!
We are tracking this RFE here [1].

I also add Jakub in the thread with who I discussed last year a possible 
restart of this effort, he could add more use cases.

The problem with vsock, host-side, currently is that if you launch a VM 
with a virtio-vsock device (using vhost) inside a container (e.g., 
Kata), so inside a network namespace, it is reachable from any other 
container, whereas they would like some isolation. Also the CID is 
shared among all, while they would like to reuse the same CID in 
different namespaces.

This has been partially solved with vhost-user-vsock, but it is 
inconvenient to use sometimes because of the hybrid-vsock problem 
(host-side vsock is remapped to AF_UNIX).

Something from the cover letter of the series [2]:

  As we partially discussed in the multi-transport proposal, it could
  be nice to support network namespace in vsock to reach the following
  goals:
  - isolate host applications from guest applications using the same ports
    with CID_ANY
  - assign the same CID of VMs running in different network namespaces
  - partition VMs between VMMs or at finer granularity

Thanks,
Stefano

[1] https://gitlab.com/vsock/vsock/-/issues/2
[2] https://lore.kernel.org/virtualization/20200116172428.311437-1-sgarzare@redhat.com/


