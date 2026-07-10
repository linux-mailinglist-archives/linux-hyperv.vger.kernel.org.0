Return-Path: <linux-hyperv+bounces-11912-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jwU9KDgnUWp9AAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11912-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 19:09:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5217B73CEC7
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 19:09:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UVe+s+im;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11912-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11912-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8F163000B08
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 17:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C730C43B485;
	Fri, 10 Jul 2026 17:06:49 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F17EEC0
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 17:06:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703209; cv=none; b=DanVcFE1fRUbmeuHkVSzDFWsMe9n9PK3OKs7jaYY6vK9K3xG9Rk9/YepXF0w+4VRS8+pw02nJMau5jkgHsV3HymRYgkYwd3qTTQidBzDnpU9UHHGZmQ9ycveuQ4y6/f9Y44qtKeqt148LCyDMniYj4PGEB992UhVqDREeZMq6WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703209; c=relaxed/simple;
	bh=9lSzgAW8+FmEe+Hp7Rve4vbC7ZImzNSGMC/0E8OnJU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyWcq3Z+5wCMijL3tkanELPmogc1HIUXHRArTdgM1n7mOE5ADqXEbKgLROXrIHxBxAOGLPihZz3DqIAck0EB8mRPxHkWOuSJYxd5giSLACOi8Zwzzf8wphJWVSV0k3l5V9FTT8hOtKpJ0PWPapgVWxGsQDiyV0mDf+H88U+kaho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVe+s+im; arc=none smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8486ac3f347so1591592b3a.1
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 10:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783703207; x=1784308007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SpFBfA7wdgGokfuzCR83lopKSZdMUZgccIdXLTCA/gs=;
        b=UVe+s+imfdj2zLvI6r5wP+Z4/k6qUc5bZgmJ/1j24jXUTjNUo7KCbZe1mKBeoIwdXK
         GVlHfwzz2SjrPsRBD3JLvfw8xU4FJCAHOBRQdi8mPgMzysC5DZdXKWnzxQQUOJdbF08+
         A5K56Vu5SJ8cvJURFUyh3RuxGN8s8GHmKJ+5OfaFWXLJueu3xSB8kRYa72YirkSKoFBo
         jovSI71te5CCZCel7ZKm+LugxzzLMtoJtphYHN6w/22q8BTQQV38nDmifGX2LXp+EY22
         OHzYbEh7a+IoCc5iIuYuo0+QZZ9jUKNB4dlLkQWdI3q2UxjXMR1G+CftIKNd6uJklOxh
         4fVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783703207; x=1784308007;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SpFBfA7wdgGokfuzCR83lopKSZdMUZgccIdXLTCA/gs=;
        b=DpCAgbIPCQ3gRusB67oHuUNWS9KjJdjaasts5caSH5jhoQoNQ8c8S3t4QBMAeeY3Nd
         obpcVyU07BZdJqiiCuFW2COkYC7XSVbxxiVylOydrv4Q4yvrb4m56drda659OG+FR09K
         yo9u/FE0oPQSxLH29/AdPPkX8h++kaBYkoLiq7JL6eSH13czrkU/4oK3qfVj4w2HsZI3
         BBVpNqb0dXjkEBGhg87c/kg2+pRsaX6tYP+1c6He9Q1T1M9+AV65Aup/jraNA1RkFTHU
         85RQIgm8vN4/uWGtYtmH+U9YeqTU/uP2dM8mZTwrcmmRtJ4si9nwa1UA+OJXbzvUoo9E
         mWRQ==
X-Forwarded-Encrypted: i=1; AHgh+RogauucPlISJTcrKTdL7asBIUYvN1u2u2Z4FwJqaW6I22+iZnAOXdEWRZhzYokU83mov6t5q3DyYN2vMus=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWnzsEl5EASuvHJPkCMya6ne3VrJYNGZk1ggd+knxUsq3Tn7+Y
	U4OBKqcvkOo7UUJaO2UH/AgALDrqDv0l52KLSrf4RkKg/nVZCC6X8yrN
X-Gm-Gg: AfdE7clhIGmZ2VdouGy0VbtBWV+C0hMiQ7E0mEJsWEtRGCBK61EQ3NIVj0m8C+DlXRY
	rFINOdKV3csibF/feKVKwZx69IGZy9iC8BSbOUe6GwN2NSatnGHhwpZ4rKH0XR4V5T3Pp9uz0Wd
	ormuGSPECGkwfULu20eXFCY/t8BP/VCBwpFRM1B3wvTOYBoGRFzSNjrmU+leh14lUsoaU0dFxUK
	HE2JXyFaCFdu2bypry8dqlIAkxXTUNm8q+X62/KY6yIH5DabXp0AdXUFnxeqEFLrngJlG0qmggk
	iBK99C3leyIcU+tdfatEupjw0Lt85zhe7BB5b1zPdfaayj6yZsZNxrePHu7KK86UQYoN4yJZYuv
	PzvCZaHBotGrIPnKexYhr5V/ICvfRGNm///PamvPf16sDTqRlPalGjRPFlpAVjpNHX4OuVun19D
	5CzbAjn2eU8i3giZreLnGf0OmG7QqlDlVHV+aOMNBKw92BvYo6NJVXGdk=
