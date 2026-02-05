Return-Path: <linux-hyperv+bounces-8740-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNDMMJzjhGlC6QMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8740-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:38:20 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A5DF679D
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 618B1301F31E
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 18:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC6F2FF155;
	Thu,  5 Feb 2026 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YNC5qwIa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48742FF14D;
	Thu,  5 Feb 2026 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770316621; cv=none; b=Ba+roL/nsY6aK1PZuRe45ydWnG1cnx8rlNoErZFYRYPTvYppeeVf3qPxDZ9himZ4rTQvmR5DRBSS2JdS7LGJN1Fc4c3cVWMt6ZD+mL9iSebadgLd80RQ4lnx8I4WMkOKBxMaakEqcjivhAPZBHHy9Qs5fs8Y/sqd71gRMB7EK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770316621; c=relaxed/simple;
	bh=vVbeOeYTJgsS1ZukBzFpoE2G40NK9bFviPQgHNuLzuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2semFjIiSfRDOXdRLdPTsls6E+Biv3QPmSqTWBt/oImFeP4V/JN2qXJSIvgb9lYOP/9TDc5WyHpKOeK0scyvWSmFo9pIs77rEOGe4FF5zQzd8ZgeZZ+Tl1xsXX9IBJzvQ3nInI35JCT7isvx7rrna0mOcTJN177xek4IhM0SDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YNC5qwIa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id A71B020B7168;
	Thu,  5 Feb 2026 10:36:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A71B020B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770316614;
	bh=T9UDi94u3DQFddZD/5DZdafghiDbKocbGM1cB3oHAX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YNC5qwIaMJKOm4gB7s1FgWpDkB71dbVFNC1eSHEEJv856MnI13/FB7eqFYw2KH3xe
	 ZMGp1hP2OmiJmY/rbIxHHyfHxsTgA1vUi0GtMeYRR3DV7pFI7Rxk5lC4c7zbgwzjh0
	 qyKL2GuGQBuf948EW3ggaNoXnxkzpVA/1cYZF9pk=
Date: Thu, 5 Feb 2026 10:36:53 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mshv: Handle insufficient root memory hypervisor
 statuses
