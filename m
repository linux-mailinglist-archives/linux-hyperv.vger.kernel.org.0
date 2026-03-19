Return-Path: <linux-hyperv+bounces-9544-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHKQHrMGvGkArgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9544-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 15:22:43 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6BE2CCACA
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 15:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55DF9305BABB
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FF5315D40;
	Thu, 19 Mar 2026 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qJFdgiFw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4jpB79yc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OrcSAEzL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HXVk5/yP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8F930E84A
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929636; cv=none; b=j5Gd3ykvNx4Le101zCIdW9SfcxuUJLEE5xTjVfW/h01+krb09/ZawvNFu1tJVxbcs5M/1fwY37L6Py/gh5kjTqL/1AtAxAkv0qvMquitAWcAw8GVIkoYmkKXGxQgGZWyYTxTl2RQVAByiqr5XZ9J1WNZoI8Wb7lTNcsqnFxvzIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929636; c=relaxed/simple;
	bh=4zAon2/wL1xkF183JwLxXVvEK05OvlwLI29zwOFhq2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKQdl5woSmL7s8tx/8sy0HBTpRaDsYwVaSFtL4PY9WlqnGdtcapyddJ4Li9NaoobOHE79mKmli2bFVh/N8ee8M8GDlSXaLPedC+ZZ257S4tutSkeqSN5E9CKzTIG2DbtZpiPEOyr2HkdFHmYMDX4wgD+gxvr0WaxJRKaX9UrvjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qJFdgiFw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4jpB79yc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OrcSAEzL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HXVk5/yP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 233AB5BD4B;
	Thu, 19 Mar 2026 14:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773929632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fUFXPph0d+U/6GDmGbgLZ/FXBjYuxpYsgD69WTKZEc=;
	b=qJFdgiFwZof840urwELAyJUPmqr5R5KSb1T4rwYuc7bb8XNbCm/kv+M5FkrKSBEOM1bZiu
	/MGyuwm/OFnFKmJm/t/Uz/+GbEcAEAQCMtEWioCbgwKOh4DWZ0qNVZOg9g66xDY+m4U+fD
	w9Xqoe30eNI+goFz62hSwZMzWorThdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773929632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fUFXPph0d+U/6GDmGbgLZ/FXBjYuxpYsgD69WTKZEc=;
	b=4jpB79ycXSQsxOkgtV3HKUa6Dm/vQ/wRir8pmFsiYnB6qgK3LbPe12RtulXb4tol7/E3ij
	faYPra8B4GTfZjDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773929631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fUFXPph0d+U/6GDmGbgLZ/FXBjYuxpYsgD69WTKZEc=;
	b=OrcSAEzL/6c4UDB40dZmtUkHL2UKN/t418W/3/WLfRE3VUYtttdOTA1LBRs2LexriSZBXr
	IUCLAcO9QxQoLCNXA0PSitgNb7BC5cuH9t+EXroQLbXGhfbC1mTChSWj64vc6V41FfYy8R
	mio6pb/J12e+5TPnOnmBoDRex83ce1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773929631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fUFXPph0d+U/6GDmGbgLZ/FXBjYuxpYsgD69WTKZEc=;
	b=HXVk5/yPJtxIjyky0dtujMNvVHE9KONXRU8D1O6wb4LBxoqwDaKPYOnkGEkCrYDJmYyVOA
	klxEA++oJw6AsaAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14B714273B;
	Thu, 19 Mar 2026 14:13:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TmUEBZ8EvGlPZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Mar 2026 14:13:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C850FA0B32; Thu, 19 Mar 2026 15:13:46 +0100 (CET)
Date: Thu, 19 Mar 2026 15:13:46 +0100
From: Jan Kara <jack@suse.cz>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, gfs2@lists.linux.dev, 
	intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 12/61] quota: Prefer IS_ERR_OR_NULL over manual NULL check
Message-ID: <ol2d7c5z7yfyuwo5tyfxurgqedruhr6bzmuv37bx5phhrmmoyh@4zjspbtexid3>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-12-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-12-bd63b656022d@avm.de>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9544-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,avm.de:email,suse.cz:dkim,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8F6BE2CCACA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue 10-03-26 12:48:38, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Jan Kara <jack@suse.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Thanks for the patch but frankly I find the original variant clearer wrt
what is going on. So I prefer to keep the code as is.

								Honza

> ---
>  fs/quota/quota.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index 33bacd70758007129e0375bab44d7431195ec441..2e09fc247d0cf45b9e83a4f8a0be7ea694c8c2a1 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -965,7 +965,7 @@ SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
>  	else
>  		drop_super_exclusive(sb);
>  out:
> -	if (pathp && !IS_ERR(pathp))
> +	if (!IS_ERR_OR_NULL(pathp))
>  		path_put(pathp);
>  	return ret;
>  }
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

