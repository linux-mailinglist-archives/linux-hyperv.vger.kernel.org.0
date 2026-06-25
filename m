Return-Path: <linux-hyperv+bounces-11681-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XXwIKlpqPWqG2wgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11681-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 19:50:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C5E6C802A
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 19:50:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WEm3xqAM;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11681-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11681-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A46F7300289E
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 17:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6863EB7FD;
	Thu, 25 Jun 2026 17:50:16 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC54339B954
	for <linux-hyperv@vger.kernel.org>; Thu, 25 Jun 2026 17:50:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782409816; cv=none; b=poy0aAnHFk/btmav7wm+SjpqQiSEUHHjd1izeuq1LRhMnXeP0KynPsz//II8hQy+HpPaRK7LAR7q0E6VTY3+8ACSB1R8T9fi9pl1cCEms+toKxxEzsMVq1ybcPPEwOsi8wL9V58CevXu1EClodoje0Lgmb+nk/PQJ+6TVHekKUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782409816; c=relaxed/simple;
	bh=u2CuW0x1/EmckT65DhLWqpVDwQecbKHAb07ZWB6hB+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Py7ZNKJ72shpAeMhG5/fkRad1aZJewMvj33dN6U8Q8/w4RRv6cO76hDFRFBE4w9+wUYqYoG6/4TdFGhLuXt+F/nUh1lMP1idkncLbUUqJaLHqCcp6IgX3Iy+tyaPGv3rHGchYAqp4yUfOuNqrgld8w/DsZB7812DGjhBlgINWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEm3xqAM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B031F00A3A;
	Thu, 25 Jun 2026 17:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782409814;
	bh=mNYPZedTJVfaPfMonIJ00/zApu6jfhQwoNktpbhb+fI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WEm3xqAMni7Pg0cnqvuuTajYeUZFZRTwK2BJhuXtBThuCIyNTiPxinhIArRlO1ONr
	 fs2FUtowBwji9zv2UTgf00qPQIO+DwMJNX14cK29MTwoSbgcpKoumZ+PoH+LMr26tV
	 zPDsrEozwwoSU8I9nRevRgHaoO2EVpBqzAj2VlmmLJwBoc31X9T3QBILGbM0bz6eHd
	 tFtL2H26fR26XovR0/bRdvz1ngGFR9X/Cg5WeLzR7myo0lyV1LW/EIMKG89wo0s3qQ
	 AD4tQj0LZzNUhCgu+Mku0HEsuDoNIoFFxV2bjGiPxRRNvM7z5ZVBE1wlXXz5s0Dvh+
	 xjJ2y/kk+6h1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] arm64: hyperv: Route hypercalls through RSI host
 call in CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260625173500.1995481-6-kameroncarr@linux.microsoft.com>
References: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com>
 <20260625173500.1995481-6-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 17:50:13 +0000
Message-Id: <20260625175014.32B031F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11681-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47C5E6C802A

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Missing Unprotected IPA Translation
- [High] Alignment Constraint Violation / Boot Failure
- [High] Missing NULL Pointer Check / NULL Dereference
--

commit a71c2edcad24708c7ea03f518e33fcef346f68d6
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

arm64: hyperv: Route hypercalls through RSI host call in CCA Realms
   =20
Modify the five hypercall wrapper functions to check is_realm_world()
and use the per-CPU rsi_host_call structure when inside a Realm.

> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
> index e33a9e3c366a1..77cba08fca132 100644
> --- a/arch/arm64/hyperv/hv_core.c
> +++ b/arch/arm64/hyperv/hv_core.c
> @@ -13,9 +13,41 @@

[ ... ]

