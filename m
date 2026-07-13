Return-Path: <linux-hyperv+bounces-11962-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ri+EI78YVWqrjwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11962-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 18:56:31 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA7F74DC98
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 18:56:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pZ6p7Hie;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11962-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11962-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EEB33024184
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E58743F4DF;
	Mon, 13 Jul 2026 16:56:17 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111D9330B01
	for <linux-hyperv@vger.kernel.org>; Mon, 13 Jul 2026 16:56:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961777; cv=none; b=lyGB7hSv6usaloG0jueJ3DLGOwHwY5s8iyygfkAyPC0dmWdLqPNWwHQ2YjDI3YIm7iuJgdBNpejYLpW+C5+Q7cN1il4YXq+NcSUX29sAt4yya0ZZ9Ve0shCHIHrNgD+rL3ySGevFTY4VWXHIZMsvQ5IyzwjnyaMJu8566mdMGZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961777; c=relaxed/simple;
	bh=wYe7kym3kczWr73lptfB1bTj81zD5wvAqQaXYZ4DW5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwpLszAuZcRowUgzyIkDfyO4/Fw730uR1YlbVnUHkUv4rlkVr8VcF0aAhpjcT7zQgCjGNPUtZmz8+TIFf/wPwjs+ODhzMoskYRu6dl11X48iOh410zLlYUMyXqSz5x35WY7fK9qaeZ6tNVZXzw0goHE4EAcjrktbzqqttxxxsDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZ6p7Hie; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso78967a91.1
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Jul 2026 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783961775; x=1784566575; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+wyTThpzWI663yfCX7yR0ohXV0bj+fwjL2+oCBrswHw=;
        b=pZ6p7Hie+ZuMyCjYswdbNFYtHYwpTiPQJeBxQDgIy7EmtqA3YwrisiUmulxHWcgh7p
         mSzANG/LXXobjGulyTi2kSjzBvp+JDDbq1wXipDZgrSJWUj1crZjkt2sxlTMK/zueLf7
         5yPmfr75fWWklrWpWcDCcHrcGG157arPtZtcY2FARd/IaVTlv1jRZfHH+eqHXs12qk3G
         A1xBemqKnmwrdUlPtwZs8SH4WDWAbkeFi8shvGawPWatfrORXtRU+Zq89GODYbZc/wYa
         2Pe75HEhtpy9RKIUzBPRBHmH6bodAKIQlnOkVGuH4YWIkHJyDGjDsclp+F/R+JU8qqkD
         UxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961775; x=1784566575;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+wyTThpzWI663yfCX7yR0ohXV0bj+fwjL2+oCBrswHw=;
        b=FSkAo0O8N9+KV3QRPasq2W0Kre1kQZtwKmiLz3PJKaBU/znAgGBi/UwDhLNbInFoSc
         pOSn2D0coT41SgkcZ/Tg/3IbXcO+QFThXTfgUrHLx8WdLINmGcl7GzGtKzxkLxy73APp
         yi7R0KGRcJysxrSU+AzHI34FabKHPBepYgAEU28C64Ir8jS2K0HPnsqP0PMgkapCtsqv
         ajtashUIIeUrXfEJVQmydPklvr/Qb/lZfn1ODkJbuKq9KDCAQ8uWIdYuMPDpFNuu5sGi
         J6rknsApMI9FqpVBfbU1MMH3MGpmJr2zyb3LiMvs2ydhOzCQgV+NJJm+ydk2aVbV3KuS
         ecPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpvUTo8okheGabzHCOYcDJUts/1LCfmHLywwilDcQn4bHtVPGFhFntd87YNd9nYI0IC+pxbaukVZ9lo0s0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+PgiuokbGHOc/G48/9eU0T172jb/yruwNCWLiPvFkjEXrW9M
	asNgv41COHxkFHf6e4C0DxPPtB66cxYOpMwxQAVgto9La/BhT1i+z1gt
X-Gm-Gg: AfdE7cmLNp5WRyJhFocgEHLB/bZhX/5b6BodFvcTrDzxy1S0GoQfjwXxAl1mC98GKeC
	WO0n4J+BfdYsHOmIdJeik2wim3JUHKUjJMR61E4S0iLaeoIGAEDtuy1UrNqKIDNZhdUeyl6518E
	HLShkjiReu8v0yvgTEIrafsr4Da8oT1EtnrMZZFrZgarPZqbn9Cjn60tLQc3oU/SAdrVQN0H5T+
	/SKXKqyjtP+mxfZkrLoFZeuN9emJKtVmrD/Npx3N2pDADOjRMTiDkmbAqOt+VyHzBDgNpa6embc
	ACw3hwmy4v44la9SK6BNKlI1DpJWR916ayT9neAk25yygkW3T4jGDvYys717FC4pF2kme+Tho+Z
	nWWuf6LoMVh7q8N59ng+HeeTRGSlB3UHMTVamjleBKnzm27rll10dGKMKdFNSLQ29MsxaurmglO
	7jn+Cpphj/Ni5NglCUzbyoN2EUN6leNBiRErqJDU6HMxgDCpYd8KS+qdY=
X-Received: by 2002:a17:90b:57cb:b0:36b:769c:c037 with SMTP id 98e67ed59e1d1-38dc81978ecmr7351194a91.5.1783961775319;
        Mon, 13 Jul 2026 09:56:15 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e1745a596sm180718a91.15.2026.07.13.09.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:56:14 -0700 (PDT)
Date: Mon, 13 Jul 2026 09:56:12 -0700
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
Subject: Re: [PATCH v8 4/8] mshv: Use hmm_range_fault_unlocked_timeout() for
 region faults
Message-ID: <alUYrESVcHR_p-S_@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <178371881034.900500.5214601525971121683.stgit@skinsburskii>
 <20260710151216.0397a6f9ac5c7b4ccd274cc1@linux-foundation.org>
 <alG1JwgUK44dCiN4@skinsburskii>
 <20260710224606.69235ab5c49b5987fd33e924@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710224606.69235ab5c49b5987fd33e924@linux-foundation.org>
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
	TAGGED_FROM(0.00)[bounces-11962-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BA7F74DC98

On Fri, Jul 10, 2026 at 10:46:06PM -0700, Andrew Morton wrote:
> On Fri, 10 Jul 2026 20:14:47 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> > > > +	mutex_lock(&region->mreg_mutex);
> > > > +
> > > > +	if (mmu_interval_read_retry(range.notifier, range.notifier_seq)) {
> > > > +		mutex_unlock(&region->mreg_mutex);
> > > > +		cond_resched();
> > > > +		goto again;
> > > > +	}
> > > > +
> > > 
> > > If the calling process has realtime scheduling policy and either a)
> > > we're uniprocessor or b) this process and the holder of
> > > interval_sub->invalidate_seq are both pinned to the same CPU then
> > > cond_resched() won't do anything, and this might be an infinite loop?
> > 
> > Yes, looks like it might.
> > What can be done to prevent this?
> 
> Well the best way is remove the polling loop and use a proper sleep/wakeup
> mechanism - mutex_lock()/prepare_to_wait()/etc.
> 
> If the polling loop is to be retained then maybe msleep(1) or
> usleep_range()?

Well, running MSHV - or, I suppose, any other VM - on a uniprocessor host
would not be very efficient.

I’m not sure whether this corner case needs to be handled explicitly.
But even if it does, supporting or explicitly forbidding it would be a
separate change. As Jason noted, this is not a regression introduced by
this series.

Thanks,
Stanislav

