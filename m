Return-Path: <linux-hyperv+bounces-11976-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kbMFOKR4VmrE6QAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11976-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 19:57:56 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94301757AAE
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 19:57:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=Del5tMhz;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11976-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11976-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D27B301FF8B
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 17:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA7D3314D0;
	Tue, 14 Jul 2026 17:57:55 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C880832E757;
	Tue, 14 Jul 2026 17:57:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051875; cv=none; b=YhFTKcrSuH1Sg+BcUTonc9P7Q+A+2CgTzL+QSOvUTgm7zEwmr+CVJQMnabk3kFRnwey7EEEUzRGlOY0UuE6U+LIGt93IaqyX5wyGr0hK3P9KOcqo24O+mz+xxZcZrsXxtHnL4h1sQXvL0MEfcmxkCr8NQPI3ZtmHeb4XTlluvro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051875; c=relaxed/simple;
	bh=OI3JlDuLY07U0gR/Ke0Vick6BYegbcgNSuIJ8n4P2Dw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oImAZL7MkL3ZHIjOrQob+aaLlNhb8WxVcI6C1Fgdlc6tTbzbXiwxPkRRc2PgMbb3mAeWQL1+vRJdYcuIwMcMmKhKMOPasKp2+GA/UZrHZgCRO//TRpjcJ84TQwOvcstqnCqSmD+pgYyJw5skmybJx811Aff5VdsZ2lVddMSXb6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Del5tMhz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234151F000E9;
	Tue, 14 Jul 2026 17:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784051873;
	bh=GZsCQFEgcn6EMOCDEWdLwPkfWWcQqzlkLED/YqdY1Tc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Del5tMhzu3youmLCKHjbgtPvdsDIH+7IGGFST8BzaPmqfbbkJZKJ/z7YuaAT/X/p7
	 YChgX7fSaBbak9aPutlauCQ1Jbkj4qG9n6iEshYriEkzHWNiPFv0rwct2vUBjwBQdh
	 kaZUweQ5gxNphKPDgOzYUI91+awAsCTyJPp5rwvA=
Date: Tue, 14 Jul 2026 10:57:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, corbet@lwn.net,
 dakr@kernel.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org, kys@microsoft.com,
 leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com, ljs@kernel.org,
 longli@microsoft.com, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
 vbabka@kernel.org, wei.liu@kernel.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v8 0/8] mm/hmm: Add mmap lock-drop support for
 userfaultfd-backed mappings
Message-Id: <20260714105751.f45ec4c70702c222febdbf07@linux-foundation.org>
In-Reply-To: <alZfTxfypj39OrCE@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
	<20260710151151.1e193eedd0cf2591ae392f76@linux-foundation.org>
	<alG2-RSitzPWClAX@skinsburskii>
	<20260710224950.53bcb43ce7e564f07a1f6a8c@linux-foundation.org>
	<alVRU38lMfvmUFqJ@skinsburskii>
	<20260713154535.7656b3a630e2f6f076b4e76e@linux-foundation.org>
	<alZfTxfypj39OrCE@skinsburskii>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:skinsburskii@gmail.com,m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:jgg@ziepe.ca,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-11976-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ee.iitb.ac.in,lwn.net,kernel.org,microsoft.com,ziepe.ca,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de,kvack.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94301757AAE

On Tue, 14 Jul 2026 09:09:51 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:

> On Mon, Jul 13, 2026 at 03:45:35PM -0700, Andrew Morton wrote:
> > On Mon, 13 Jul 2026 13:57:55 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> > 
> > > > > I rebased this series on top of mm-new right before sending it out.
> > > > > Should I have used a different branch?
> > > > 
> > > > mm-new is good - Sashiko attempts that.  But it's changing rapidly at
> > > > this point in the development cycle.
> > > > 
> > > 
> > > I’d like to send another revision addressing a few comments and also
> > > replace the `max/max_t` check with something simpler.
> > > 
> > > Which branch should I base it on so that Sashiko can apply it
> > > successfully?
> > 
> > mainline Linus would be safest.
> > 
> 
> Looks like linux-next/master has been updated with the v8 of the series.

That's because v8 is in mm.git's mm-unstable branch.

> I have v9 with a few small fixes, but it is too late to send it out already?

It's called "unstable" for a reason!  Material in mm-unstable is still
under review, test and the latest stages of development.  Getting
things finalized for movement into the non-rebasing mm-stable branch,
then into mainline.

So altering or replacing patchsets while they're in mm-unstable is
perfectly OK and expected.

> If it's not, then what should I base it on?

Well it's a bit tricky to replace a series when it's in mm-unstable. 
One can do a git-checkout of the commit which precedes the v8 series. 
Or base on current Linus mainline, which usually works out.

Sending little fixup patches against what's presently in mm-unstable
also works.  I'll queue each one immediately behind the patch which it
alters then squash them into their parent patch before moving the series
into mm-stable.

A third alternative is for me to drop v8 from mm-unstable, then you
wait until that has propagated onto the servers or into linux-next,
then base on that.  This approach is OK but I kinda unprefer it because
there's a bit of latency and it makes it harder for me to prepare my
"here's how v9 altered mm.git" summaries.


Which would you prefer?

