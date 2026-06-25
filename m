Return-Path: <linux-hyperv+bounces-11683-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m2ryDD9rPWrO2wgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11683-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 19:54:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C50436C80A2
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 19:54:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="VJX5/K1V";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11683-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11683-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D7FB300681A
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 17:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A41E30566D;
	Thu, 25 Jun 2026 17:54:04 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD7D3EA961
	for <linux-hyperv@vger.kernel.org>; Thu, 25 Jun 2026 17:54:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410044; cv=none; b=HE7KXw/qb/+TZbeRCpfO4ZUHQA0vFncOIVlpUAo1tBP6aCPHqbY6+aFYMKvM5ZoiDEW5cWNsoF28QBgcruZE7KFdSZM9lVyrfVnPLA2PH26iIhOb2emnP5mpuI6pM9SHccXlARWaDqXhO6Jg0uxwijy+0rcMuUneFuaCXAyHFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410044; c=relaxed/simple;
	bh=qG0bn8kxZQeXC+1GlekZJ3kTnfb1eop9+y2PB3tftk0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RR0d1K+/KSp1UU8J/nd+JMqHW49l2WO4F0fylHZX/eID+E/vs+RkptJ8WYnzXQyYc+BABDaD3AJjQbBWMiIA/JAFr9tKEQaNCczoGxNmdQzyEoPJhR6DwVGGPopNCqt6ZUpMDgXFSWSqDsZt2LyTJr65Y3GX52f47bejRd4GnSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJX5/K1V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378B51F000E9;
	Thu, 25 Jun 2026 17:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782410042;
	bh=KBqLGNFCwil1X1ocztkmUvL0PUsyEzxpBiVKIzfYqOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VJX5/K1V8WRSHbuKxm3BpQJX+3xmGg8x1aH2EkOH+5xA1hVjdWU7mvZfTLci47kgG
	 UPytES6EPWMwKcYGuA8jfwPBldi62O5gTDvcFMaMRbSLh/D+DmkvyXEl5DmSiNSoSF
	 jzFXjXw3dGCKqHOBd7Hys4itYSkJF1V5gpLkP+DJXfHmXVsLfA2Dyezugwr/jycYPi
	 u75XUrsekHxO3CwQsKlOfNzgOr+p7IgP7zQVfE3NTk93yAljL53O3E6nMTiNnlBhYi
	 thD/hE5Uqu5NyvZN276th/i5Ho22EDSMhFz1lB8PMiwDWcmYb5YX3mzE4DCABggn79
	 KGQlPKc3ZlEeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] firmware: smccc: Detect hypervisor via RSI host
 call in CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260625173500.1995481-3-kameroncarr@linux.microsoft.com>
References: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com>
 <20260625173500.1995481-3-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 17:54:01 +0000
Message-Id: <20260625175402.378B51F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11683-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C50436C80A2

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Initialization order bug causes `arm_smccc_hypervisor_has_uuid()=
` to incorrectly fall back to standard SMC during early boot in a CCA Realm.
--

commit 8e27a5d40fac36e0edcb6814624362e892694ac4
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

firmware: smccc: Detect hypervisor via RSI host call in CCA Realms

This commit modifies arm_smccc_hypervisor_has_uuid() to check is_realm_worl=
d()
and use an RSI host call to query the hypervisor UUID inside a Realm. It ad=
ds
a file-static RSI host call buffer serialized by a spinlock for ARM64.

> diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smcc=
c.c
> index bdee057db2fd3..a876b7aa2dc99 100644
> --- a/drivers/firmware/smccc/smccc.c
> +++ b/drivers/firmware/smccc/smccc.c
[ ... ]
> @@ -67,12 +73,45 @@ s32 arm_smccc_get_soc_id_revision(void)
>  }
>  EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
> =20
[ ... ]
>  bool arm_smccc_hypervisor_has_uuid(const uuid_t *hyp_uuid)
>  {
>  	struct arm_smccc_res res =3D {};
>  	uuid_t uuid;
> =20
> -	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
> +#ifdef CONFIG_ARM64
> +	if (is_realm_world())
> +		arm_smccc_realm_get_hypervisor_uuid(&res);
> +	else
> +#endif

[Severity: Medium]
Will this check evaluate to false during early boot, causing the detection =
to
incorrectly fall back to the standard SMC conduit?

Looking at setup_arch(), psci_dt_init() executes before arm64_rsi_init() is
called to set up the rsi_present static key used by is_realm_world():

setup_arch() {
    ...
    if (acpi_disabled)
        psci_dt_init();
    else
        psci_acpi_init();

    arm64_rsi_init();
    ...
}

Because psci_dt_init() calls psci_probe(), which calls kvm_init_hyp_service=
s(),
this eventually reaches arm_smccc_hypervisor_has_uuid() before the static k=
ey
is initialized.=20

Does this sequence cause a silent failure to detect the KVM hypervisor insi=
de
an Arm CCA Realm?

> +		arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID,
> +				     &res);
> +
>  	if (res.a0 =3D=3D SMCCC_RET_NOT_SUPPORTED)
>  		return false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625173500.1995=
481-1-kameroncarr@linux.microsoft.com?part=3D2

