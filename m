Return-Path: <linux-hyperv+bounces-8212-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B3FD0E1B6
	for <lists+linux-hyperv@lfdr.de>; Sun, 11 Jan 2026 07:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DEC930089B5
	for <lists+linux-hyperv@lfdr.de>; Sun, 11 Jan 2026 06:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDB7239E79;
	Sun, 11 Jan 2026 06:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqtMKNLL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g24Dq8GI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768751F30A4
	for <linux-hyperv@vger.kernel.org>; Sun, 11 Jan 2026 06:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768113827; cv=none; b=NfDwsvIhdZTZyX+aYgef3j+H/xp8Jndg8f0Jz6L/JwC14aEHOcB5t0Hvhdlz/Jpl++Emp7FGK/P835Cqlamh+wVSPbuhzDzqSiCFX/W5tXZCg2HuvYnGeC29BswvurAnAGLAVNKIY+xtLt5+OjAcYC6V/iYrcXXUZQ1pPbv5qHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768113827; c=relaxed/simple;
	bh=JD9UEMV2ESqXFzdZlTaAIe3B3dw0Y3l06h1cl/AHTH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJTN7XosJOGKbjndvKM7hdahAuN6IA6MH+DrzvF7ar6OiCdxek97sTRLckSZhBiE+lF959MXK2xyOSnEpal79QKDVFrNxo809TIvDnKJFhhqyEfBn7sdP7vRHstHFDFU2I5mNtOyxqEUyZeOSBTrxU/tipw/B73k1NWlFrK7H0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqtMKNLL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g24Dq8GI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768113824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A6/EDkpRsLZ7JjY4jSYMGAe1PlTU/1r9sRvOnftJVsA=;
	b=dqtMKNLLwsWFQizCwj45yG6XwFqYeIc6hV2QY8Mhf8RHuxcM6N06xNgN7m9gevW8m3TuE/
	SK5iHtBVnCfDGhvhhXfi/yQ/Z4Ut9ItwajKp9x+QliLhbKKN6pGPK8a7SJ6ajSmcHRlaoJ
	zxWbCRrjyTX8vpi5W1ySpNRIY+XKwXA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-3R2rf7XqONKre32W_Zq-iQ-1; Sun, 11 Jan 2026 01:43:43 -0500
X-MC-Unique: 3R2rf7XqONKre32W_Zq-iQ-1
X-Mimecast-MFC-AGG-ID: 3R2rf7XqONKre32W_Zq-iQ_1768113822
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso64724495e9.2
        for <linux-hyperv@vger.kernel.org>; Sat, 10 Jan 2026 22:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768113822; x=1768718622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A6/EDkpRsLZ7JjY4jSYMGAe1PlTU/1r9sRvOnftJVsA=;
        b=g24Dq8GIUvts4DaC5ph6QFJy/aBstxBJB+Nvd9BT6OY2C5pYYDJ/hNV30FZ9stNLcx
         ATuC8RKgwwQBxiR4f/8wsYWvZ9WE/jR0ksPQ82Qx8p9etROqBDv8IcMUXNkfxirNUMZb
         LIWOSDgMYxgdqZFXlgRzr9qT+Ou/Twwlkz9EtH3Wfutw+Vz+hChXMqayRYtn+h9Eo0eq
         zZBC3I6MPUcg498CxN3EqRysj51y4mE7eboib8NKj2zZelgUwJzl/4YK6EuQkMv2JIoV
         ggfs8jrGy2f3WcIX1i+aMsF87N0iVLhUjfxGqPgsEprXxd80fz5K8jNXnEHGzp2f0s1E
         bGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768113822; x=1768718622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6/EDkpRsLZ7JjY4jSYMGAe1PlTU/1r9sRvOnftJVsA=;
        b=NchlLvPAjN4fZXKyzp+RiFEbdukiXUS/6K4XZddSyadVY9L4lQ3K1c6yTPhAyHmzlq
         BeV+A9dOkq+ceydV65EGk0hUyb+lsE4J7F5Bql6fUztMB7BX4BJaYVF2Z8QYXakU4sk9
         MwHHAq9Hz2s68KM4uzF4BaT/zQf+xKexpxI6sbUP0stlgpKLouLxSg9JK7KByEAOCIwH
         10F/3SzOAfMz7/ytNhsMcwTshha2ZKLhVjamD25aaDuosNKum+6aFQ0D7Opf+epe+ruJ
         4jQrECNwFKgleskktyA949L5iVeUkYn/SN/QfuzbqFQegoZnaE8RsLVJ9AEckLf2I2Tn
         4skg==