Message-ID: <aYTjRfN1NwYbUsAp@skinsburskii.localdomain>
References: <177005499596.120041.5908089206606113719.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177005515446.120041.8169777750859263202.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <s6orh5waw2djyiv5w6yzwiaxv7rcja6iua6kbzldthsmceelqv@dnf2zr2m74we>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s6orh5waw2djyiv5w6yzwiaxv7rcja6iua6kbzldthsmceelqv@dnf2zr2m74we>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8740-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii.localdomain:mid]
X-Rspamd-Queue-Id: 25A5DF679D
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 11:37:49PM +0530, Anirudh Rayabharam wrote:
> On Mon, Feb 02, 2026 at 05:59:14PM +0000, Stanislav Kinsburskii wrote:
> > When creating guest partition objects, the hypervisor may fail to
> > allocate root partition pages and return an insufficient memory status.
> > In this case, deposit memory using the root partition ID instead.
> > 
> > Note: This error should never occur in a guest of L1VH partition context.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/hv_common.c      |    2 +
> >  drivers/hv/hv_proc.c        |   14 ++++++++++
> >  include/hyperv/hvgdk_mini.h |   58 ++++++++++++++++++++++---------------------
> >  3 files changed, 46 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index c7f63c9de503..cab0d1733607 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -792,6 +792,8 @@ static const struct hv_status_info hv_status_infos[] = {
> >  	_STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	-EIO),
> >  	_STATUS_INFO(HV_STATUS_INSUFFICIENT_MEMORY,		-ENOMEM),
> >  	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY,	-ENOMEM),
> > +	_STATUS_INFO(HV_STATUS_INSUFFICIENT_ROOT_MEMORY,	-ENOMEM),
> > +	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY,	-ENOMEM),
> >  	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_ID,		-EINVAL),
> >  	_STATUS_INFO(HV_STATUS_INVALID_VP_INDEX,		-EINVAL),
> >  	_STATUS_INFO(HV_STATUS_NOT_FOUND,			-EIO),
> > diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> > index dfa27be66ff7..935129e0b39d 100644
> > --- a/drivers/hv/hv_proc.c
> > +++ b/drivers/hv/hv_proc.c
> > @@ -122,6 +122,18 @@ int hv_deposit_memory_node(int node, u64 partition_id,
> >  	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
> >  		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
> >  		break;
> > +
> > +	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY:
> > +		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
> > +		fallthrough;
> > +	case HV_STATUS_INSUFFICIENT_ROOT_MEMORY:
> 
> Is num_pages uninitialized when we reach this case directly?
> 

It actually does not. I'll fix it.

Thanks,
Stanislav

> Thanks,
> Anirudh.
> 
> > +		if (!hv_root_partition()) {
> > +			hv_status_err(hv_status, "Unexpected root memory deposit\n");
> > +			return -ENOMEM;
> > +		}
> > +		partition_id = HV_PARTITION_ID_SELF;
> > +		break;
> > +
> >  	default:
> >  		hv_status_err(hv_status, "Unexpected!\n");
> >  		return -ENOMEM;
> > @@ -135,6 +147,8 @@ bool hv_result_needs_memory(u64 status)
> >  	switch (hv_result(status)) {
> >  	case HV_STATUS_INSUFFICIENT_MEMORY:
> >  	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
> > +	case HV_STATUS_INSUFFICIENT_ROOT_MEMORY:
> > +	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY:
> >  		return true;
> >  	}
> >  	return false;
> > diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> > index 70f22ef44948..5b74a857ef43 100644
> > --- a/include/hyperv/hvgdk_mini.h
> > +++ b/include/hyperv/hvgdk_mini.h
> > @@ -14,34 +14,36 @@ struct hv_u128 {
> >  } __packed;
> >  
> >  /* NOTE: when adding below, update hv_result_to_string() */
> > -#define HV_STATUS_SUCCESS			    0x0
> > -#define HV_STATUS_INVALID_HYPERCALL_CODE	    0x2
> > -#define HV_STATUS_INVALID_HYPERCALL_INPUT	    0x3
> > -#define HV_STATUS_INVALID_ALIGNMENT		    0x4
> > -#define HV_STATUS_INVALID_PARAMETER		    0x5
> > -#define HV_STATUS_ACCESS_DENIED			    0x6
> > -#define HV_STATUS_INVALID_PARTITION_STATE	    0x7
> > -#define HV_STATUS_OPERATION_DENIED		    0x8
> > -#define HV_STATUS_UNKNOWN_PROPERTY		    0x9
> > -#define HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE	    0xA
> > -#define HV_STATUS_INSUFFICIENT_MEMORY		    0xB
> > -#define HV_STATUS_INVALID_PARTITION_ID		    0xD
> > -#define HV_STATUS_INVALID_VP_INDEX		    0xE
> > -#define HV_STATUS_NOT_FOUND			    0x10
> > -#define HV_STATUS_INVALID_PORT_ID		    0x11
> > -#define HV_STATUS_INVALID_CONNECTION_ID		    0x12
> > -#define HV_STATUS_INSUFFICIENT_BUFFERS		    0x13
> > -#define HV_STATUS_NOT_ACKNOWLEDGED		    0x14
> > -#define HV_STATUS_INVALID_VP_STATE		    0x15
> > -#define HV_STATUS_NO_RESOURCES			    0x1D
> > -#define HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED   0x20
> > -#define HV_STATUS_INVALID_LP_INDEX		    0x41
> > -#define HV_STATUS_INVALID_REGISTER_VALUE	    0x50
> > -#define HV_STATUS_OPERATION_FAILED		    0x71
> > -#define HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY    0x75
> > -#define HV_STATUS_TIME_OUT			    0x78
> > -#define HV_STATUS_CALL_PENDING			    0x79
> > -#define HV_STATUS_VTL_ALREADY_ENABLED		    0x86
> > +#define HV_STATUS_SUCCESS				0x0
> > +#define HV_STATUS_INVALID_HYPERCALL_CODE		0x2
> > +#define HV_STATUS_INVALID_HYPERCALL_INPUT		0x3
> > +#define HV_STATUS_INVALID_ALIGNMENT			0x4
> > +#define HV_STATUS_INVALID_PARAMETER			0x5
> > +#define HV_STATUS_ACCESS_DENIED				0x6
> > +#define HV_STATUS_INVALID_PARTITION_STATE		0x7
> > +#define HV_STATUS_OPERATION_DENIED			0x8
> > +#define HV_STATUS_UNKNOWN_PROPERTY			0x9
> > +#define HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE		0xA
> > +#define HV_STATUS_INSUFFICIENT_MEMORY			0xB
> > +#define HV_STATUS_INVALID_PARTITION_ID			0xD
> > +#define HV_STATUS_INVALID_VP_INDEX			0xE
> > +#define HV_STATUS_NOT_FOUND				0x10
> > +#define HV_STATUS_INVALID_PORT_ID			0x11
> > +#define HV_STATUS_INVALID_CONNECTION_ID			0x12
> > +#define HV_STATUS_INSUFFICIENT_BUFFERS			0x13
> > +#define HV_STATUS_NOT_ACKNOWLEDGED			0x14
> > +#define HV_STATUS_INVALID_VP_STATE			0x15
> > +#define HV_STATUS_NO_RESOURCES				0x1D
> > +#define HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED	0x20
> > +#define HV_STATUS_INVALID_LP_INDEX			0x41
> > +#define HV_STATUS_INVALID_REGISTER_VALUE		0x50
> > +#define HV_STATUS_OPERATION_FAILED			0x71
> > +#define HV_STATUS_INSUFFICIENT_ROOT_MEMORY		0x73
> > +#define HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY	0x75
> > +#define HV_STATUS_TIME_OUT				0x78
> > +#define HV_STATUS_CALL_PENDING				0x79
> > +#define HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY	0x83
> > +#define HV_STATUS_VTL_ALREADY_ENABLED			0x86
> >  
> >  /*
> >   * The Hyper-V TimeRefCount register and the TSC
> > 
> > 

