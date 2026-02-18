Return-Path: <linux-hyperv+bounces-8907-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDxbLTJLlmkmdgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8907-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 00:28:50 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2126E15AEE1
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 00:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C652530146B5
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 23:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E3233ADA2;
	Wed, 18 Feb 2026 23:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOVNSRc2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D7233AD89;
	Wed, 18 Feb 2026 23:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771457328; cv=none; b=aDUaJyAZOkDVLrBLtul7Ohd80zydIOamwgsKKgeGOe8j+AWN24duxblU5Zp04AAdu8KFMklZH6wMLeg9BJtOxt66bQPQzzQzEpf5kRGKd6G6HePbWPYUcV2P15STAuLXiZX/XBdNbIkgsUyuUmJu124Yri1IdrXMRg+p263CbtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771457328; c=relaxed/simple;
	bh=IBAkS8u6VNd52AA9lZsLMbz/p5Vg+98qG1j9tdgSt6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZWteyp0KTFZM4D6haYl7MmpBpPcqRPEehXYtCBT3QzJvEQJIPG4F+ZFdrki08uyfth4gu15lqbD7gVQR/0COOu3DI/+Vm8vCEwM1UoucFt3Mux8+99Xsqqa1eidZpFMnEJWl0M236Je1BhBYfba0tQCfymS0Ycn8oLibg/+vLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOVNSRc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B164C116D0;
	Wed, 18 Feb 2026 23:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771457327;
	bh=IBAkS8u6VNd52AA9lZsLMbz/p5Vg+98qG1j9tdgSt6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOVNSRc2Fl8JxKgtYpTVmHa04QplzzNANbWMkzimAdt9Y9OUyRzVpcKQewAtl92VL
	 1dYBIzb5E2qdhid9m1tdvwfR8EvF5Q2FS+VOx9pixQkvwrLjVOmbzhhAmOICact/iO
	 /erHJ9fJdxkvXcVBYZMNSB1jKvotSObQuvspBNm/x2iPUseVQq3SYxHL0FlY+r0VCf
	 hKrbsV2D3Zbo+QEKcSTtxUGBEYsqLnH2Yp/lahGrMbQMGUqwvlm9ErLRamtsmZ8x0q
	 maKB5nS0UzSgyvWgxnfDHxCscth6PH6qLU4h2c7I53jsXxhm15DhX4CxdZWzUd0FDP
	 6KrMgiBDIeIkw==
Date: Wed, 18 Feb 2026 23:28:46 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] mshv: Add support for integrated scheduler
Message-ID: <20260218232846.GL2236050@liuwe-devbox-debian-v2.local>
References: <177144189787.43429.7425661016523660268.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177144189787.43429.7425661016523660268.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-8907-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2126E15AEE1
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 07:11:40PM +0000, Stanislav Kinsburskii wrote:
> Query the hypervisor for integrated scheduler support and use it if
> configured.
> 
> Microsoft Hypervisor originally provided two schedulers: root and core. The
> root scheduler allows the root partition to schedule guest vCPUs across
> physical cores, supporting both time slicing and CPU affinity (e.g., via
> cgroups). In contrast, the core scheduler delegates vCPU-to-physical-core
> scheduling entirely to the hypervisor.
> 
> Direct virtualization introduces a new privileged guest partition type - L1
> Virtual Host (L1VH) — which can create child partitions from its own
> resources. These child partitions are effectively siblings, scheduled by
> the hypervisor's core scheduler. This prevents the L1VH parent from setting
> affinity or time slicing for its own processes or guest VPs. While cgroups,
> CFS, and cpuset controllers can still be used, their effectiveness is
> unpredictable, as the core scheduler swaps vCPUs according to its own logic
> (typically round-robin across all allocated physical CPUs). As a result,
> the system may appear to "steal" time from the L1VH and its children.
> 
> To address this, Microsoft Hypervisor introduces the integrated scheduler.
> This allows an L1VH partition to schedule its own vCPUs and those of its
> guests across its "physical" cores, effectively emulating root scheduler
> behavior within the L1VH, while retaining core scheduler behavior for the
> rest of the system.
> 
> The integrated scheduler is controlled by the root partition and gated by
> the vmm_enable_integrated_scheduler capability bit. If set, the hypervisor
> supports the integrated scheduler. The L1VH partition must then check if it
> is enabled by querying the corresponding extended partition property. If
> this property is true, the L1VH partition must use the root scheduler
> logic; otherwise, it must use the core scheduler. This requirement makes
> reading VMM capabilities in L1VH partition a requirement too.
> 
> Signed-off-by: Andreea Pintilie <anpintil@microsoft.com>
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Applied.

