Return-Path: <linux-hyperv+bounces-11909-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MqbZE8okUWq6/wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11909-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 18:58:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DECEA73CD19
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 18:58:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=pJjUs4fx;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11909-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11909-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C474C3068C66
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 16:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C40A43DA53;
	Fri, 10 Jul 2026 16:47:51 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C766E43D4F4
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 16:47:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702070; cv=none; b=bH+OdlTd2GOvgUuCi88gQUH75dYYKA5awvhN9SYIDa1272ycuddSfPUyBLPoxwYlLYdsp6yQv7IHa4ZVwpucX/qZd2YR5T2t1jwT0905hVCnx87CR31gH0W4jvfV+QRZaEYQ8Lniuz7TLTbD5xMIkrjQiCgrzL//AA4Mf4y5UVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702070; c=relaxed/simple;
	bh=5mY/LNzOoYWIQwJjGaIbGESQyPbUXU5+u9YysOMf/yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMe/TwHdp0ol+jtZsADYrJoRjlvTW7qTdSjG/VufI+Vni8bplzL2RG5NxQ2dgE3v6IcNS+XHqT6zA/1r9jBOtkMJSkCHUKLEVsdntuStEj4LA/ALT+BwfaOj2T02VrkAh21rmllzAL95qzqB7/OBYAuCbV3x6KlmaxywRi5va68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pJjUs4fx; arc=none smtp.client-ip=209.85.222.181
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-922ff615c14so86831085a.3
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783702065; x=1784306865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ldYpDeT5zs3T98XMfsT8ni9uE73SXe2oYxwTATvCf1s=;
        b=pJjUs4fxJRRV4JyKYlLYpWw2bzk38dHrOh6nkT9Fk9sBD5r2HLAYjShp/o6Cg6ZF/q
         Gcp+e2f0MX07bpFIZtTZE3rC/QY83URHHcn/Y7Of2fITSLy3FIy18aw7x1UoV35GELov
         dNC0vVBsROWvwix7FeVYppBiNutBs7LzTTbELawNd6P7ReUVwboVJ66LT1SzaVt3ZDbv
         cwpfjr33yr5c0UpQqB072mC1rty2Ao2KZWj4gV2U8OvZPENCqA2SvCxk2+P4seYkMskX
         N8kFoYFWDXKD+KoWDBl/g/WHzBDxI+NIKG4vTr/cF/0hgOXKAAnzXeMOSvwbBLoVQWwl
         RI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783702065; x=1784306865;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ldYpDeT5zs3T98XMfsT8ni9uE73SXe2oYxwTATvCf1s=;
        b=MYviOe3hbpA3/0IfM+eNUM9vQDyV+LUa1c/I7Mg+myc41cWI28pb1fz55PUi63YVJb
         w1QyyTu8d6WHUMLgX5CiXmkciBGBL1YKhq3iGj2CN5wok+q+wdUGNzYoyjipFs7S2jbk
         NBf4YZQzwzd51pq+vDEP9P2G3XWRO3htOBM8yKGohYeBgs2IJ+AIN5Q00qrDjo1xPMHP
         gGfG+Zw/ddar1Y2AeyoArSTeG5WN4gTBfQmD30HTv7pIuqgNwi7uzsiNIt+xjuS1yDqt
         yZHe45+Nvc8ZU1iwxldsktWdflNdwfoUjS97u8VSgzcbqvIDMsT3Fjkv/SOPFM6VfzGe
         qTAw==
X-Forwarded-Encrypted: i=1; AHgh+RoDlPFfQ9VQwsPy1gfIKzdbXmDX02OeY3EdkqvxY2FxTO0s9vtiGTaDkb+0dmoCZ0fIYT2dhrdIjBCKPjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCY09UUzUy97R09MyKNzH1ETST+8Cdtt5MdTVw9DMR7ZQzjhRj
	nKG8ZwhD28k4eByYpM/haNzHDpCDqalATxEZpUav0Q0EEmLVOKmDsl6TK0cw/gpyNrk=
X-Gm-Gg: AfdE7cmXtBDrjV++s8OjRWh+dDa1zH1LCT8mOHUsOrCskrV50NRD8prF3SDRYEd/tnZ
	NXMWNGZ8/1yWemI+3Nt47wIN5Sy+5duT5f2Tu+v7W+iMhcr8bAJtOU3m08zRlSnUEI8Vwggje8c
	lbX//yI0kjzzlB5NGPdyWxT/PC8CSEpdjVlWAbJj8zgqsX4kLKyUjob+10mvyQshdflU+KjlpKp
	xPkVhtk8QLkOkhoW3JlvszGjf29qk2zacDglQwKEc3Yj3hoYFcez7YXF/EmBgtce0uLN9ql/N4B
	MB+uFu/WJH4jVtv8XEPkUB1nrQqNozowN9sukiBamf7ac4LIuOJe61h85XkusNWgPO/4FF7eQ2o
	gpp0cUQFrUp2/oivoXjJPeY2FE+EXOSFN/uKfpL38cPlswfrNelzcR8XASMmP
X-Received: by 2002:a05:620a:4044:b0:92a:3ceb:9cf1 with SMTP id af79cd13be357-92ecf68b839mr1385461685a.37.1783702065110;
        Fri, 10 Jul 2026 09:47:45 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd5bbac2asm45778726d6.21.2026.07.10.09.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:47:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wiEO7-00000007ZDn-3hnt;
	Fri, 10 Jul 2026 13:47:43 -0300
Date: Fri, 10 Jul 2026 13:47:43 -0300
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
Subject: Re: [PATCH v7 2/8] mm/hmm: add hmm_range_fault_unlocked_timeout()
 for mmap lock-drop support
Message-ID: <20260710164743.GX118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345362182.660027.12809852179204464964.stgit@skinsburskii>
 <20260710162749.GP118978@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710162749.GP118978@ziepe.ca>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:skinsburskii@gmail.com,m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11909-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DECEA73CD19

On Fri, Jul 10, 2026 at 01:27:49PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 07, 2026 at 12:47:01PM -0700, Stanislav Kinsburskii wrote:
> 
> > +int hmm_range_fault_unlocked_timeout(struct hmm_range *range,
> > +				     unsigned long timeout)
> > +{
> > +	struct mm_struct *mm = range->notifier->mm;
> > +	unsigned long deadline = 0;
> > +	int locked, ret;
> > +
> > +	if (timeout)
> > +		deadline = jiffies + timeout;
> > +
> > +	do {
> > +		if (fatal_signal_pending(current))
> > +			return -EINTR;
> > +
> > +		if (timeout && time_after(jiffies, deadline))
> > +			return -EBUSY;
> 
> I really dislike there is a timeout here, HMM is supposed to be more
> deterministic. GUP doesn't have a timeout, what is this about?

It looks like you've moved the timeout processing related to the mmnu
notifier sequence from the callers into this helper. I'm fine with
that, but maybe add some comments that this timeout is helping
implement the mmu notifiers, and we do expect that the HMM part will
not timeout.

Though it is a little hard to see how your stated purpose of enabling
userfaultfd is going to work, aren't you pretty much guarenteed to hit
a timeout if the userfaultfd process is adversly scheduled? That's
going to end up broken.

So, maybe the deadline should be resetting after every handled fault?
ie the timeout really is only about the mmu notifier and we don't
count the time spent handling faults or walking?

Jason

