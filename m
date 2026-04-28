Return-Path: <linux-hyperv+bounces-10415-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPkXFjum8GlAWgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10415-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 14:21:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5254484C1D
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 14:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0077B3046983
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 12:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B290C40FDA5;
	Tue, 28 Apr 2026 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MB2bK3Gj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLeopdxU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D172D40FD94
	for <linux-hyperv@vger.kernel.org>; Tue, 28 Apr 2026 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378542; cv=none; b=M3vgEQqVomGQ1h73BZl76FxoSusOeNQQ2qmMjzt6TPW+DOi7AXf2kAtKC92SmGwvCGWOM0xbddF7atHXEQiiQIS+eAob1/C+EPdXgRNxcMiTPl9GH+AR3OHQl5ClXQ5cOZsAuCnYA7buC8VFTIiSTc9FZoqUC4/t+87C/vB0+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378542; c=relaxed/simple;
	bh=s59HQ/z0DRUQxzWAOS9RZKTQ0TksCpF9LL3RKo4XTR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAN4514sJayZg8Ho3blldMy+jes1R1tZYIEXGvK+sbiHOveEx8Clb832Heg9KJQsrjG3JiEAvkSi6uP1gECsI1IYxKoFWlHGVve8hBJb1uhVCpT1FUKUy+btYL2iGSD5Ga8yI0tG5MPTn3tGbfU4XLmp2ZK9MSR1mZo0qPhYmh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MB2bK3Gj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLeopdxU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777378536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tK5HQfADPaU9p5E+7yAgbo7JP8UVnZzs4QHnbuo5QyI=;
	b=MB2bK3GjFtxL1pdvdvlw/xFUPrvqZwi2rPSkNqIF+jCqv98FFNJKr6vWEMdnUCpx1Tkjcs
	ewFyz7hCJgetsiYiyG9gvI0fwp07Sgf2CJBa/CO538TanwjUz8mwJ23D5ime6Pjiy/g1yK
	prVn0n5ekcQF9Fbqe+v6B1BwbQd5KPs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-nRFYgay2NFqC_NGBQAGaOg-1; Tue, 28 Apr 2026 08:15:35 -0400
X-MC-Unique: nRFYgay2NFqC_NGBQAGaOg-1
X-Mimecast-MFC-AGG-ID: nRFYgay2NFqC_NGBQAGaOg_1777378534
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488f973ddfeso83957065e9.3
        for <linux-hyperv@vger.kernel.org>; Tue, 28 Apr 2026 05:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777378534; x=1777983334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tK5HQfADPaU9p5E+7yAgbo7JP8UVnZzs4QHnbuo5QyI=;
        b=GLeopdxUQP8kG6kg2TMDGdLSiZmJWQc3gKk0HMlMceC2zjxyQjpu5JL6xXp4A1PJF/
         LRyOZiZu5/FFkCQD/QQQl4XIia7LQewUxwErFOeUHXI8AKMQA62jXrbGKsI2xGaiUK31
         ip3xwqjDYSg51O5xrWM59ChvrM81XxBYt5H2Tl5ZWj97ZZIOK/zmm1aQsBS819dfM7Fg
         YeYJbO3AL36NgAugH/gw+H4sE2XcUBC09CuvNXt/MWwRbilCCMQ8XwWxjxG5XShwRbem
         f2uPar3YK960GOXbosZM1+mP7HL6Y2xap5xtZ+oxreYCQEhFU0DNi7m0oXax6zpdnnOY
         fEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777378534; x=1777983334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tK5HQfADPaU9p5E+7yAgbo7JP8UVnZzs4QHnbuo5QyI=;
        b=LHJOats2dX0iOWBRe4PhD0K+z6l0SriKnrL6MF4sNUkEmsbtB367++42eu2fxFsxSs
         dKfwHx4l+3ACc26WZkprGuOvR+Xoz6bAHeWKftlusi/c+7eE4NAQluDCZMxq3pSqF5Bl
         5riiH1LkI98Cq+BrWo2te6kXGMynrWVIfm+oOIV0K6OKZIYfGUPVUW1N5byEjQZKE3Og
         gcyNGd7SsT3pMV0fEYr+pBf7llVdEP6HsCvAhVwWFYNp3xuxVElu4Khq0c09pzAofUHY
         qEmQqJNxtep45KW9RswjRogKYk5oM9G3+ZGkIrQf3SjTPOVU8j196mOQykEATvg2jQ4v
         m/jg==
X-Forwarded-Encrypted: i=1; AFNElJ8849mJXHyZY9fHSCMX+oV1FgY02XpdI2M7mvCkPqcEGmhqJCCXdDkIdBmZxXcAg039jlX4IfcV5TeXe6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyncYqK151LAUKW3+4IFbMvuocNq1ehQYVzWPW91aguoRdsbeBW
	w3Ls9TpIXtbieyFPGTZ5JmUBSi9jWwCNuzZsOMdseSbPIWrau99Fyn4z0ftHkF4fk/XTElK+hdF
	+9ZvtV1NvZamMFKsxL3Is/FeAt3F7NtHXokOJvK/CNI4J+FPLC07of+Ms2iXZwO1BQQ==
