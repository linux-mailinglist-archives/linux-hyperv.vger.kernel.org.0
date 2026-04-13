Return-Path: <linux-hyperv+bounces-10124-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rnv5ETeB3GmySAkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10124-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 07:37:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C5D3E7830
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 07:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F84C300A7D7
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 05:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A18830EF6C;
	Mon, 13 Apr 2026 05:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYAidPKq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2323A30C35F;
	Mon, 13 Apr 2026 05:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776058675; cv=none; b=VrthSnC0aKYhCgVEZbRKozfnX3k9sHpZ3DmVaAsC5kBizcYj7EZWlfZUtw5YN/98GzaerVlMPUTputAHKxPkGTJm7de0Tf/7I+H/1Eeh6d2IwY4TP0p5ITdOjtMisoOo8qjR1szBAs44mvMEnGmsA2sERxMoJypt0UMD/o0vvNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776058675; c=relaxed/simple;
	bh=c9xdq9i+G0zulG6323Mzb3s5ZrM924e/Sx6+1KNbAKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4GsPoe+PNPCFy1xXwwsK0VDQQl9ADsbrY8Jr0OGwBNn2oIxW4gVyGIqpxx02/cGnaHGOFrFww3m2tODOF6AEIhquGEac84vxJ3bZW9+YYNbItX1tRWlFbRzS6hfsT2Jq9gt2vBtf8qrW0SiHVthSUNHNegiQU6qnjaqNcd5/JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYAidPKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D756C116C6;
	Mon, 13 Apr 2026 05:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776058674;
	bh=c9xdq9i+G0zulG6323Mzb3s5ZrM924e/Sx6+1KNbAKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CYAidPKqcLB7DggtGonSr6XqmwbLLK9P1gNbNHNBTA3mq0vH1b50IIBl5v1zbXXps
	 GHHshy2hpn9wUga0epb1dJOO1e0BFndrNx4clnhZZOn7zUnMfzMx6U35BjPalsVv13
	 qe/HFMZY82osynewGvSj46/ZbqIGUSh+xDIhvSd+QTqUHgM4YzoDv1x2RvlqnEOdRo
	 7wWfyVwal3hQDzOC2w+RlZOAL/OCU5glHRpaDPGFhkr7WJsPEXrSyKatLqSv2fukC/
	 Y5fVO5ybbUpow/LSffY8kBaDZD2Hl75evpdO2SqpzWa/lnBVl0wUwWPho8OkumYSk0
	 wrCdvcELxpHgA==
Date: Mon, 13 Apr 2026 06:37:41 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
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
	Pedro Falcato <pfalcato@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, 
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>, "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v4 19/21] uio: replace deprecated mmap hook with
 mmap_prepare in uio_info
Message-ID: <adyAzdYVm95MZny2@lucifer>
References: <cover.1774045440.git.ljs@kernel.org>
 <157583e4477705b496896c7acd4ac88a937b8fa6.1774045440.git.ljs@kernel.org>
 <adx2ws5z0NMIe5Yj@shinmob>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adx2ws5z0NMIe5Yj@shinmob>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10124-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1C5D3E7830
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 05:14:08AM +0000, Shinichiro Kawasaki wrote:
> On Mar 20, 2026 / 22:39, Lorenzo Stoakes (Oracle) wrote:
> > The f_op->mmap interface is deprecated, so update uio_info to use its
> > successor, mmap_prepare.
> >
> > Therefore, replace the uio_info->mmap hook with a new
> > uio_info->mmap_prepare hook, and update its one user, target_core_user,
> > to both specify this new mmap_prepare hook and also to use the new
> > vm_ops->mapped() hook to continue to maintain a correct udev->kref
> > refcount.
> >
> > Then update uio_mmap() to utilise the mmap_prepare compatibility layer to
> > invoke this callback from the uio mmap invocation.
> >
> > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
>
> Hello Lorenzo, since two weeks ago, I observe a failure during my kernel test
> set targeting Linux for-next branch. On failure, kernel reported a WARN at
> __vma_check_mmap_hook [1]. I bisected and found that this patch is the trigger.
> Here I share my observations of the failure. Actions or advices for fix will be
> appreciated.

Ugh yeah thanks, this actually needs to account for use of compatibility layer,
so probably we shouldn't even assert this as that isn't easily detectable.

I'll send a hotfix for this that can be bundled up with 7.1 patches.

Cheers, Lorenzo

