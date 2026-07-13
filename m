Return-Path: <linux-hyperv+bounces-11966-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LSuVCF9RVWpImwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11966-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 22:58:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA4A74F28D
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 22:58:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NgBrxDlp;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11966-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11966-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 907A5307A9CF
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 20:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1642A35E1D9;
	Mon, 13 Jul 2026 20:58:01 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C933235E1AA
	for <linux-hyperv@vger.kernel.org>; Mon, 13 Jul 2026 20:57:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783976281; cv=none; b=QNuox6L3roFtesIRCZ0iFPAxlUE22AKKXyKc9HkZmddiION/S+sBFjwQvCZkULooDhLlEntgbHv5E4SDCel7Cd2QTcK1APaUaNAAuz1IoPh2grNKP1GdPe9E3lbccHewZC3dbd2xuFLPEg1QObK/4LAG1CCZCeTxWnSjqxBMkP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783976281; c=relaxed/simple;
	bh=D3eahPIAIk1fvhyOZkYEJP6bQ6n0at+bhFjOvvkmzpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUnr3sIqyRU0OHbp1QRBE77py2vECuVMuh3dnW7GuSbw/J/qBE20TWvNn/84STTt+8KZWZ/1qus83jiGVfEqeBTbEkzV9rlEBSLUUsDjXAIltTMtQvf4Xd3AVLhSVqJcepNDSVCFRd+ub387/ke+3fdn2JgX92l6SQ5tRS0F4Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgBrxDlp; arc=none smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-384c94c9414so272115a91.3
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Jul 2026 13:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783976279; x=1784581079; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oNqruOZIzwruIpGvkzB4DJORZxeTGWU0clCn+vXfCzI=;
        b=NgBrxDlpDoknd6Zv5Ca/Oeewg5yuANlXmHDRnnhqXDWhgDP2P44OrR0s0/MTMy34mZ
         n3zXMmcIfGoNR7Sd680LfEr1/geQl8EGetahP7W6fUt1MxIqIdI/L1VUVBggJAmQ51v0
         jXoSwvwvp/CrIoMSWg71PL3DRpm2hdJGate6aUcUOOKGl8xTstjSeqi6gEKS96UO7Zjd
         lb2a22B/uNSSHg5FZmQ48yi/TVkiA9sVtHA1/za6mSwdA5n6CL1pr/nmcJGtyJ1Z/Prh
         VUKEcE5b/3E9zbq5R57HBRuSsc33Y7ePwJV08k/0UBOriBpPl9MhiDN0KZiEmLww+N0n
         mgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783976279; x=1784581079;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oNqruOZIzwruIpGvkzB4DJORZxeTGWU0clCn+vXfCzI=;
        b=JkjrPCa48kwylB48qxou2nJiGCoGoLy6+HDgrZ2NMM0f/wbzRNNgsZ0yndnCMaodZD
         QhG+Rx4AtjH1eAl8vIB0CB2e05Mzap4r/Gs72QGr1paiuhVQ29A/McETAK9CEuPzLMNJ
         NRQZQQuRWUQhBTqHtRehyGW+z9EL/OLrrhn8IXLhqOWs6H08enzU0i5W82kwM9hy3KZ3
         dqswvhp6wK7kapzJHuBxyJmY2gbG0ViK451NllE2LcTbwh9eEVg1NG8t2nasKhOnigSp
         P0I2rW9htptvzWN76M4aDimJKIxzOk4PWzz1SxgwDSRN955Z7izCjb9kl0HQkCMyQudG
         WJRw==
X-Forwarded-Encrypted: i=1; AHgh+RpIEnxPfKwUUU5Bl5PjIRherSXNOlc4g/1ujJnK5gcQZyIwsH7oqv8LObSTUbF9anOTvbqmy1T3Fxjnm5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy8K17PIxXzS51c/CP69z8Lrn3RrgdXlB/i4KXQZNT9+r6VMNJ
	TZgElI9aI2R6wOJs1Nfz7yKekkXEZ1rN9INVKUul6TRJJJXku9eV/TVo
