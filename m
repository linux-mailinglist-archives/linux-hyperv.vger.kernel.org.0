Return-Path: <linux-hyperv+bounces-8505-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEWBDqgUdGk32AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8505-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 01:39:04 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FC07BBA6
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 01:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9619630156D4
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 00:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15F91C5486;
	Sat, 24 Jan 2026 00:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ua9n+eZs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8607E0E4;
	Sat, 24 Jan 2026 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769215139; cv=none; b=Pfm77nuys5+PkTgmI/9GQfcup9XFtI9L1h+4p0ET9qJTKju202zWLa3PlSJkpYwdUghFLltHtNbswdDXctGwugjX5mO2fG37onH5W3rnZr5WdmSaGgVbb5rA6ezg9oQ6UtBuvIcpttW4UQxI4pzE3drrBOc9oz+GpRqvBMXCNPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769215139; c=relaxed/simple;
	bh=ZlDCMBbPo+nuCgXQh7FJ/Ds6DFTi6MlKI4HqKcnr5to=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHj6IgZRokpNcKJYIgV/rIkEL6otS0HghG4PIH0Pgvt1fT0Ejy8mYbFNkF2GjlP+SQlo3GE+0u2p3gYRk8gdfFyZLzJjmBKqk4PXcIoK1ZZGaCfRdXRNmV8AMI2BnEJ/3rrSvIgnYVPRAqwoJafP+PP7yF2mmEfnOkofl4OwDqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ua9n+eZs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.32.59] (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id E61B920B7167;
	Fri, 23 Jan 2026 16:38:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E61B920B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769215137;
	bh=EooaXTHikFgY2c5b/5Qui7RI5PR9D7e9Nlkv9UbFGyY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ua9n+eZshb41iJSM0VepkPNs2akDdspbcAC+KpkJ1vXE7KN85qAmzy6YXLGgxOWrM
	 HFbL7ENaTscuSs5mfxkV9jRnHPj0JaJyBcfZXN0vSEsHue2qBzucYEkZivymiUUWaI
	 8ogGB/QBfff0uau+8//BaoY1uYmIDQBKP/Io8ejA=
Message-ID: <669e56da-e27f-1dd7-e7d0-0323ae7beaae@linux.microsoft.com>
Date: Fri, 23 Jan 2026 16:38:56 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v0 09/15] mshv: Import data structs around device domains
 and irq remapping
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
 nunodasneves@linux.microsoft.com, mhklinux@outlook.com,
 romank@linux.microsoft.com
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-10-mrathor@linux.microsoft.com>
 <aW_-9KO2DrVvmvSs@skinsburskii.localdomain>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <aW_-9KO2DrVvmvSs@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8505-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: A8FC07BBA6
X-Rspamd-Action: no action

On 1/20/26 14:17, Stanislav Kinsburskii wrote:
> On Mon, Jan 19, 2026 at 10:42:24PM -0800, Mukesh R wrote:
>> From: Mukesh Rathor <mrathor@linux.microsoft.com>
>>
>> Import/copy from Hyper-V public headers, definitions and declarations that
>> are related to attaching and detaching of device domains and interrupt
>> remapping, and building device ids for those purposes.
>>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> ---
>>   include/hyperv/hvgdk_mini.h |  11 ++++
>>   include/hyperv/hvhdk_mini.h | 112 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 123 insertions(+)
>>
> 
> <snip>
> 
>> +/* ID for stage 2 default domain and NULL domain */
>> +#define HV_DEVICE_DOMAIN_ID_S2_DEFAULT 0
>> +#define HV_DEVICE_DOMAIN_ID_S2_NULL    0xFFFFFFFFULL
>> +
>> +union hv_device_domain_id {
>> +	u64 as_uint64;
>> +	struct {
>> +		u32 type : 4;
>> +		u32 reserved : 28;
>> +		u32 id;
>> +	};
>> +} __packed;
> 
> Shouldn't the inner struct be packed instead?
> 
>> +
>> +struct hv_input_device_domain { /* HV_INPUT_DEVICE_DOMAIN */
>> +	u64 partition_id;
>> +	union hv_input_vtl owner_vtl;
>> +	u8 padding[7];
>> +	union hv_device_domain_id domain_id;
>> +} __packed;
>> +
>> +union hv_create_device_domain_flags {	/* HV_CREATE_DEVICE_DOMAIN_FLAGS */
>> +	u32 as_uint32;
>> +	struct {
>> +		u32 forward_progress_required : 1;
>> +		u32 inherit_owning_vtl : 1;
>> +		u32 reserved : 30;
>> +	} __packed;
>> +} __packed;
> 
> Why should the union be packed?

 From GCC docs:

Specifying this attribute for struct and union types is equivalent to
specifying the packed attribute on each of the structure or union members.

Thanks,
-Mukesh



> Thanks,
> Stanislav
> 
>> +
>> +struct hv_input_create_device_domain {	/* HV_INPUT_CREATE_DEVICE_DOMAIN */
>> +	struct hv_input_device_domain device_domain;
>> +	union hv_create_device_domain_flags create_device_domain_flags;
>> +} __packed;
>> +
>> +struct hv_input_delete_device_domain {	/* HV_INPUT_DELETE_DEVICE_DOMAIN */
>> +	struct hv_input_device_domain device_domain;
>> +} __packed;
>> +
>> +struct hv_input_attach_device_domain {	/* HV_INPUT_ATTACH_DEVICE_DOMAIN */
>> +	struct hv_input_device_domain device_domain;
>> +	union hv_device_id device_id;
>> +} __packed;
>> +
>> +struct hv_input_detach_device_domain {	/* HV_INPUT_DETACH_DEVICE_DOMAIN */
>> +	u64 partition_id;
>> +	union hv_device_id device_id;
>> +} __packed;
>> +
>> +struct hv_input_map_device_gpa_pages {	/* HV_INPUT_MAP_DEVICE_GPA_PAGES */
>> +	struct hv_input_device_domain device_domain;
>> +	union hv_input_vtl target_vtl;
>> +	u8 padding[3];
>> +	u32 map_flags;
>> +	u64 target_device_va_base;
>> +	u64 gpa_page_list[];
>> +} __packed;
>> +
>> +struct hv_input_unmap_device_gpa_pages {  /* HV_INPUT_UNMAP_DEVICE_GPA_PAGES */
>> +	struct hv_input_device_domain device_domain;
>> +	u64 target_device_va_base;
>> +} __packed;
>> +
>>   #endif /* _HV_HVHDK_MINI_H */
>> -- 
>> 2.51.2.vfs.0.1
>>


