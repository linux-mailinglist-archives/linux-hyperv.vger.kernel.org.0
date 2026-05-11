Return-Path: <linux-hyperv+bounces-10751-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGDNB7XoAWqemAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10751-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 16:33:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A7E510370
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 16:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 562FD3002A22
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 14:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FB43FBEC6;
	Mon, 11 May 2026 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="Lc9HoCfv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A90202C48;
	Mon, 11 May 2026 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509625; cv=pass; b=cLF34aqMSXcBYW6wDEx8+CxNpcsfokunlAgC0MR68LF8ozT1Jw07iI9ZvY+2H/eEFCrveXcnIYGZ49snsudj1+hEv0BT5tBSZjLAr5T6RtSRnd35AKpeMI4eXMuQme++9aLuPEIxO672gC0EwKYJ48Zsj0JtaUNwZLdmHNZlTL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509625; c=relaxed/simple;
	bh=JTYpYqueDYtSLGIyzULu+pEdIYAA5NjGOedyFanwuIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWEDzhlKRUnIhJWZt6a5cyG1A8uQMn+XMbUcKwStTr0UIsM0YCo+P6XFcfZv90AYBNu6TxnNxl0hHvfyFyjd+8yubweOkeNtO6chK8GJ9XP4tDtnMUK85M93nLCb/JBTSWcQFM56rrvdtay8eQsa5aM19XC0SMKmP+fmP8g60q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=Lc9HoCfv; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1778509613; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L6hzmF3zNwIs/VnSY30DxmVVN6w0s9WVHK/cIN6/GXg4wjNj4joeqOz1tcUkcSmN4qqDBBU8ZB9xg0t2gjryj0eGeFBBW8qNOO4RZrO+4cCNpFAOF7E7FkDzeE04cVGlH5O/CHD5Jv75ikv4XOlbF5r31kRmNY7zYBVFzSxvkEM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778509613; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vHIxm4N30hCjhBizWWd6Pe2sUVzDJgt8mADk+YbQ0Xo=; 
	b=ghFWYecBODFXN4HlY6ShS0JFegPI8VSZZG3xNZ4Fel0h1hqKQ3GTOslHFENu0D0ecOXXgyiUNdzL6Q8XpEyu4WS0mg/yI3HB0LpdPpZaXqs9yk9GbyO9ZYGPXd+hqwdXblJhGWKs37ipuxc6w6Py4Eg7QtqbjLedyCS1guF3bLo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778509613;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=vHIxm4N30hCjhBizWWd6Pe2sUVzDJgt8mADk+YbQ0Xo=;
	b=Lc9HoCfv+EgJ3OXB7Fmsnpok0iEhorSgDrbtFIIPdylUT+b4+QxmjUYhmt/25WFi
	LfwTxdcg59uB4cVawSMhIZ2JEjgHTgrJAW+/RGhLW2XHKdWF74rOYCaIVkL0p6CP0X6
	kxWtc6hWn4BDQn34sc9TROfrqOQEy0JfFzkxX7+0=
Received: by mx.zohomail.com with SMTPS id 1778509611153158.26742556224815;
	Mon, 11 May 2026 07:26:51 -0700 (PDT)
Date: Mon, 11 May 2026 14:26:45 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/18] mshv: Publish VP to pt_vp_array before
 installing the file descriptor
Message-ID: <20260511-warping-determined-kagu-eb5fcd@anirudhrb>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816867231.21765.15171005242069873878.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177816867231.21765.15171005242069873878.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 76A7E510370
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-10751-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 03:44:32PM +0000, Stanislav Kinsburskii wrote:
> mshv_partition_ioctl_create_vp() called anon_inode_getfd() before
> publishing the new VP into partition->pt_vp_array.  anon_inode_getfd()
> includes fd_install(), so the fd was live in current->files before the
> publish ran.
> 
> A concurrent MSHV_RUN_VP ioctl on that fd does not serialise against the
> in-progress MSHV_CREATE_VP — it takes vp->vp_mutex, not the partition
> mutex.  Once the VP starts running and traps, mshv_intercept_isr() can look
> up partition->pt_vp_array[vp_index] and observe NULL, silently dropping the
> intercept message.
> 
> Split the fd creation: reserve an fd with get_unused_fd_flags(), create the
> file with anon_inode_getfile(), publish the VP via smp_store_release(), and
> finally call fd_install() as the userspace-visibility commit point.
> 
> Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c |   29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index e32f6e0f9f637..1c18d1c1f7947 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1142,6 +1142,8 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>  	struct mshv_vp *vp;
>  	struct page *intercept_msg_page, *register_page, *ghcb_page;
>  	struct hv_stats_page *stats_pages[2];
> +	struct file *file;
> +	int fd;
>  	long ret;
>  
>  	if (copy_from_user(&args, arg, sizeof(args)))
> @@ -1214,14 +1216,18 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>  	if (ret)
>  		goto put_partition;
>  
> -	/*
> -	 * Keep anon_inode_getfd last: it installs fd in the file struct and
> -	 * thus makes the state accessible in user space.
> -	 */
> -	ret = anon_inode_getfd("mshv_vp", &mshv_vp_fops, vp,
> -			       O_RDWR | O_CLOEXEC);

Why not just move this anon_inode_getfd() after the smp_store_release()
call?

Thanks,
Anirudh.


