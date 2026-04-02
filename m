Return-Path: <linux-hyperv+bounces-9914-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDekGwCSzmkbogYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9914-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 17:57:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7508838B8DE
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 17:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9232D300A279
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 15:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EFD3CBE72;
	Thu,  2 Apr 2026 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="wSQO14ka"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE1B318146;
	Thu,  2 Apr 2026 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145342; cv=pass; b=gWcpEKXBUiiiLoDKiuxSFhRpo5rqJgi0bQZ7h4CkbZvwJB4QPgS68YUI1BOJsIqClYYwvrnA3Il1N5ImKh019BTL+3Rag+xQNoVnrGmnPuBrtwearxsFaB0ZYGvZfB8mXVP/kRhm/jC53ER2ALT3UW3MmTS7OHkrFmeci75/nHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145342; c=relaxed/simple;
	bh=5bbxHoX8QOcrOL454eBjrg3Sva4qyQ/yOU5CD2rEOKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMie090I4Vcc6Req255MEXo6JwVB4VJxcEAwygXdqCN8yIYoQkHnYISDwq+6eS/lsTWWkqjaYtf4NzBS2b9ZPryZRN3I00K8b3APUXQOKhANRsD6/E/xSf5evFgROv2TPsj1RrIJhRZcDkE+ItJgjDifqpY0+zA9y7uE0i4TWPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=wSQO14ka; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1775145315; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lPMEHcjJsXWPC4Yam95rUjIH0DinwxhcQ+ANI7RwMBwAfdAAUSeu9u3eCLD8/Y7VP5dEuoD2TXM6TYjGQGrzErl6hpai+XKfOeHUHRtMy7EnP+syOLWE76AqBiPHzj1YQVlnsu6DOllemz4A9SXigq1dt4q0S2cf4HekeqDwAaM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775145315; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kLM+yFounjeNAoH7A9dnDyeLUKswpiloxzozmzgSUzo=; 
	b=akZ1Zh6vNDCwnWyGIi57UyrQzyOpzDRMEnh5sdFyOfdqyNqiHbpnDClYePeOdFWIF9dHDxOxyNR/8GFO2OPhg9aMXkr72vlW+perxOV4kj8VA399uQi6p24wsGeBNn0nVh4I4rNp23s2M7A0uClyo8eExerEJCsJ+nVARAThtTc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775145315;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=kLM+yFounjeNAoH7A9dnDyeLUKswpiloxzozmzgSUzo=;
	b=wSQO14kaqlJNDtVW2oiPbYX/5TwRN00qtdbcSV7rvswtpPrZH3zlWVpJL414KxSW
	cd/OvTTVwwmNmXr1ppN7Rijv/hj/C/EoXdYvudw+NpyA29hEj/bM7WfO7w8lLbBykeL
	o1Dr3x/srFoc2gfS/zUcqqp2RbQfMVSMlVM4UHug=
Received: by mx.zohomail.com with SMTPS id 1775145312629275.6285733305667;
	Thu, 2 Apr 2026 08:55:12 -0700 (PDT)
Date: Thu, 2 Apr 2026 15:55:06 +0000
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
	Roman Kisel <romank@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/6] Drivers: hv: vmbus: fix hyperv_cpuhp_online variable
 shadowing
Message-ID: <20260402-daft-vociferous-lobster-0ad0ee@anirudhrb>
References: <20260327201920.2100427-1-jloeser@linux.microsoft.com>
 <20260327201920.2100427-2-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327201920.2100427-2-jloeser@linux.microsoft.com>
X-ZohoMailClient: External
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9914-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linux.microsoft.com,outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:dkim,anirudhrb.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7508838B8DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 01:19:12PM -0700, Jork Loeser wrote:
> vmbus_alloc_synic_and_connect() declares a local 'int
> hyperv_cpuhp_online' that shadows the file-scope global of the same
> name. The cpuhp state returned by cpuhp_setup_state() is stored in
> the local, leaving the global at 0 (CPUHP_OFFLINE). When
> hv_kexec_handler() or hv_machine_shutdown() later call
> cpuhp_remove_state(hyperv_cpuhp_online) they pass 0, which hits the
> BUG_ON in __cpuhp_remove_state_cpuslocked().
> 
> Remove the local declaration so the cpuhp state is stored in the
> file-scope global where hv_kexec_handler() and hv_machine_shutdown()
> expect it.
> 
> Fixes: 2647c96649ba ("Drivers: hv: Support establishing the confidential VMBus connection")
> Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 3e7a52918ce0..301273d61892 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1430,7 +1430,6 @@ static int vmbus_alloc_synic_and_connect(void)
>  {
>  	int ret, cpu;
>  	struct work_struct __percpu *works;
> -	int hyperv_cpuhp_online;
>  
>  	ret = hv_synic_alloc();
>  	if (ret < 0)
> -- 
> 2.43.0
> 

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


