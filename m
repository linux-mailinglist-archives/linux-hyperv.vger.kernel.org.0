Return-Path: <linux-hyperv+bounces-11906-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UMu3JSoiUWoD/wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11906-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 18:47:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ABD73CB01
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 18:47:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=MTVA1wSc;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11906-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11906-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7970C3013883
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 16:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20EF43B3D4;
	Fri, 10 Jul 2026 16:43:15 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21DE43B3EF
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 16:43:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701795; cv=none; b=TO/ciPIUaZDgcWxdAPObWfuB3kEysUdlTlAmUAKrOmFnzp6+kY/2tZ6YwccUIOJjfUCJqBg14UJ8N5LoaZuTYKZ+QN0ytFVrxPhCO95FjNgXz5eqZqaq9gIDy2+kRO6a/8Rpld3Uk229dfw2S1UgJ0wqYKFQVnhwKw0uZChKIvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701795; c=relaxed/simple;
	bh=ZL2zX2D9UZwwCtPCpSQDsF4TpGKLC8vJlz83DhiVqG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isuunAmyjS1UDFRMUVyAuFUbOF5+wzfjgNE66yVUxkMWqq8+H9WmZYlGjNAhVtZDIdPYMRAwLV6FKZt1GfzmGA0y6FeehwpYaUTBLyhDTNeA7kQ1u1aALNXpmMVltQ0jbOjXBjVY/UZEkpFk3K7nyEZ/PQcxR3x5f7HHS8D0Njo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MTVA1wSc; arc=none smtp.client-ip=209.85.219.54
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8efcfdb2b43so7500666d6.3
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783701793; x=1784306593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cCrA5GvcNcomQ8YHAskvpnsx6mUAVwyB/JWdGkfbiJc=;
        b=MTVA1wScQzJ9mlsaDCFYAeIc6xDO4WA4Ha4RmRKgQuysCFeal1CB14Sstfu4qFZ55f
         5cmlur51RFp7E08XP0GP0n+sZtz0fWTWn9KAeT+6cdTgXgk34jVkAL2//BWc+AE0eh/o
         pVATPDZeP9aLep4mUYpOaw5F8BtOjdTkDlFFtCYDYFB30W/Ghd/j3osldimeaWfpiVXF
         eWKYnURUzVLAc1nLwCsM4FJLlramamUsaud7zt/S+jZKmlI4H5rpUl06VdgG6YIGp1PF
         bBsToAihc8O4hRIFyPSAuyBXyTdFTL5VmCtZBBTfB+Qaq1KgIVsfqYJIuAv6sv+JXdkA
         wJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701793; x=1784306593;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cCrA5GvcNcomQ8YHAskvpnsx6mUAVwyB/JWdGkfbiJc=;
        b=Wx0Rnna6PCUoeEWAleXi9t65w7H0gKFuZ+d2CIIXh2nN9OnNwCFDgVbhFKb9p5SjO7
         zMopwzz/0hvl/C6rFFX2zXFg9W0G0VMrAR/TnN4DlEhOsIAUgaRt9VWVJvbir2zcTwob
         zG50o0XrstIxwwuenCyZFLLg6mAyBPw4pKJdFc6d9O9R1i3ejI7Fm9T7qxtGGfnBQYD3
         HmHurnKAtFB8ywV6L+iDgGMbeywDyAjqfhko3RrzrXFz7M1bgJuFKMiESz6DmbvALggB
         rx4gy+OBCognbsVdbFsRskx7jM9aFrMsq/2fcUU8wwkcyeQ77PCfVp2NOiwFn9kAlFRt
         sXog==
X-Forwarded-Encrypted: i=1; AHgh+RpiebSiIuABgraeCmq0VgY+Dl2lr7XKaFyisDBnli3yUazx43HuFoI3H3weRu0LJfwXt4fY4C5cH+/wsmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7rcV+Qks0dw2YZDJyriS8FEYhcpM63ZdatTOoIei3maIUYss+
	4/1v1PlZZEiNrbJfyrxbjwYaphqcsOd2Djklj2p2YSbl6UViTqoip73r0xKsLeB2zkU=
X-Gm-Gg: AfdE7cnPBSgU8DKEpmHWNW8o0oTo8k4qVc9omTLgwZfLSHe47ZpD1FRo8EXNAsZgL1N
	kYIs+6GmDqgoDsw95MiSrlpvl6l4aHF4+q428bsMJ9Pq4K9cbtzAvH1x7IXpgg1a6AgFEJTR0wY
	q/7nG9tswFjpnpPzJVho6Kk1sktfrwBTGHWQp+c+mTUK2rMbbXv2hw9eLrhfKWDDTzWKkqcSCQ+
	noFW01IJir30wWrDdQFkXSFf5JzRvMhESkKUd5zNvIRVj30Y5bIArpvDJvM9G5x0ANc6MH2sJvr
	8NtrGKYQVxADYRhmRRPUd+Rixd9ngCjEhXpogx1Z5oSq/nhiiWPg25QC652T05adMT+4opldasU
	2QgRSHOZ5+XGcs2joOdyG1FIfxY34e1GNoNCuHZLYrzxLvC6dNC6gIl6KqhZQ
X-Received: by 2002:a05:6214:43c8:b0:8f4:4d6:8adb with SMTP id 6a1803df08f44-8fec1d808a6mr146369176d6.22.1783701792723;
        Fri, 10 Jul 2026 09:43:12 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-900a7f8f5d6sm30725036d6.15.2026.07.10.09.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:43:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wiEJj-00000007Yof-1AFg;
	Fri, 10 Jul 2026 13:43:11 -0300
Date: Fri, 10 Jul 2026 13:43:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
	corbet@lwn.net, dakr@kernel.org, david@kernel.org,
	decui@microsoft.com, haiyangz@microsoft.com, kees@kernel.org,
	kys@microsoft.com, leon@kernel.org, liam@infradead.org,
	lizhi.hou@amd.com, ljs@kernel.org, longli@microsoft.com,
	lyude@redhat.com, maarten.lankhorst@linux.intel.com,
	mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
	nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
	rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
	skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
	vbabka@kernel.org, wei.liu@kernel.org,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v7 6/8] RDMA/umem: Use hmm_range_fault_unlocked_timeout()
 for ODP faults
Message-ID: <20260710164311.GU118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345364975.660027.8790629832830633290.stgit@skinsburskii>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178345364975.660027.8790629832830633290.stgit@skinsburskii>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:skinsburskii@gmail.com,m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11906-lists,linux-hyperv=lfdr.de];
	DMARC_NA(0.00)[ziepe.ca];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,microsoft.com,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de,kvack.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15ABD73CB01

On Tue, Jul 07, 2026 at 12:47:29PM -0700, Stanislav Kinsburskii wrote:
> ib_umem_odp_map_dma_and_lock() takes mmap_read_lock() only around
> hmm_range_fault(), then retries -EBUSY until HMM_RANGE_DEFAULT_TIMEOUT
> expires.
> 
> Use hmm_range_fault_unlocked_timeout() instead. The HMM helper now owns
> the mmap lock and refreshes range->notifier_seq for its internal retries.
> ODP keeps using HMM_RANGE_DEFAULT_TIMEOUT for each HMM fault attempt,
> while interval invalidation retries continue to be handled by the existing
> outer loop.
> 
> ODP still validates the interval notifier sequence while holding umem_mutex
> before DMA mapping pages.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  drivers/infiniband/core/umem_odp.c |   18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

