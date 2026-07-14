Return-Path: <linux-hyperv+bounces-11977-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LnRFLr+WVmrf+QAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11977-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 22:06:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 683937589E7
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 22:06:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lXiePRH7;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11977-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11977-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 650C8304A97A
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 20:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEA1423EA1;
	Tue, 14 Jul 2026 20:05:57 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F4A4EA395
	for <linux-hyperv@vger.kernel.org>; Tue, 14 Jul 2026 20:05:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059556; cv=none; b=oyiER76FbjRLRjf/Y0YHwIPbbZvkc87YTy0JFIv4BirptFTjlVZVip4usDXaqW8kj+TuHURtN0RYIuX4l+K4HA9m4Zp+TOO77GKTcUh7BV55IOASJ1Mm7VemIdy8TrAn+oNLoSck5LyoMRKQYqzsDzdZfDi7wNUDFtAUJ93uoVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059556; c=relaxed/simple;
	bh=1uIy+Qd4I0VZk3IKsXvjdEcJk8DHXM5OZO3Y2c8nsVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAWewHTSMnD4Qh+UmxFtOtQigYC5jWPpcVAV6EEN9Tt3QcyGFBz3TWj6CEOyTnz4EDGi9g80t2nTXWM/oq3alDj2IMhX0qp1D/u5BLCZQoKx5Ri2s1KnJfLnJGdkX2hnbaCbLc/DSkoTL39pJehz/VV98BEgwcrHK3M6XCLkB7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXiePRH7; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so3006665a91.0
        for <linux-hyperv@vger.kernel.org>; Tue, 14 Jul 2026 13:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784059551; x=1784664351; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2TZmO5aEOGXmRgWMClTIlhAZCzNX5InAxzEzEi9D4GA=;
        b=lXiePRH7w9MGJyqOlo8uTDd/4y5uBW1g0tMgC14az7iiCSEzd7Uanjh2r4CT+ZOxho
         N8gZWIs0YIb63jXMothAfdUBtw63WXZe7XZcAvg5cY3vmUxArdpfSrW5u2JADEtjKBoF
         2iOJYOFo3CqJT6wBKO4xdX152LvIB5PKMLDyBN6X9a7AcvQsjL5wwttKWm86EAanDZ/f
         krk3xhjFZk7igPScYtg5QMvaGzI4GGziMJOwh30dA92QyhPkR3pT0XJCCemQ/GuX47wx
         JWjSvKGPRE61v1Oojp3XpYrvuNvqjiXK8QT4+U4DSOe3aHnPkciSg9DtO/23j5ZSqfeH
         gEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784059551; x=1784664351;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2TZmO5aEOGXmRgWMClTIlhAZCzNX5InAxzEzEi9D4GA=;
        b=K0iV09DYSHLXMSgdL0kfC1vE1iAWzYZ5uNHaPfya5d0ehcJg8ISsup5mYzpUG9tZHt
         dcD7wP40x+Fp3IpUG2ASpXh5gqFeYJ9o295TQGggif9hBeMRE8qI2CLy/19oO8+DYlKm
         FTopLUDyJ64tHnLwQCtV/6AwCwSL8BNITqGoPU3w+r/XCL3MC2l25Nc0mQrJY7B2qYPs
         Pllvxwglehj9Eu0lMeFj0seqJeEKoJUUTXQm96g9yeqwbGxmhSSs3qjA0AYTKvCazHfG
         iNFZ9fIUE86OGJYTRVWSFP7VfKk89bOcgWesWJecGa4O7tKIhQfdNpLmm8gTBgFbTMiE
         vNJw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/qWPGp7NAvlzG8C+U0tWsgcHLMU2/CX5WJ/qKkcmmxi3puncHCxN2iFZzXg3c4ewqtXOIU9T8t5GT+mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEBgTJZqb3wKqJqcqkNbxJfmgszXGo0M5OOop13Wg+YNgDa9d9
	VrkLn0hoLF2FxLMwWRtt504CeTxu6vHmvIFAOqpOvsTLxu0P85kV7GQ2
