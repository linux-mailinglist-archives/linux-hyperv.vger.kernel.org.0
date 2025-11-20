Return-Path: <linux-hyperv+bounces-7721-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FC5C76911
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 00:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id EBAB02B651
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 22:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D892D5957;
	Thu, 20 Nov 2025 22:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M/Wl97gR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087EE1C3C08;
	Thu, 20 Nov 2025 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763679548; cv=none; b=pEdPsD26PWoirCN4scAd0CD9nKeAIAkf0CXFm7feqQ/nF4gzXvIU1tKNsyRJanm6wNt4CKTpvfapQk3VnejvPbI2wJoWf/bZox0NSZ4SwPsnWiTD+uzHc2yDpKF05qG+i780oXXOCQj6EyBTkn7ZsrcjH0p7zlLukO3csE3zorE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763679548; c=relaxed/simple;
	bh=Ih/RjbAYaAVDIAgdpElpviT27S6IwSzhqcgUFgY/61c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUH9fnxPnqnmK82Vwo74R8LlmIhP+fRqH737ctzUWfWY7DjGlRMlw3f81Kziv7QMnxrJ0ov/NxAmE6E6/P20ySF4gztnQlHaEe+X8/hqTf8zQyQBNd7TWXO98V/raGDnuq8ptWhnPxZE1GKjv6IlmXc0uE0nEYPgohYSdsRNYgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M/Wl97gR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1044)
	id A45D021203A0; Thu, 20 Nov 2025 14:59:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A45D021203A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763679546;
	bh=LtLJh+RA+rSnv2nIQTaQLj6QtrPtqNH8AYzTrnuLdzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/Wl97gRT6eOKDUfTklT3u3WM+K+wFumHt4cK3dBbOqXk/25JYR6j+Q28/stTMYNm
	 Ii/1jjWPMgscGDTAmN1UC/M5Eb6SJ9U97Hg38vmX8Y9VWhH0e4tzj6BPbva4hA8MXh
	 RciwRaIuUQAW0hT+6Gs10iU0vkkNv4R6eFKEAsxo=
Date: Thu, 20 Nov 2025 14:59:06 -0800
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
Subject: Re: [PATCH v5 1/3] hyperv: Add definitions for MSHV sleep state
 configuration
Message-ID: <20251120225906.GE24244@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20251117210855.108126-1-prapal@linux.microsoft.com>
 <20251117210855.108126-2-prapal@linux.microsoft.com>
 <SN6PR02MB41574A771FC709C6BE97A3E8D4D6A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41574A771FC709C6BE97A3E8D4D6A@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Nov 18, 2025 at 06:10:51PM +0000, Michael Kelley wrote:
> From: Praveen K Paladugu <prapal@linux.microsoft.com> Sent: Monday, November 17, 2025 1:08 PM
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
> >  include/hyperv/hvhdk_mini.h | 40 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 43 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> > index 1d5ce11be8b6..04b18d0e37af 100644
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
> > index f2d7b50de7a4..41a29bf8ec14 100644
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
> > @@ -184,6 +198,32 @@ struct hv_output_get_system_property {
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
> > +
> > +		/*
> > +		 * Add a reserved field to ensure the union is 8-byte aligned as
> > +		 * existing members may not be. This is a temporary measure
> > +		 * until all remaining members are added.
> > +		 */
> > +		 u64 reserved0[8];
> 
> I had expected a single u64 to pad out to 64-bit alignment. This is 512 bytes.
>
I hear you Michael. I chose to this to keep this struct future-proof.
There are some entries in this union that are this big. To not run into
alignment issues when new entries are added to this union, I added this
reserved element which is of the size of the largest element in the
union.

> > +	};
> > +} __packed;
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
> > 

