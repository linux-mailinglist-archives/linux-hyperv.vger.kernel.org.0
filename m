Return-Path: <linux-hyperv+bounces-10673-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCp2Kb2P/GlhRQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10673-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 15:12:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8134E8FE6
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 15:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62B003034DD1
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 13:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252CA3F9F27;
	Thu,  7 May 2026 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="DyfJWvy9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7807F3F7896;
	Thu,  7 May 2026 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778159109; cv=pass; b=GjfIndXqktK7MkCZ+2VKvUIudWloUglowUrFEG2zmYA+jbSn+DdGsK8atInbJZZEWeGGob7XTUsWg2Byzx5NAAv37dCNI5s+bOkllZF2nz7gJNgKVZAItHObh03aJ5llz7gBQQtNNAXoHys0k89vq5+VPnFk47QytJXtqQd/MXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778159109; c=relaxed/simple;
	bh=ZYCdlAbQgv8Kcqsy1+cEBf+0CXdRsC0Ofa3+aoRWDF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jS6IjVVWJIHkmTWkcrtuEuXjxYfEggJflxUaylobFQxOQZZaGyZyV59/JM1230fN7QJ186FwvI7cTGGrQQiJcfnMUsj5G89uFH9bXnWrZ7hHoxmZ812idywXS31cVbX7NyrG68Tdrt1vHzxnDni+S6zO9Q1fZ3a1fpH2Ba8P+Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=DyfJWvy9; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1778159096; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BlOAlp+3r/Ap74axR+CJ3NGvZme3Nlt0Q8tKkAJWRv8LANxvz+w/Oc7CR9psabqNCm4zvGvICwBr+0qcCEyUfEC26rXYKz2xJ4QvKVk6Cx9etMDF6DzKugcZCUTtmbVzWJo8OHCZq8K0ne2uQjOQUfvDhohFqx/fLg4F/TZjD0w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778159096; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2JaQRn6OKa3xjghXI/I52IqjfKLOzsbWaUWh1o+pdBY=; 
	b=FZ3fj/JW3xXjhMeOQYwPKP1RlP7N/IaV0jpmymefM5cTHgj02lDtALb3OApxN3qfpCz0UvUGg+0HmFQaSwOE9GdI2ZWlTr0FrV+3ZGN5t6UqJ8N9fZpMF7pZzZfN5cD/91sl06ANjVbkU4u7C/8TQM42ILh06D2wdHYwYn2g3DQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778159096;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=2JaQRn6OKa3xjghXI/I52IqjfKLOzsbWaUWh1o+pdBY=;
	b=DyfJWvy9Gz+/YqDnHahQrbucmNMNUa1AezDB68ldnKWSFb5o1VhxcEBv38TE5pUa
	otfBatlTzgAsdGgWR/zznboa1YHOw5kC0mSt2FixWAzw2KZJxZyMat7ejDqd0/StFMM
	RWR1ldafqAuDykZmkXJThyhEed5R6WZLTnSk/W44=
Received: by mx.zohomail.com with SMTPS id 177815909338948.467473220813645;
	Thu, 7 May 2026 06:04:53 -0700 (PDT)
Date: Thu, 7 May 2026 13:04:46 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mshv: Simplify GPA map/unmap hypercall helpers
Message-ID: <20260507-didactic-celestial-sparrow-dc7a1d@anirudhrb>
References: <177756065245.17889.140699174692055235.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260505-efficient-victorious-degu-d5ec2e@anirudhrb>
 <afoGGj1dCKDpVcy_@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afoGGj1dCKDpVcy_@skinsburskii.localdomain>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 6C8134E8FE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10673-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, May 05, 2026 at 08:00:42AM -0700, Stanislav Kinsburskii wrote:
> On Tue, May 05, 2026 at 06:13:01AM +0000, Anirudh Rayabharam wrote:
> > On Thu, Apr 30, 2026 at 02:52:17PM +0000, Stanislav Kinsburskii wrote:
> > > Clean up hv_do_map_gpa_hcall() and hv_call_unmap_gpa_pages() after the
> > > preceding bug-fix patches:
> > > 
> > > Move "done += completed" before the status checks so that pages mapped
> > > by a partially-successful batch are included in the error cleanup unmap.
> > > Previously these mappings were leaked on failure.
> > > 
> > > While here, improve type safety and readability:
> > >  - Change "int done" to "u64 done" to match the u64 page_count it is
> > >    compared against, avoiding signed/unsigned comparison hazards.
> > >  - Use u64 for loop iteration and batch size variables consistently.
> > >  - Add proper braces to the for-loop body in hv_do_map_gpa_hcall().
> > >  - Remove unnecessary "ret" variable from hv_call_unmap_gpa_pages().
> > >  - Simplify the error-path unmap to use "done << large_shift" directly
> > >    instead of mutating done in place.
> > > 
> > > v3: aligned changes by 80 colons
> > > v2: replaced min with min_t
> > 
> > This part describing the changes in various version should be placed
> > after the "---" line below. This way it won't appear in the final commit
> > log.
> > 
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#commentary
> 
> Thanks for the geidance, will do next time.
> 
> Thanks,
> Stanislav

Wei might fix this while committing or maybe ask you send another
version. But either way:

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


