Return-Path: <linux-hyperv+bounces-8763-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLu5IMgehmm/JwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8763-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Feb 2026 18:03:04 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1169100AEE
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Feb 2026 18:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52D67300CE54
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Feb 2026 17:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D167435EDBB;
	Fri,  6 Feb 2026 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YY5f8n77"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE0E35DCEF;
	Fri,  6 Feb 2026 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770397355; cv=none; b=FUVY7XuM7Hh8ZUZnyZrOJxVz4GGOIa/V8mdLcnT/SNV9eSU3X6Gjzp7Ecr96cqT/IRZ/azEsE5dosdGLTYdRRRHkvNGW6xi1BQNCvd80dsCenOqfcSBMFhKgt/sq8GxYgNKrsA9Pua5UYdF8Npc7Lz1ustHw/N6+UVVtOCuiN/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770397355; c=relaxed/simple;
	bh=WfyxGl0bChzfohIuRcdxFN0vzJoCZpB3UmyirWYB8UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uy5RC5gQdhlyQqBPWExumiTAWoYaioW7mktIxf4J42X1OFsLTi+GEP3Yv2oV2/fclRIn/oeZ6xp5F6YnJ4cj20jfMsJxmfFu/Q/TKoe4TkeEf8bg/R3EYK0fHO4vfvqtK8Ek7lijGTBLW9kJqPUOGces6kyl1hidydIGsaWjdvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YY5f8n77; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id A8F9F20B7165;
	Fri,  6 Feb 2026 09:02:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A8F9F20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770397355;
	bh=Y72LWLItji/TYX3xkirCgWbzCbqoPvITuFB23XhFY94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YY5f8n77AR5O8WTBcTjO4Gw8h5DkdAb/ZEau9u4uJ8WCAGQZEHHISgvKlFjE/o9uL
	 DCc5fQ+K8WeY1n+8KQIqQJL4ZLerlpxW8F6RwLZM+1ME1s3d0qyGhcPQMX3mE9g3Cs
	 KkswyQdQXjQ+fFQ2GGIMetu+75VPkSPU0Q9Q0NY8=
Date: Fri, 6 Feb 2026 09:02:33 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mshv: Handle insufficient root memory hypervisor
 statuses
Message-ID: <aYYeqazAk0_aT_B1@skinsburskii.localdomain>
References: <177031674698.186911.179832109354647364.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177031694699.186911.12873334535011325477.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <aYWCmVxnO8R3vsc-@anirudh-surface.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYWCmVxnO8R3vsc-@anirudh-surface.localdomain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8763-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: D1169100AEE
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 05:56:41AM +0000, Anirudh Rayabharam wrote:
> On Thu, Feb 05, 2026 at 06:42:27PM +0000, Stanislav Kinsburskii wrote:
> > When creating guest partition objects, the hypervisor may fail to
> > allocate root partition pages and return an insufficient memory status.
> > In this case, deposit memory using the root partition ID instead.
> > 
> > Note: This error should never occur in a guest of L1VH partition context.
> 
> I think you should rephrse this to:
> 
> "... should never occur in an L1VH partition"
> 
> because none of the errors in this patch series occur inside a guest. They
> either occur in L1VH or root or both.
> 
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/hv_common.c      |    2 +
> >  drivers/hv/hv_proc.c        |   14 ++++++++++
> >  include/hyperv/hvgdk_mini.h |   58 ++++++++++++++++++++++---------------------
> >  3 files changed, 46 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index f20596276662..6b67ac616789 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -794,6 +794,8 @@ static const struct hv_status_info hv_status_infos[] = {
> >  	_STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	-EIO),
> >  	_STATUS_INFO(HV_STATUS_INSUFFICIENT_MEMORY,		-ENOMEM),
> >  	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY,	-ENOMEM),
> > +	_STATUS_INFO(HV_STATUS_INSUFFICIENT_ROOT_MEMORY,	-ENOMEM),
> > +	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY,	-ENOMEM),
> >  	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_ID,		-EINVAL),
> >  	_STATUS_INFO(HV_STATUS_INVALID_VP_INDEX,		-EINVAL),
> >  	_STATUS_INFO(HV_STATUS_NOT_FOUND,			-EIO),
> > diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> > index 181f6d02bce3..5f4fd9c3231c 100644
> > --- a/drivers/hv/hv_proc.c
> > +++ b/drivers/hv/hv_proc.c
> > @@ -121,6 +121,18 @@ int hv_deposit_memory_node(int node, u64 partition_id,
> >  	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
> >  		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
> >  		break;
> > +
> > +	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY:
> > +		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
> > +		fallthrough;
> > +	case HV_STATUS_INSUFFICIENT_ROOT_MEMORY:
> 
> I have the same comment as on v2 about num_pages being uninitialized when we
> reach this case directly.
> 

It is initialized to 1 on top of the function.

Thanks,
Stanislav.

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
> > @@ -134,6 +146,8 @@ bool hv_result_needs_memory(u64 status)
> >  	switch (hv_result(status)) {
> >  	case HV_STATUS_INSUFFICIENT_MEMORY:
> >  	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
> > +	case HV_STATUS_INSUFFICIENT_ROOT_MEMORY:
> > +	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY:
> >  		return true;
> >  	}
> >  	return false;
> > diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> > index 99ea0d03e657..50f5a1419052 100644
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