X-Received: by 2002:a05:6a20:d494:b0:3c0:9acb:400 with SMTP id adf61e73a8af0-3c0f13a6583mr4025578637.37.1783703207546;
        Fri, 10 Jul 2026 10:06:47 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3a2e42bsm5458929a12.30.2026.07.10.10.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 10:06:46 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:06:44 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <alEmpEv-Q_bQFzNu@skinsburskii>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345362182.660027.12809852179204464964.stgit@skinsburskii>
 <20260710163835.GR118978@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710163835.GR118978@ziepe.ca>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	TAGGED_FROM(0.00)[bounces-11912-lists,linux-hyperv=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,microsoft.com,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de,kvack.org,vger.kernel.org];
	FORGED_SENDER(0.00)[skinsburskii@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5217B73CEC7

On Fri, Jul 10, 2026 at 01:38:35PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 07, 2026 at 12:47:01PM -0700, Stanislav Kinsburskii wrote:
> > hmm_range_fault() requires the caller to hold the mmap read lock for the
> > duration of the call. This is incompatible with mappings whose fault
> > handler may release the mmap lock, notably userfaultfd-managed regions,
> > where handle_mm_fault() can return VM_FAULT_RETRY or VM_FAULT_COMPLETED
> > after dropping the lock. Drivers that need to populate device page tables
> > for such mappings have no way to do so today.
> 
> sashiko could not apply v7 for some reason but the remarks on v6
> seemed meaningful, did you see them were they delt with?
> 

Yes, I dealt with them.

> https://sashiko.dev/#/patchset/178336023903.504354.7500950448226027718.stgit%40skinsburskii
> 
> > diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
> > index 7d61b7a8b65b..70885f153d03 100644
> > --- a/Documentation/mm/hmm.rst
> > +++ b/Documentation/mm/hmm.rst
> > @@ -208,6 +208,69 @@ invalidate() callback. That lock must be held before calling
> >  mmu_interval_read_retry() to avoid any race with a concurrent CPU page table
> >  update.
> >  
> > +Dropping the mmap lock during page faults
> > +=========================================
> > +
> > +Some VMAs have fault handlers that need to release the mmap lock while
> > +servicing a fault (for example, regions managed by ``userfaultfd``).
> > +``hmm_range_fault()`` cannot be used on such mappings because it must hold the
> > +mmap lock for the duration of the call. Drivers that need to support them
> > +should call::
> 
> Given the majority of callers use this API it should probably be the
> focus of the documentation and example, regulate the existing API to a
> 'BTW if you really need the mmap lock, and you really shouldn't, this
> exists too'
> 

Sure, I'll update the doc to reflect it this way.

> > @@ -32,6 +32,7 @@
> >  
> >  struct hmm_vma_walk {
> >  	struct hmm_range	*range;
> > +	int			*locked;
> 
> Let's use bool if you have to respin this
> 

Sure.

> > @@ -651,37 +663,33 @@ static int hmm_do_fault(struct mm_struct *mm,
> >  		fault_flags |= FAULT_FLAG_WRITE;
> >  	}
> >  
> > -	for (; addr < end; addr += PAGE_SIZE)
> > -		if (handle_mm_fault(vma, addr, fault_flags, NULL) &
> > -		    VM_FAULT_ERROR)
> > -			return -EFAULT;
> > +	for (; addr < end; addr += PAGE_SIZE) {
> > +		vm_fault_t ret;
> > +
> > +		ret = handle_mm_fault(vma, addr, fault_flags, NULL);
> > +
> > +		if (ret & (VM_FAULT_COMPLETED | VM_FAULT_RETRY)) {
> > +			*hmm_vma_walk->locked = 0;
> > +			return HMM_FAULT_UNLOCKED;
> > +		}
> > +
> > +		if (ret & VM_FAULT_ERROR) {
> > +			int err = vm_fault_to_errno(ret, 0);
> > +
> > +			if (err)
> > +				return err;
> > +			BUG();
> 
> Linux will be upset if he sees this.  
> 
> if (WARN_ON(!err))
>    err = -EINVAL
> 

It will. I copied it from GUP.
I'll change it the way you propose it.

> > +/**
> > + * hmm_range_fault - try to fault some address in a virtual address range
> > + * @range:	argument structure
> > + *
> > + * Returns 0 on success or one of the following error codes:
> > + *
> > + * -EINVAL:	Invalid arguments or mm or virtual address is in an invalid vma
> > + *		(e.g., device file vma).
> > + * -ENOMEM:	Out of memory.
> > + * -EPERM:	Invalid permission (e.g., asking for write and range is read
> > + *		only).
> > + * -EBUSY:	The range has been invalidated and the caller needs to wait for
> > + *		the invalidation to finish.
> > + * -EFAULT:     A page was requested to be valid and could not be made valid
> > + *              ie it has no backing VMA or it is illegal to access
> > + *
> > + * This is similar to get_user_pages(), except that it can read the page tables
> > + * without mutating them (ie causing faults).
> > + *
> > + * The mmap lock must be held by the caller and will remain held on return.
> > + * For a variant that allows the mmap lock to be dropped during faults (e.g.,
> > + * for userfaultfd support), see hmm_range_fault_unlocked_timeout().
> > + */
> 
> Add a comment discourging anyone from using this function and prefer
> hmm_range_fault_unlocked_timeout()
> 

Will do.

Thanks,
Stanislav

> Other than the concern about the timeout and minor nits this looks
> fine
> 
> Jason

