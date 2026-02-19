Return-Path: <linux-hyperv+bounces-8918-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGpoE7iEl2mUzgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8918-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 22:46:32 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 940BC162EE5
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 22:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E7B83018772
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 21:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979683064A0;
	Thu, 19 Feb 2026 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZRU6XyWJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2DE2D9EC2;
	Thu, 19 Feb 2026 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771537575; cv=none; b=p1eaeK7iFOlXzuFr6srarw0aE8I2DIJ44ds/hJIvE2DQhmWQOKGycRSBQ3nZUuXHCMC/gI3yehC2VncJqVIydUdb1TcxiW2wSjn6Pa5VDKN2L5SNVfBp3ykgoD4QQRMboyB+0yWrnfnKL8KwQz2FxtdCCqjme64sV9FonVn/po4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771537575; c=relaxed/simple;
	bh=chAvArdb7zpbFw83ywWlGpMZQLSe7yffb2J8O93YzZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsgWm258dRd3Jm526ZD3Rn7xYXf95egpUxf1kVjv7JGlK7bd6maaOSFt04F1gat4/K1n2xdjh93y+cl5dJNebM/pLpeTs/HfFBmVTDI6SDguJyU/noJhF9RecAcX5AK6upH1Vu+/rkhcsNPxaBXY32NRC2FRrJgeVekLXHYP7Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZRU6XyWJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id E762420B6F00;
	Thu, 19 Feb 2026 13:46:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E762420B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771537568;
	bh=aiuSqVkPHKzz0DSvSp7aacmsoZM2HA5BICGuqa562Wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZRU6XyWJyHS3N0enA/8yyAp7k4D4JyIsLDdzlCobDzr32i6Z0hhs46zD0FIPXrV2u
	 pC4hY20UmRkkb2TErTyLcC1T3ezwXsOvJpXm15/J7ydUDY25jN09ucR4PfYtJcg7ED
	 n+13usEHr0tE29Zotj/6eeJkWScshdcx24sLOpNU=
Date: Thu, 19 Feb 2026 13:46:05 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] mshv: Handle insufficient root memory hypervisor
 statuses
Message-ID: <aZeEnc1wZ6ipC8G8@skinsburskii.localdomain>
References: <177031674698.186911.179832109354647364.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177031694699.186911.12873334535011325477.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157F28C4F4CEFB886CF949ED466A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260219064701.GQ2236050@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219064701.GQ2236050@liuwe-devbox-debian-v2.local>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,microsoft.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8918-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 940BC162EE5
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 06:47:01AM +0000, Wei Liu wrote:
> On Fri, Feb 06, 2026 at 06:54:55PM +0000, Michael Kelley wrote:
> > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Thursday, February 5, 2026 10:42 AM
> > > To: kys@microsoft.com; haiyangz@microsoft.com; wei.liu@kernel.org;
> > > decui@microsoft.com; longli@microsoft.com
> > > Cc: linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: [PATCH v3 4/4] mshv: Handle insufficient root memory hypervisor statuses
> > > 
> > > When creating guest partition objects, the hypervisor may fail to
> > > allocate root partition pages and return an insufficient memory status.
> > > In this case, deposit memory using the root partition ID instead.
> > > 
> > > Note: This error should never occur in a guest of L1VH partition context.
> > > 
> > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > ---
> > >  drivers/hv/hv_common.c      |    2 +
> > >  drivers/hv/hv_proc.c        |   14 ++++++++++
> > >  include/hyperv/hvgdk_mini.h |   58 ++++++++++++++++++++++---------------------
> > >  3 files changed, 46 insertions(+), 28 deletions(-)
> > > 
> > > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > > index f20596276662..6b67ac616789 100644
> > > --- a/drivers/hv/hv_common.c
> > > +++ b/drivers/hv/hv_common.c
> > > @@ -794,6 +794,8 @@ static const struct hv_status_info hv_status_infos[] = {
> > >  	_STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	-EIO),
> > >  	_STATUS_INFO(HV_STATUS_INSUFFICIENT_MEMORY,		-ENOMEM),
> > >  	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY,	-ENOMEM),
> > > +	_STATUS_INFO(HV_STATUS_INSUFFICIENT_ROOT_MEMORY,	-ENOMEM),
> > > +	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY, 	-ENOMEM),
> > >  	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_ID,		-EINVAL),
> > >  	_STATUS_INFO(HV_STATUS_INVALID_VP_INDEX,		-EINVAL),
> > >  	_STATUS_INFO(HV_STATUS_NOT_FOUND,			-EIO),
> > > diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> > > index 181f6d02bce3..5f4fd9c3231c 100644
> > > --- a/drivers/hv/hv_proc.c
> > > +++ b/drivers/hv/hv_proc.c
> > > @@ -121,6 +121,18 @@ int hv_deposit_memory_node(int node, u64 partition_id,
> > >  	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
> > >  		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
> > >  		break;
> > > +
> > > +	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY:
> > > +		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
> > > +		fallthrough;
> > > +	case HV_STATUS_INSUFFICIENT_ROOT_MEMORY:
> > > +		if (!hv_root_partition()) {
> > > +			hv_status_err(hv_status, "Unexpected root memory deposit\n");
> > > +			return -ENOMEM;
> > > +		}
> > > +		partition_id = HV_PARTITION_ID_SELF;
> > > +		break;
> > > +
> > 
> > Per the discussion in v1 of this patch set, if the number of pages that should be
> > deposited in a particular situation is different from what this function provides,
> > the fallback is to use hv_call_deposit_pages() directly. From what I see, there's
> > only one such fallback case after a hypercall failure -- in hv_do_map_gpa_hcall().
> > The other uses of hv_call_deposit_pages() are initial deposits when creating a
> > VP or partition.
> > 
> > But if hv_call_deposit_pages() is used directly, the logic added here to detect
> > insufficient root memory and deposit to HV_PARTITION_ID_SELF isn't applied.
> > So if the hypercall in hv_do_map_gpa_hcall() fails with insufficient root
> > memory, the deposit is done to the wrong partition ID. If that case can
> > actually happen, then some additional logic is needed in
> > hv_do_map_gpa_hcall() to handle it. Or there needs to be a fallback
> > function that contains the logic.
> 
> Stanislav, how about this comment? Please submit a follow-up patch if
> necessary.
> 

I'll sumbit a follow-up patch.

Thanks,
Stanislav

> Wei
> 
> > 
> > Other than that, everything else in this patch set looks good to me.
> > 
> > Michael
> > 
> > >  	default:
> > >  		hv_status_err(hv_status, "Unexpected!\n");
> > >  		return -ENOMEM;

