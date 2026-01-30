Return-Path: <linux-hyperv+bounces-8622-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KDcEnosfWmYQgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8622-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 23:11:06 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B63BF088
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 23:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C98B33013D70
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 22:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046B737AA64;
	Fri, 30 Jan 2026 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M/p07QAc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA56155757;
	Fri, 30 Jan 2026 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769811060; cv=none; b=aFu5vm+rUVckXwDbeLQL/oxped53Qf9KWNEUljd+mAujfZLzXVEXzDFpnnyL9+IEIAnqQ9ZcelEhQKHEJrmbT+EZYwMBUFxt+s7A+BeSouTvmhlTEKUvGthJ/jb0AO8gAsqdRJNhl02cnx+/JFP7kk8+Y2hO2J4oBLJqO64yh3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769811060; c=relaxed/simple;
	bh=Kvn53S/7Uu5XjxpNmJH/V1bZCoRof7W96nwi0bI/KwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0a350OCEV+loaQ+6dRrnYkn6oNr1M8c7B4sq84OQ88OTinpuh21NLCYeZMJ9xeUjIDYum7WZxYCjz3CBMUZAC8iyaPMJve4eYPNyTjlSLyWyvURngvKwyFq8rRcVUuVsYxtjimRDnKl/N2MucZkIRaFHapr22oYLsLhA7Oa4KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M/p07QAc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.32.91] (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7860E20B7167;
	Fri, 30 Jan 2026 14:10:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7860E20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769811059;
	bh=S587GzR4/YVCY/QYXE0GwuuvvAlb8tY57rX4G8C6bLs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M/p07QActjgiHNcnhmZsRTLUFAuzv8OY9gTXXsPwS4J8GyF4pNSuVniqUb1LpipFK
	 AbRAuJJOuGrsaUNuTxwNkfS+U+w+JqcqBbxv1weBv/3ctrswVNuecYXEVPwC8Ux0xd
	 peGfHlBkqCvfmDGYYOMJ+6xHY4JPa4fGfMIMJcvE=
Message-ID: <ace4f4fd-f328-cfdc-00eb-6751c8c9ebb0@linux.microsoft.com>
Date: Fri, 30 Jan 2026 14:10:57 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v0 12/15] x86/hyperv: Implement hyperv virtual iommu
Content-Language: en-US
To: Jacob Pan <jacob.pan@linux.microsoft.com>
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
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-13-mrathor@linux.microsoft.com>
 <20260121211806.000006aa@linux.microsoft.com>
 <34de2049-912e-fc9e-9fc1-727fade0480f@linux.microsoft.com>
 <20260127112144.00002991@linux.microsoft.com>
 <20260127143119.00006d2f@linux.microsoft.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260127143119.00006d2f@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
	TAGGED_FROM(0.00)[bounces-8622-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[28];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: A3B63BF088
X-Rspamd-Action: no action

On 1/27/26 14:31, Jacob Pan wrote:
> Hi Mukesh,
> 
>>>>> +
>>>>> +	if (hv_l1vh_partition() && !hv_curr_thread_is_vmm() &&
>>>>> !hv_no_attdev) {
>>>>> +		pr_err("Hyper-V: l1vh iommu does not support
>>>>> host devices\n");
>>>> why is this an error if user input choose not to do direct
>>>> attach?
>>>
>>> Like the error message says: on l1vh, direct attaches of host
>>> devices (eg dpdk) is not supported. and l1vh only does direct
>>> attaches. IOW, no host devices on l1vh.
>>>    
>> This hv_no_attdev flag is really confusing to me, by default
>> hv_no_attdev is false, which allows direct attach. And you are saying
>> l1vh allows it.
>>
>> Why is this flag also controls host device attachment in l1vh? If you
>> can tell the difference between direct host device attach and other
>> direct attach, why don't you reject always reject host attach in l1vh?
> On second thought, if the hv_no_attdev knob is only meant to control
> host domain attach vs. direct attach, then it is irrelevant on L1VH.
> 
> Would it make more sense to rename this to something like
> hv_host_disable_direct_attach? That would better reflect its scope and
> allow it to be ignored under L1VH, and reduce the risk of users
> misinterpreting or misusing it.

It would, but it is kernel parameter and needs to be terse. It would
be documented properly tho, so we should be ok.

Thanks,
-Mukesh


