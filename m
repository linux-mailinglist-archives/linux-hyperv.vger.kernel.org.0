Return-Path: <linux-hyperv+bounces-10353-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG3yNJRh6mmrygIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10353-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 20:14:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6A7455F82
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 20:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5B5E3006174
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54EF3AB28C;
	Thu, 23 Apr 2026 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYG/dQJH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29363AA514;
	Thu, 23 Apr 2026 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968081; cv=none; b=X16WtX6wvFY8cZIIR4s0RFdcfAYYvw5f3Prv8yAL6mrTtdcWEeVxjJ9l0tk4wAlVAMwB0RsT3D2JYg0BFJyHJVUcdoRccWkBQ30nW8sw47FgWVS2cQrTRLQ5nUnyrs1UkWsEfh3yCfETFVQYFFEfBDmffiYUIe2L6QoMF0z7OtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968081; c=relaxed/simple;
	bh=blhlCdwOF7Fd4G+7hOI/byyV50C43hMllgPaC5GEL88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvOW7d80TL6KVI/WOhycgp1GikRouiYs7U5HvF526uDvtGuaTNOI4eYadzf8o+A/1lZtPcmJr2JekoIWcrUTb5B73d+lV4SqQ26IJJ3qfAcPbraA2qRC4M2EY1YyqycXIVoP6ZsggGIn4yfFXwpLmvhFdBfMWesvDkZh8fNoMKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYG/dQJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD5BC2BCAF;
	Thu, 23 Apr 2026 18:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776968081;
	bh=blhlCdwOF7Fd4G+7hOI/byyV50C43hMllgPaC5GEL88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYG/dQJHF1GMHhLQ20t3trueYuWrubW/MvA2Oq+H+2qBW0hkuPg1osDmC96OlIZ7s
	 vIoDTt07XmbsNf1UO0jfwMScsGG8G6qY8zjxCa6qR4pnhqafajVwZoJOKCmL6yqc5J
	 hyJavCXQ+7h0dLKCRzyGdLb3nlUJ5I0+kahqA6rkuB7QfZPLSv2jriU8sBI9Y46tP/
	 1/vN5oj1JYRPrCmCbz/Y8DYqudPlPYPb+T3GHU7vEBzFIxoempCsr3+xH3XdNVSW7l
	 6+mkPFkHTSNpV0+s8SlgdFqUVkI9o4aRCwcF+Ft+8byL57kEsp/MOaPZPU4v3/Uj8P
	 tiv5hJWzbVbkA==
Date: Thu, 23 Apr 2026 18:14:40 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: wei.liu@kernel.org,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>, stable@kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mshv: add a missing padding field
Message-ID: <20260423181440.GA1196957@liuwe-devbox-debian-v2.local>
References: <20260423172625.1189669-2-wei.liu@kernel.org>
 <614f1e17-2dba-4529-b067-e1434b74cad8@linux.microsoft.com>
 <19a904f4-e26f-4951-85ac-aae537da89cb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19a904f4-e26f-4951-85ac-aae537da89cb@linux.microsoft.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10353-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linux.microsoft.com,microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D6A7455F82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 10:32:58AM -0700, Easwar Hariharan wrote:
> On 4/23/2026 10:29 AM, Easwar Hariharan wrote:
> > On 4/23/2026 10:26 AM, wei.liu@kernel.org wrote:
> >> From: Wei Liu <wei.liu@kernel.org>
> >>
> >> That was missed when importing the header.
> >>
> >> Reported-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> >> Reported-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> >> Fixes: e68bda71a2384 ("hyperv: Add new Hyper-V headers in include/hyperv")
> >> Cc: stable@kernel.org
> >> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> >> ---
> >>  include/hyperv/hvhdk.h | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> >> index 5e83d3714966..ff7ca9ee1bd4 100644
> >> --- a/include/hyperv/hvhdk.h
> >> +++ b/include/hyperv/hvhdk.h
> >> @@ -79,6 +79,7 @@ struct hv_vp_register_page {
> >>  
> >>  		u64 registers[18];
> >>  	};
> >> +	__u8 reserved[8];
> >>  	/* Volatile XMM registers (HV_X64_REGISTER_CLASS_XMM) */
> >>  	union {
> >>  		struct {
> > 
> > 
> > This is not a uapi, so why not just use u8 instead of __u8?
> > Or since it's 8 u8s, a u64?
> > 
> > Thanks,
> > Easwar (he/him)
> 
> Hm, occurs to me that this would be used by VMMs, but then the registers
> field just above used a u64 instead of a __u64....

I fat-fingered u8 to __u8.  User space code has scripts to massage the
types as needed.

To remain consistent with the existing code, it should be u8.

I can change the type when I commit this.

Wei

> 
> 

