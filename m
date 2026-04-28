Return-Path: <linux-hyperv+bounces-10411-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOo0BdsZ8GntOQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10411-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 04:22:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB2447CB21
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 04:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E2A1302F9AE
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 02:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48F03909B3;
	Tue, 28 Apr 2026 02:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="B39f6qoV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DE32D879E;
	Tue, 28 Apr 2026 02:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777342936; cv=none; b=ia8zARyVfriQHva8g2So57C7l3XxGKZE97eG6gxtnEBArFefe6oOEDa3dgnqruGpZZ/rQqx+kXyIGZCsFnyLirykK9bQOM88gi2VSpGZ/UsMJBQJqi7D8kZAvqbQVIOcRLysIm1fYqHqQh74nnDT9acFcTuNNKMpl4TT9pkinOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777342936; c=relaxed/simple;
	bh=ZGtX9WCr5zkWpmmvkEth6BMnjp67T1OH13wleeEhs5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktaPYkoSeI+kLnvxbpT9YlsWP6YCs/NRgxlVTM2PA48L+rLxqz9yS8MXXZsqygJ17+2bOXDVHbD7iXpc598R7VlTrHrnX7lq9v96Dvw6CJX2nfqqEcjgKEK8U5iDrW5Yzbt+B8Pz/zT9oo4wuuDCxpPDUW4Yd7ouy6ih9MrQOsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=B39f6qoV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.0.48] (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5812820B716A;
	Mon, 27 Apr 2026 19:22:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5812820B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777342934;
	bh=+IGQoTFr6Qw+EwmeMJT0ONytj53r7yK9Br87bvqZ/PM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B39f6qoV/2v2M6uwjFfc4vZ8hZYZndrMmocQpsC+wZhzw87oZAWKOSHiV9+S+OxE7
	 5//1yYEVSmRpELFbDSpBVNsqT+W/54o3nRUL73gjylrWf1JytwHomgAIgmyrhjQgU8
	 5uyvosrDRXUyFUC7eALyiQiTiZO7LTbLKlxk9FDw=
Message-ID: <43f41598-ee90-eb2f-1877-da6d1687322e@linux.microsoft.com>
Date: Mon, 27 Apr 2026 19:22:12 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V1 08/13] PCI: hv: rename hv_compose_msi_msg to
 hv_vmbus_compose_msi_msg
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org, wei.liu@kernel.org,
 mhklinux@outlook.com, muislam@microsoft.com, namjain@linux.microsoft.com,
 magnuskulke@linux.microsoft.com, anbelski@linux.microsoft.com,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, longli@microsoft.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de
References: <20260427163139.GA157548@bhelgaas>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260427163139.GA157548@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6AB2447CB21
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-10411-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zytor.com,arm.com,kernel.org,outlook.com,microsoft.com,linux.microsoft.com,vger.kernel.org,lists.linux.dev,redhat.com,alien8.de,linux.intel.com,8bytes.org,google.com,arndb.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]

On 4/27/26 09:31, Bjorn Helgaas wrote:
> On Tue, Apr 21, 2026 at 07:32:34PM -0700, Mukesh R wrote:
>> Main change here is to rename hv_compose_msi_msg to
>> hv_vmbus_compose_msi_msg as we introduce hv_compose_msi_msg in upcoming
>> patches that builds MSI messages for both VMBus and non-VMBus cases. VMBus
>> is not used on baremetal root partition for example. While at it, replace
>> spaces with tabs and fix some formatting involving excessive line wraps.
> 
> Would be better to do the whitespace changes in their own patch,
> although several of them should just be dropped (see below).
> 
> Capitalize subject ("PCI: hv: Rename ...").
> 
> Add "()" after function names in subject and commit log.

Ok, will do in next version.

>> +++ b/drivers/pci/controller/pci-hyperv.c
>> @@ -30,7 +30,7 @@
>>    * function's configuration space is zero.
>>    *
>>    * The rest of this driver mostly maps PCI concepts onto underlying Hyper-V
>> - * facilities.  For instance, the configuration space of a function exposed
>> + * facilities.	For instance, the configuration space of a function exposed
> 
> Oops, this hunk made it worse.  Definitely don't want a tab there.
> 
>> @@ -1954,7 +1955,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>>   			return;
>>   		}
>>   		/*
>> -		 * The vector we select here is a dummy value.  The correct
>> +		 * The vector we select here is a dummy value.	The correct
> 
> Another tab that should be a space.  Actually, you should just drop
> this hunk; the rest of the comment has two spaces after periods, so
> this should too.

well, most of our files does global replace 8 spaces with tabs, so
everywhere comments are well indented. Since, checkpatch doesn't complain
about tabs on comment lines, may I assue it is not a strict requirement
and more a nit or personal preference?

Thanks,
-Mukesh


>> @@ -2046,7 +2047,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>>   
>>   		/*
>>   		 * Make sure that the ring buffer data structure doesn't get
>> -		 * freed while we dereference the ring buffer pointer.  Test
>> +		 * freed while we dereference the ring buffer pointer.	Test
> 
> Same here.  This makes it worse.
> 
>> @@ -2226,7 +2227,7 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
>>   /**
>>    * get_bar_size() - Get the address space consumed by a BAR
>>    * @bar_val:	Value that a BAR returned after -1 was written
>> - *              to it.
>> + *		to it.
> 
> Just put "to it" on the preceding line.  There's plenty of space
> there.
> 
>> @@ -2580,7 +2581,7 @@ static void q_resource_requirements(void *context, struct pci_response *resp,
>>    * new_pcichild_device() - Create a new child device
>>    * @hbus:	The internal struct tracking this root PCI bus.
>>    * @desc:	The information supplied so far from the host
>> - *              about the device.
>> + *		about the device.
> 
> Ditto.  If you want to change this, put "about the device" on the
> preceding line.
> 
>> @@ -3422,7 +3423,7 @@ static int hv_allocate_config_window(struct hv_pcibus_device *hbus)
>>   	 * vmbus_allocate_mmio() gets used for allocating both device endpoint
>>   	 * resource claims (those which cannot be overlapped) and the ranges
>>   	 * which are valid for the children of this bus, which are intended
>> -	 * to be overlapped by those children.  Set the flag on this claim
>> +	 * to be overlapped by those children.	Set the flag on this claim
> 
> Another hunk that should be dropped.