X-Gm-Gg: AfdE7cm2q8XOCwGf1Ag0qRH5dQN5y1OoaUKvFOvSHTAxom8f/gjWtVRuxiYU0uy0tFE
	80UToOPuxehvpuFKqe94TZHkrc+f4A0df68jRUL8vuPIKLh02Z43oMzMCW5niUvDvqTS55XYdej
	5PM5iahPOhDFBK0TYcRlypVp4SaQ5gWon3NpBgqLPUo9wgyW8CycqC6etaTOKEeMiSHDLXlyJtq
	FtmlueHqNMaaN1rpovrMxbIR56BxIXUjpZI9tjM2iEEZuEQrGQT1NTesXkRe4eSxttAhslQPBv3
	j0ED45dpgfj2OF+qLPGMOsmYhYm3fhvUyMO6NN7gk865RbS6kuFCjs+Tn9pG/4a89OEiYs2t9yV
	fuDA60Ltg8+86r9PRv+OfLDVZZ6YU0ut0pOHSnq/7cTz9bcoUOJDeVCm4mZqnzCmYfi2FMX6X54
	rKtQtvVYtooYoUWyFNqlnCr87/xHg6gpSofSB35n5kqEMA56wmRIfqvZzfXOE6g0Uu7g==
X-Received: by 2002:a17:90a:d88b:b0:381:528a:808c with SMTP id 98e67ed59e1d1-38dc75e3d4fmr9572711a91.12.1783976279067;
        Mon, 13 Jul 2026 13:57:59 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172b6ce6sm403816a91.1.2026.07.13.13.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 13:57:58 -0700 (PDT)
Date: Mon, 13 Jul 2026 13:57:55 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, corbet@lwn.net,
	dakr@kernel.org, david@kernel.org, decui@microsoft.com,
	haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org,
	kys@microsoft.com, leon@kernel.org, liam@infradead.org,
	lizhi.hou@amd.com, ljs@kernel.org, longli@microsoft.com,
	lyude@redhat.com, maarten.lankhorst@linux.intel.com,
	mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
	nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
	rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
	skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
	vbabka@kernel.org, wei.liu@kernel.org,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v8 0/8] mm/hmm: Add mmap lock-drop support for
 userfaultfd-backed mappings
Message-ID: <alVRU38lMfvmUFqJ@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <20260710151151.1e193eedd0cf2591ae392f76@linux-foundation.org>
 <alG2-RSitzPWClAX@skinsburskii>
 <20260710224950.53bcb43ce7e564f07a1f6a8c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710224950.53bcb43ce7e564f07a1f6a8c@linux-foundation.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	TAGGED_FROM(0.00)[bounces-11966-lists,linux-hyperv=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:jgg@ziepe.ca,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ee.iitb.ac.in,lwn.net,kernel.org,microsoft.com,ziepe.ca,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de,kvack.org,vger.kernel.org];
	FORGED_SENDER(0.00)[skinsburskii@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FA4A74F28D

On Fri, Jul 10, 2026 at 10:49:50PM -0700, Andrew Morton wrote:
> On Fri, 10 Jul 2026 20:22:33 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> > On Fri, Jul 10, 2026 at 03:11:51PM -0700, Andrew Morton wrote:
> > > On Fri, 10 Jul 2026 14:26:20 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> > > 
> > > > This series extends the HMM framework to support userfaultfd-backed memory
> > > > by allowing the mmap read lock to be dropped during hmm_range_fault().
> > > 
> > > Thanks.  This seems fairly mature and mostly-reviewed so I'll give it a
> > > spin in mm.git's mm-new branch.
> > > 
> > > Unfortunately Sashiko wasn't able to apply this or v7.  I'm not sure
> > > what base you were using.  Hopefully there's a reason for a v9 so we
> > > can retry this.
> > > 
> > 
> > I rebased this series on top of mm-new right before sending it out.
> > Should I have used a different branch?
> 
> mm-new is good - Sashiko attempts that.  But it's changing rapidly at
> this point in the development cycle.
> 

I’d like to send another revision addressing a few comments and also
replace the `max/max_t` check with something simpler.

Which branch should I base it on so that Sashiko can apply it
successfully?

Or would it be better to send fixups against `mm-new`?

Thanks, Stanislav

