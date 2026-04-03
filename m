Return-Path: <linux-hyperv+bounces-9949-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNs4FqtDz2k3ugYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9949-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 06:35:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A380B390EFD
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 06:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D80443012C55
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 04:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D672F308F1D;
	Fri,  3 Apr 2026 04:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="ob9644sx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6571D199FAB;
	Fri,  3 Apr 2026 04:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190924; cv=pass; b=J4ilYNjtQ7a7rAu37oNvDTV0VxAeY2MGGYkbQB7YT+d2TvJK02WJoL9tYBHIQiILACdMKaSx66hGYjCi4feMAG1W0VeIM35BttuzpQGjXkaD4ZPD/PDWt6jMKBCdpotkbRqbDEMuFgEp9Y0WwZxVV5xuVfPmN+8e0xRcZN4nlLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190924; c=relaxed/simple;
	bh=53egjnL1OKq0GbU774VLjHSsx6HFDO+RvmWuUSFIQpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKYtmjUzDCALcrXGrM3/JP95oxnN6HUmkpV4izLHzCybytuBoLO9f0qe2QPGjbVEou6SIhG2JqxV23UmSlhhu+lypiiQHX9y23t8285T0YcWjbquK55aN+DAQjE+DFHJrp8mCWJdKjQvtdSqWhEWWpJ5MFzJQuKLD1vECPfFfTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=ob9644sx; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1775190895; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=buFSmw0+AAYx/nTRHqD3XRhe8RxvCAsBjjz1F0mRStScmhDp4IJn1SO+ZN5gBos3PKzMQ2BSHNde4Ss+YdTUzqrYPzx9Lc+/hdxtJNeCm6rLufJhQtLzBmYBmL7vF4BBhYIfyglWzPwuA5s4ozKJmN/gZoxq72vcH68yHtOxItk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775190895; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZV73pn+v9d/KwU6f76PKtM3XEeR9qNT2vzJWpBho5c8=; 
	b=Kr4d5KLAYrkWKB9GntNO2aHpQW/acfTwp2GR/tBUCkm7/6pcJEmBN3oyQVKWXJh08XuRzbnGhB92RxrfPIsG0dofi3L3GMh6cL2/YvsjT6p0PMMMmzF2rEIuGnyhAcaVYqOcYA63DXz/z7HQjzrNkM1u093OuzoPeBZ+R5c7Mt0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775190895;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=ZV73pn+v9d/KwU6f76PKtM3XEeR9qNT2vzJWpBho5c8=;
	b=ob9644sxu+KHFl71+wd0UTGxSQ947vjxX68CpXmFVdEow64tgZxKS4OMnXXFMjHm
	pm7h9hS0V+XbVaPv2yWxCLPC207EKHMgDLgDDv74K66ZOxqcuO1tegPgY1jkBuyDNVi
	U256kpSQEQGwggobQ+EK/aHFRMy6Arl8+cOyzGhw=
Received: by mx.zohomail.com with SMTPS id 1775190893222914.1172856120195;
	Thu, 2 Apr 2026 21:34:53 -0700 (PDT)
Date: Fri, 3 Apr 2026 04:34:45 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Roman Kisel <romank@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/6] mshv: limit SynIC management to MSHV-owned resources
Message-ID: <20260403-natural-fuzzy-kakapo-f5cbab@anirudhrb>
References: <20260327201920.2100427-1-jloeser@linux.microsoft.com>
 <20260327201920.2100427-5-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327201920.2100427-5-jloeser@linux.microsoft.com>
X-ZohoMailClient: External
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9949-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linux.microsoft.com,outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A380B390EFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 01:19:15PM -0700, Jork Loeser wrote:
> The SynIC is shared between VMBus and MSHV. VMBus owns the message
> page (SIMP), event flags page (SIEFP), global enable (SCONTROL), and
> SINT2. MSHV adds SINT0, SINT5, and the event ring page (SIRBP).
> 
> Currently mshv_synic_init() redundantly enables SIMP, SIEFP, and
> SCONTROL that VMBus already configured, and mshv_synic_cleanup()
> disables all of them. This is wrong because MSHV can be torn down
> while VMBus is still active. In particular, a kexec reboot notifier
> tears down MSHV first. Disabling SCONTROL, SIMP, and SIEFP out from
> under VMBus causes its later cleanup to write SynIC MSRs while SynIC
> is disabled, which the hypervisor does not tolerate.
> 
> Restrict MSHV to managing only the resources it owns:
> - SINT0, SINT5: mask on cleanup, unmask on init
> - SIRBP: enable/disable as before
> - SIMP, SIEFP, SCONTROL: on L1VH leave entirely to VMBus (it
>   already enabled them); on root partition VMBus doesn't run, so

Actually, I believe VMBus does run on a nested root partition. Doesn't
it? That would then be another case to handle in this patch.

Thanks,
Anirudh.


