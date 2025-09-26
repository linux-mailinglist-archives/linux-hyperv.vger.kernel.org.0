Return-Path: <linux-hyperv+bounces-6999-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B78B1BA4B9A
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Sep 2025 18:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B8C740106
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Sep 2025 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF66309DC5;
	Fri, 26 Sep 2025 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmiiRzsj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E0E3081A6
	for <linux-hyperv@vger.kernel.org>; Fri, 26 Sep 2025 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905796; cv=none; b=dwjoO3wHol9VrwZqjha859vvO3Qf+ufIgXF7IHpP5WvPrHJLQevEl9qc9DxXjxMop095VEDeSXjoravg0reuF9BYjUhHwTIapAuAU5EVargIcuVQFFvAeE5x+Zz+Tcf/yPx+XYlzePldVPRSzckkC8Bw+yUGLwzfJuo7KU7hS2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905796; c=relaxed/simple;
	bh=pXbsgR7Ss1aZW3LlfLUf8FaVnZ9Gf2yLcMLB47EnsOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAmTHBbiSP0LLomAc4TZKBeLWBlRBmvoUuSln1bkLLy85C5og6NnuDxjjkqULadXux80VOF6Art3mQdgpQCd5myrD/trG2RjEhVY5MDxlqtzH3XjEhK4GY78N9/9OaNhF/62rNOaSB5w8wI4JYBvf7Rp2f1mrVupB099Il9zDOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JmiiRzsj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758905794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pXbsgR7Ss1aZW3LlfLUf8FaVnZ9Gf2yLcMLB47EnsOc=;
	b=JmiiRzsjY2PNJPRkB27SfeHXtbu+E/gvLCg3m1QVrEmxvvRUgC1t2fpKZJVpgtqKHiwCEt
	FeS9qLedLEODoPXK29ifE89t2uN4rq/yyjPaVJ2fs9l9f+xXkCfelxZueq6f89D39lY0Xr
	BOPENKKeeD7QOYEw5HKzBMbssm+E6Lg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-OpOTeFkuPTGtXggk4MmPeQ-1; Fri, 26 Sep 2025 12:56:31 -0400
X-MC-Unique: OpOTeFkuPTGtXggk4MmPeQ-1
X-Mimecast-MFC-AGG-ID: OpOTeFkuPTGtXggk4MmPeQ_1758905791
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32e09eaf85dso3038226a91.1
        for <linux-hyperv@vger.kernel.org>; Fri, 26 Sep 2025 09:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758905791; x=1759510591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXbsgR7Ss1aZW3LlfLUf8FaVnZ9Gf2yLcMLB47EnsOc=;
        b=RDb8Z2MEA7PYq6GM3kzql9TUFb8hZipzSxdRC1lbfK67Gzkm8jjpapnKMYAg2jiK6R
         ppxwg3CnYipFL78ti4V3/sbFeHoztBlGGB/houT+kgz1fZYkcKkj3OCH0TVEt+kw6MGX
         /fmZAmu7RLMCArr3sndqdOpQEmvdoZ154KhG1aE9kmxNpSqyCjuziQbHGMJRm6MZxWXA
         9puusJQrFdOveok/U2vxjQbPZsFpJ1qbi+4cVJNUqL3Wrxw2zSXt3NQuTEPUAsahnPj8
         FhrCPkbFIY0aPhxFUC6+tOMG4b5lGcdA6l0bFDwQoAe6IhT5QYHjcWay/dDnVlov52RQ
         QKYw==
X-Forwarded-Encrypted: i=1; AJvYcCVZz9OJM/pto1e3pVMq3/pHF4eS1A+TnsAa6VHmuNHztAHI9cBZwiqXIHd+0y+CT90qBP7ddOAPMo2qG9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdcU+sDpGWwE1ccFRcPM9ZzIUlsn4wOynPqEqfd6jgVOLn33p4
	vSxp19XLOqNArTMIaFgerG6RC9zz2Bul/9FjuWBBloJkUO/hCsC6jGmXcKEL/SQdYjHXM1Regqr
	oqfkSi4IBEb97cgngclAnpC1QOuQXkZAho8b9JjrH4PNvyqCxzF5XnGxb03G+Siz+Xif0M0wRR9
	Lt/9N3QjTE0lhzPwTiWayfX14Fo9i3YlHyotMDkHg2
X-Gm-Gg: ASbGnctWuFy/cbJ5mPE/O5RtFn8CELq4RJ9nZ49cYTKr6QKsGoX7cFt20vogR2duKUJ
	aOiE/av2ppNL4+Kv51xdKm2VVOp9pbeNXoy5yVtOYYUNll4PzRqyfUNDt8Eitin43/AG0Pm4KsD
	ad9sbwtjmDdaxwXBgt
X-Received: by 2002:a17:90b:1c8e:b0:330:6d2f:1b5d with SMTP id 98e67ed59e1d1-3342a2e3a0amr9010743a91.26.1758905790857;
        Fri, 26 Sep 2025 09:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe/T2nb02ygPzWQlJc91OzCWfWy7tzKbeCqK0AzZtfTw4rJhgRJgzOCPPd+wuatdh/bS3alm4U9h9urtacQQ4=
X-Received: by 2002:a17:90b:1c8e:b0:330:6d2f:1b5d with SMTP id
 98e67ed59e1d1-3342a2e3a0amr9010727a91.26.1758905790446; Fri, 26 Sep 2025
 09:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com> <wcts7brlugr337mcdfbrz5vkhvjikcaql3pdzgke5ahuuut37v@mgcqyo2umu7w>
In-Reply-To: <wcts7brlugr337mcdfbrz5vkhvjikcaql3pdzgke5ahuuut37v@mgcqyo2umu7w>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 26 Sep 2025 18:56:19 +0200
X-Gm-Features: AS18NWDruDib3lxkmBnMwisbhI6jtN_YtNKGNRjNW1-ckH59RRm0Bu1PSqLse0I
Message-ID: <CAGxU2F6pZ7Bp53M3fTpSGDQYnrfxrttQc5bDmQLQX0cseW2A_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/9] vsock: add namespace support to vhost-vsock
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 15:53, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Hi Bobby,
>
> On Tue, Sep 16, 2025 at 04:43:44PM -0700, Bobby Eshleman wrote:
> >This series adds namespace support to vhost-vsock and loopback. It does
> >not add namespaces to any of the other guest transports (virtio-vsock,
> >hyperv, or vmci).
>
> Thanks for this new series and the patience!
> I've been a bit messed up after KVM Forum between personal stuff and
> other things. I'm starting to review and test today, so between this
> afternoon and Monday I hope to send you all my comments.

Okay, I reviewed most of them (I'll do the selftest patches on Monday)
and I think we are near :-)

Just a general suggestion, please spend more time on commit description.
All of them should explain better the reasoning behind. This it will
simplify the review, but also future debug.

Thanks and have a nice weekend!
Stefano


