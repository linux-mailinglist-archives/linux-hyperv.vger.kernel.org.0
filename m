Return-Path: <linux-hyperv+bounces-10418-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IthJly18GlwXgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10418-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 15:25:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06560485CCC
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 15:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88C93317FF71
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 13:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB72F3F9F42;
	Tue, 28 Apr 2026 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0H/R6oW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="osYpFarW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E602C181
	for <linux-hyperv@vger.kernel.org>; Tue, 28 Apr 2026 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381974; cv=none; b=Jwh/xCbq0KdQAhxBIdBDrXfDovxwQrrfADH8Mex76dmlkb1/lQjcgHeFfqjAhEg9Dz2m2iU8oqbesZJAjdfLuFT4SD3zPYToHdlmiNazH7fmyjLmqHN/LFW2d86tnTCs2iUrayPEm08ECMTbKJppj5p1edI3Ic9gXat2CtDyah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381974; c=relaxed/simple;
	bh=ENP0+US9+uoSMKwsdCFAUa8StYi9uiDiDLxaqDcJiMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tk/XekUKdP6yjb8Lk0WHtZwbsPTckfjzxQXuPMqrzv+Lgk0ihlPcLf7jOIlvNyISxnrDxcf8uwLvH0wk1EYIYtNuNRqTE2ni08NDl8H9Po/KH/frvmdhjdMiPuLZ/4yWhSK4HdVbwH0OTygMMHzch3MFvrZjeMn2Jw2/9BZxFq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0H/R6oW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=osYpFarW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777381972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7GdUrfWfNS9OpD5GGiftL2t6uJKybTSHgDqr3QHoPs=;
	b=Q0H/R6oWqIPkaU2SCF26uJ+379oAiiPXDxlY/edBIdjKy9qYEuO9WLMxRIEE+wgT55vkgV
	WAnPuIYMnDBzCvHfL0KZU5H5qJH5HY5hG7U+bvK3lzqtQzadd+Qir92iAv4ngdD/oO94ES
	yomSyfrTvIl3Nb/zN7AYc8dJrQADIeQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-VMxdPKNNORqMuAjFUfeIUw-1; Tue, 28 Apr 2026 09:12:51 -0400
X-MC-Unique: VMxdPKNNORqMuAjFUfeIUw-1
X-Mimecast-MFC-AGG-ID: VMxdPKNNORqMuAjFUfeIUw_1777381970
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d2cd2674so88917405e9.0
        for <linux-hyperv@vger.kernel.org>; Tue, 28 Apr 2026 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777381970; x=1777986770; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j7GdUrfWfNS9OpD5GGiftL2t6uJKybTSHgDqr3QHoPs=;
        b=osYpFarW/+gzfYCnP1vTXAPp26eIN9gv09kD6jmCwFhEjrdjHL9bDatZ7kgtoBmneE
         i0DCcbUIBnHuIo12V1SPplpe6Z26XvcKYy9SViSMhj+eIp+c4O4anS4lrsKjgrVST1we
         j2XW+fUimi1of09xNwQ6uWS9st5TIvtXiSmEkiDL4Y+RVq1/WyKv3dl4CQh8BF+o61KX
         7zlOlSP5v73kvyoZqsZoMtBkRC5rjFzj3qwEoCSnjm14lST0Lwtmx+CAxi9NlAHEbtBH
         jmQZOWIA9bH9aT7ShbgTGGC1yPY5A4NN831cxIm9RGV4wVhsxZZWvbTz/UpjvkwseQxz
         hMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777381970; x=1777986770;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j7GdUrfWfNS9OpD5GGiftL2t6uJKybTSHgDqr3QHoPs=;
        b=RLrqHLqQNRbsesRY576Wi6GaG3FyIl3CFPyQ1VhhE+93qQm95wKuzpwMzfdR/XzqlB
         vlnTbp2Ljm6ZpYlkC74MX5/MztfMmFnjeL4l+zhv9Kr9KQUgfcvE5tW/TZNMzeuNcRTn
         Eu/frScJIClxaiY1IFdIGN0ZIma3m90I7PO2/+yPJ9hx48gBB4Wx+6PlxzTUKgLC8D3C
         U1b07yynuy9hC62SpymQSQNoiYgWEd8GXiXrhmrTU7MHVOhVcSYjeMH9gW6mHGM4Ioj+
         LrArWw2UAI7SKrSM8J8GhEoR4yIH49s5lHlRrhzIlA+2AeNqti9lCKTBI+W1kCKLC63x
         f3KQ==
