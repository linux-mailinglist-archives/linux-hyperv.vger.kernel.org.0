Return-Path: <linux-hyperv+bounces-11897-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DwneEqOOUGpU1QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11897-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 08:18:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 965F373792E
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 08:18:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=YNqa0lUn;
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11897-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11897-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 549DE3019F04
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 06:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD3B3ACEFB;
	Fri, 10 Jul 2026 06:17:52 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A44372EEF;
	Fri, 10 Jul 2026 06:17:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783664271; cv=none; b=kYfhcq54WP08TC6lAYOy/gkfD0FDy7me5kd6Zwrzf1iqSsTCgHiRoW1pknbOVWB94pUefRtlOKAv71aDO+c1oBJzfaPyk1b/UdgPT6hDYSknsYvzmYI0Z1pOPc+0Eyl6zlpBguMYuur9lbFkM2lgBdX2eZTYXCqNhSynjpYD6Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783664271; c=relaxed/simple;
	bh=XOmSjByoNF6Vt4jgC7Oz9VwkAlxisH3g8HUOSqtXj8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNgWpoIkJrmwoMTPDOjix+Mxjr7TGwl70rzWm18xBJcGaRLgGeJGAch13yra6+3ctpBxZqvWpe96HWPg7rx3K/2JalHG5wqn3iJrmH/jPpcMilMJ0MZwrW191TFWNAERrievGoJyPLZDrHx25TnEP0Z2JepSZ08n+omz6hpJg40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YNqa0lUn; arc=none smtp.client-ip=13.77.154.182
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3839B20B716E;
	Thu,  9 Jul 2026 23:17:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3839B20B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783664262;
	bh=5BI1bwekiHhmXFmNYH3osBguDBBQ2ik4qNO2EtDDABM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YNqa0lUnd+91XFtKhumTUuIQSy5ymXySxSHsDfPqXrA1xNJyuESOexSzLLaDphq7b
	 jyRGPVEgyP4IRfULmaHSeagXGJdN4TWsSjHa1LDg2HxO20SohSYAfhc+akJ+Rgsl3v
	 hqdL5nVm1HB+kjepLHBimGMiY57EwZakHmmpTrc8=
Date: Fri, 10 Jul 2026 14:17:46 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "kys@microsoft.com" <kys@microsoft.com>, 
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>, 
	"longli@microsoft.com" <longli@microsoft.com>, "joro@8bytes.org" <joro@8bytes.org>, 
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org" <mani@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, "tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>, 
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>
Subject: Re: [PATCH v2 1/4] hyperv: Introduce new hypercall interfaces used
 by Hyper-V guest IOMMU
Message-ID: <skgtaljhihedmdtax3jlqbrbtl3goky2odrdvohaopux35gljh@ieyan5a7cxpu>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-2-zhangyu1@linux.microsoft.com>
 <SN6PR02MB41579A957E1C81583BBA1119D4FE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41579A957E1C81583BBA1119D4FE2@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mhklinux@outlook.com,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pci@vger.kernel.org,m:linux-arch@vger.kernel.org,m:wei.liu@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:lpieralisi@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:arnd@arndb.de,m:jgg@ziepe.ca,m:jacob.pan@linux.microsoft.com,m:tgopinath@linux.microsoft.com,m:easwar.hariharan@linux.microsoft.com,m:mrathor@linux.microsoft.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11897-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:from_mime,linux.microsoft.com:dkim,ieyan5a7cxpu:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 965F373792E

