Return-Path: <linux-hyperv+bounces-10454-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF0GNxZG8WkcfgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10454-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 01:43:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5C348D61E
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 01:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ED7F326D5B0
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 23:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937E73AE199;
	Tue, 28 Apr 2026 23:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qvNu30D/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D18C3A759A;
	Tue, 28 Apr 2026 23:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419101; cv=none; b=NoW6iHxMAthf8wzYiomkb3nod4O78k6RoZoM4pZ8jkrK+uSj+X8aDkzPVdj7Uv8IkupKkvuwOVprb9pcUi5YPfQ9V/APMMZJnCLE5+AeP+W0zngcVNPHc+RFWWctsrRnfD7jWR3Y8F/oYBtGCSAsb42yiaxBLco7ylYzURSC1Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419101; c=relaxed/simple;
	bh=6BP6uIHZbTktrvlfNGRHL6Ggf9EcNniaAe8QV9HtMy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbwHl1fXoCvS690q22IEUzJ0yY2hbYzFOnyf9fph0OfdN0TTeS3oJLIEe4iWqxgRqhJtQczrrQKZOQW58p+RFnuOiG+fCtW1MWsfHdefdC9zAgQWqjwlfJ8AuJFah8i0qJVEgS+gI63JdkqUV4SC+xUL0m7nLGNGxN1xQ1MeQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qvNu30D/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id D30CE20B716C;
	Tue, 28 Apr 2026 16:31:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D30CE20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777419100;
	bh=uY+jSoZNJx6vlzhjnQTr140pzsiwTvKzXaqj8ES4Q5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qvNu30D/24oJ6YWIbUar5clgkS03nY7DVHPrFlJM7DJKgilTw9nIReu6peuIunW+j
	 Y1LaUqdYE+IGfQ4tJgrtihso11MC9aGAOpdhlwj/ce0oqVzi9N0lZ4t3TYogyADIqm
	 ouzS0DztWxqHeboEde8NiMFAAvHStBJSuIeizKLs=
Date: Tue, 28 Apr 2026 16:31:37 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Michael Kelley <mhklinux@outlook.com>,
	Anirudh Rayabharam <anirudh@anirudhrb.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 3/3] mshv: unmap debugfs stats pages on kexec
Message-ID: <afFDWZSJ0lEH-7oU@skinsburskii.localdomain>
References: <20260427213855.1675044-1-jloeser@linux.microsoft.com>
 <20260427213855.1675044-4-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427213855.1675044-4-jloeser@linux.microsoft.com>
X-Rspamd-Queue-Id: 3C5C348D61E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10454-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com,anirudhrb.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii.localdomain:mid]

On Mon, Apr 27, 2026 at 02:38:54PM -0700, Jork Loeser wrote:
> On L1VH, debugfs stats pages are overlay pages: the kernel allocates
> them and registers the GPAs with the hypervisor via
> HVCALL_MAP_STATS_PAGE2. These overlay mappings persist in the
> hypervisor across kexec. If the kexec'd kernel reuses those physical
> pages, the hypervisor's overlay semantics cause a machine check
> exception.
> 
> Fix this by calling mshv_debugfs_exit() from the reboot notifier,
> which issues HVCALL_UNMAP_STATS_PAGE for each mapped stats page before
> kexec. This releases the overlay bindings so the physical pages can be
> safely reused. Guard mshv_debugfs_exit() against being called when
> init failed.
> 
> Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

> ---
>  drivers/hv/mshv_debugfs.c | 7 ++++++-
>  drivers/hv/mshv_synic.c   | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_debugfs.c b/drivers/hv/mshv_debugfs.c
> index 418b6dc8f3c2..3c3e02237ae9 100644
> --- a/drivers/hv/mshv_debugfs.c
> +++ b/drivers/hv/mshv_debugfs.c
> @@ -674,8 +674,10 @@ int __init mshv_debugfs_init(void)
>  
>  	mshv_debugfs = debugfs_create_dir("mshv", NULL);
>  	if (IS_ERR(mshv_debugfs)) {
> +		err = PTR_ERR(mshv_debugfs);
> +		mshv_debugfs = NULL;
>  		pr_err("%s: failed to create debugfs directory\n", __func__);
> -		return PTR_ERR(mshv_debugfs);
> +		return err;
>  	}
>  
>  	if (hv_root_partition()) {
> @@ -710,6 +712,9 @@ int __init mshv_debugfs_init(void)
>  
>  void mshv_debugfs_exit(void)
>  {
> +	if (!mshv_debugfs)
> +		return;
> +
>  	mshv_debugfs_parent_partition_remove();
>  
>  	if (hv_root_partition()) {
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index 978a1cace341..88170ce6b83f 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -723,6 +723,7 @@ mshv_unregister_doorbell(u64 partition_id, int doorbell_portid)
>  static int mshv_synic_reboot_notify(struct notifier_block *nb,
>  			      unsigned long code, void *unused)
>  {
> +	mshv_debugfs_exit();
>  	cpuhp_remove_state(synic_cpuhp_online);
>  	return 0;
>  }
> -- 
> 2.43.0
> 

