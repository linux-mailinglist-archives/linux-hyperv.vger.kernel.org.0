Return-Path: <linux-hyperv+bounces-9913-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNnjEcyQzmkbogYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9913-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 17:52:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C4138B7FA
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 17:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F086930892D7
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 15:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9123264CC;
	Thu,  2 Apr 2026 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="SCbuL7Zd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3C313E07;
	Thu,  2 Apr 2026 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144773; cv=pass; b=KSy+uPhsQ67WUIBP9XVgcIPp5/+LXTvzXamA9bww8JN8kDCgM2A1Nxq86wfjvxlVyZXgTW+9IPtDllWIgRHBu++bDsYUqj5PrBq/eGQE6SKAamVkrf0KkhDhngAZ28ib5pmtFiKzFihmBhysnZyxMgty1FekCTNgTcUONGnyp5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144773; c=relaxed/simple;
	bh=UBg5LD5sOflwXcwOHZXJ3fl5CBAKSmwXUGGD/QPn4As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MguYkNuyxCWyEPMXIfkHT5LsiEbSWYPZWdhNPEtzjq6+7AhxR5on8BIBZr1KuWAQN558+jCY2LQSSfjcIp+G83LqW273oQ5YFY4GACu8jtoflzgW8TpbTTR/g/BapTqMlP3bGCVV/nOf6ytLvlvKlhSi8++g8tmbWL1iZPx3w+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=SCbuL7Zd; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1775144764; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DDbWtAHdzYQlLrobq5cykVQuopDq9M66OIZd2UUMd5KFxUezg99wH2mYHiqBtzcgjllFqSj5fJLXcdBJkA+q9jGaD29Ilp7WUys0JovbSmDS8ZUOJ9PhhlHmZKqdyG60dJXvUFvMsNwfIoPLuCCExeZyUB1sRdI4HreGeQWaPBA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775144764; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=F1OMDQ6wy2s1L9cnxdbU5FKM5Hg9NknaLd52AdcZvhg=; 
	b=iUZu+QJuq1R/XOOn9jbAdHXLqqU9WEguaTtTiiX+Z5YAgluXvYxbgoh2Y6jFhY/5oRahHR11mqqTRps4QdDHRbCjM5iArj0Eg+r4fIkucUfbhR2mHAT/y4oF0V+QnvS46KAKynXKjbXTKm8hibaLDdKWXsUTQPz53gPgyOTgm08=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775144764;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=F1OMDQ6wy2s1L9cnxdbU5FKM5Hg9NknaLd52AdcZvhg=;
	b=SCbuL7ZdVrW/Lu6uTzSmkD6phpBE5HQ9yIM4n4gBkaLnBZUvounuj/M3+tQg/9AJ
	LOMLdL5IMbSB061om9WfXt7pBxLK7DUg/Xueg3T3rIuymhR2+gk79LY/+C8ShlBPpkr
	SjFfAs94eY+vtnPZFVg7dlfrh/FeMbjBWQ/gpWHs=
Received: by mx.zohomail.com with SMTPS id 1775144762383679.2332007304095;
	Thu, 2 Apr 2026 08:46:02 -0700 (PDT)
Date: Thu, 2 Apr 2026 15:45:58 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Add tracepoint for GPA intercept handling
Message-ID: <20260402-sarcastic-rottweiler-of-criticism-8330ae@anirudhrb>
References: <177439679671.175364.15362688285596134992.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177439679671.175364.15362688285596134992.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9913-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:dkim,anirudhrb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0C4138B7FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 11:59:59PM +0000, Stanislav Kinsburskii wrote:
> Provide visibility into GPA intercept operations for debugging and
> performance analysis of Microsoft Hypervisor guest memory management.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c |    6 ++++--
>  drivers/hv/mshv_trace.h     |   29 +++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 2 deletions(-)

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