On Thu, Jul 09, 2026 at 07:06:19PM +0000, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Thursday, July 2, 2026 9:05 AM
> > 
> > From: Wei Liu <wei.liu@kernel.org>
> > 
> > Hyper-V guest IOMMU is a para-virtualized IOMMU based on hypercalls.
> > Introduce the hypercalls used by the child partition to interact with
> > this facility.
> > 
> > These hypercalls fall into below categories:
> > - Detection and capability: HVCALL_GET_IOMMU_CAPABILITIES is used to
> >   detect the existence and capabilities of the guest IOMMU.
> > 
> > - Device management: HVCALL_GET_LOGICAL_DEVICE_PROPERTY is used to
> >   check whether an endpoint device is managed by the guest IOMMU.
> > 
> > - Domain management: A set of hypercalls is provided to handle the
> >   creation, configuration, and deletion of guest domains, as well as
> >   the attachment/detachment of endpoint devices to/from those domains.
> > 
> > - IOTLB flushing: HVCALL_FLUSH_DEVICE_DOMAIN is used to ask Hyper-V
> >   for a domain-selective IOTLB flush (which in its handler may flush
> >   the device TLB as well).
> > 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> > Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> > ---
> >  include/hyperv/hvgdk_mini.h |   8 +++
> >  include/hyperv/hvhdk_mini.h | 124 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 132 insertions(+)
> > 
> > diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> > index 6a4e8b9d570f..5bdbb44da112 100644
> > --- a/include/hyperv/hvgdk_mini.h
> > +++ b/include/hyperv/hvgdk_mini.h
> > @@ -486,10 +486,16 @@ union hv_vp_assist_msr_contents {	 /*
> > HV_REGISTER_VP_ASSIST_PAGE */
> >  #define HVCALL_GET_VP_INDEX_FROM_APIC_ID		0x009a
> >  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
> >  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
> > +#define HVCALL_CREATE_DEVICE_DOMAIN			0x00b1
> > +#define HVCALL_ATTACH_DEVICE_DOMAIN			0x00b2
> >  #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
> >  #define HVCALL_POST_MESSAGE_DIRECT			0x00c1
> >  #define HVCALL_DISPATCH_VP				0x00c2
> > +#define HVCALL_DETACH_DEVICE_DOMAIN			0x00c4
> > +#define HVCALL_DELETE_DEVICE_DOMAIN			0x00c5
> >  #define HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9
> > +#define HVCALL_CONFIGURE_DEVICE_DOMAIN			0x00ce
> > +#define HVCALL_FLUSH_DEVICE_DOMAIN			0x00d0
> >  #define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7
> >  #define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8
> >  #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY	0x00db
> > @@ -502,6 +508,8 @@ union hv_vp_assist_msr_contents {	 /*
> > HV_REGISTER_VP_ASSIST_PAGE */
> >  #define HVCALL_MMIO_READ				0x0106
> >  #define HVCALL_MMIO_WRITE				0x0107
> >  #define HVCALL_DISABLE_HYP_EX                           0x010f
> > +#define HVCALL_GET_IOMMU_CAPABILITIES			0x0125
> > +#define HVCALL_GET_LOGICAL_DEVICE_PROPERTY		0x0127
> >  #define HVCALL_MAP_STATS_PAGE2				0x0131
> > 
> >  /* HV_HYPERCALL_INPUT */
> > diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> > index b4cb2fa26e9b..493608e791b4 100644
> > --- a/include/hyperv/hvhdk_mini.h
> > +++ b/include/hyperv/hvhdk_mini.h
> > @@ -547,4 +547,128 @@ union hv_device_id {		/* HV_DEVICE_ID */
> >  	} acpi;
> >  } __packed;
> > 
> > +/* Device domain types */
> > +#define HV_DEVICE_DOMAIN_TYPE_S1	1 /* Stage 1 domain */
> > +
> > +/* ID for default domain and NULL domain */
> > +#define HV_DEVICE_DOMAIN_ID_DEFAULT 0
> > +#define HV_DEVICE_DOMAIN_ID_NULL    0xFFFFFFFFULL
> > +
> > +union hv_device_domain_id {
> > +	u64 as_uint64;
> > +	struct {
> > +		u32 type: 4;
> > +		u32 reserved: 28;
> > +		u32 id;
> > +	} __packed;
> > +};
> > +
> > +struct hv_input_device_domain {
> > +	u64 partition_id;
> > +	union hv_input_vtl owner_vtl;
> > +	u8 padding[7];
> > +	union hv_device_domain_id domain_id;
> > +} __packed;
> > +
> > +union hv_create_device_domain_flags {
> > +	u32 as_uint32;
> > +	struct {
> > +		u32 forward_progress_required: 1;
> > +		u32 inherit_owning_vtl: 1;
> > +		u32 reserved: 30;
> > +	} __packed;
> > +};
> > +
> > +struct hv_input_create_device_domain {
> > +	struct hv_input_device_domain device_domain;
> > +	union hv_create_device_domain_flags create_device_domain_flags;
> > +} __packed;
> > +
> > +struct hv_input_delete_device_domain {
> > +	struct hv_input_device_domain device_domain;
> > +} __packed;
> > +
> > +struct hv_input_attach_device_domain {
> > +	struct hv_input_device_domain device_domain;
> > +	union hv_device_id device_id;
> > +} __packed;
> > +
> > +struct hv_input_detach_device_domain {
> > +	u64 partition_id;
> > +	union hv_device_id device_id;
> > +} __packed;
> > +
> > +struct hv_device_domain_settings {
> > +	struct {
> > +		/*
> > +		 * Enable translations. If not enabled, all transaction bypass
> > +		 * S1 translations.
> > +		 */
> > +		u64 translation_enabled: 1;
> > +		u64 blocked: 1;
> > +		/*
> > +		 * First stage address translation paging mode:
> > +		 * 0: 4-level paging (default)
> > +		 * 1: 5-level paging
> > +		 */
> > +		u64 first_stage_paging_mode: 1;
> > +		u64 reserved: 61;
> > +	} flags;
> > +
> > +	/* Address of translation table */
> > +	u64 page_table_root;
> > +} __packed;
> > +
> > +struct hv_input_configure_device_domain {
> > +	struct hv_input_device_domain device_domain;
> > +	struct hv_device_domain_settings settings;
> > +} __packed;
> > +
> > +struct hv_input_get_iommu_capabilities {
> > +	u64 partition_id;
> > +	u64 reserved;
> > +} __packed;
> > +
> > +struct hv_output_get_iommu_capabilities {
> > +	u32 size;
> > +	u16 reserved;
> > +	u8  max_iova_width;
> > +	u8  max_pasid_width;
> > +
> > +#define HV_IOMMU_CAP_PRESENT (1ULL << 0)
> > +#define HV_IOMMU_CAP_S2 (1ULL << 1)
> > +#define HV_IOMMU_CAP_S1 (1ULL << 2)
> > +#define HV_IOMMU_CAP_S1_5LVL (1ULL << 3)
> > +#define HV_IOMMU_CAP_PASID (1ULL << 4)
> > +#define HV_IOMMU_CAP_ATS (1ULL << 5)
> > +#define HV_IOMMU_CAP_PRI (1ULL << 6)
> 
> hvgdk_mini.h mostly uses the Linux BIT() and BIT_ULL()
> macros instead of explicit shifts. But this is hvhdk_mini.h.
> Does it need to play by a different set of rules for
> compatibility with the original Windows files? I think
> the Linux BIT* macros are preferable if possible. 
> 

I'm not aware of any compatibility requirement. And since it
does not change the real definition, I guess we should use
BIT*.

> > +
> > +	u64 iommu_cap;
> > +	u64 pgsize_bitmap;
> > +} __packed;
> > +
> > +enum hv_logical_device_property_code {
> > +	HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU = 10,
> > +};
> > +
> > +struct hv_input_get_logical_device_property {
> > +	u64 partition_id;
> > +	u64 logical_device_id;
> > +	/* Takes values from enum hv_logical_device_property_code. */
> > +	u32 code;
> > +	u32 reserved;
> > +} __packed;
> > +
> > +struct hv_output_get_logical_device_property {
> > +#define HV_DEVICE_IOMMU_ENABLED (1ULL << 0)
> 
> Same here about BIT_ULL().
> 

Will fix. Thanks!

B.R.
Yu

> > +	u64 device_iommu;
> > +	u64 reserved;
> > +} __packed;
> > +
> > +struct hv_input_flush_device_domain {
> > +	struct hv_input_device_domain device_domain;
> > +	u32 flags;
> > +	u32 reserved;
> > +} __packed;
> > +
> >  #endif /* _HV_HVHDK_MINI_H */
> > --
> > 2.52.0
> > 
> 

