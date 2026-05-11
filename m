Return-Path: <linux-hyperv+bounces-10737-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNb3Mo1RAWq+UgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10737-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 05:48:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C961507C26
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 05:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E824A301CF86
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 03:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7F921CC51;
	Mon, 11 May 2026 03:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="j07Nby/G"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0EF37C907;
	Mon, 11 May 2026 03:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778471209; cv=pass; b=aeUfOHt6FQdu5DGjYJGiSDONSn7nOFG4SNo4tMtv7WHIyj2rTlhZr/BZijT/851EgMq1QovDQdYNtuJx7ZL3y5aCddgId3XKJ2gUfyPXJCBzAtzgqgzGCFfpvNkXtl1eIrGznvIo3wmFPZEeXxCfLWGQtMaxR25uWwmfi1SZE8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778471209; c=relaxed/simple;
	bh=mmKBaLjFhNUWZtqM/TYvk0LCupog8OQza9Uv5egSbw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzA/ScSIo77UjabTcJBRYN5O3CtRmjzykFUH6Oqw3KUCDIfWq80DkGJVX/QuOfrcNG7Y+kTYPxCFqFfmanAOuDZpL27aE6NJvi2qfYjKKXPJuOf3x8aO/TDJTb9ABfwN124g/qDY2Gh2aM4+7HZ/YF+kzfSJn3GqF8At7JBsyxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=j07Nby/G; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1778471199; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LpHJF3Wbmn0LD+lp1sCjpOLeKOI/nIBYzmd3O21iEgd8QysIMvOJHUmnDBGEQmc9Rizrjt7MQ/UOi9ooEc+0EEwEi1jwQB7iscP94eZrpxmIqHzQYC+q1z1BXjfAiwbZEGZqgQfk4g4iCYfm40yS0PmD++6WshB1qioq24XY9yo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778471199; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=swj8A2RoycoOlNQSV2ssdy0cbAkxlMn7X6gFrTc4kbY=; 
	b=hNA7BPYW/mCXErXdUNaEo5aCC2dyh7h1IaeYaTWo+ry7s1nOrpDXhPyyxs/gZi6Qa1LYvi520eVTHzNblwWT/aTx8xMuE9jhrE+P8wDi0t+weSKavQwn3oM+U8KM9Q24HwK9rP+vkTgGMuQQJTYznY7TKkpb4WClUR59LTp+s08=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778471199;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=swj8A2RoycoOlNQSV2ssdy0cbAkxlMn7X6gFrTc4kbY=;
	b=j07Nby/GeQSZmeDuV9Ef8JytIMOnp8trdV6o0SqRX6SZeaqC9wAIpMLSZOnUMKOO
	iUSXBER8THvnXUc035QXTgOfpU93Ypf+oKwcIoUxtH17UnMziFtOG9G6OgfgDduBxsh
	kd6E/vQ0wRbETqi6/z0F63LRhESQOO0sD9ZvmUPg=
Received: by mx.zohomail.com with SMTPS id 1778471197807776.2446057236166;
	Sun, 10 May 2026 20:46:37 -0700 (PDT)
Date: Mon, 11 May 2026 03:46:32 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/18] mshv: Fix IRQ leak and type hazards in
 hv_call_modify_spa_host_access
Message-ID: <20260511-caped-white-boobook-51ee6b@anirudhrb>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816858406.21765.9718563917415905259.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177816858406.21765.9718563917415905259.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 3C961507C26
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
	TAGGED_FROM(0.00)[bounces-10737-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anirudhrb.com:email,anirudhrb.com:dkim]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 03:43:04PM +0000, Stanislav Kinsburskii wrote:
> The bounds check inside the PFN-filling loop can return -EINVAL while
> interrupts are disabled via local_irq_save(), leaking IRQ state.
> 
> Remove the check — it is redundant because the loop invariant
> (done + i < page_count == page_struct_count >> large_shift) guarantees
> (done + i) << large_shift < page_struct_count always holds.
> 
> While here, fix type mismatches: change 'int done' to 'u64 done' and
> use u64 for loop and batch-size variables so they match the u64
> page_count they are compared against.
> 
> Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_hv_call.c |   18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


