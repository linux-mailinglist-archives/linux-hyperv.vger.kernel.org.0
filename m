Return-Path: <linux-hyperv+bounces-11902-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +ND4KnseUWpk/gIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11902-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 18:31:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1243773C998
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 18:31:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=C9B0DUBQ;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11902-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11902-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31193300B604
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD4843711B;
	Fri, 10 Jul 2026 16:31:42 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AE6363C5B
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 16:31:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701102; cv=none; b=jq4dmWO0aUq1BLrpTpeFw+C+DVrvGz0/7jS5gD2e+Tk0AQhcqMPwDk2nY0ilImaVxOUbTwXgLybnDiTMhAVkfetJKVEhIPCB+U+z7o30QSEaxaDqnGD1Xwq3PT2mF6dgnGLmqPXjCS0rEfvoOSyKMwMtOqzkwkx3qAv8i4WKBi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701102; c=relaxed/simple;
	bh=Sbx8vXWqQQ/M0W9UlsuLQM8Ua5Q1vedFs+JL66TJWSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByIwuXx0jlB2OK1R69A8FlZ8TsfL6E0qRuuwmNqnyNsp58rPK1XJdr2cPlAavXVdOWHpOyNh89k0eHhpdtUoysyoKyFOZQhTyvCBdNJ81V+MAB2mbzJqo+ZM2/8s+deM+koBRp2ijk4SS4AeZNDbdpK6UMiZZyaQQ6bSpY94oqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=C9B0DUBQ; arc=none smtp.client-ip=209.85.219.49
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8fcc43c48f7so8670946d6.2
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783701099; x=1784305899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ihr9TBqVvOWsgDH+NpkUYsK2K2fCkLkiaNuX2IHUYwY=;
        b=C9B0DUBQrFvmPqU9NSXU7hegpl7ojs8/mhmMnr9+I8B5xI9cbJN4vquMR+TKjoSRbe
         hRVqntMatUOMVwQ77aec0J9Doya+aG8IZxs5XirF5Ku3Ah35eFZG0l4ACmfIwbWBJMhX
         oVNossKW2Twv3Vh/obtosrQ/pXr9DDd7KelvhktBuY09jEM5IGYcXMOnzEoGs6Q/7Jdj
         K7AUzEdbaXOvsXR0zmLhfvAaQjl+FLj+w+DzYga35xmOl5qsbr94OSq0jOzS2tfeoYeK
         6EJs8zXW2Mz1qdRSBb4NWbEFf6BK3WwdCTjumyD2SidvzWStaTThJnCiasO0muhiqMZ2
         k0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701099; x=1784305899;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ihr9TBqVvOWsgDH+NpkUYsK2K2fCkLkiaNuX2IHUYwY=;
        b=TtJkFRzXycN4Ei4+Hi/tVd7Uw5QNHkgn8Ndbd6Yxrc6UVf9RLaL+K7TOU1bR1BohbZ
         eVfAWl5t/v1nlbJvtsTUkh1Es7d+arQ1hKyqUUQxjeIUZzAS6jiEE5q4/z+USgaOuRGv
         6/SaIMjKu2wYLCoWb+bOq86KSltbiFvJw3uNRRzfRYEbffImrbM28HQMg2kWn3Y6Ty83
         tHXAQKLPdae2nhw7j02Zpzgb3pCqlVaQzqSvxf+1SOWvRbglIShGwIQOC0CIN+M1Db69
         g7nkg/NzFgUUoaB8ElwUS5GSO5L04a/zy216eDMUrTGMCgRgyyYtSRLv3yfaGcQv/mMM
         XT9g==
X-Forwarded-Encrypted: i=1; AHgh+RqTrQuT/AJpTN4+mqhQd6GEVr9LFTXLhWnq1K1P27k9njIvHfk+kXv1YMYk+tVrnPX/vUSlyxqvo5JrKcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3IzbiHOEQyAf7WnbEUqxfJ4iPPicjyToOAE7X6+XtKTeV8uk
	IZeloq2ocCHJwHgog+OSxhmCBJsjXbSoc6tllPuGSZW4s/hEx7tmGJ+oFinDmfuEriM=