> +static u64 hv_do_rsi_hypercall(u64 control, u64 input1, u64 input2)
> +{
> +	struct rsi_host_call *hostcall;
> +	unsigned long flags;
> +	u64 ret;
> +
> +	if (!hv_hostcall_array)
> +		return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
> +	local_irq_save(flags);
> +	hostcall =3D &hv_hostcall_array[smp_processor_id()];
> +	memset(hostcall, 0, sizeof(*hostcall));
> +	hostcall->gprs[0] =3D HV_FUNC_ID;
> +	hostcall->gprs[1] =3D control;
> +	hostcall->gprs[2] =3D input1;
> +	hostcall->gprs[3] =3D input2;
> +
> +	if (rsi_host_call(virt_to_phys(hostcall)) =3D=3D RSI_SUCCESS)

[Severity: High]
Does this allocation guarantee the 256-byte alignment required by the Arm C=
CA
RMM specification for the hostcall structure IPA?

If hv_hostcall_array is allocated with kcalloc(), which does not guarantee
type alignment, SLUB debugging or KASAN redzones could shift the object
offset.

Will calling rsi_host_call() with a misaligned pointer cause the RMM to
reject the command with RSI_ERROR_INPUT, ultimately triggering a fatal
BUG_ON(!hv_result_success(status)) in the wrapper?

> +		ret =3D hostcall->gprs[0];
> +	else
> +		ret =3D HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
> +	local_irq_restore(flags);
> +	return ret;
> +}

[ ... ]

> @@ -29,8 +61,11 @@ u64 hv_do_hypercall(u64 control, void *input, void *ou=
tput)
>  	input_address =3D input ? virt_to_phys(input) : 0;
>  	output_address =3D output ? virt_to_phys(output) : 0;
> =20
> -	arm_smccc_1_1_hvc(HV_FUNC_ID, control,
> -			  input_address, output_address, &res);
> +	if (is_realm_world())
> +		return hv_do_rsi_hypercall(control, input_address, output_address);

[Severity: Critical]
Will this translate the virtual address into a protected IPA without applyi=
ng
the PROT_NS_SHARED bit required for host access?

In an Arm CCA Realm, memory shared with the host must be accessed via the
unprotected IPA space. The virt_to_phys() call only calculates the canonical
protected IPA.

When the untrusted host attempts to read or write the hypercall buffer using
these protected IPAs, won't the RMM block the access and generate a stage-2
fault?

> +
> +	arm_smccc_1_1_hvc(HV_FUNC_ID, control, input_address,
> +			  output_address, &res);
>  	return res.a0;
>  }

[ ... ]

> @@ -76,24 +117,44 @@ EXPORT_SYMBOL_GPL(hv_do_fast_hypercall16);
>  void hv_set_vpreg(u32 msr, u64 value)
>  {
>  	struct arm_smccc_res res;
> +	struct rsi_host_call *hostcall;
> +	unsigned long flags;
> +	u64 status;
> =20
> +	if (is_realm_world()) {
> +		local_irq_save(flags);
> +		hostcall =3D &hv_hostcall_array[smp_processor_id()];
> +		memset(hostcall, 0, sizeof(*hostcall));

[Severity: High]
What happens if this is called early during a kernel panic before
hv_hostcall_array is initialized?

If an early kernel panic occurs or allocation fails, the crash handler
hyperv_report_panic() will invoke hv_set_vpreg(). Because this lacks the NU=
LL
check present in hv_do_rsi_hypercall(), calculating the offset from NULL and
passing it to memset() might cause a double fault.

Could this prevent the panic from being reported to the hypervisor and
hang the system?

> +		hostcall->gprs[0] =3D HV_FUNC_ID;
> +		hostcall->gprs[1] =3D HVCALL_SET_VP_REGISTERS |

[ ... ]

> @@ -108,29 +169,55 @@ void hv_get_vpreg_128(u32 msr, struct hv_get_vp_reg=
isters_output *result)
>  {
>  	struct arm_smccc_1_2_regs args;
>  	struct arm_smccc_1_2_regs res;
> +	struct rsi_host_call *hostcall;
> +	unsigned long flags;
> +	u64 status;
> =20
> +	if (is_realm_world()) {
> +		local_irq_save(flags);
> +		hostcall =3D &hv_hostcall_array[smp_processor_id()];
> +		memset(hostcall, 0, sizeof(*hostcall));

[Severity: High]
Similar to hv_set_vpreg(), does this need a check for hv_hostcall_array
being NULL to avoid a NULL pointer dereference if invoked before the array
is properly allocated?

> =20
> -	/*
> -	 * Use the SMCCC 1.2 interface because the results are in registers
> -	 * beyond X0-X3.
> -	 */
> -	arm_smccc_1_2_hvc(&args, &res);
> +		hostcall->gprs[0] =3D HV_FUNC_ID;
> +		hostcall->gprs[1] =3D HVCALL_GET_VP_REGISTERS |

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625173500.1995=
481-1-kameroncarr@linux.microsoft.com?part=3D5

