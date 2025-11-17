Return-Path: <linux-hyperv+bounces-7652-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B98C66389
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 22:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35CFC360E27
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 21:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05E0312812;
	Mon, 17 Nov 2025 21:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fG76OkHY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3354125291B;
	Mon, 17 Nov 2025 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413839; cv=none; b=T5oqCjyctae5ulca4J0+hEk/GgMXpm0C+bTNVww1Q86e08Wwu4StNf17TTMWW7p14XlSDd+nQgcgw0BtlwsN2jEZxssGzH6xdih6BQXgHOVwbO8svDhHjpxbvgPDuFGS8EzO+qFlxFjQ2vBytN538qSXcxT07sL0D3EK60OlRL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413839; c=relaxed/simple;
	bh=j4iX/FIFPukpuY7YLcS9hj1eHkgJxP9yQ7OtyGtAyJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuZYVH7OPeqIozA7oTstXbkriLoh/0dSbPCbsXTN6TWyX52mucwUzmmj80YsZ0nEwLthnFJfccsgm2orJcR0f5/QIGgFV3y0T+hcTJ2GCdte05sGSOjUETfGLASddbGAojmmP3Ku2Cn8MNnIkS81sXfOp8v3xFPJuu7OOEB5g94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fG76OkHY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1044)
	id E7F12211AA26; Mon, 17 Nov 2025 13:10:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E7F12211AA26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763413837;
	bh=tRFuwuHvSFrTzvEom8/duAaeMWqEqSkJTMFfwfJtdIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fG76OkHYOHDT29vHTqM6PYTGTFd+8bd+EHdhqPz7KNku8wqRabpeOdCw1W/LnA2rj
	 n78t/mp1A/Dzo6/cZpDEYh2hMfn/NlFshdYU5uWfLNsplrsLW2U5O1zWZ5gdBMsITr
	 GskdzTFCTennGzSiq8EI7FYQL2JwYm4KzjMLhyi0=
Date: Mon, 17 Nov 2025 13:10:37 -0800
From: Praveen Paladugu <prapal@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"anbelski@linux.microsoft.com" <anbelski@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>,
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
Subject: Re: [PATCH v4 1/3] hyperv: Add definitions for MSHV sleep state
 configuration
Message-ID: <20251117211037.GA24244@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20251107221700.45957-1-prapal@linux.microsoft.com>
 <20251107221700.45957-2-prapal@linux.microsoft.com>
 <SN6PR02MB4157FD3C208A593FB391932AD4CDA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157FD3C208A593FB391932AD4CDA@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Nov 13, 2025 at 07:41:55PM +0000, Michael Kelley wrote:
