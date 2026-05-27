Return-Path: <linux-hyperv+bounces-11262-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLkEOeV1F2ruFggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11262-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:53:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E9C5EAC70
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48F303024971
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 22:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21AA3B6345;
	Wed, 27 May 2026 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhw7S3jJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC4235F17D;
	Wed, 27 May 2026 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779922241; cv=none; b=MN9KUb/RVlbx/feJyF0gwvhK2D+mKVOJ+lf+2qtkcFPbI4QzOiszncO032ycJkaPt5PAOy3vDWr8c98IBJAYdHOLRYoFcsVpQebPx8jO4DzJxWinVExzIm35Sa7S26Q65hOyWMp4UKS5MhqOFoh3e4fGNPEvgvXOmEguPR64SaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779922241; c=relaxed/simple;
	bh=rWwyGqzEcc1rl4gmeL5NkuvI/2yXQskzT3jCS38aDtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WF0ZtPmalijuth+U+0l/dssPkzQfR2mSwLP0nfIMG47YiEpevFNeyH202HxXN0YyirMsILMzZKTXwMOB2xnKM9qdngUlVS41HCa/1xd+LjyLBQPXorvq4tx3irYW/PUhzJ8cEP44zPb4VvGfzcSlU6TZ22wAem1NPzGdKJqBZJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhw7S3jJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C7B1F000E9;
	Wed, 27 May 2026 22:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779922240;
	bh=9ySTpxezoAiBFX0/7zEUiI4eNm+Oaylf4HMVPn8Ys+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fhw7S3jJcbuIlgSOp29WFGHzJGB8ddxj21QfNQC7Kt+/DuNhL3vzkfrKDOK2vHXpU
	 9u3VGq1FBhaFxNhXtDsHCGmQxkVUA9Ohv3lMJq9Az76x2nDOwUB6XMvehUlh9tTFoC
	 EGh04Ya+JrGSncmzc441tVrPR6j2TzwyfIIw08LxXSPeFPEe6h/434pSvOdwDDpKsf
	 7oDoNQaqM5EhSla92HypgPbcuB4wUC2Nf3obbHOjWriw5lRJevLfjOdPHN4Upktnyr
	 vdvGgOrWVDC3Yq5FtR1nZ8EZ9nncfapF6wZnVzmeAn8Aci91MUqjjSrAfcng/qGtOj
	 ZNfnnt/SxyJXg==
Date: Wed, 27 May 2026 15:50:38 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juergen Gross <jgross@suse.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, John Stultz <jstultz@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stephen Boyd <sboyd@kernel.org>, x86@kernel.org,
	linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	Michael Kelley <mhklinux@outlook.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v3 09/41] clocksource: hyper-v: Don't save/restore TSC
 offset when using HV sched_clock
Message-ID: <20260527225038.GG3518940@liuwe-devbox-debian-v2.local>
References: <20260515191942.1892718-1-seanjc@google.com>
 <20260515191942.1892718-10-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515191942.1892718-10-seanjc@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11262-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,microsoft.com,broadcom.com,siemens.com,linux.intel.com,infradead.org,suse.com,google.com,intel.com,oracle.com,lists.linux.dev,vger.kernel.org,lists.xenproject.org,outlook.com,amd.com,linutronix.de,amazon.co.uk];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,liuwe-devbox-debian-v2.local:mid,outlook.com:email]
X-Rspamd-Queue-Id: 44E9C5EAC70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026 at 12:19:10PM -0700, Sean Christopherson wrote:
> Now that Hyper-V overrides the sched_clock save/restore hooks if and only
> sched_clock itself is set to the Hyper-V reference counter, drop the
> invocation of the "old" save/restore callbacks.  When the registration of
> the PV sched_clock was done separately from overriding the save/restore
> hooks, it was possible for Hyper-V to clobber the TSC save/restore
> callbacks without actually switching to the Hyper-V refcounter.
> 
> Enabling a PV sched_clock is a one-way street, i.e. the kernel will never
> revert to using TSC for sched_clock, and so there is no need to invoke the
> TSC save/restore hooks (and if there was, it belongs in common PV code).
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