X-Gm-Gg: AeBDievIAVCkp+LnM2Ymb208gyOc8qRnA0OcHQg3lO9QTSmtQghlIxSVrj/r0mEwTB2
	qwQuW+sd5BAged3e3gh6VF+OnRO37OSrZu0IstJ0Tw+mZbKTtZveUy0aUuLnk0InkukYkeBnYBP
	Hzc3yE2lMxpQKiqexCfh+lgl8Ab2Tvo5KdiSGMgpWFbi/wBnHPiBkSAoA5l2GMB4ZRkrd2VySrR
	BeTvdX8FxeXbgZPC7KYpl8m0UMOcrSRTcNefS2EQqyob/P/nVYkANbZCUTz78R4qaRxXintXoJ7
	l9BYQDQiz01TXelUMrtmedLg7w2PTqDtz6gNx0c5f54nZ2PiAz9eUHEgMD/lGn2+KqEO4BvYRC6
	h0foG5T84ei7qgDnwcUZoX6uNoG1Ng1k4Kj+GuEA2yuacDrKdXc0MhPDfkuSexomDctaQucY4Jv
	BAdTv+BA==
X-Received: by 2002:a05:600c:83c3:b0:489:1ff5:edda with SMTP id 5b1f17b1804b1-48a77aee45amr48089585e9.6.1777378533931;
        Tue, 28 Apr 2026 05:15:33 -0700 (PDT)
X-Received: by 2002:a05:600c:83c3:b0:489:1ff5:edda with SMTP id 5b1f17b1804b1-48a77aee45amr48088625e9.6.1777378533314;
        Tue, 28 Apr 2026 05:15:33 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773a87bfsm64239235e9.2.2026.04.28.05.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:15:32 -0700 (PDT)
Date: Tue, 28 Apr 2026 14:15:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: netdev@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Michael Kelley <mhklinux@outlook.com>, Himadri Pandya <himadrispandya@gmail.com>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@kernel.vger.org
Subject: Re: [PATCH] hv_sock: fix ARM64 support
Message-ID: <afCjpGa4Xm4hIPj6@sgarzare-redhat>
References: <20260428110530.1717647-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260428110530.1717647-1-hamzamahfooz@linux.microsoft.com>
X-Rspamd-Queue-Id: D5254484C1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10415-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,davemloft.net,google.com,redhat.com,outlook.com,gmail.com,lists.linux.dev,kernel.vger.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.org:email]

On Tue, Apr 28, 2026 at 07:05:30AM -0400, Hamza Mahfooz wrote:
>VMBUS ring buffers must be page aligned. Therefore, the current value of
>24K presents a challenge on ARM64 kernels (with 64K pages). So, use
>VMBUS_RING_SIZE() to ensure they are always aligned and large enough to
>hold all of the relevant data.
>
>Cc: stable@kernel.vger.org

mmm, this is the first time I've seen this address used for stable. Even 
after searching in the log, I don't see anyone else who's used it.
Where did you get it from?

 From Documentation/process/stable-kernel-rules.rst :

   To have a patch you submit for mainline inclusion later automatically 
   picked up for stable trees, add this tag in the sign-off area::

     Cc: stable@vger.kernel.org


The patch LGTM.

Thanks,
Stefano

>Fixes: 77ffe33363c0 ("hv_sock: use HV_HYP_PAGE_SIZE for Hyper-V communication")
>Tested-by: Dexuan Cui <decui@microsoft.com>
>Reviewed-by: Dexuan Cui <decui@microsoft.com>
>Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
>---
> net/vmw_vsock/hyperv_transport.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 069386a74557..40f09b23efa3 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -375,10 +375,10 @@ static void hvs_open_connection(struct vmbus_channel *chan)
> 	} else {
> 		sndbuf = max_t(int, sk->sk_sndbuf, RINGBUFFER_HVS_SND_SIZE);
> 		sndbuf = min_t(int, sndbuf, RINGBUFFER_HVS_MAX_SIZE);
>-		sndbuf = ALIGN(sndbuf, HV_HYP_PAGE_SIZE);
>+		sndbuf = VMBUS_RING_SIZE(sndbuf);
> 		rcvbuf = max_t(int, sk->sk_rcvbuf, RINGBUFFER_HVS_RCV_SIZE);
> 		rcvbuf = min_t(int, rcvbuf, RINGBUFFER_HVS_MAX_SIZE);
>-		rcvbuf = ALIGN(rcvbuf, HV_HYP_PAGE_SIZE);
>+		rcvbuf = VMBUS_RING_SIZE(rcvbuf);
> 	}
>
> 	chan->max_pkt_size = HVS_MAX_PKT_SIZE;
>-- 
>2.54.0
>


