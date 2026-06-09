Return-Path: <linux-hyperv+bounces-11568-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u0HAGfNaKGqWCgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11568-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 20:26:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F5F6634EF
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 20:26:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Bhkvw/xa";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11568-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11568-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53C0330065DE
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 18:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB54386C3E;
	Tue,  9 Jun 2026 18:24:50 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5FE3F1AA6
	for <linux-hyperv@vger.kernel.org>; Tue,  9 Jun 2026 18:24:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029490; cv=none; b=ljtvSL67xsfB0509AdD0DlNcUSq99Xa1kCCQI7nBB+mPXKzyi4SBj0RmYJmfgPhbHV19DJzsFztma2srbX0EDccY5MOarJ0XqlhmLeOQhpXLi8a0CtRqMMIsz1LOl7xDZ5h2cFGcNWMybZkXL+EswKLMYdrBdo+2Wuu+4qRhiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029490; c=relaxed/simple;
	bh=x75UjGDXg/u3vxO7MyY5ngFpp/GmDGG9L+xpT8u0cfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AbiKoMYfjsw31VEMcLjGLIkEYZJnm428Suxa/mkXz4+uj7xydYrCI/UzAtbWXsQ4wSqHCC58Avnp/iHBzKjm554oyhUxNyP+o/F2xyprg8tJwD2xIoARKroFYPjprAQohozDYXMwef8Hz94HVQlSoMaCS+KBAmyZY8I/MzDuxTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bhkvw/xa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B761F00893;
	Tue,  9 Jun 2026 18:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781029489;
	bh=aYQMdHanTylwRRT4Z03HTEtBWbzcGmZ+n/kRjMoZPds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bhkvw/xaIChP/JnnAdKYNS++3st782GtGVKEWx6E3E6QPIDS5TqAVb1i+CNFG0v64
	 cV6XlPWyUCzH+iBbX6VaUT3p+H7OFGZkAWci4Uxc7GOw09MECZc+yAfN9zCI0/mdoX
	 /KHVpNzprHHiGSw31JgkJNpJn71vxQYCgmXxAUaG6+Mj2wuu8aDLvjQnp5/hMkp8wQ
	 aGF6ifrZOx7C6TmK7fWiqUogOAaboFxCO1C/iOy5K6CoEohwe7zZc6bpcO0Gag9eXC
	 JHvWQBaWSKJ6fZQj510UlGxi0GqTo0Gj+P0aIQMZ3Iq0YROmtsYprV+Czwk86lezfN
	 sOIc3GAayupjg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/6] firmware: smccc: Detect hypervisor via RSI host
 call in CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260609181030.2378391-3-kameroncarr@linux.microsoft.com>
References: <20260609181030.2378391-3-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:24:48 +0000
Message-Id: <20260609182448.D3B761F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11568-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kameroncarr@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11F5F6634EF

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Host call structure `uuid_hc` is allocated in protected memory, wh=
ich will cause the RMM to reject the RSI_HOST_CALL.
--

commit ec503a8b7982b956b2d7e06ff213250087e22275
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

firmware: smccc: Detect hypervisor via RSI host call in CCA Realms

Modify arm_smccc_hypervisor_has_uuid() to check is_realm_world() and use
rsi_host_call() to query the hypervisor vendor UUID when inside a Realm.
This introduces a file-static rsi_host_call buffer serialized by a spinlock
to handle the request.

> diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smcc=
c.c
> index bdee057db2fd3..6b465e65472b0 100644
> --- a/drivers/firmware/smccc/smccc.c
> +++ b/drivers/firmware/smccc/smccc.c

[ ... ]

> @@ -67,12 +73,45 @@ s32 arm_smccc_get_soc_id_revision(void)
>  }
>  EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
> =20
> +#ifdef CONFIG_ARM64
> +static struct rsi_host_call uuid_hc;
> +static DEFINE_SPINLOCK(uuid_hc_lock);
> +
> +/*
> + * Helper function to get the hypervisor UUID via an RsiHostCall.
> + */
> +static bool arm_smccc_realm_get_hypervisor_uuid(struct arm_smccc_res *re=
s)
> +{
> +	guard(spinlock_irqsave)(&uuid_hc_lock);
> +
> +	memset(&uuid_hc, 0, sizeof(uuid_hc));
> +	uuid_hc.gprs[0] =3D ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID;
> +
> +	if (rsi_host_call(__pa_symbol(&uuid_hc)) !=3D RSI_SUCCESS)

[Severity: High]
Will the RMM reject this host call because uuid_hc is located in protected
memory?

In ARM CCA (Realms), the memory passed to the RMM for an RSI_HOST_CALL
needs to be in the unprotected (shared) state, as the untrusted host
hypervisor must be able to read and write to it.=20

Since uuid_hc is statically allocated, it resides in the kernel's protected
BSS section. Calling rsi_host_call() with this physical address will likely
result in RSI_ERROR_INPUT and break hypervisor UUID discovery.

Additionally, because memory decryption operates at page granularity, apply=
ing
set_memory_decrypted() to a static variable would decrypt adjacent, unrelat=
ed
kernel data and expose it to the untrusted host.

Should this instead use a dedicated, dynamically allocated page that is saf=
ely
marked as decrypted?

> +		return false;
> +
> +	res->a0 =3D uuid_hc.gprs[0];
> +	res->a1 =3D uuid_hc.gprs[1];
> +	res->a2 =3D uuid_hc.gprs[2];
> +	res->a3 =3D uuid_hc.gprs[3];
> +	return true;
> +}
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609181030.2378=
391-1-kameroncarr@linux.microsoft.com?part=3D2

