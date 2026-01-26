Return-Path: <linux-hyperv+bounces-8524-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHKPE5C3d2nKkQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8524-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 19:50:56 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B525D8C380
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 19:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95EFA303AAA9
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 18:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBDA252904;
	Mon, 26 Jan 2026 18:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="Hl5+kK9e"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6085025A2CF;
	Mon, 26 Jan 2026 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769453384; cv=pass; b=r5zh4PGCxfOmdQtpUve0SYw6W7S3IrL6f12JnXRvtgg8XlzWR3o0g1Q+us5RgI08MozCqigPkzIaIlLWZMcF8DfMPwMnWlT0xRePNMfK+zVgQpJ4O+DMP4a/OAfG67MYu40PowKE96TTWxXu5WhFIXHNkV2lkdAG/R+yzsf+2s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769453384; c=relaxed/simple;
	bh=YGqymm3gz6KCJTrs1aJv/WQ0u8BK/nYTMJjPDi3J52U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZmqoN0hOyhI+h5m/niThgQ4jPjbwn/ELVVbIj5vsj3L0+rIA+43QQhaVbYzh8kzDDwozArXf295Aaa824VFjOYra/OvIbAJAmjyu+1Bq908jId4tljUfc06y05bXHLQ2iGVJOqa838OJu4Ezj6qdGWi30LP2aXqhlcuo38NwPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=Hl5+kK9e; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1769453373; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i63lVhT0DGB2RRqtcaqE6bexNGTaiRP6U5DZeGnqVIQIxk1ujbW8oOFXPZJu8KcvfKEC+1/r+Su/Tr1ZuYZxGtku7m4OkPuTfqxFGhtZ7QGAZQ9Ge6v81WEEuE4WhgxNnjuVdukPe4gCiUeOdDzHFyxlHSXOYeH3hJ6An4MdF4I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769453373; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8sPoInVGoPsbBKVUEW9y8qYI3+3E9DKU6AAAHormY2U=; 
	b=jXZkF9ppCZAXaOfJVECS6CRGF4d/BqIvaaI1waE3h/DkHUWERLbFn2s0YOY3REKOUvPxWKhRXddyy6QOXQhjK7iCrOIfXEeHJ6tBnbqtIK+8mzp4YKBDcKZxYwAW2yk9x/OM2/1wm18AEZgByHXo1HFLh3PV1ZnVWbFkg916ddw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769453373;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=8sPoInVGoPsbBKVUEW9y8qYI3+3E9DKU6AAAHormY2U=;
	b=Hl5+kK9eDMJXn9sJqGeRcjCp8ZFDLKSfZk80JyTfcj56vPmRUQBL39DhOJPtT7ut
	pFcd6TIDSFqmYAG+sn5rSiUvGSYlhHFx+6H/sagHLckcehKFS9tEqbuKo8Rve0chlld
	QJ8/GSRbNGEcEiCZ3wLiG/wpKDv9qjotDF+096TA=
Received: by mx.zohomail.com with SMTPS id 1769453370806146.58906313464558;
	Mon, 26 Jan 2026 10:49:30 -0800 (PST)
Date: Tue, 27 Jan 2026 00:19:24 +0530
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <xyzkeqng3767mlpzu7xbmgobjr6ob2wp2brocmjczbbl4dypxh@wkibga46f33c>
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[anirudhrb.com];
	TAGGED_FROM(0.00)[bounces-8524-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B525D8C380
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 10:20:53PM +0000, Stanislav Kinsburskii wrote:
> The MSHV driver deposits kernel-allocated pages to the hypervisor during
> runtime and never withdraws them. This creates a fundamental incompatibility
> with KEXEC, as these deposited pages remain unavailable to the new kernel
> loaded via KEXEC, leading to potential system crashes upon kernel accessing
> hypervisor deposited pages.
> 
> Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> management is implemented.

Someone might want to stop all guest VMs and do a kexec. Which is valid
and would work without any issue for L1VH.

Also, I don't think it is reasonable at all that someone needs to
disable basic kernel functionality such as kexec in order to use our
driver.

Thanks,
Anirudh.

> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 7937ac0cbd0f..cfd4501db0fa 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -74,6 +74,7 @@ config MSHV_ROOT
>  	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
>  	# no particular order, making it impossible to reassemble larger pages
>  	depends on PAGE_SIZE_4KB
> +	depends on !KEXEC
>  	select EVENTFD
>  	select VIRT_XFER_TO_GUEST_WORK
>  	select HMM_MIRROR
> 
> 

