Return-Path: <linux-hyperv+bounces-9644-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKR5F0u3vWkqAwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9644-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 22:08:27 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B80B82E11B1
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 22:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B54433047527
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 21:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016CF367F2A;
	Fri, 20 Mar 2026 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qC8HBmDJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15502E6CA6;
	Fri, 20 Mar 2026 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774040903; cv=none; b=MWqzcwCdDjslScYWKaAlCWYg4FbD9dIIOt9fumyJ6ez9Nyx/qzSZY1TJ6QoELSLc6c5TzW3cRADfKyWblFw4kYPxPulpElks+xlbnFD+tMGp5gSVGgYYJpud5MIZ7ugHhcJ7uUuN15FPcfHaXJqiFVhXMx+HaPdXqGNcoXkcFvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774040903; c=relaxed/simple;
	bh=u0zdmPIhkicnjjaekGwGuaSnl24uNp/SD6pTY4tTyoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6BGGSrG9/BXqjmalSf6WATIL+CQggZXnY21NICBtZQMVgEkjwS0XfV1dwIyqImk88F64N9FVvs6I18BaV7BesdGk9hbkkENtKZAxY8ogWwOvZR5dydhF7Q/lpvpb74U9c4bSEE/KOseskDU3YbDc5AzAQH+aIGwQ8F01OJwpMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qC8HBmDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E28C4CEF7;
	Fri, 20 Mar 2026 21:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774040903;
	bh=u0zdmPIhkicnjjaekGwGuaSnl24uNp/SD6pTY4tTyoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qC8HBmDJbc3QTlANvhaLjcn0O5ay5GqzDEvYHXsOkZQejTAbOkx+bkEo+ki3/IcqS
	 2zxeTAiPAA/ZnIrs1vWkKIH1qQM6hWWWHXeyTtkY/GTcJVwCwrNv3c5QnInC7yBUEZ
	 Emq3X5gGUqXLf66MStAVqC5m2WCTfSbnlpAHXDlhTtb1Ap6h4AtLg1EuCVIYnM3U2k
	 9XYMGV8lFcVQ3Ofo63x/aFk8UD8Gt0FgB8ThIniVMGJGtCnjMclwn9hpHtv2VORGXx
	 vrpZQBmOIITR6wCUusRaEbZoc8REFtZupMT7Shny3yqCThx6DNBFOpK9/XXBVuE7o9
	 ZHBuzLHK9WgAw==
Date: Fri, 20 Mar 2026 14:08:12 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Bodo Stroesser <bostroesser@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org,
	linux-staging@lists.linux.dev, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v3 15/16] mm: add mmap_action_map_kernel_pages[_full]()
Message-ID: <20260320210812.GA3988975@ax162>
References: <cover.1773944114.git.ljs@kernel.org>
 <54ff3670662e10a66ce0c1a13c0ae93b99a5f201.1773944114.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54ff3670662e10a66ce0c1a13c0ae93b99a5f201.1773944114.git.ljs@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9644-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[45];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B80B82E11B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Lorenzo,

On Thu, Mar 19, 2026 at 06:23:39PM +0000, Lorenzo Stoakes (Oracle) wrote:
> A user can invoke mmap_action_map_kernel_pages() to specify that the
> mapping should map kernel pages starting from desc->start of a specified
> number of pages specified in an array.
> 
> In order to implement this, adjust mmap_action_prepare() to be able to
> return an error code, as it makes sense to assert that the specified
> parameters are valid as quickly as possible as well as updating the VMA
> flags to include VMA_MIXEDMAP_BIT as necessary.
> 
> This provides an mmap_prepare equivalent of vm_insert_pages().  We
> additionally update the existing vm_insert_pages() code to use
> range_in_vma() and add a new range_in_vma_desc() helper function for the
> mmap_prepare case, sharing the code between the two in range_is_subset().
> 
> We add both mmap_action_map_kernel_pages() and
> mmap_action_map_kernel_pages_full() to allow for both partial and full VMA
> mappings.
> 
> We update the documentation to reflect the new features.
> 
> Finally, we update the VMA tests accordingly to reflect the changes.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
...
> diff --git a/mm/util.c b/mm/util.c
> index 8cf59267a9ac..682d0d24e1c6 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1446,6 +1446,8 @@ int mmap_action_prepare(struct vm_area_desc *desc)
>  		return io_remap_pfn_range_prepare(desc);
>  	case MMAP_SIMPLE_IO_REMAP:
>  		return simple_ioremap_prepare(desc);
> +	case MMAP_MAP_KERNEL_PAGES:
> +		return map_kernel_pages_prepare(desc);
>  	}
>  
>  	WARN_ON_ONCE(1);
> @@ -1476,6 +1478,9 @@ int mmap_action_complete(struct vm_area_struct *vma,
>  	case MMAP_REMAP_PFN:
>  		err = remap_pfn_range_complete(vma, action);
>  		break;
> +	case MMAP_MAP_KERNEL_PAGES:
> +		err = map_kernel_pages_complete(vma, action);
> +		break;
>  	case MMAP_IO_REMAP_PFN:
>  	case MMAP_SIMPLE_IO_REMAP:
>  		/* Should have been delegated. */
> @@ -1497,6 +1502,7 @@ int mmap_action_prepare(struct vm_area_desc *desc)
>  	case MMAP_REMAP_PFN:
>  	case MMAP_IO_REMAP_PFN:
>  	case MMAP_SIMPLE_IO_REMAP:
> +	case MMAP_MAP_KERNEL_PAGES:
>  		WARN_ON_ONCE(1); /* nommu cannot handle these. */
>  		break;
>  	}

Not sure if it has been reported/addressed yet but it looks like
mmap_action_complete() was missed here, as pointed out by clang:

  $ make -skj"$(nproc)" ARCH=arm LLVM=1 mrproper allnoconfig mm/util.o
  mm/util.c:1520:10: warning: enumeration value 'MMAP_MAP_KERNEL_PAGES' not handled in switch [-Wswitch]
   1520 |         switch (action->type) {
        |                 ^~~~~~~~~~~~

I assume

diff --git a/mm/util.c b/mm/util.c
index 682d0d24e1c6..c41c119a5a74 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1523,6 +1523,7 @@ int mmap_action_complete(struct vm_area_struct *vma,
 	case MMAP_REMAP_PFN:
 	case MMAP_IO_REMAP_PFN:
 	case MMAP_SIMPLE_IO_REMAP:
+	case MMAP_MAP_KERNEL_PAGES:
 		WARN_ON_ONCE(1); /* nommu cannot handle this. */
 
 		err = -EINVAL;
--

should be the fix?

Cheers,
Nathan

