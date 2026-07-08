Return-Path: <linux-hyperv+bounces-11871-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AlOJHLBMTmqvKQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11871-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 15:12:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B71E5726AB1
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 15:12:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=o5SMCqDd;
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11871-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11871-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0B543010382
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jul 2026 13:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2C1231A41;
	Wed,  8 Jul 2026 13:05:22 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205A02D7BF;
	Wed,  8 Jul 2026 13:05:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515922; cv=none; b=Hk79hJX8zWw5/XWbSbvXPm9kWwfwq8GJq0Wr+qBJA3kOHhO+idepqSeuvc85YIhDwHDWueSxtM5bNqV8+3orma4WDEdMHHyPzk9lRFTRUKiFxsMkmfe9JVHD6gbN5cwtMnmzG2siDlN21MXRKvZBIK56GsILbATmRidSMQOfXW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515922; c=relaxed/simple;
	bh=D80+sHK7oQ+gk/o/uHFNOev3aQMwbuQIuU8DjcxiGno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7lPpZY75AMods4YddqqI3RYkmfAb8MhxglCUW7AenxrsXCMaCFsAUjWaEnK0iagnxb8d7Pj/OhvZQERh3vLZ7nhZPl7I+HUAEbvEUJ/K6AOGffSTgInpJ9xrneUhwC1d6FK0xlyPivlwQ77/T1ueebbtezLSScUE+1s0cATbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=o5SMCqDd; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 16F2E20B7166; Wed,  8 Jul 2026 06:05:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16F2E20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783515916;
	bh=QWhOUjoq7glD3ulLx+EiI8YDgxzBwmTEbtliBi47jGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o5SMCqDdEnDKNnoi5nReXrmeA6sNVr+6tqanMAQVuwUMmmc8CyN41XEwYXahHMDIE
	 ugII6JjDkMAQYxPLCjp0zvvJry8V2StlUtPmtVn4ojNxLa9sACsurZA8tMUBtnXxCk
	 J8AVxuASMLmtM8priCqgTkXOEYxC4vrZbPKVlZ2Q=
Date: Wed, 8 Jul 2026 09:05:16 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Yi Xie <xieyi@kylinos.cn>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: fix fd leak in mshv_ioctl_create_vtl()
Message-ID: <ak5LDBRXOVYTrZ9r@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260708012852.36824-1-xieyi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708012852.36824-1-xieyi@kylinos.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:xieyi@kylinos.cn,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11871-lists,linux-hyperv=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hamzamahfooz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hamzamahfooz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B71E5726AB1

On Wed, Jul 08, 2026 at 09:28:52AM +0800, Yi Xie wrote:
> put_unused_fd() if anon_inode_getfile() fails.
> 
> Signed-off-by: Yi Xie <xieyi@kylinos.cn>

Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

> ---
>  drivers/hv/mshv_vtl_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index 0d3d4161974f..897a41b08d02 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -129,6 +129,7 @@ mshv_ioctl_create_vtl(void __user *user_arg, struct device *module_dev)
>  	file = anon_inode_getfile("mshv_vtl", &mshv_vtl_fops,
>  				  vtl, O_RDWR);
>  	if (IS_ERR(file)) {
> +		put_unused_fd(fd);
>  		kfree(vtl);
>  		return PTR_ERR(file);
>  	}
> -- 
> 2.34.1

