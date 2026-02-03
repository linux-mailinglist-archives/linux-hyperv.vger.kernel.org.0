Return-Path: <linux-hyperv+bounces-8675-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBgkLCIYgmmZPAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8675-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 16:45:38 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31972DB747
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 16:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FC21302F7FF
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Feb 2026 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853BF3B95FC;
	Tue,  3 Feb 2026 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jvbQp8Ss"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E2D3AE6F3;
	Tue,  3 Feb 2026 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133498; cv=none; b=YyDykQLZP0Mg0ZtEalM79bFIdBl6A931PrLsrtEPNyPSczgXQJkhe2UBoaNZtWFTMK+l+Xsj/SqGCk/uUvdOzs0I5Km/e00M3nKC+PYhRQsp/4gnl0NXp9c5P34VP9MN+W0gqEY35Tt4pLdoLujBVZiHBijO2IdxqX10O2+HxQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133498; c=relaxed/simple;
	bh=KehIKaQfzkeq88H7XuueNLn0JeA1YXl+hGWFleWWQs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAHMt5mRsLii1v92AXJHsZNr/EkWdTGK7Is1hdzd1wmogj70VrCMLapRLau0/q9SFXMOTgHzOclHFwQwOhtUSiDgeeeOYqNDVRiqvlO0dZPKy30QSQBe9MyoStClG7md9Zriq9tujDWOGgqNOi5KQ1TsKAjUIuJFBnjv2zMY+/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jvbQp8Ss; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id AB4A220B7167;
	Tue,  3 Feb 2026 07:44:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB4A220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770133497;
	bh=R2/47XpOWWPoP5Lt2tw9xXub2Zm/f22CK3pjh+tfCzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvbQp8SsB0ICnbFxdykkI21uR8rSxBBnAH2GgCsSBv8bcdqjLaEOdfENoFnXwPzLw
	 gEbx4W0KUrhbaVCbaF1BGKCyY70C8P6FHAki0v/Wfg/cAaVfe2xDAgQo3M9TtMQyGI
	 VvNfw/nm7L0np9ujTggelij7gTAd1tL+90mC8d2c=
Date: Tue, 3 Feb 2026 07:44:54 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mshv: Use EPOLLIN and EPOLLHUP instead of POLLIN and
 POLLHUP
Message-ID: <aYIX9tvVut-i9QXt@skinsburskii.localdomain>
References: <20260129155154.484671-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129155154.484671-1-mhklinux@outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TAGGED_FROM(0.00)[bounces-8675-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,skinsburskii.localdomain:mid,linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 31972DB747
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 07:51:54AM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> mshv code currently uses the POLLIN and POLLHUP flags. Starting with
> commit a9a08845e9acb ("vfs: do bulk POLL* -> EPOLL* replacement") the
> intent is to use the EPOLL* versions throughout the kernel.
> 
> The comment at the top of mshv_eventfd.c describes it as being inspired
> by the KVM implementation, which was changed by the above mentioned
> commit in 2018 to use EPOLL*. mshv_eventfd.c is much newer than 2018
> and there's no statement as to why it must use the POLL* versions.
> So change it to use the EPOLL* versions. This change also resolves
> a 'sparse' warning.
> 
> No functional change, and the generated code is the same.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601220948.MUTO60W4-lkp@intel.com/
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

> ---
>  drivers/hv/mshv_eventfd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
> index 0b75ff1edb73..dfc8b1092c02 100644
> --- a/drivers/hv/mshv_eventfd.c
> +++ b/drivers/hv/mshv_eventfd.c
> @@ -295,13 +295,13 @@ static int mshv_irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode,
>  {
>  	struct mshv_irqfd *irqfd = container_of(wait, struct mshv_irqfd,
>  						irqfd_wait);
> -	unsigned long flags = (unsigned long)key;
> +	__poll_t flags = key_to_poll(key);
>  	int idx;
>  	unsigned int seq;
>  	struct mshv_partition *pt = irqfd->irqfd_partn;
>  	int ret = 0;
>  
> -	if (flags & POLLIN) {
> +	if (flags & EPOLLIN) {
>  		u64 cnt;
>  
>  		eventfd_ctx_do_read(irqfd->irqfd_eventfd_ctx, &cnt);
> @@ -320,7 +320,7 @@ static int mshv_irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode,
>  		ret = 1;
>  	}
>  
> -	if (flags & POLLHUP) {
> +	if (flags & EPOLLHUP) {
>  		/* The eventfd is closing, detach from the partition */
>  		unsigned long flags;
>  
> @@ -506,7 +506,7 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
>  	 */
>  	events = vfs_poll(fd_file(f), &irqfd->irqfd_polltbl);
>  
> -	if (events & POLLIN)
> +	if (events & EPOLLIN)
>  		mshv_assert_irq_slow(irqfd);
>  
>  	srcu_read_unlock(&pt->pt_irq_srcu, idx);
> -- 
> 2.25.1
> 

