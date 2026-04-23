Return-Path: <linux-hyperv+bounces-10347-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOaTGDlX6mkhxgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10347-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 19:30:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE12455825
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 19:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A86343013A51
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 17:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3E03A75A5;
	Thu, 23 Apr 2026 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tAg9crFX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3BE307AF0;
	Thu, 23 Apr 2026 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965401; cv=none; b=PUlYVIR948cx1ms6b6d99DaL9kx0vOZVyb9fYE8CrP/FHtoliPdu/Wwv/g+9JhjwAMnVWEhPrWp0UzJHYCzgmBZWnqaKF7fnoBIBXXTed+FIkoeoR8VPq6ODtwfUFwbcPy096kmFFEwgaDPoCKEw+jjXhm5O1WEZA4x3s1L/TgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965401; c=relaxed/simple;
	bh=s77qgGV6rEYpp74gWpITm83/Nu85AN92A+w1sB35naU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n4Q1yHxGsfqpeFvROcWAAhZwrOls3zYcN4z7N3ZCjwHfaLpqng9C8iJsT/wpps46z48cj/1hIQlkA8wFiZtIB7Hogl65LAbZomYOgZ+rQxt7ehF6I/5rdqtgWdEo3CLP5207VeP7iIYhYaAmeJGZjU0OyUIfXBE24bwDYx4b2Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tAg9crFX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.201.246] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id DBD0620B7165;
	Thu, 23 Apr 2026 10:29:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DBD0620B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776965400;
	bh=s9juGdNXSUt3Z8Nr9rfoPqObNvAJMZXoghUL9x3G65Q=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=tAg9crFXAhJgoPrOu4t230ot/9/VIDEg0AnYVUitmYq18g3qivfjhTSrcjLYiMck0
	 DKwzjh6PU2bFgg5aW8V/LnIZxBzwV3KG02ImaI/00j0AF9fSkfX44jm+uNtJS7UHi4
	 +6S95IrPqDBjcjCsCPgaR+uBkGfP2H5sHEO0TPYQ=
Message-ID: <614f1e17-2dba-4529-b067-e1434b74cad8@linux.microsoft.com>
Date: Thu, 23 Apr 2026 10:29:52 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 easwar.hariharan@linux.microsoft.com,
 =?UTF-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>, stable@kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Roman Kisel <romank@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mshv: add a missing padding field
To: wei.liu@kernel.org
References: <20260423172625.1189669-2-wei.liu@kernel.org>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260423172625.1189669-2-wei.liu@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10347-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.microsoft.com,kernel.org,microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[easwar.hariharan@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFE12455825
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/23/2026 10:26 AM, wei.liu@kernel.org wrote:
> From: Wei Liu <wei.liu@kernel.org>
> 
> That was missed when importing the header.
> 
> Reported-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> Reported-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Fixes: e68bda71a2384 ("hyperv: Add new Hyper-V headers in include/hyperv")
> Cc: stable@kernel.org
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  include/hyperv/hvhdk.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index 5e83d3714966..ff7ca9ee1bd4 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -79,6 +79,7 @@ struct hv_vp_register_page {
>  
>  		u64 registers[18];
>  	};
> +	__u8 reserved[8];
>  	/* Volatile XMM registers (HV_X64_REGISTER_CLASS_XMM) */
>  	union {
>  		struct {


This is not a uapi, so why not just use u8 instead of __u8?
Or since it's 8 u8s, a u64?

Thanks,
Easwar (he/him)

