Return-Path: <linux-hyperv+bounces-8555-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALQiHwk9eWkmwAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8555-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 23:32:41 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F0E9B162
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 23:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A497300462D
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 22:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7508F2C15BA;
	Tue, 27 Jan 2026 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="F1si3MiQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B77286D4B;
	Tue, 27 Jan 2026 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553084; cv=none; b=PJtHjqTspFGeR7/y9DRJhvPFG+sEpLjk1ONyvpHvnor3kuc4TjZ8nDTUXanq3EtDqfAuZLWX6VDjjxVKcAagBw6sEBOpgNxmRCEVIVuabCYBuFlCNEN4G/nQdLT/x62boiVUQTtvc7IclfkYo2KCtYW07tmuRDNrCA+XeM1t0II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553084; c=relaxed/simple;
	bh=M7OTPa9CFRukaUgTXMHL3iHKOsHBdZB2KAce7e7QMz4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Op8UqaS8GAwurrebF9+HN2zMRSMogolEqgxvub02peM5n6DzVXO52LZlIOhc7gY5g7ipCqmNKohIJs/lwzJoHuogib1Nqg5+aG8eu1MQiOjfyrQMDxuV6UKh1BDUeIf8L+WtEltggBv8TodgccrSxHP/zV9bQ+Zfkc6cbTgZIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=F1si3MiQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [20.236.10.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id B8ED720B7165;
	Tue, 27 Jan 2026 14:31:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B8ED720B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769553082;
	bh=9Y87uN8apxJlmpJ0adW57fWqDfRG/gwUC83x8atmq9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F1si3MiQathZr4J82s8s0tPHsEM5HHu3iS0KWgyiIFmh8t2z/1riF5H5xeqL6uiuf
	 AOSvepTJcBbjh7av4ZpznQmyzGXf8lMs9q1Z9SaOKsW9NyFqjtoOkeHsLcJPT2cZXK
	 bl7roCyARz3JMk+uDttCnod8Mzv/bdsqjOGEPfig=
Date: Tue, 27 Jan 2026 14:31:19 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
 nunodasneves@linux.microsoft.com, mhklinux@outlook.com
Subject: Re: [PATCH v0 12/15] x86/hyperv: Implement hyperv virtual iommu
Message-ID: <20260127143119.00006d2f@linux.microsoft.com>
In-Reply-To: <20260127112144.00002991@linux.microsoft.com>
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
	<20260120064230.3602565-13-mrathor@linux.microsoft.com>
	<20260121211806.000006aa@linux.microsoft.com>
	<34de2049-912e-fc9e-9fc1-727fade0480f@linux.microsoft.com>
	<20260127112144.00002991@linux.microsoft.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8555-lists,linux-hyperv=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.pan@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26F0E9B162
X-Rspamd-Action: no action

Hi Mukesh,

> > >> +
> > >> +	if (hv_l1vh_partition() && !hv_curr_thread_is_vmm() &&
> > >> !hv_no_attdev) {
> > >> +		pr_err("Hyper-V: l1vh iommu does not support
> > >> host devices\n");    
> > > why is this an error if user input choose not to do direct
> > > attach?    
> > 
> > Like the error message says: on l1vh, direct attaches of host
> > devices (eg dpdk) is not supported. and l1vh only does direct
> > attaches. IOW, no host devices on l1vh.
> >   
> This hv_no_attdev flag is really confusing to me, by default
> hv_no_attdev is false, which allows direct attach. And you are saying
> l1vh allows it.
> 
> Why is this flag also controls host device attachment in l1vh? If you
> can tell the difference between direct host device attach and other
> direct attach, why don't you reject always reject host attach in l1vh?
On second thought, if the hv_no_attdev knob is only meant to control
host domain attach vs. direct attach, then it is irrelevant on L1VH.

Would it make more sense to rename this to something like
hv_host_disable_direct_attach? That would better reflect its scope and
allow it to be ignored under L1VH, and reduce the risk of users
misinterpreting or misusing it.

