Return-Path: <linux-hyperv+bounces-11258-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGOzMedvF2pDFAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11258-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:27:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 209D25EAA96
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F8EA3034BF7
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 22:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A373F3C1F37;
	Wed, 27 May 2026 22:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7MNn1du"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C53ACA52;
	Wed, 27 May 2026 22:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920824; cv=none; b=LiSbQhKo6L4wf9/r+scbdBtn6cmRvjXTroBNc+SsVxmDplwpXfBheeE35L2d4JYEpKEltZo21vB3CfnMltiMsRWmqXDK9v1qSeJaRFMChoOigEHE0djnrQez2TU8g7FFR5MWB6XgexD88jygQ4r1PmO6ZNfVBWYaZJYY1njOMGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920824; c=relaxed/simple;
	bh=YYPQMaGSOGCyGuRgQ6KkRhpV3psyeiFtLHhVoR8l9Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YClYQ9IQ49YOOOYjG2PcWn7gKNcMJnM85N4NTUmLtyZC6B7CsqInY2eRtW5SDOg2QwMLQJ7xdLm/gbUMudv8He6+KV78zMHwni2AmrtbqK90yB9C2tORZY/vuCbmIrpbBj4Xvn3ei8vhh+U3xAhF/wB8vQEtOFAS//Gr/Mldp4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7MNn1du; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F2A1F000E9;
	Wed, 27 May 2026 22:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779920823;
	bh=Kq/Q4+ThDF9dZrfshBxHg+q9mvQxgCwlhQwNZ+X8Gq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z7MNn1duO1R/t0/sEGLYNEsPcq6ssgXk061l88FLtPgHwJ3NHhnZ+F/v5pgK7D55E
	 isErcKuQ+Y0eeIr/L7BQWcT0w3jQFGRrAx+MYyx+Cvp2p8f+dtucVILdj2q24cDlSo
	 gpoIIpcIiLvT4zl7uYcHVtRXftRJ9RbbFMIoG20+CxPhy3MlaZONsy0wqERu9xE5AG
	 h6rG8kYBe6fFMfj433pnNIFibs6Qj8jWq736BPVYvfwgD8pohHbt9SZNI6p/ix9+Vp
	 D400aQzsPEtBFDo/GqXjaOeIDny0PB6uSlh7zIUi/kFudpxrHzUKGfi5Sg8DlOapwz
	 8ReQcQmgudsUQ==
Date: Wed, 27 May 2026 15:27:01 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Can Peng <pengcan@kylinos.cn>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	longli@microsoft.com, decui@microsoft.com,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] drivers: hv: use kmalloc_array in
 mshv_root_scheduler_init
Message-ID: <20260527222701.GC3518940@liuwe-devbox-debian-v2.local>
References: <20260520071632.557990-1-pengcan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520071632.557990-1-pengcan@kylinos.cn>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11258-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,liuwe-devbox-debian-v2.local:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 209D25EAA96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 03:16:32PM +0800, Can Peng wrote:
> Replace kmalloc() with kmalloc_array() to prevent potential
> overflow, as recommended in Documentation/process/deprecated.rst.
> 
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---
>  drivers/hv/mshv_root_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index bd1359eb58dd..146726cc4e9b 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2241,7 +2241,7 @@ static int mshv_root_scheduler_init(unsigned int cpu)
>  	outputarg = (void **)this_cpu_ptr(root_scheduler_output);
>  
>  	/* Allocate two consecutive pages. One for input, one for output. */
> -	p = kmalloc(2 * HV_HYP_PAGE_SIZE, GFP_KERNEL);
> +	p = kmalloc_array(2, HV_HYP_PAGE_SIZE, GFP_KERNEL);

HV_HYP_PAGE_SIZE is a constant (4096). We don't have any dynamism in code.
There is zero potential for overflow.

That being said, I'm fine with taking this patch to stay consistent with
the document.

Thanks for your contribution.

Wei


>  	if (!p)
>  		return -ENOMEM;
>  
> -- 
> 2.53.0
> 