X-Gm-Gg: AfdE7cmgwUi8bKneIGoh7fF6Ct50uWWVRTDmUWLG15NXBJJPtTn8BC83H2EL96PSGOO
	3IfznnRqn6Nh+xol+hTnGIR1DLvQML4lfZ81Id9teUDr7i0OQdlQT6+xQLKCoug1+mGzRJEIknQ
	gfhWG6G2SIMz8k6Ntuo2wUnqDn5bY7KI7Dbsz4zIiHawMw7I6SW8DN1RQvUx1wY9yMh+3yg2d3y
	NAfnUihSIQOEIL+qWYKYPC478drDM+RPMNo6weOClg2Dstqn5i6FKAbczpzi4/vk/KAkYAkU19o
	pgiwDq7La4m/J/QMaHnXMe46Y4S25jY10NcOPoBTPM5+UjSpxmzK/Ks+a6A+12mSCXBjFJ6+JNB
	aIHv4qsy5kZaJlaJkoj0BZkIDlbiaaqfvXaSVeTCYmCMHtZk7lUxI18erVltE9MVM6v/nihk=
X-Received: by 2002:a05:6214:4710:b0:903:12c9:cba6 with SMTP id 6a1803df08f44-90312c9dcb8mr32500716d6.47.1783701099176;
        Fri, 10 Jul 2026 09:31:39 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56c4cd1sm44753226d6.16.2026.07.10.09.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:31:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wiE8X-00000007Xks-3Vyo;
	Fri, 10 Jul 2026 13:31:37 -0300
Date: Fri, 10 Jul 2026 13:31:37 -0300
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
Subject: Re: [PATCH v7 1/8] mm/hmm: move page fault handling out of walk
 callbacks
Message-ID: <20260710163137.GQ118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345361483.660027.16455119612963295072.stgit@skinsburskii>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178345361483.660027.16455119612963295072.stgit@skinsburskii>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:skinsburskii@gmail.com,m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11902-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1243773C998

On Tue, Jul 07, 2026 at 12:46:54PM -0700, Stanislav Kinsburskii wrote:
> hmm_range_fault() currently triggers page faults from inside the page-table
> walk callbacks: hmm_vma_walk_pmd(), hmm_vma_walk_pud(),
> hmm_vma_walk_hugetlb_entry() and the pte-level helper all call
> hmm_vma_fault(), which in turn calls handle_mm_fault() while the walker
> still holds nested locks.  The pte spinlock is dropped explicitly by each
> caller, and the hugetlb path manually drops and retakes
> hugetlb_vma_lock_read around the fault to dodge a deadlock against the walk
> framework's unconditional unlock.
> 
> This layering does not extend cleanly to fault handlers that may release
> mmap_lock (VM_FAULT_RETRY, VM_FAULT_COMPLETED). If the lock is dropped
> while walk_page_range() is mid-traversal, the VMA can be freed before the
> walk framework's matching hugetlb_vma_unlock_read(), turning that unlock
> into a use-after-free.
> 
> Split the responsibilities the way get_user_pages() does. Walk callbacks
> become inspect-only: when they detect a range that needs to be faulted in,
> they record it in struct hmm_vma_walk and return a private sentinel
> (HMM_FAULT_PENDING). The outer loop in hmm_range_fault() then drops out of
> walk_page_range(), invokes a new helper hmm_do_fault() that calls
> handle_mm_fault() with only mmap_lock held, and restarts the walk so the
> now-present entries are collected into hmm_pfns.
> 
> No functional change for existing callers. As a side effect the hugetlb
> callback no longer needs the hugetlb_vma_{un}lock_read dance, and every
> fault-path exit from the callbacks now releases the pte spinlock on a
> single, common path. This refactor is also a precursor for adding an
> unlockable variant of hmm_range_fault() in a follow-up patch.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  mm/hmm.c |  118 +++++++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 75 insertions(+), 43 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

