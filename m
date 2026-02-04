Return-Path: <linux-hyperv+bounces-8697-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMitHJnkgmnXeAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8697-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 07:18:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A25E2442
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 07:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 167E33004D8A
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 06:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043A03659F8;
	Wed,  4 Feb 2026 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ji9H29A4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D4E257459;
	Wed,  4 Feb 2026 06:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770185875; cv=none; b=q4NANjkB5s/Xq1/Bvk/utytjYs4ANovkjyiufc6QY/yq4ebCPJvWn9QJcpXTahEd1v6S+EXeebIZPD2uU4tBpGZ6hl3jfqRMhCYxd8nUiqlhLWilEpfCSUEZLOR5riL5MMSk0Y5ykKKKEkeOiAUD3OmbwYw+tDU4tHehLBEGd+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770185875; c=relaxed/simple;
	bh=Kh1smmysGz1nepbLrobU29MXGw0xgSZ0akmiQo+9bOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsVO1vV2z8qRx3utaVcb7KUNo9kQHio3//iBn9MRQ64zlktPbkJ4fJBPvajkppoE/W/AXJ/qGIdUE8mlaCyaDTYZ51QgdAFQ9Y0YfUnfeoDkjeLdniXxFQmgPOlWmEgoe4CYnEgwkfEhoLeOOy2gwu4XMR075KQLG9vR/Bm5u6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ji9H29A4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F939C4CEF7;
	Wed,  4 Feb 2026 06:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770185875;
	bh=Kh1smmysGz1nepbLrobU29MXGw0xgSZ0akmiQo+9bOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ji9H29A4YvL4Kb3TRh0veDiQIXsUG4o4/2K3YjgQczdAfhP23m+pvxYXuSO19JJya
	 ZOMFv8ZFOQ6GIo1ukKBH4svEH9fWQYdx+GJjOTNaofDji+ETt/xczRPGHZN3PbU6nh
	 ZU7dmGuC/zkSZvk3NwdQjY/uQCEqAfY84GuCuxwk2Ai7h5szSdATcO2d/YK0tOIYVd
	 vUMXO9hrF9jTT+ZgwTfTU/TLQT1Ixkxc/qgHkPhBNG5cLeKmZ345bDiWVvdnsqpko6
	 WGp9fig46onHV+xUYXPoshYmfiVcU/v7YY1XmYxmL6Rabw1a1AjOF6lDuUcGC7p4qK
	 IKPi2mWo8A+2A==
Date: Wed, 4 Feb 2026 06:17:54 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhklinux@outlook.com, skinsburskii@linux.microsoft.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	prapal@linux.microsoft.com, mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com
Subject: Re: [PATCH v6 0/7] mshv: Debugfs interface for mshv_root
Message-ID: <20260204061754.GF79272@liuwe-devbox-debian-v2.local>
References: <20260128181146.517708-1-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128181146.517708-1-nunodasneves@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8697-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,outlook.com,linux.microsoft.com,microsoft.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: 92A25E2442
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 10:11:39AM -0800, Nuno Das Neves wrote:
> Expose hypervisor, logical processor, partition, and virtual processor
> statistics via debugfs. These are provided by mapping 'stats' pages via
> hypercall.
> 
> Patch #1: Update hv_call_map_stats_page() to return success when
>           HV_STATS_AREA_PARENT is unavailable, which is the case on some
>           hypervisor versions, where it can fall back to HV_STATS_AREA_SELF
> Patch #2: Use struct hv_stats_page pointers instead of void *
> Patch #3: Make mshv_vp_stats_map/unmap() more flexible to use with debugfs
>           code
> Patch #4: Always map vp stats page regardless of scheduler, to reuse in
>           debugfs
> Patch #5: Change to hv_stats_page definition and
>           VpRootDispatchThreadBlocked
> Patch #6: Introduce the definitions needed for the various stats pages
> Patch #7: Add mshv_debugfs.c, and integrate it with the mshv_root driver to
>           expose the partition and VP stats.
> 
[...]
> 
>  drivers/hv/Makefile                |   1 +
>  drivers/hv/mshv_debugfs.c          | 726 +++++++++++++++++++++++++++++
>  drivers/hv/mshv_debugfs_counters.c | 490 +++++++++++++++++++
>  drivers/hv/mshv_root.h             |  49 +-
>  drivers/hv/mshv_root_hv_call.c     |  64 ++-
>  drivers/hv/mshv_root_main.c        | 140 +++---
>  include/hyperv/hvhdk.h             |   7 +
>  7 files changed, 1412 insertions(+), 65 deletions(-)
>  create mode 100644 drivers/hv/mshv_debugfs.c
>  create mode 100644 drivers/hv/mshv_debugfs_counters.c
> 

Applied to hyperv-next. Thank you!

