Return-Path: <linux-hyperv+bounces-11512-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 01YAN3gfI2qQjAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11512-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 21:11:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4948564ADBE
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 21:11:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=Y8L6Xv72;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11512-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11512-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CD1D301B4C2
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jun 2026 19:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D97E24A05D;
	Fri,  5 Jun 2026 19:11:49 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5052278F29;
	Fri,  5 Jun 2026 19:11:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686709; cv=none; b=NFqZuIS5ezNBXGIFLlNiTGBIexViap37sq1dLUEYAhiNmtue/kPPw/V+R039fJkXk8Fnd4u0Cc7mUy1NfNrk1dGUuYs+/bzKAG8v4eRy5l02XmDdqcNeRGykTbVqOG9UF44JynHzEbLfmP3Bb+hqQrIlhrjcFD+4y7sdvesQIqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686709; c=relaxed/simple;
	bh=SKp5A5HIZ5LbGgMxAlOWW38knJh5nsNKeP4rRRaOunY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvMGROxhbNm3w+eNRtESdWOfvnJatwQfadb+Cyo3rkT0jqs+nImizxlicsx+XX7oqP5ci4cIO+mbRgtPBN0Rmv9i71Y2I4FskgxkzduAZotdHE2bNS1nS1wXhOH408SiIL4WL7U7x8fJcjl+U3pCzoV6IQk+i0+JIrUV3TH6vYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y8L6Xv72; arc=none smtp.client-ip=13.77.154.182
Received: from [192.168.1.6] (unknown [106.222.229.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id A29DA20B716A;
	Fri,  5 Jun 2026 12:11:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A29DA20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780686691;
	bh=g+C/A1n1XipAX/omglYkXyb1smfS0wsd04VTHPRIuFA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y8L6Xv72+P63O7Se6Gq3ROF34iCXfCPtuO1QN/+yYOpGh2VvRMo+neGjZtzMZ+WxE
	 G1snnBsuBlDUHlu3GTvdsrznfWzTSvRTukKs4TCnusBIn+e7d+XVoIQwZkIiMlo9WV
	 rQ7eajfzOhIueP7REbuO8T1MF/Nxk0x7hCmpaCzg=
Message-ID: <43b4f0e4-e071-4e49-b1a2-b56303297c49@linux.microsoft.com>
Date: Sat, 6 Jun 2026 00:41:41 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hv_balloon: Simplify data output in
 hv_balloon_debug_show()
To: Markus Elfring <Markus.Elfring@web.de>, linux-hyperv@vger.kernel.org,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Long Li <longli@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <4f969d00-df24-4cde-8539-8cbe4a09f417@web.de>
Content-Language: en-US
From: Sahil Chandna <sahilchandna@linux.microsoft.com>
In-Reply-To: <4f969d00-df24-4cde-8539-8cbe4a09f417@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11512-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[web.de,vger.kernel.org,microsoft.com,kernel.org];
	FORGED_SENDER(0.00)[sahilchandna@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Markus.Elfring@web.de,m:linux-hyperv@vger.kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:longli@microsoft.com,m:wei.liu@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sahilchandna@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4948564ADBE



On 05/06/2026 18:20, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 5 Jun 2026 14:44:54 +0200
> 
> Move the specification for a line break from a seq_puts() call
> to a seq_printf() call.
> 
> The source code was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/hv/hv_balloon.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 9a55f5c43307..42ce27be344d 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1862,9 +1862,7 @@ static int hv_balloon_debug_show(struct seq_file *f, void *offset)
>   	if (hot_add_enabled())
>   		seq_puts(f, " hot_add");
>   
> -	seq_puts(f, "\n");
> -
> -	seq_printf(f, "%-22s: %u", "state", dm->state);
> +	seq_printf(f, "\n%-22s: %u", "state", dm->state);
>   	switch (dm->state) {
>   	case DM_INITIALIZING:
>   			sname = "Initializing";

Reviewed-by: Sahil Chandna <sahilchandna@linux.microsoft.com>

