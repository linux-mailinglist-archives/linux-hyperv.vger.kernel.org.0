Return-Path: <linux-hyperv+bounces-8886-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC+1EuZylWlaRgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8886-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 09:05:58 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B568153D9B
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 09:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ECFA3011864
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 08:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7390E30FC06;
	Wed, 18 Feb 2026 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGwzO4fB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504B230F7FE;
	Wed, 18 Feb 2026 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771401955; cv=none; b=Ii1rYG66QDGswKR068NhCtaa5zmVSxk1oCfonsjHHUgULHAyuJ1ItHNPUelqjJr0L3AS1KJ/hdsvE5RMW+EQzNJAiMHFqPNhjU6/FryHMXDfiDvgaPKY5DDXFpO/9A+mm7Qi3ePgu9gr9f9gpmS9Pa9cMBJ563nWivgpOaownnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771401955; c=relaxed/simple;
	bh=prR4rQg25f/kOJgYSr0Inu3cWRsJz8ynFpQBA5dYaBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udj/Y2F88hqGB5kRb6xaRNJoRYAaRpTaAyMcYte9/i4oXxOg/fDeWvHL32lm+mH1aRevHftLgl7cjJyhM+b6QnRdrL/Xg4OfntvQUR/tJHfjc3y5GvThDIivMMpN3fwpNBRljU2Z/06OwzT1LqiwG/bqrI0JwzwGOXnnMESl+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGwzO4fB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0539FC19421;
	Wed, 18 Feb 2026 08:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771401955;
	bh=prR4rQg25f/kOJgYSr0Inu3cWRsJz8ynFpQBA5dYaBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZGwzO4fB55PJn0zRqTy2MYlyZcW9YGn5PhDLGhkmcsj7BW+1ucaZ/WDLZKqtlk2/S
	 v80eAHJBvp4YzdLZQiW9bsIxg9pjrbKtSiG+FaabRnNOeD2BjyGsALxFdlvXeChSVa
	 AAdTm/wG6BmKUt7y8Q3cjXstpTm9mhcav+23umMqsE1R7bcah+n3a9mXW9u/dti4Kx
	 A76R9dzagaTVBmMRrNFi6O05KonVOYN7afdRDNJMkWjcrVHA+rIEQBfCg8e57xPgie
	 Rf5DIa0y5Yf3ZOx5kAu0BXp9FFbBHENrtyDjbqL+3bxLNIA3Ykt97dkoOgPg7oRupg
	 9JlC/eTmeSB3g==
Date: Wed, 18 Feb 2026 08:05:53 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mshv: Add support for integrated scheduler
Message-ID: <20260218080553.GH2236050@liuwe-devbox-debian-v2.local>
References: <177006034399.132128.8748943595417271449.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260204071816.GN79272@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260204071816.GN79272@liuwe-devbox-debian-v2.local>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-8886-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 9B568153D9B
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 07:18:16AM +0000, Wei Liu wrote:
> On Mon, Feb 02, 2026 at 07:26:06PM +0000, Stanislav Kinsburskii wrote:
> > Query the hypervisor for integrated scheduler support and use it if
> > configured.
> > 
> > Microsoft Hypervisor originally provided two schedulers: root and core. The
> 
> Microsoft Hypervisor provides three schedulers: root, classic
> (with or without SMT) and core. The latter two are hypervisor based.
> 
> > root scheduler allows the root partition to schedule guest vCPUs across
> > physical cores, supporting both time slicing and CPU affinity (e.g., via
> > cgroups). In contrast, the core scheduler delegates vCPU-to-physical-core
> > scheduling entirely to the hypervisor.
> > 
> > Direct virtualization introduces a new privileged guest partition type - L1
> 
> Level-1 Virtualization Host.
> 
> > Virtual Host (L1VH) — which can create child partitions from its own
> > resources. These child partitions are effectively siblings, scheduled by
> > the hypervisor's core scheduler. This prevents the L1VH parent from setting
> > affinity or time slicing for its own processes or guest VPs. While cgroups,
> > CFS, and cpuset controllers can still be used, their effectiveness is
> > unpredictable, as the core scheduler swaps vCPUs according to its own logic
> > (typically round-robin across all allocated physical CPUs). As a result,
> > the system may appear to "steal" time from the L1VH and its children.
> > 
> > To address this, Microsoft Hypervisor introduces the integrated scheduler.
> > This allows an L1VH partition to schedule its own vCPUs and those of its
> > guests across its "physical" cores, effectively emulating root scheduler
> > behavior within the L1VH, while retaining core scheduler behavior for the
> > rest of the system.
> > 
> > The integrated scheduler is controlled by the root partition and gated by
> > the vmm_enable_integrated_scheduler capability bit. If set, the hypervisor
> > supports the integrated scheduler. The L1VH partition must then check if it
> > is enabled by querying the corresponding extended partition property. If
> > this property is true, the L1VH partition must use the root scheduler
> > logic; otherwise, it must use the core scheduler. This requirement makes
> > reading VMM capabilities in L1VH partition a requirement too.
> > 
> > Signed-off-by: Andreea Pintilie <anpintil@microsoft.com>
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> [...]
> > +++ b/include/hyperv/hvhdk_mini.h
> > @@ -87,6 +87,9 @@ enum hv_partition_property_code {
> >  	HV_PARTITION_PROPERTY_PRIVILEGE_FLAGS			= 0x00010000,
> >  	HV_PARTITION_PROPERTY_SYNTHETIC_PROC_FEATURES		= 0x00010001,
> >  
> > +	/* Integrated scheduling properties */
> > +	HV_PARTITION_PROPERTY_INTEGRATED_SCHEDULER_ENABLED	= 0x00020005,
> 
> The internal name is "HvPartitionPropertyHierarchicalIntegratedSchedulerEnabled".
> 
> You missed the "Hierarchical" part in the property code name.
> 

I attempt to apply this patch and fix these issues. Unfortunately it
doesn't apply cleanly to hyperv-next.

Wei

