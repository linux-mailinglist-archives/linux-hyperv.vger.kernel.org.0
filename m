Return-Path: <linux-hyperv+bounces-9443-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A8zMfQauGlYZAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9443-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 16:00:04 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A08829BE8C
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 16:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6C4E3004635
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 14:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B943033FB;
	Mon, 16 Mar 2026 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiVlA9K5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19C430148C;
	Mon, 16 Mar 2026 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672885; cv=none; b=DIbCa/Mj1F6wNzlFZCMONcQb7/EiWQPGCDa6YH+CmIpSyOBJ+7Njw8F9496DvrLnTjUtoRusyQ7JdcmkhI15S1ax6safc25kD5mEYei3NNWe4gLmp7Y2WM4VHGXZ5tlQ8NORapl7poX1N76CA8uJ9q5GQR9gVF9smihScgM8aWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672885; c=relaxed/simple;
	bh=151f3cWiR6axiSpyETGy2809glU/p+Thfrb+WhG7his=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRECAOu6SaE0Y2Jfvx/zSMhAr02PoPB72X/wzSvxGDSJzRRAld3y77vzVwLcLeSs4Hy4NXIzEJf5ECfxOb4ydOjiPwY+pfTL98NQF33xMZJT9fZS6c/3Yp7tp4no6KTRPv8HyklkR7iBsoP8KedFOd/jvSTcTste+sFVIPgWfDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiVlA9K5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6787C19421;
	Mon, 16 Mar 2026 14:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773672884;
	bh=151f3cWiR6axiSpyETGy2809glU/p+Thfrb+WhG7his=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IiVlA9K5MR2pm/vVWcjl3jHa1ZLppG/xkVDg4LYhSHBo7tILA3oKU7/VyDtSsg2Kg
	 kQqyeUnfpOlDxu6AfhX2DKeTc56qG3sgVr8cRvArcJDPpB7MtB8+8m/W1CGm4DXnWU
	 /IAV35ajExH6TG7ujNjLHJy8C1NUnuOmNHMTs/CZoSJyL1gIEFWKuYKmUapF57E+52
	 QtJhwAwyYFC0d6NKgO01Zvw7BDFPVjqf+FrFODQ4Cqwr/bAXtOkwM5wsRJqmso1ekz
	 dUhxuwzJMFbfz9arxSyuA8RSwOjRWaOSv5ZVSyJ0pPvwE3EtZ56ZowEAdLjTcvuW1x
	 yQ/B9jgOXn+mA==
Date: Mon, 16 Mar 2026 14:54:33 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Clemens Ladisch <clemens@ladisch.de>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Bodo Stroesser <bostroesser@gmail.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	David Hildenbrand <david@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-staging@lists.linux.dev, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH 15/15] mm: add mmap_action_map_kernel_pages[_full]()
Message-ID: <b9474609-4c7e-4cbe-8e6c-d55baa689430@lucifer.local>
References: <cover.1773346620.git.ljs@kernel.org>
 <21d8899bb1f4db61203072fb3a56a6c98a61e23d.1773346620.git.ljs@kernel.org>
 <4fd15134-ae1e-4233-8d5a-9d1e0b9f94dc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fd15134-ae1e-4233-8d5a-9d1e0b9f94dc@infradead.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9443-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCPT_COUNT_TWELVE(0.00)[45];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lucifer.local:mid]
X-Rspamd-Queue-Id: 2A08829BE8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 04:15:26PM -0700, Randy Dunlap wrote:
>
> On 3/12/26 1:27 PM, Lorenzo Stoakes (Oracle) wrote:
>
> > Finally, we update the VMA tests accordingly to reflect the changes.
>
> IMO we could omit the word "we" 5 times above.
> (but no change is required)
>
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 88f42faeb377..88ad5649c02d 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
>
> > +/**
> > + * range_is_subset - Is the specified inner range a subset of the outer range?
> > + * @outer_start: The start of the outer range.
> > + * @outer_end: The exclusive end of the outer range.
> > + * @inner_start: The start of the inner range.
> > + * @inner_end: The exclusive end of the inner range.
> > + *
> > + * Returns %true if [inner_start, inner_end) is a subset of [outer_start,
>
>     * Returns:
> (for kernel-doc)

Ack

>
> > + * outer_end), otherwise %false.
> > + */
> > +static inline bool range_is_subset(unsigned long outer_start,
> > +				   unsigned long outer_end,
> > +				   unsigned long inner_start,
> > +				   unsigned long inner_end)
> > +{
> > +	return outer_start <= inner_start && inner_end <= outer_end;
> > +}
> > +
> > +/**
> > + * range_in_vma - is the specified [@start, @end) range a subset of the VMA?
> > + * @vma: The VMA against which we want to check [@start, @end).
> > + * @start: The start of the range we wish to check.
> > + * @end: The exclusive end of the range we wish to check.
> > + *
> > + * Returns %true if [@start, @end) is a subset of [@vma->vm_start,
>
>     * Returns:

Ack

>
> > + * @vma->vm_end), %false otherwise.
> > + */
> >  static inline bool range_in_vma(const struct vm_area_struct *vma,
> >  				unsigned long start, unsigned long end)
> >  {
> > -	return (vma && vma->vm_start <= start && end <= vma->vm_end);
> > +	if (!vma)
> > +		return false;
> > +
> > +	return range_is_subset(vma->vm_start, vma->vm_end, start, end);
> > +}
> > +
> > +/**
> > + * range_in_vma_desc - is the specified [@start, @end) range a subset of the VMA
> > + * described by @desc, a VMA descriptor?
> > + * @desc: The VMA descriptor against which we want to check [@start, @end).
> > + * @start: The start of the range we wish to check.
> > + * @end: The exclusive end of the range we wish to check.
> > + *
> > + * Returns %true if [@start, @end) is a subset of [@desc->start, @desc->end),
>
>     * Returns:

Ack, I think in general I've seen (or believe I've seen :) other cases without
the colon, so was kinda imitating, but I may also be imagining that ;)

>
> > + * %false otherwise.
> > + */
> > +static inline bool range_in_vma_desc(const struct vm_area_desc *desc,
> > +				     unsigned long start, unsigned long end)
> > +{
> > +	if (!desc)
> > +		return false;
> > +
> > +	return range_is_subset(desc->start, desc->end, start, end);
> >  }
>
> --
> ~Randy
>

Will also fold these changes into the respin!

Cheers, Lorenzo

