Return-Path: <linux-hyperv+bounces-9645-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DVMEAvIvWkrBgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9645-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:19:55 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A25982E1B12
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1AD43032981
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 22:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C99373BE8;
	Fri, 20 Mar 2026 22:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4f0P+4/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E23B34EEE4;
	Fri, 20 Mar 2026 22:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044866; cv=none; b=hKzNCmyIzm1W/vqubHro4uJ9+BgcFahzTFb+Q33hPI5IuZDL5k0Au8yTnVBulLJNic3HitRq1ILUEJ85IKA4pZcqhbBSe+K5uwjVgURen/B1CxVbIIx9ws2Lf0+iR6zewalGg08+GxbTTqSAXqU51BcYtItOKtArVPhfs6b/n1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044866; c=relaxed/simple;
	bh=EJFefe3k86LwmaxBPXrya5hP9X6x4nyWEoivmKnN/xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXu1YD0o+Jpp7Yq3SC6X1raRf/GBTToeKHeCDd07Oe4U7HPxIQDRCZryqem4zxExV6sm8UX6/q+VbPPMxYwYQk54XZ6vNGx+8xPzJOaFS0mILbR+uBklm46uxWHZHp1q60DOtaoyy0HxK0JKFM0DWXT1mD2mz+R9F0AhVaMBFwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4f0P+4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E6EC2BC87;
	Fri, 20 Mar 2026 22:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774044866;
	bh=EJFefe3k86LwmaxBPXrya5hP9X6x4nyWEoivmKnN/xA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I4f0P+4/Fr6KtbcDwJjO9w3QoIlF6KRTpZZJWZSbvooeYpf7n8wbwYC1XDUZKnHdS
	 xJOHJXSYItqCme2WWVfCRZflxAnLBFq0xUXkN/i0EoMg/pppX8wxvEhdW4so2zLAaW
	 8o22ncvQ+k+qmAqGFLocIUB3mwyn4EFgiCAmzExcQ2PJXvFrx0OGiIndik/aoCynLN
	 9JymF+UWIuaY29XIocf6s5fsDz9rF1s06hN8PoHaaGnJyhpqaOsm9NjsdMF+qSOTnQ
	 TtuOLyxXpYUlmButgynZGHhdY/u1nPzDI5uyj80JTcR+BPt0fmTl9WQ4HOYZ3YlHK1
	 lA5kQrtlVkd5Q==
Date: Fri, 20 Mar 2026 22:14:24 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
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
Subject: Re: [PATCH v3 15/16] mm: add mmap_action_map_kernel_pages[_full]()
Message-ID: <d709465e-79ba-4a12-9bf7-803a3732aa85@lucifer.local>
References: <cover.1773944114.git.ljs@kernel.org>
 <54ff3670662e10a66ce0c1a13c0ae93b99a5f201.1773944114.git.ljs@kernel.org>
 <20260320210812.GA3988975@ax162>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320210812.GA3988975@ax162>
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
	TAGGED_FROM(0.00)[bounces-9645-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: A25982E1B12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 02:08:12PM -0700, Nathan Chancellor wrote:
> Hi Lorenzo,
>
> On Thu, Mar 19, 2026 at 06:23:39PM +0000, Lorenzo Stoakes (Oracle) wrote:
> > A user can invoke mmap_action_map_kernel_pages() to specify that the
> > mapping should map kernel pages starting from desc->start of a specified
> > number of pages specified in an array.
> >
> > In order to implement this, adjust mmap_action_prepare() to be able to
> > return an error code, as it makes sense to assert that the specified
> > parameters are valid as quickly as possible as well as updating the VMA
> > flags to include VMA_MIXEDMAP_BIT as necessary.
> >
> > This provides an mmap_prepare equivalent of vm_insert_pages().  We
> > additionally update the existing vm_insert_pages() code to use
> > range_in_vma() and add a new range_in_vma_desc() helper function for the
> > mmap_prepare case, sharing the code between the two in range_is_subset().
> >
> > We add both mmap_action_map_kernel_pages() and
> > mmap_action_map_kernel_pages_full() to allow for both partial and full VMA
> > mappings.
> >
> > We update the documentation to reflect the new features.
> >
> > Finally, we update the VMA tests accordingly to reflect the changes.
> >
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> ...
> > diff --git a/mm/util.c b/mm/util.c
> > index 8cf59267a9ac..682d0d24e1c6 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -1446,6 +1446,8 @@ int mmap_action_prepare(struct vm_area_desc *desc)
> >  		return io_remap_pfn_range_prepare(desc);
> >  	case MMAP_SIMPLE_IO_REMAP:
> >  		return simple_ioremap_prepare(desc);
> > +	case MMAP_MAP_KERNEL_PAGES:
> > +		return map_kernel_pages_prepare(desc);
> >  	}
> >
> >  	WARN_ON_ONCE(1);
> > @@ -1476,6 +1478,9 @@ int mmap_action_complete(struct vm_area_struct *vma,
> >  	case MMAP_REMAP_PFN:
> >  		err = remap_pfn_range_complete(vma, action);
> >  		break;
> > +	case MMAP_MAP_KERNEL_PAGES:
> > +		err = map_kernel_pages_complete(vma, action);
> > +		break;
> >  	case MMAP_IO_REMAP_PFN:
> >  	case MMAP_SIMPLE_IO_REMAP:
> >  		/* Should have been delegated. */
> > @@ -1497,6 +1502,7 @@ int mmap_action_prepare(struct vm_area_desc *desc)
> >  	case MMAP_REMAP_PFN:
> >  	case MMAP_IO_REMAP_PFN:
> >  	case MMAP_SIMPLE_IO_REMAP:
> > +	case MMAP_MAP_KERNEL_PAGES:
> >  		WARN_ON_ONCE(1); /* nommu cannot handle these. */
> >  		break;
> >  	}
>
> Not sure if it has been reported/addressed yet but it looks like
> mmap_action_complete() was missed here, as pointed out by clang:
>
>   $ make -skj"$(nproc)" ARCH=arm LLVM=1 mrproper allnoconfig mm/util.o
>   mm/util.c:1520:10: warning: enumeration value 'MMAP_MAP_KERNEL_PAGES' not handled in switch [-Wswitch]
>    1520 |         switch (action->type) {
>         |                 ^~~~~~~~~~~~
>
> I assume
>
> diff --git a/mm/util.c b/mm/util.c
> index 682d0d24e1c6..c41c119a5a74 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1523,6 +1523,7 @@ int mmap_action_complete(struct vm_area_struct *vma,
>  	case MMAP_REMAP_PFN:
>  	case MMAP_IO_REMAP_PFN:
>  	case MMAP_SIMPLE_IO_REMAP:
> +	case MMAP_MAP_KERNEL_PAGES:
>  		WARN_ON_ONCE(1); /* nommu cannot handle this. */
>
>  		err = -EINVAL;
> --
>
> should be the fix?
>
> Cheers,
> Nathan

Thanks, will fix, working on a respin now anyway :)

Cheers, Lorenzo

