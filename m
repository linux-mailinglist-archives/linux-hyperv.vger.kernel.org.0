Return-Path: <linux-hyperv+bounces-9690-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEtuGyoEwWlUPgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9690-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 10:13:14 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5662C2EECB2
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 10:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02FDE3007495
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 09:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3936138654A;
	Mon, 23 Mar 2026 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joSxwlsp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1260B38645C;
	Mon, 23 Mar 2026 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774257189; cv=none; b=IAMoIWp50673lX7OldzuRG0xhq1aOEoavrH2k18cJQNaGBO2KEcEjoe30rvsm8zP2qVXcubCUDDH4gU3hfGLUwhdb7SFjQGoNFxFJryEKqulPUlwI08yNhdy2xZUSwwA4+z5LcJrtLRRJjhztv6leVIEMgpRxIDbrN9KcIPvIPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774257189; c=relaxed/simple;
	bh=wzMrqKx3Jtzn/TAs56FycVP5WjxG7mSofPlph6puuTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/6cb/WTHpRio3DUgEoymf65kGKM/au8CA4Uq5/BbqZzTJf87+0opctAdhyFO8MSHkafnHCXcFT2J9npxeUdeo4eq5R4siGPzTbjZWQUA3u9Xbu5xu9aAouUujc7U9/nSwmImCxldAajJrEIaALUNQnxn8f835rOUXQC8WENpZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joSxwlsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06702C4CEF7;
	Mon, 23 Mar 2026 09:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774257188;
	bh=wzMrqKx3Jtzn/TAs56FycVP5WjxG7mSofPlph6puuTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=joSxwlspVhKYcgE4zizMzEupkVxH7zBoRt16ItgpGqtktF8hLPrEEOTxfgh4aRR46
	 H0U9alpLsA83SdovjY4NjT0S8IVfoGCFHfdV08wBojK7QatPitGsHroy+nurmzIUo5
	 9LTrYrheRCty7XcM5Hdcd35jJVYk4YzX2FwqnAgbFVPaee1S/zk0OOYbb6dWKe54SV
	 Qejn61X7CFhOqRsAbeUsXpGiEPrzUHGPx8hpLYNbDN7Ghgx9DVL33kddcsAYc4j5Sz
	 AmCzqaip3eo7Xnd8PbIQkYXGzXvvJm8fegMwy8XoqhfyH8Ytxfa3hUrWvBicIE9Bu0
	 C1NjdvWhW+Gjw==
Date: Mon, 23 Mar 2026 09:13:06 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Long Li <longli@microsoft.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "K . Y . Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Bodo Stroesser <bostroesser@gmail.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	David Hildenbrand <david@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, 
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>, "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v4 18/21] drivers: hv: vmbus: replace deprecated mmap
 hook with mmap_prepare
Message-ID: <409ff1b0-43ff-4b1d-ad07-7624e0817640@lucifer.local>
References: <cover.1774045440.git.ljs@kernel.org>
 <05467cb62267d750e5c770147517d4df0246cda6.1774045440.git.ljs@kernel.org>
 <SN6PR02MB41573DF211DA2469D7FFE892D44BA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41573DF211DA2469D7FFE892D44BA@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9690-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[45];
	FREEMAIL_CC(0.00)[microsoft.com,linux-foundation.org,lwn.net,ladisch.de,arndb.de,linuxfoundation.org,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,outlook.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5662C2EECB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 04:16:20AM +0000, Michael Kelley wrote:
> From: Lorenzo Stoakes (Oracle) <ljs@kernel.org> Sent: Friday, March 20, 2026 3:40 PM
> >
> > The f_op->mmap interface is deprecated, so update the vmbus driver to use
> > its successor, mmap_prepare.
> >
> > This updates all callbacks which referenced the function pointer
> > hv_mmap_ring_buffer to instead reference hv_mmap_prepare_ring_buffer,
> > utilising the newly introduced compat_set_desc_from_vma() and
> > __compat_vma_mmap() to be able to implement this change.
> >
> > The UIO HV generic driver is the only user of hv_create_ring_sysfs(),
> > which is the only function which references
> > vmbus_channel->mmap_prepare_ring_buffer which, in turn, is the only
> > external interface to hv_mmap_prepare_ring_buffer.
> >
> > This patch therefore updates this caller to use mmap_prepare instead,
> > which also previously used vm_iomap_memory(), so this change replaces it
> > with its mmap_prepare equivalent, mmap_action_simple_ioremap().
> >
> > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> > ---
> >  drivers/hv/hyperv_vmbus.h    |  4 ++--
> >  drivers/hv/vmbus_drv.c       | 31 +++++++++++++++++++------------
> >  drivers/uio/uio_hv_generic.c | 11 ++++++-----
> >  include/linux/hyperv.h       |  4 ++--
> >  4 files changed, 29 insertions(+), 21 deletions(-)
> >
>
> There are two mmap() code paths in the Hyper-V UIO code. One path is
> to mmap() the file descriptor for /dev/uio<n>, and the other is to mmap()
> the "ring" entry under /sys/devices/vmbus/devices/<uuid>. The former is
> done by uio_mmap(), and the latter by hv_uio_ring_mmap_prepare().
>
> I tested both these paths using a combination of two methods in a
> x86/x64 VM on Hyper-V:
>
> 1) Using the fcopy daemon, which maps the ring buffer for the primary
> channel and sends/receives messages with the Hyper-V host. This
> method tests only the 1st path because the fcopy daemon doesn't create
> any subchannels that would use the "ring" entry.
>
> 2) Using a custom-built test program. This program doesn't communicate
> with the Hyper-V host, but allows mostly verifying both code paths for the
> primary channel. As a sanity check, it verifies that the two mmaps are
> mapping the same memory, as expected.
>
> As such,
>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>

Perfect, thanks so much for this!

It is tricky for me to test these, beyond fairly exhaustive logical
confirmation of equivalence, so this is _hugely_ helpful.

>
> The most robust test would be to run DPDK networking against
> UIO, as it would communicate with the Hyper-V host and use
> multiple subchannels that resulting in mmap'ing the "ring"
> entry under /sys.
>
> @Long Li -- I'll leave it to your discretion as to whether you want
> to test DPDK against these mmap() changes.

Thanks in advance for taking a look on this also!

>
> I've noted one minor issue below.
>
> [snip]
>
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1015,8 +1015,8 @@ struct vmbus_channel {
>  	/* The max size of a packet on this channel */
>  	u32 max_pkt_size;
>
> -	/* function to mmap ring buffer memory to the channel's sysfs ring attribute */
> -	int (*mmap_ring_buffer)(struct vmbus_channel *channel, struct vm_area_struct *vma);
> +	/* function to mmap_prepare ring buffer memory to the channel's sysfs ring attribute */
>
> Changing the comment from "mmap ring buffer" to "mmap_prepare ring buffer"
> produces awkward wording since "mmap" is used here as a verb.  It might be better
> to just leave the comment unchanged.

Sure am happy with that of course, I think Sashiko moaned about this but
it's obviously fine either way.

Andrew - do you mind restoring the comment to its original form above? Thanks!

>
> Michael
>
>
> +	int (*mmap_prepare_ring_buffer)(struct vmbus_channel *channel, struct vm_area_desc *desc);
>
>  	/* boolean to control visibility of sysfs for ring buffer */
>  	bool ring_sysfs_visible;

Cheers, Lorenzo

