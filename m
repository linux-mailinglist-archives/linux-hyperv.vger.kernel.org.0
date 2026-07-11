Return-Path: <linux-hyperv+bounces-11943-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SqH5CTrZUWpCJgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11943-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 07:48:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5875C7406D7
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 07:48:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=zxP6H3RU;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11943-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11943-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D3C5301BCE4
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 05:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438202EC08C;
	Sat, 11 Jul 2026 05:48:37 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA02DB7BE;
	Sat, 11 Jul 2026 05:48:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783748917; cv=none; b=o0qhbtm23gtBCm4kFZk3ZDH1gRVDzNFPYjdnRtZobapVz7u1AijXLmYqw3z4pgJyV2yUCf8dwJYRVceStt3Q0O5r4Tno/ZRLLYlbg8f4vQ9a/ROaGdsvtTUeEq8KjeVUWJ8CJZjnjWohs3wW2+sOU7byTrXOsW9HFDF/TP3m8pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783748917; c=relaxed/simple;
	bh=2X3u/rhMdoK2ZSzI5yRlLbKzVLTeEAk7NfzAxOZxq8M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Svv3aPSGkD1Q0veLIwbSj3XAS1SgUWDr/DbneYWlZzhh1Co2O27I0E6kX2O2A9cCmRfRSlYfNoWlNeGPKRTbRCY4UH97zZeT38wQppzri+A9lT+hpx8GhYVtMw4R1bJWpqbqPFwVIYdQ1gCdzXUTz1Ap32OFjcVG1oyIc2UD9vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zxP6H3RU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B1C1F000E9;
	Sat, 11 Jul 2026 05:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783748915;
	bh=/bm56TdW2Rt1TzYZP4AwroZ1H/akE8N7PaZmAo9v49o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=zxP6H3RUmBd6ihlhUQIdRJzfv+dWAy7/NIa1aujz+UJUigwYO9G60/3Bm1HoqfjnX
	 DZhiti+OpHf6AgYSszNldBtjYCKgg5QG6160LxG4/45mDd4arD7V/RUmAhgcW9bWTx
	 E9/cf5f5XfN6+ulL7h4VwT+i3BR5zKS6NdueS7go=
Date: Fri, 10 Jul 2026 22:48:33 -0700
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
Subject: Re: [PATCH v8 5/8] drm/nouveau: Use
 hmm_range_fault_unlocked_timeout() for SVM faults
Message-Id: <20260710224833.9caf2a0a9906f0515e326a45@linux-foundation.org>
In-Reply-To: <alG1k3JsoywE2CBM@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
	<178371881847.900500.8789369230260725500.stgit@skinsburskii>
	<20260710151222.ddb35eab9c81a8720491464a@linux-foundation.org>
	<alG1k3JsoywE2CBM@skinsburskii>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:skinsburskii@gmail.com,m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:jgg@ziepe.ca,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,linux-hyperv@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11943-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,ee.iitb.ac.in,lwn.net,kernel.org,microsoft.com,ziepe.ca,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de,kvack.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:from_mime,linux-foundation.org:dkim,linux-foundation.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5875C7406D7

On Fri, 10 Jul 2026 20:16:35 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:

> On Fri, Jul 10, 2026 at 03:12:22PM -0700, Andrew Morton wrote:
> > On Fri, 10 Jul 2026 14:26:58 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> > 
> > > @@ -683,15 +683,11 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
> > >  			goto out;
> > >  		}
> > >  
> > > -		range.notifier_seq = mmu_interval_read_begin(range.notifier);
> > > -		mmap_read_lock(mm);
> > > -		ret = hmm_range_fault(&range);
> > > -		mmap_read_unlock(mm);
> > > -		if (ret) {
> > > -			if (ret == -EBUSY)
> > > -				continue;
> > > +		ret = hmm_range_fault_unlocked_timeout(&range,
> > > +						       max(timeout - jiffies,
> > > +							   1L));
> > 
> > "1UL" here?  I'd have expected min() to warn, as it likes to do.
> 
> I'm not sure... The "timeout - jiffies" can become negative.
> Won't 1UL convert both of them to "UL" and thus make the comparison
> overflow?

`timeout' and `jiffies' are both unsigned long.