> From: Praveen K Paladugu <prapal@linux.microsoft.com> Sent: Friday, November 7, 2025 2:17 PM
> > 
> > Add the definitions required to configure sleep states in mshv hypervsior.
> > 
> > Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> > Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
> > Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
> > Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> > ---
> >  include/hyperv/hvgdk_mini.h |  4 +++-
> >  include/hyperv/hvhdk_mini.h | 33 +++++++++++++++++++++++++++++++++
> >  2 files changed, 36 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> > index 7499a679e60a..b43fa1c9ed2c 100644
> > --- a/include/hyperv/hvgdk_mini.h
> > +++ b/include/hyperv/hvgdk_mini.h
> > @@ -465,19 +465,21 @@ union hv_vp_assist_msr_contents {	 /*
> > HV_REGISTER_VP_ASSIST_PAGE */
> >  #define HVCALL_RESET_DEBUG_SESSION			0x006b
> >  #define HVCALL_MAP_STATS_PAGE				0x006c
> >  #define HVCALL_UNMAP_STATS_PAGE				0x006d
> > +#define HVCALL_SET_SYSTEM_PROPERTY			0x006f
> >  #define HVCALL_ADD_LOGICAL_PROCESSOR			0x0076
> >  #define HVCALL_GET_SYSTEM_PROPERTY			0x007b
> >  #define HVCALL_MAP_DEVICE_INTERRUPT			0x007c
> >  #define HVCALL_UNMAP_DEVICE_INTERRUPT			0x007d
> >  #define HVCALL_RETARGET_INTERRUPT			0x007e
> >  #define HVCALL_NOTIFY_PARTITION_EVENT                   0x0087
> > +#define HVCALL_ENTER_SLEEP_STATE			0x0084
> >  #define HVCALL_NOTIFY_PORT_RING_EMPTY			0x008b
> >  #define HVCALL_REGISTER_INTERCEPT_RESULT		0x0091
> >  #define HVCALL_ASSERT_VIRTUAL_INTERRUPT			0x0094
> >  #define HVCALL_CREATE_PORT				0x0095
> >  #define HVCALL_CONNECT_PORT				0x0096
> >  #define HVCALL_START_VP					0x0099
> > -#define HVCALL_GET_VP_INDEX_FROM_APIC_ID			0x009a
> > +#define HVCALL_GET_VP_INDEX_FROM_APIC_ID		0x009a
> >  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
> >  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
> >  #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
> > diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> > index f2d7b50de7a4..06cf30deb319 100644
> > --- a/include/hyperv/hvhdk_mini.h
> > +++ b/include/hyperv/hvhdk_mini.h
> > @@ -140,6 +140,7 @@ enum hv_snp_status {
> > 
> >  enum hv_system_property {
> >  	/* Add more values when needed */
> > +	HV_SYSTEM_PROPERTY_SLEEP_STATE = 3,
> >  	HV_SYSTEM_PROPERTY_SCHEDULER_TYPE = 15,
> >  	HV_DYNAMIC_PROCESSOR_FEATURE_PROPERTY = 21,
> >  	HV_SYSTEM_PROPERTY_CRASHDUMPAREA = 47,
> > @@ -155,6 +156,19 @@ union hv_pfn_range {            /* HV_SPA_PAGE_RANGE */
> >  	} __packed;
> >  };
> > 
> > +enum hv_sleep_state {
> > +	HV_SLEEP_STATE_S1 = 1,
> > +	HV_SLEEP_STATE_S2 = 2,
> > +	HV_SLEEP_STATE_S3 = 3,
> > +	HV_SLEEP_STATE_S4 = 4,
> > +	HV_SLEEP_STATE_S5 = 5,
> > +	/*
> > +	 * After hypervisor has received this, any follow up sleep
> > +	 * state registration requests will be rejected.
> > +	 */
> > +	HV_SLEEP_STATE_LOCK = 6
> > +};
> > +
> >  enum hv_dynamic_processor_feature_property {
> >  	/* Add more values when needed */
> >  	HV_X64_DYNAMIC_PROCESSOR_FEATURE_MAX_ENCRYPTED_PARTITIONS =
> > 13,
> > @@ -184,6 +198,25 @@ struct hv_output_get_system_property {
> >  	};
> >  } __packed;
> > 
> > +struct hv_sleep_state_info {
> > +	u32 sleep_state; /* enum hv_sleep_state */
> > +	u8 pm1a_slp_typ;
> > +	u8 pm1b_slp_typ;
> > +} __packed;
> > +
> > +struct hv_input_set_system_property {
> > +	u32 property_id; /* enum hv_system_property */
> > +	u32 reserved;
> > +	union {
> > +		/* More fields to be filled in when needed */
> > +		struct hv_sleep_state_info set_sleep_state_info;
> > +	};
> > +} __packed;
> 
> Because struct hv_sleep_state_info is 6 bytes long, this
> hypercall input struct ends up being 14 bytes long, which is
> unusual. Hyper-V almost always makes hypercall input size
> a multiple of 8 bytes, though in a few cases the last 4 bytes
> might be ignored, making it a multiple of 4 bytes. So I'm
> wondering if there should be a 2 byte "reserved" field in
> struct hv_sleep_state_info so that everything ends up
> being a multiple of 8 bytes.
> 
> Since there aren't any fields after such a putative "reserved"
> field, there's nothing currently at the wrong offset. But it would
> affect how much space gets zero'ed in hv_initialize_sleep_states().
> Zero'ing those last 2 bytes might prove useful if future versions
> of the hypervisor were to use those 2 bytes for an additional
> field or two.
>
Nice catch Michael. I added a reserved field to the union to keep the struct
fully aligned and future proof.

> > +
> > +struct hv_input_enter_sleep_state {     /* HV_INPUT_ENTER_SLEEP_STATE */
> > +	u32 sleep_state;        /* enum hv_sleep_state */
> > +} __packed;
> > +
> >  struct hv_input_map_stats_page {
> >  	u32 type; /* enum hv_stats_object_type */
> >  	u32 padding;
> > --
> > 2.51.0