X-Forwarded-Encrypted: i=1; AJvYcCUbqtQhNJ4PZLSpxRyQskhIkXp90P8f5YdXBM2CAZeSL7NslG8RvhbQ0dAJ6AAYxFavHmuxqedC954hnCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2PIIIbEnTtjelJLpIsnWamQYW2e9ai5bxU57U7PDDkb3++WRa
	PddOmbUaubTUHcteNdTsQfG8C0jJYJtdR9LYG4+Al1VPiydmoQft9IFA+xO11keG68Bf7jiw7b2
	w253FTI9sZ4ZxAYLJSLaev+6332+515v2sPdHQMNap8uW8d05PyCo02K7fg+6zz1/uQ==
X-Gm-Gg: AY/fxX7ueDPF7DBbpFEE8eG2wdIAtn8cWO8HaTyOMl8SwT5HAmRWvFz2SSgVJm9RTPY
	SBKz/KKZHfhSBW2y2mqEJ52DeR5UnEjVEwPf66sP0GfM5wQo0a3UzVPLF0KhQDY4lneGBfL0w5e
	O80EK7uGX/omb9Kf0NBKnEalWuRBaGPCrBBhuS+FEGiKqnllrd96eDPVNyYoB2xcLIP4HbwPhtE
	kUsDCLsFxnVbZ99Yd/dff/cdAo20xYi2yzbMvKjyVCFZ2h9ySj6ei9VheQr6FQjDYnGJUQBYNW2
	tHAoRzcpP1PmGj1eiQlJ4H7Rfq5UUcxrAQtLWsI0IVszPzuWvC+vjepS2lEFgW34R5YVPQ+0g9a
	0GGVJWnaNa+njU+4MvYwBxGCY7xNmpBs=
X-Received: by 2002:a05:600c:190e:b0:477:9aeb:6a8f with SMTP id 5b1f17b1804b1-47d84b1faffmr173261285e9.9.1768113822029;
        Sat, 10 Jan 2026 22:43:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFprQahh0jRaFJb4VDDWHvHnytv+WdXNUVMhHUBmCAuMZpoJ/VdEFWzP+x0Gcih4TrON/Ayw==
X-Received: by 2002:a05:600c:190e:b0:477:9aeb:6a8f with SMTP id 5b1f17b1804b1-47d84b1faffmr173260995e9.9.1768113821580;
        Sat, 10 Jan 2026 22:43:41 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6ef885sm284657415e9.9.2026.01.10.22.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 22:43:41 -0800 (PST)
Date: Sun, 11 Jan 2026 01:43:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 02/13] vsock: add netns to vsock core
Message-ID: <20260111013536-mutt-send-email-mst@kernel.org>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <20251223-vsock-vmtest-v13-2-9d6db8e7c80b@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223-vsock-vmtest-v13-2-9d6db8e7c80b@meta.com>

On Tue, Dec 23, 2025 at 04:28:36PM -0800, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add netns logic to vsock core. Additionally, modify transport hook
> prototypes to be used by later transport-specific patches (e.g.,
> *_seqpacket_allow()).
> 
> Namespaces are supported primarily by changing socket lookup functions
> (e.g., vsock_find_connected_socket()) to take into account the socket
> namespace and the namespace mode before considering a candidate socket a
> "match".
> 
> This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode to
> report the mode and /proc/sys/net/vsock/child_ns_mode to set the mode
> for new namespaces.
> 
> Add netns functionality (initialization, passing to transports, procfs,
> etc...) to the af_vsock socket layer. Later patches that add netns
> support to transports depend on this patch.
> 
> dgram_allow(), stream_allow(), and seqpacket_allow() callbacks are
> modified to take a vsk in order to perform logic on namespace modes. In
> future patches, the net will also be used for socket
> lookups in these functions.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

...


>  static int __vsock_bind_connectible(struct vsock_sock *vsk,
>  				    struct sockaddr_vm *addr)
>  {
> +	struct net *net = sock_net(sk_vsock(vsk));
>  	static u32 port;
>  	struct sockaddr_vm new_addr;
>


Hmm this static port gives me pause. So some port number info leaks
between namespaces. I am not saying it's a big security issue
and yet ... people expect isolation.


-- 
MST


