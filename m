Return-Path: <linux-hyperv+bounces-9402-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKKnN7j/s2mWewAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9402-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 13:14:48 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57657282CEA
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 13:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0342A3087C1C
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 12:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A2939185E;
	Fri, 13 Mar 2026 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DB6dRsTQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F9D382281;
	Fri, 13 Mar 2026 12:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773404034; cv=none; b=mzbQ0FYTIB86l3e9CSS3lyWVuJo+Caf+CzeFD2PFdDNsdqhj2RWPARomVac32iRqkpO8tn5nl7o4wkHxx/DlqoLe5lM7x4XDkwvKKa+S/Prx8T0q2ejAsmmYOff3kQeIvTf5V5H9eGtQLmBiDyc5g0NqL3sIKD8ksfQXOatKbsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773404034; c=relaxed/simple;
	bh=YTSstfxoFHiBrx/2m0P/t3MkgTKyeJ4OyC8gGdFgfg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4WyUdvtvgs5IqdEo9Y/lo2dYWypLQKWi9c+T3/prLW0aOrmqZzGzB13z3YJH+6H3cpuCMEDRj7NFw9FKPMumVBcE0dYLkwSmshidclfin1u8LIO78yvgtrzIodGumXn6OJ6Au1NJ1Fkrd3wSFqum0fjLpbDRsgBNd4Cbp8giys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DB6dRsTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E0DC19421;
	Fri, 13 Mar 2026 12:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773404033;
	bh=YTSstfxoFHiBrx/2m0P/t3MkgTKyeJ4OyC8gGdFgfg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DB6dRsTQ08n3qOo3LbHGR1u+n0kWeOhSwb+ENV+XLmec/F+YIQ0TbkSpcxXc4SxOp
	 vHeCf5xRAJLRPuA8hMqRPDPvUtF/PM2u9MLhTGgfq0Ae11MF9gBBhHXccmzR/v45mn
	 xB0zSI5yzSzGTansN0d4x/wNLnx0ndS+Dl4B+JhsaH2l6nIzblj937L039TmtA4rml
	 Dr6J3+ATKRtvGj3D+6JSEUu1hbMWQTHb7OHl+ygHlVZiX0nXmiZRiVxI/hdDdKQZaN
	 hT2R8s+ucuXlNHEKl1rR953D/AJ1NweqQI8U1F2poQTAT5Z/pBYTS88vUfrR7KVI0X
	 7ogwZcTeTjd3A==
Date: Fri, 13 Mar 2026 12:13:42 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Clemens Ladisch <clemens@ladisch.de>, 
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
Subject: Re: [PATCH 01/15] mm: various small mmap_prepare cleanups
Message-ID: <fa6bf4b1-b4da-4679-bd4d-7a0884b45fbb@lucifer.local>
References: <cover.1773346620.git.ljs@kernel.org>
 <56372fe273f775b26675a04652c1229e14680741.1773346620.git.ljs@kernel.org>
 <20260312141425.1837736829210f2d0b00cac6@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312141425.1837736829210f2d0b00cac6@linux-foundation.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9402-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57657282CEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 02:14:25PM -0700, Andrew Morton wrote:
> On Thu, 12 Mar 2026 20:27:16 +0000 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org> wrote:
>
> > +int mmap_action_prepare(struct vm_area_desc *desc,
> > +			struct mmap_action *action)
> > +
> >  {
> >  	switch (action->type) {
> >  	case MMAP_NOTHING:
> > -		break;
> > +		return 0;
> >  	case MMAP_REMAP_PFN:
> > -		remap_pfn_range_prepare(desc, action->remap.start_pfn);
> > -		break;
> > +		return remap_pfn_range_prepare(desc, action);
> >  	case MMAP_IO_REMAP_PFN:
> > -		io_remap_pfn_range_prepare(desc, action->remap.start_pfn,
> > -					   action->remap.size);
> > -		break;
> > +		return io_remap_pfn_range_prepare(desc, action);
> >  	}
> >  }
> >  EXPORT_SYMBOL(mmap_action_prepare);
>
> hm, was this the correct version?
>
> mm/util.c: In function 'mmap_action_prepare':
> mm/util.c:1451:1: error: control reaches end of non-void function [-Werror=return-type]
>  1451 | }

Seems different compiler versions do different things :)

In theory we should never hit that but memory corruption and err... rogue
drivers? could cause it ofc :)

Will fix on respin.

>
> --- a/mm/util.c~mm-various-small-mmap_prepare-cleanups-fix
> +++ a/mm/util.c
> @@ -1356,6 +1356,8 @@ int mmap_action_prepare(struct vm_area_d
>  		return remap_pfn_range_prepare(desc, action);
>  	case MMAP_IO_REMAP_PFN:
>  		return io_remap_pfn_range_prepare(desc, action);
> +	default:
> +		BUG();

I'd probably prefer a WARN_ON_ONCE(1) return -EBLAH; will think about it on
respin.

>  	}
>  }
>  EXPORT_SYMBOL(mmap_action_prepare);
> _
>

Cheers, Lorenzo