X-Forwarded-Encrypted: i=1; AFNElJ9cQHYCmtj1bwHSVxeW+hqAuPsYpBWWAylUV5ZTCKNRHSmjUEwoeGw73g6WIl3ZP8QLH4a4bOyecMnysAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgv1Tn3pXZcbFt0J/s5stDDsL6lhirYGo9XV4hUl1eQpvbz5gU
	uGMH/VwVsBDmwEVv1G9cr2qOs2nn1cpPXcciUJisKa/T8jKxRQp0AHDmgQEje25iWHGMI0n+7Vn
	JZuuHuP9tPLSodkHYF/VOgWFEW2LEFHEWyLN24w/NPs/Ey06uBiWtBjDbrs3dji0blA==
X-Gm-Gg: AeBDiet1piKMjqQzD51cXxtGRZ0SExvkQ+9DqoksbGH/KSBHZnW56MeiBPWD3uxlYd3
	R1WyPmamw+izK7UxQ30kh12+YYhNsiGeMq2xKwci884wUt4qoKily6BS186TBp5wzSi4zyEr1oY
	T4o9ZjcIvm5NSxtgxs60blL9LeblQaBQEXU9J36X66JaNCX9dDZYIJv9cYRHIRLBh6UzrxG8LZF
	6Sh1eLv9aKzhfqMfk+b1KD/8oW9T81f6JIBjt6OypM2/0998jvtE/rjcR/KWjV5tkrCObspuQf+
	UfMNmfki0nCCDdt2nQlG1VZXTx62DaGrn0szJJQ8KzR6Nb0yAdqv8cyZc4ImmTbYmdlSfyyeZYB
	FjmWNdUH1b+eyInbZcH3wFqNsU+dFABWP6ug51J2tYkgk4ZtdRc72Trg7pcc82OLtx3uzIKNc/C
	wPkGy+nA==
X-Received: by 2002:a05:600c:8b57:b0:489:1a65:dd6e with SMTP id 5b1f17b1804b1-48a77aed628mr53248785e9.8.1777381969864;
        Tue, 28 Apr 2026 06:12:49 -0700 (PDT)
X-Received: by 2002:a05:600c:8b57:b0:489:1a65:dd6e with SMTP id 5b1f17b1804b1-48a77aed628mr53248255e9.8.1777381969380;
        Tue, 28 Apr 2026 06:12:49 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d02f270sm6398058f8f.9.2026.04.28.06.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:12:48 -0700 (PDT)
Date: Tue, 28 Apr 2026 15:12:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: netdev@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Michael Kelley <mhklinux@outlook.com>, Himadri Pandya <himadrispandya@gmail.com>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv_sock: fix ARM64 support
Message-ID: <afCxfHKA7hJilGM3@sgarzare-redhat>
References: <20260428125339.13963-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428125339.13963-1-hamzamahfooz@linux.microsoft.com>
X-Rspamd-Queue-Id: 06560485CCC
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
	TAGGED_FROM(0.00)[bounces-10418-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,davemloft.net,google.com,redhat.com,outlook.com,gmail.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

No version number in the subject?

Please next time follow 
https://docs.kernel.org/process/submitting-patches.html#subject-line

   Common tags might include a version descriptor if the multiple 
   versions of the patch have been sent out in response to comments 
   (i.e., “v1, v2, v3”), or “RFC” to indicate a request for comments.

On Tue, Apr 28, 2026 at 08:53:39AM -0400, Hamza Mahfooz wrote:
>VMBUS ring buffers must be page aligned. Therefore, the current value of
>24K presents a challenge on ARM64 kernels (with 64K pages). So, use
>VMBUS_RING_SIZE() to ensure they are always aligned and large enough to
>hold all of the relevant data.
>
>Cc: stable@vger.kernel.org
>Fixes: 77ffe33363c0 ("hv_sock: use HV_HYP_PAGE_SIZE for Hyper-V communication")
>Tested-by: Dexuan Cui <decui@microsoft.com>
>Reviewed-by: Dexuan Cui <decui@microsoft.com>
>Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
>---
> net/vmw_vsock/hyperv_transport.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

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