X-Gm-Gg: AfdE7cngLGc7rP3KdN46TbQyMjDHbBTguwOX0c6vewp+myo3Wt2CYzdG0f37h9ZXLAl
	XJ2ZpS23CekEGDS11RyoVXlHvLGcjdi9IjdSc67wtePRoAGP9hrMB+YGCfsebB8q5CZ4J/d0qnP
	tEOlftAJSMVfN5I2TwgZy1HGWL4tv/9eGf5FSiJ4YMLvb4szdkNBbe4i6Vx7oBGs6bTiWOVsVmk
	2aQQCoL/6RXLEQZKmITBf1kjppjC1bLh0dNt39tJ+3IJRappBs7DtViRP/ZW1c3FChb1rF5cUMh
	pwLFtkd4z8/VQRnJvYBdahfgj11HjZ/sXptTuCq33n88GfnPoFd22Fi+tzMHUqWoq5l7fJia1dx
	l0ggYZC6cGNIl9pc97tl6CmxvXzZLQz741qeJxCDn0Wg+VoFqUhdEkAXrFopK27jvk/4jCoP7Ow
	OycTfjOZwkRg9PLAhFAkre+izjNEeyAWWq9oxD7ymGeIofO+RXcFZdlRY=
X-Received: by 2002:a17:90b:57e5:b0:37f:be6c:f3f2 with SMTP id 98e67ed59e1d1-38e29ff93eemr138372a91.2.1784059550783;
        Tue, 14 Jul 2026 13:05:50 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172b6cfbsm2007674a91.3.2026.07.14.13.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 13:05:50 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:05:45 -0700
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
Message-ID: <alaWmUEeIBeSkmO0@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <20260710151151.1e193eedd0cf2591ae392f76@linux-foundation.org>
 <alG2-RSitzPWClAX@skinsburskii>
 <20260710224950.53bcb43ce7e564f07a1f6a8c@linux-foundation.org>
 <alVRU38lMfvmUFqJ@skinsburskii>
 <20260713154535.7656b3a630e2f6f076b4e76e@linux-foundation.org>
 <alZfTxfypj39OrCE@skinsburskii>
 <20260714105751.f45ec4c70702c222febdbf07@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714105751.f45ec4c70702c222febdbf07@linux-foundation.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	TAGGED_FROM(0.00)[bounces-11977-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,skinsburskii:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 683937589E7

On Tue, Jul 14, 2026 at 10:57:51AM -0700, Andrew Morton wrote:
> On Tue, 14 Jul 2026 09:09:51 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> > On Mon, Jul 13, 2026 at 03:45:35PM -0700, Andrew Morton wrote:
> > > On Mon, 13 Jul 2026 13:57:55 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> > > 
> > > > > > I rebased this series on top of mm-new right before sending it out.
> > > > > > Should I have used a different branch?
> > > > > 
> > > > > mm-new is good - Sashiko attempts that.  But it's changing rapidly at
> > > > > this point in the development cycle.
> > > > > 
> > > > 
> > > > I’d like to send another revision addressing a few comments and also
> > > > replace the `max/max_t` check with something simpler.
> > > > 
> > > > Which branch should I base it on so that Sashiko can apply it
> > > > successfully?
> > > 
> > > mainline Linus would be safest.
> > > 
> > 
> > Looks like linux-next/master has been updated with the v8 of the series.
> 
> That's because v8 is in mm.git's mm-unstable branch.
> 
> > I have v9 with a few small fixes, but it is too late to send it out already?
> 
> It's called "unstable" for a reason!  Material in mm-unstable is still
> under review, test and the latest stages of development.  Getting
> things finalized for movement into the non-rebasing mm-stable branch,
> then into mainline.
> 
> So altering or replacing patchsets while they're in mm-unstable is
> perfectly OK and expected.
> 
> > If it's not, then what should I base it on?
> 
> Well it's a bit tricky to replace a series when it's in mm-unstable. 
> One can do a git-checkout of the commit which precedes the v8 series. 
> Or base on current Linus mainline, which usually works out.
> 
> Sending little fixup patches against what's presently in mm-unstable
> also works.  I'll queue each one immediately behind the patch which it
> alters then squash them into their parent patch before moving the series
> into mm-stable.
> 
> A third alternative is for me to drop v8 from mm-unstable, then you
> wait until that has propagated onto the servers or into linux-next,
> then base on that.  This approach is OK but I kinda unprefer it because
> there's a bit of latency and it makes it harder for me to prepare my
> "here's how v9 altered mm.git" summaries.
> 
> 
> Which would you prefer?

Well, given that Sashiko didn’t pick up my series based on mm-new, I’d
prefer to send a few follow-up patches in the hope that they will be
reviewed in the context of the original series.

Thanks,
Stanislav

