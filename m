Return-Path: <linux-hyperv+bounces-10824-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLhHNtBLBGrNGgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10824-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 12:00:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE9F5310FA
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 12:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E5E03033536
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 09:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2F93E3D98;
	Wed, 13 May 2026 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="j3689UxF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390EF387347;
	Wed, 13 May 2026 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666259; cv=pass; b=IGoyo9WYY6AeBMnaVaFMLgVPcEeBp8FRXTeZhYLIxsI9KJXErZ0IKEnX5HYLOjILSgxAm7zpppG7/LQo/Nd2uDuAo9m9I7DvE6++DeZ8LUCiUX74cluQoJqcOUBZyj09hxGQRPuytcTAZp4IKxDzt8ipaMBJU1wKZVToDZacnnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666259; c=relaxed/simple;
	bh=RYA1EjPl5lTgedw7QcrGdDTzWzT0GvYmTYwNS/Jmt4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcLhZikamUNAVCMAdF1fm96UAyZQ6B+s1BE2P7ZP/NVTFXLCkbrnXfwBcL8MCtAFNHvPYdAfTepeDmpJ1DtLvOOiUtkU2kYiOtm2zjqkwtAn64JBqlHBcgQsjId+AsoF+YE/C4bwDu8ivQQIBPLbf7TbxEu2zERGvUaBd0T+Obg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=j3689UxF; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1778666246; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c4LxJbjGRGrqHBCMQI9d1DZXmEzSgjaMAVdOans2s0id/evYnF7f1+VTsZdgAFHiWq5XFV+gv8k8BFyUuRZQY2UFHpJ7WLduQ8eQL1OtXp9FCYB516Cl/iyVL9Dv90x5s/laBRHvH1mU4EtJ/IcIydm8FGCIAVf3t/FT51DGudU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778666246; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mCw0ukA7cqSglTemo+3wzTk+DiWMX/CnxSSQ/J0Wpac=; 
	b=OZkfkPEjgI53RCkhOvQHG5qvX4fWEhPNFWvRIUpuKsCkZKLjVxmgScYZBxYNsRUej+XlSlnEfxe4Ya9eWiHcYHFzLoZUALb3jeJmP2seTGechDPcZk9q5E/wsjMVfsxaCIGin2lqXJY7oklwmPoZnUI158xhKWj2sAoaQ3Xv34A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778666246;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=mCw0ukA7cqSglTemo+3wzTk+DiWMX/CnxSSQ/J0Wpac=;
	b=j3689UxFYw4Hi8fpLbACU1QV4/SF88byAlafQ0fwRtqU5LOutFrOxiGs4vcIEt9F
	bSuv25m1UwwUaG5/aFHRWAQ0bTi5NzPJZcG5avqBqyTMh6F/uPg5EzkHhFym4zo8+Bh
	RDQveqQOJwQU49Z2Bzl/97WHLzbsbbaIYF5HYniA=
Received: by mx.zohomail.com with SMTPS id 1778666244035328.7049140342921;
	Wed, 13 May 2026 02:57:24 -0700 (PDT)
Date: Wed, 13 May 2026 09:57:13 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/18] mshv: Order pt_vp_array publish against irqfd
 assertion path
Message-ID: <20260513-wealthy-prudent-tortoise-94deab@anirudhrb>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816865606.21765.9555294064589953949.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177816865606.21765.9555294064589953949.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 8BE9F5310FA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10824-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[anirudh.anirudhrb.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anirudhrb.com:email,anirudhrb.com:dkim]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 03:44:16PM +0000, Stanislav Kinsburskii wrote:
> mshv_partition_ioctl_create_vp() initialises a VP struct (allocations,
> mutex_init, init_waitqueue_head, page mappings) and then publishes the
> pointer into partition->pt_vp_array.  Several ISR paths read this array
> locklessly: the intercept ISR, the two scheduler ISRs, and
> mshv_try_assert_irq_fast() on the irqfd fast path.
> 
> Of these, only mshv_try_assert_irq_fast() can structurally race the
> publish.  It runs from an eventfd waker without holding pt_mutex, and
> MSHV_IRQFD does not require the target lapic_apic_id (== vp_index) to
> refer to an existing VP at registration time.  A user can therefore
> register an irqfd targeting a yet-to-be-created VP, then trigger
> mshv_try_assert_irq_fast() concurrently with MSHV_CREATE_VP for the
> same index.  On weakly-ordered architectures the reader can observe a
> non-NULL pointer in pt_vp_array before the initialising stores to the
> VP struct become visible, leading to use of partially-initialised
> fields (e.g. vp_register_page).
> 
> The other ISR readers cannot reach this race: the hypervisor will not
> generate intercept or scheduler messages for a VP that has never been
> told to run, and the user can only call MSHV_RUN_VP on the VP fd
> returned by MSHV_CREATE_VP, which by construction is returned after
> the publish.  Leave those readers as plain loads.
> 
> Use smp_store_release() in mshv_partition_ioctl_create_vp() to publish
> the pointer, and pair it with smp_load_acquire() in
> mshv_try_assert_irq_fast().  On x86 these compile to plain accesses
> under TSO; on ARM64 they emit one-instruction acquire/release barriers,
> acceptable on this fast path.
> 
> The destroy-side path (destroy_partition() clearing pt_vp_array[i] to
> NULL after kfree(vp)) has a separate ordering and lifetime concern
> that is out of scope here.
> 
> Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_eventfd.c   |    9 ++++++++-
>  drivers/hv/mshv_root_main.c |    8 +++++++-
>  2 files changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


