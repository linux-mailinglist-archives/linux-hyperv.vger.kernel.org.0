Return-Path: <linux-hyperv+bounces-9392-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BWqKylJs2nzUAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9392-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 00:15:53 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FC827B352
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 00:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F07A1304F310
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 23:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1958B1DC198;
	Thu, 12 Mar 2026 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W/09uimW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEA240DFDC;
	Thu, 12 Mar 2026 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773357350; cv=none; b=d9hQ9OXqYSX9MXRU+oU9Z+bAf2AcLJxxk1EGoHi9y3ISLcf75/l+PCiBBSte4G74aoGFkzszzxbHAYEsU2RXsOxuJOqjPTorocG0F8leyWFEJJOKg4bqK3i7AkIB+WSd/cYlpZVQognkNA3NchEkg9Z7TlcQyazHtBUpEefm2fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773357350; c=relaxed/simple;
	bh=p2SRKGVFSyP2Xu+amBX53g78Qjd+fd3UcCdqNkYLdeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fw2dR7PYvFHvjEGSKwZjItyUgjWN+bOXeTumoQ2t/SIS+jBpIL/hZZy8rWEz8JKp8N1jglg5JiQ9o0XXOKW3i9cwvkgu9dTdliGTUORlH7Ttem592mCb10lE/t9LeED7fwKWyHN5MMCA3l8h2jkXswD4r+RyFHvvMOH9EWKMZcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W/09uimW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=LjcR94bmvH2oOH8ZUWLFU9TNRvfPfrpZ+1MwNkcZH5I=; b=W/09uimWlmT/Ysq3jgNMt1gI7H
	GOweGLT/9vNXsJOPg9hm2zWvmdX3q1Mku+Gp0H9Iy01Esb6LQV5ATBVsFtN7xIiUoagCrBlANpDjy
	LFKllY8nRMXqP5YIQU35yhpjR6xLflNsnx64mvIpAEWYWRWDPhCqNZYr0PnzOZoWDQK+FM4dlVpqj
	nTXMWJe8aCw5gHcb65NFh+tuJVdjDY9IaRhmpRA+PnQPWNf8cS/Xo1D5AhzPt2W5l4FH91HqP8G0U
	kPRc+Y45RDEk4AoFzuVcdgRIIbo7k6atO+7RsPG8yCEeiefwSsO6mHknQo7wHDNJwM391bMo/EMJe
	bffBLL6A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0pFY-0000000FkNf-3iHP;
	Thu, 12 Mar 2026 23:15:28 +0000
Message-ID: <4fd15134-ae1e-4233-8d5a-9d1e0b9f94dc@infradead.org>
Date: Thu, 12 Mar 2026 16:15:26 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] mm: add mmap_action_map_kernel_pages[_full]()
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Clemens Ladisch <clemens@ladisch.de>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bodo Stroesser <bostroesser@gmail.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org,
 linux-staging@lists.linux.dev, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 Ryan Roberts <ryan.roberts@arm.com>
References: <cover.1773346620.git.ljs@kernel.org>
 <21d8899bb1f4db61203072fb3a56a6c98a61e23d.1773346620.git.ljs@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <21d8899bb1f4db61203072fb3a56a6c98a61e23d.1773346620.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9392-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCPT_COUNT_TWELVE(0.00)[45];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Queue-Id: 28FC827B352
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/12/26 1:27 PM, Lorenzo Stoakes (Oracle) wrote:

> Finally, we update the VMA tests accordingly to reflect the changes.

IMO we could omit the word "we" 5 times above.
(but no change is required)

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 88f42faeb377..88ad5649c02d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h

> +/**
> + * range_is_subset - Is the specified inner range a subset of the outer range?
> + * @outer_start: The start of the outer range.
> + * @outer_end: The exclusive end of the outer range.
> + * @inner_start: The start of the inner range.
> + * @inner_end: The exclusive end of the inner range.
> + *
> + * Returns %true if [inner_start, inner_end) is a subset of [outer_start,

    * Returns:
(for kernel-doc)

> + * outer_end), otherwise %false.
> + */
> +static inline bool range_is_subset(unsigned long outer_start,
> +				   unsigned long outer_end,
> +				   unsigned long inner_start,
> +				   unsigned long inner_end)
> +{
> +	return outer_start <= inner_start && inner_end <= outer_end;
> +}
> +
> +/**
> + * range_in_vma - is the specified [@start, @end) range a subset of the VMA?
> + * @vma: The VMA against which we want to check [@start, @end).
> + * @start: The start of the range we wish to check.
> + * @end: The exclusive end of the range we wish to check.
> + *
> + * Returns %true if [@start, @end) is a subset of [@vma->vm_start,

    * Returns:

> + * @vma->vm_end), %false otherwise.
> + */
>  static inline bool range_in_vma(const struct vm_area_struct *vma,
>  				unsigned long start, unsigned long end)
>  {
> -	return (vma && vma->vm_start <= start && end <= vma->vm_end);
> +	if (!vma)
> +		return false;
> +
> +	return range_is_subset(vma->vm_start, vma->vm_end, start, end);
> +}
> +
> +/**
> + * range_in_vma_desc - is the specified [@start, @end) range a subset of the VMA
> + * described by @desc, a VMA descriptor?
> + * @desc: The VMA descriptor against which we want to check [@start, @end).
> + * @start: The start of the range we wish to check.
> + * @end: The exclusive end of the range we wish to check.
> + *
> + * Returns %true if [@start, @end) is a subset of [@desc->start, @desc->end),

    * Returns:

> + * %false otherwise.
> + */
> +static inline bool range_in_vma_desc(const struct vm_area_desc *desc,
> +				     unsigned long start, unsigned long end)
> +{
> +	if (!desc)
> +		return false;
> +
> +	return range_is_subset(desc->start, desc->end, start, end);
>  }

-- 
~Randy


