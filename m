Return-Path: <linux-hyperv+bounces-9388-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJuxNSMts2ksSwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9388-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 22:16:19 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3998A279DB0
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 22:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E0A03037E6A
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 21:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB01D3B6C02;
	Thu, 12 Mar 2026 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Duh+dhDj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535753B5832;
	Thu, 12 Mar 2026 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350069; cv=none; b=ClazzjrQcwGjPmHPlzQNoIvqLnqie62ti5ZhuBrlk3rYTrHtPIpgMv7+AgZeDVa07e++5wK2mtgppkW9ghlIUUrFoYc8kVv0X7w/vGE+4w+W9Nl0b67FMnlwEmCuYWxpDhZWRrYhkknLU8XbwIM/a552h0cdoh7bYCrFL0+cvM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350069; c=relaxed/simple;
	bh=BHIeqMCeZ08yvAl5YqqjtddRClVSOvGwSHug5GXzEz8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JWtcw6Wr/qHSOHghAHwLNXQ5H9EjpKf+6d4b8QTvHv3t6m+X0i9kFc+rom59saPj9FbLW4B0X2nakzINPbA9u6comct7v/EN6H/r+KVgeY9qEXp/dYImmq1/vk27JyLGmD6QWIgGtM1DUDhn0OCXNUp9JlLYKMhA2PDM/4IWjDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Duh+dhDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3794C4CEF7;
	Thu, 12 Mar 2026 21:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773350068;
	bh=BHIeqMCeZ08yvAl5YqqjtddRClVSOvGwSHug5GXzEz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Duh+dhDjn9i3oyIucNjLcpV7CKSwWMDBwP1nrAeCAWcyGXtDakHpRp+pm3kMEvL8y
	 SEaAaWk5jP3gQGaz8kV5kaoD1HdJgTdnHuWBZE8KvOuDSG+7q7krHiTC3YYNdfGDfn
	 Xpz6tLlo5tMrkq0Sz1LyxlbqOsozNn9yfZFUkN8M=
Date: Thu, 12 Mar 2026 14:14:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Clemens Ladisch <clemens@ladisch.de>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bodo Stroesser <bostroesser@gmail.com>, "Martin K . Petersen"
 <martin.petersen@oracle.com>, David Howells <dhowells@redhat.com>, Marc
 Dionne <marc.dionne@auristor.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, David Hildenbrand <david@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org,
 linux-staging@lists.linux.dev, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Ryan Roberts
 <ryan.roberts@arm.com>
Subject: Re: [PATCH 01/15] mm: various small mmap_prepare cleanups
Message-Id: <20260312141425.1837736829210f2d0b00cac6@linux-foundation.org>
In-Reply-To: <56372fe273f775b26675a04652c1229e14680741.1773346620.git.ljs@kernel.org>
References: <cover.1773346620.git.ljs@kernel.org>
	<56372fe273f775b26675a04652c1229e14680741.1773346620.git.ljs@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9388-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_TWELVE(0.00)[44];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3998A279DB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 20:27:16 +0000 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org> wrote:

> +int mmap_action_prepare(struct vm_area_desc *desc,
> +			struct mmap_action *action)
> +
>  {
>  	switch (action->type) {
>  	case MMAP_NOTHING:
> -		break;
> +		return 0;
>  	case MMAP_REMAP_PFN:
> -		remap_pfn_range_prepare(desc, action->remap.start_pfn);
> -		break;
> +		return remap_pfn_range_prepare(desc, action);
>  	case MMAP_IO_REMAP_PFN:
> -		io_remap_pfn_range_prepare(desc, action->remap.start_pfn,
> -					   action->remap.size);
> -		break;
> +		return io_remap_pfn_range_prepare(desc, action);
>  	}
>  }
>  EXPORT_SYMBOL(mmap_action_prepare);

hm, was this the correct version?

mm/util.c: In function 'mmap_action_prepare':
mm/util.c:1451:1: error: control reaches end of non-void function [-Werror=return-type]
 1451 | }

--- a/mm/util.c~mm-various-small-mmap_prepare-cleanups-fix
+++ a/mm/util.c
@@ -1356,6 +1356,8 @@ int mmap_action_prepare(struct vm_area_d
 		return remap_pfn_range_prepare(desc, action);
 	case MMAP_IO_REMAP_PFN:
 		return io_remap_pfn_range_prepare(desc, action);
+	default:
+		BUG();
 	}
 }
 EXPORT_SYMBOL(mmap_action_prepare);
_


