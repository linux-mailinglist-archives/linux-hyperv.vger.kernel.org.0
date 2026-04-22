Return-Path: <linux-hyperv+bounces-10314-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KYvKr/m6GkHRQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10314-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 17:18:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 185A3447C66
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 17:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FD5230783A3
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 15:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E54730E831;
	Wed, 22 Apr 2026 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oppQpWe1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEA7263C7F;
	Wed, 22 Apr 2026 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870733; cv=none; b=bh3E58qAJABLnsZZBmu5TVs4LDa7xUK86RbvxxDFJ83IKCfdCLzbOBEP+DMksn4hNMdpzxsp0iAaiAtvMQSdyDlNFTd7VdSjx408IIb1Rp9ofZsExZp4Cl9eZA9z8CHUou87GbTZecBAPbmUoaIWpy6z0ztktT7ZYW7M+Q8Nk4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870733; c=relaxed/simple;
	bh=FJ3tLnxKvLVloZ5rS+HRNuXcWnVerK4M2CifeYSuIEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0HjbW0d4XUD+lukYZYhaaXZZlsqa0KEmr+J33fqmdytx9H3+8fJ/d+JOYympXPX28CWhIK39z9X2aMSxglN6guIFKoTAlJpgwlIuDg7NvG/8qGC7ez8C9594QDViJSiI6FKAxb3QBWiyFx99/D1jjK7fUGPihdQ/8rhULj97A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oppQpWe1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 28C6F20B6F01;
	Wed, 22 Apr 2026 08:12:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 28C6F20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776870732;
	bh=vB6SASTrcM7Rgaou48JEAKmQatG4E6D4sf/B9JlqQe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oppQpWe1N3kGZ+rF+CDpURrcUxljkYeINYtAyZd6RGlTs+t2nEJ4pfiO2ioKO7POT
	 kBFzbMGKNpjbi1kTRYGE5qWdU2P7NTQdd72y/Yh9f2mfESXB1RirkvYtLmJv129sdd
	 4g7/hrs5LOE7fVsFYvzhXUScuNYacjQlzDZak6SQ=
Date: Wed, 22 Apr 2026 08:12:10 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] mshv: Refactor memory region management and map
 pages at creation
Message-ID: <aejlSrjjOmK90sFJ@skinsburskii.localdomain>
References: <177678175995.13344.10130389779290396174.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB415768E025155E296A5DE681D42D2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415768E025155E296A5DE681D42D2@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10314-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:server fail];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 185A3447C66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 01:42:54AM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesday, April 21, 2026 7:35 AM
> > 
> > This series refactors the mshv memory region subsystem in preparation
> > for mapping populated pages into the hypervisor at movable region
> > creation time, rather than relying solely on demand faulting.
> > 
> > The primary motivation is to ensure that when userspace passes a
> > pre-populated mapping for a movable memory region, those pages are
> > immediately visible to the hypervisor. Previously, all movable regions
> > were created with HV_MAP_GPA_NO_ACCESS on every page regardless of
> > whether the backing pages were already present, deferring all mapping
> > to the fault handler. This added unnecessary fault overhead and
> > complicated the initial setup of child partitions with pre-populated
> > memory.
> 
> [snip]
> 
> > 
> > v2:
> >  - Rebased on top of latest mainline, simplified the check for valid PFNs,
> >    added other minor cleanups and improvements.
> 
> I'm confused about "simplified the check for valid PFNs".
> I see one place in mshv_region_process_pfns() where a PFN
> from the mreg_pfns[] array is checked against
> MSHV_INVALID_PFN instead of doing pfn_valid(). But there
> are 11 other places in the patch set where pfn_valid() is still
> used, including in mshv_region_process_pfns().
> 

I wanted to get sashiko's feedabck.
I'll send another version with more fixes.

Thanks,
Stanislav

> Michael
> 
> > 
> > ---
> > 
> > Stanislav Kinsburskii (7):
> >       mshv: Convert from page pointers to PFNs
> >       mshv: Add support to address range holes remapping
> >       mshv: Support regions with different VMAs
> >       mshv: Move pinned region setup to mshv_regions.c
> >       mshv: Map populated pages on movable region creation
> >       mshv: Extract MMIO region mapping into separate function
> >       mshv: Add tracepoint for map GPA hypercall
> > 
> > 
> >  drivers/hv/mshv_regions.c      |  589 +++++++++++++++++++++++++++++-----------
> >  drivers/hv/mshv_root.h         |   29 +-
> >  drivers/hv/mshv_root_hv_call.c |   53 ++--
> >  drivers/hv/mshv_root_main.c    |   99 +------
> >  drivers/hv/mshv_trace.h        |   36 ++
> >  5 files changed, 508 insertions(+), 298 deletions(-)
> > 
> 

