Return-Path: <linux-hyperv+bounces-9756-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ5aD76yw2litgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9756-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 11:02:38 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3A7322990
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 11:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24CD4301E3E5
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 09:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5F83A3E64;
	Wed, 25 Mar 2026 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+uY8j9D"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154CA38D00F;
	Wed, 25 Mar 2026 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774432718; cv=none; b=aU2aRitSln/rwkEyE0m0UQsH5YGaodCqEZ9uCh+HBLpDDxtISJgbIjdbqQHk+Ou13MgRsAgNKh4h7f29iAUseXORigGfXNGNv1TuwlcGf1CdZrk6TElxyQd+BMSbDK/plrGZ0zDCeiCDGvMxG5hXDJdgokDpayf8edLw/F55pfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774432718; c=relaxed/simple;
	bh=HuY/gXey+uWVLYsCI6CkmOeVgc5q6DFm7SVnZaIS/YM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YG+tbgfN2Y59l10U8ZCb+e1hb5lwyWSIi8As7dpKyxVyItzcG4GIAO7uITBV/566VNeD75k2DscsNukYNcYHq9vfhJ+0fdglbA5hLkWSAza4p22DocfedPa4enyhs2HBqh39cwUY9Vq7mygFB/krMUCdfRfgRpbjAaU0pWow0JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+uY8j9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFACC4CEF7;
	Wed, 25 Mar 2026 09:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774432717;
	bh=HuY/gXey+uWVLYsCI6CkmOeVgc5q6DFm7SVnZaIS/YM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u+uY8j9DdWnf6aJO3ZHhf6pj8o6upnz4tgfFLuwATHjhN6SatZRmXJbkO3JFsl45s
	 ADbQAVoZ2bfxIeImDpnwFdFCo0b8tn6HNyoZW5/j1NFRa+uXe019/Hzk1B5PNJSpge
	 oitV6NhzQsBWdl1ZGdGjjAleBOpYArsdSSBmuxkg0gbhRkp5b/B8T8vJcIMEA4HjHA
	 nsppJG3k+pdtmXbLxSqIZuQQW9qLID/Ou1ZIPnKK9/Xrsxbabxym2XTk8bjNKNnh79
	 gW+HYIQy6QtFwqaoSQC+HIe2caOI1oDm6sqQ/VOpZmE6eK1dpqAouDkD3M6o3nEwh3
	 regiPf+e17GQA==
Message-ID: <9b205b06-e938-4f30-a16d-7d90f8c49818@kernel.org>
Date: Wed, 25 Mar 2026 10:58:28 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/21] mm: add mmap_action_simple_ioremap()
Content-Language: en-US
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
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org,
 linux-staging@lists.linux.dev, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 Ryan Roberts <ryan.roberts@arm.com>
References: <cover.1774045440.git.ljs@kernel.org>
 <a08ef1c4542202684da63bb37f459d5dbbeddd91.1774045440.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <a08ef1c4542202684da63bb37f459d5dbbeddd91.1774045440.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9756-lists,linux-hyperv=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB3A7322990
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 23:39, Lorenzo Stoakes (Oracle) wrote:
> Currently drivers use vm_iomap_memory() as a simple helper function for
> I/O remapping memory over a range starting at a specified physical address
> over a specified length.
> 
> In order to utilise this from mmap_prepare, separate out the core logic
> into __simple_ioremap_prep(), update vm_iomap_memory() to use it, and add
> simple_ioremap_prepare() to do the same with a VMA descriptor object.
> 
> We also add MMAP_SIMPLE_IO_REMAP and relevant fields to the struct
> mmap_action type to permit this operation also.
> 
> We use mmap_action_ioremap() to set up the actual I/O remap operation once
> we have checked and figured out the parameters, which makes
> simple_ioremap_prepare() easy to implement.
> 
> We then add mmap_action_simple_ioremap() to allow drivers to make use of
> this mode.
> 
> We update the mmap_prepare documentation to describe this mode.  Finally,
> we update the VMA tests to reflect this change.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


