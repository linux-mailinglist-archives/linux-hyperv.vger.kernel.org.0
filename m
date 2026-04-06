Return-Path: <linux-hyperv+bounces-10018-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP+DHjPr02nInwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10018-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:19:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6E03A5A02
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DD32301FD4E
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DFD390CB8;
	Mon,  6 Apr 2026 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="mDIoEufQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB706390CBE;
	Mon,  6 Apr 2026 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495965; cv=pass; b=eoX5fWqTIE/CYTKwYeDjCEqdRWuTavFgkLBB1GkdAZRKNAsRIT37/Bram71YzuNO9TTQOrk7VvO1mEunjrJncGOlnzOWhvn8y4TxuNUhR46YXf9iivJltQW1/7fwzYS2RlsD+0+TtlX5OXl6KmfmRYff2Ei4EsOYheRrOskan60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495965; c=relaxed/simple;
	bh=5M5OxqF1ikzkJo4BqDxxIBptWI6WRjEGWgmzzqcUGUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7w7SW27hX8c5ymf6A4/47jAdNnANFFcxUlqKQLK+YgulEbnmRRD1Y3XH+ICc/7sRolTTaxRjptlrMYoF9K+y/Ke3T4BJtL9efEporUeqvJQ3xqU9jJGtdNWyOJvnnThvcYJQExwYcyUaxR7gtEvGUFJyZmFLdE0V0cWRyMSWUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=mDIoEufQ; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1775495929; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Kb+7QzY9XUHuQFx2s3oF0smYiPlCA3S6tmF/ooAT0rLU7NocM64WwdFJwrmOyCja5BhWMR6YJH3wSl/teeX6O/YjxY0POl+2lIoeNYemtFxr2BgthpKqym4TRc56QOAseH/v1jrOtxOk2QOPARyz0hxjk8DcfO7r/AfRUN65bSY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775495929; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oogT3wY4IwpNt/dM4PaKWqlsiZyt7NdqlBousvPh7y4=; 
	b=TKzvJb8bc9jO1N7Y2auMzTfm3FZ5IDISab+xqN//rVoqQjc/HTHXumNovpiJQnYI2twIizI6wb02Sd+FcWxmfPk9UpeUoQOm0PMUy911NDFTDv+ELon6un6at0zSqbLtoZrf8aVq/ADMCb+OI6L4VhbjGNWneptvMv54rzO1AYU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775495929;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=oogT3wY4IwpNt/dM4PaKWqlsiZyt7NdqlBousvPh7y4=;
	b=mDIoEufQlq+6MttIrPf3hNDm5GDyiqbzKVOll5GXIlJpt679PAPOGDeNuCjaeJ5J
	woQpe8XErcVeiGw3rVGlifYEpiXlzpYOPAPzIhaFY4BwhvKIZ2whbR299zMhay1v9gB
	yW01t5b0p/3i1NDQnDcu/a+UiA6PLXyghEOX3yFo=
Received: by mx.zohomail.com with SMTPS id 1775495926003718.8491488023417;
	Mon, 6 Apr 2026 10:18:46 -0700 (PDT)
Date: Mon, 6 Apr 2026 17:18:37 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 4/6] mshv: limit SynIC management to MSHV-owned
 resources
Message-ID: <20260406-ninja-civet-of-tornado-67ff54@anirudhrb>
References: <20260403190613.47026-1-jloeser@linux.microsoft.com>
 <20260403190613.47026-5-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403190613.47026-5-jloeser@linux.microsoft.com>
X-ZohoMailClient: External
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10018-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1D6E03A5A02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 12:06:10PM -0700, Jork Loeser wrote:
> The SynIC is shared between VMBus and MSHV. VMBus owns the message
> page (SIMP), event flags page (SIEFP), global enable (SCONTROL),
> and SINT2. MSHV adds SINT0, SINT5, and the event ring page (SIRBP).
> 
> Currently mshv_synic_init() redundantly enables SIMP, SIEFP, and

The redundant enable is probably a no-op from the hypervisor side so it
probably doesn't hurt us. The main problem is with the tear down.

> SCONTROL that VMBus already configured, and mshv_synic_cleanup()
> disables all of them. This is wrong because MSHV can be torn down
> while VMBus is still active. In particular, a kexec reboot notifier
> tears down MSHV first. Disabling SCONTROL, SIMP, and SIEFP out
> from under VMBus causes its later cleanup to write SynIC MSRs while
> SynIC is disabled, which the hypervisor does not tolerate.
> 
> Restrict MSHV to managing only the resources it owns:
> - SINT0, SINT5: mask on cleanup, unmask on init
> - SIRBP: enable/disable as before
> - SIMP, SIEFP, SCONTROL: leave to VMBus when it is active (L1VH
>   and nested root partition); on a non-nested root partition VMBus
>   doesn't run, so MSHV must enable/disable them
> 
> Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
> ---
>  drivers/hv/mshv_synic.c | 142 ++++++++++++++++++++++++++--------------
>  1 file changed, 94 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index f8b0337cdc82..7d273766bdb5 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -454,46 +454,72 @@ int mshv_synic_init(unsigned int cpu)
>  #ifdef HYPERVISOR_CALLBACK_VECTOR
>  	union hv_synic_sint sint;
>  #endif
> -	union hv_synic_scontrol sctrl;
>  	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
>  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
>  	struct hv_synic_event_flags_page **event_flags_page =
>  			&spages->synic_event_flags_page;
>  	struct hv_synic_event_ring_page **event_ring_page =
>  			&spages->synic_event_ring_page;
> +	/* VMBus runs on L1VH and nested root; it owns SIMP/SIEFP/SCONTROL */
> +	bool vmbus_active = !hv_root_partition() || hv_nested;

An alternative approach could be: check if SIMP/SIEFP/SCONTROL is
already enabled. If so, don't enable it again. If not enabled, enable it
and keep track of what all stuf we have enabled. Then disable all of
them during cleanup. This approach makes less assumptions about the
behavior of the VMBUS driver and what stuff it does or doesn't use.

Thanks,
Anirudh.


