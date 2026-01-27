Return-Path: <linux-hyperv+bounces-8542-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKwcIKYdeGkKoQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8542-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 03:06:30 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B72B8EDC1
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 03:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 361893002F51
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 02:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3392BE7CD;
	Tue, 27 Jan 2026 02:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ngs/HyjF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8911F5842;
	Tue, 27 Jan 2026 02:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479586; cv=none; b=PlSnnGDJNH8o2uv6PmrhxIOJx43OZJEClCvJem4mQgPmZpGo9QYRDV4/CyoCX6CaMPvmQDDCmIsoLBeC3BzPylNJEtKT6n+uujcmLNBDixVwOFejILCr21ByYabHTsFK2ECSK/lgQj4SrqJEbrwhLtd3ut2pEoqlLXB1vLeU2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479586; c=relaxed/simple;
	bh=e/SbIVsaODkpOlS3X9ORyZTmrzNCvUyYZYcrrowGxIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+ar38ofDEDyg26DQDJUEo8teLTV8yoTBFtRK1QSbAT8G3BWmVOHTkSrYZ6XvK3Np2kYZ5pfBS/3NQGcZs2ctKYuy6mpL+Q67sxnzsXWTgJZXI9imUKbSxu746CgZAgp8GQsGiLlVWmbEvWo1FtOtKWLnUDPu07vxKKEJdOqpEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ngs/HyjF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id A86F920B7165;
	Mon, 26 Jan 2026 18:06:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A86F920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769479583;
	bh=M6HK8WSAnzrGrZ2Ekfx9q4BlKx2aHfesaZLeqJqtG3s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ngs/HyjFJihnLm8HHQT13P5pz2up+HiAy1duHvPecaqUM8HHzBm+2BhP3eR1cW6EH
	 Q84U42/JNguXcFLuo1Tn/A6YO4TAtszHU0eHPyCPRYHgW47nPIYcDgMWMAX+YlOteC
	 RBG01sbfYl3Bz3buBNs0vIZgXlIBAnpf7enufbfc=
Message-ID: <df21ce10-3cd5-9d78-a3ce-84c4b1ff9275@linux.microsoft.com>
Date: Mon, 26 Jan 2026 18:06:23 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/4] mshv: Introduce hv_deposit_memory helper functions
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <176913164914.89165.5792608454600292463.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176913212322.89165.12915292926444353627.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <23f52e20-f156-a2aa-ff04-00dc55238c51@linux.microsoft.com>
 <aXacAQP3gjZ1gSLs@skinsburskii.localdomain>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <aXacAQP3gjZ1gSLs@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8542-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9B72B8EDC1
X-Rspamd-Action: no action

On 1/25/26 14:41, Stanislav Kinsburskii wrote:
> On Fri, Jan 23, 2026 at 04:33:39PM -0800, Mukesh R wrote:
>> On 1/22/26 17:35, Stanislav Kinsburskii wrote:
>>> Introduce hv_deposit_memory_node() and hv_deposit_memory() helper
>>> functions to handle memory deposition with proper error handling.
>>>
>>> The new hv_deposit_memory_node() function takes the hypervisor status
>>> as a parameter and validates it before depositing pages. It checks for
>>> HV_STATUS_INSUFFICIENT_MEMORY specifically and returns an error for
>>> unexpected status codes.
>>>
>>> This is a precursor patch to new out-of-memory error codes support.
>>> No functional changes intended.
>>>
>>> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>>> ---
>>>    drivers/hv/hv_proc.c           |   22 ++++++++++++++++++++--
>>>    drivers/hv/mshv_root_hv_call.c |   25 +++++++++----------------
>>>    drivers/hv/mshv_root_main.c    |    3 +--
>>>    include/asm-generic/mshyperv.h |   10 ++++++++++
>>>    4 files changed, 40 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
>>> index 80c66d1c74d5..c0c2bfc80d77 100644
>>> --- a/drivers/hv/hv_proc.c
>>> +++ b/drivers/hv/hv_proc.c
>>> @@ -110,6 +110,23 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>>>    }
>>>    EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
>>> +int hv_deposit_memory_node(int node, u64 partition_id,
>>> +			   u64 hv_status)
>>> +{
>>> +	u32 num_pages;
>>> +
>>> +	switch (hv_result(hv_status)) {
>>> +	case HV_STATUS_INSUFFICIENT_MEMORY:
>>> +		num_pages = 1;
>>> +		break;
>>> +	default:
>>> +		hv_status_err(hv_status, "Unexpected!\n");
>>> +		return -ENOMEM;
>>> +	}
>>> +	return hv_call_deposit_pages(node, partition_id, num_pages);
>>> +}
>>> +EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
>>> +
>>
>> Different hypercalls may want to deposit different number of pages in one
>> shot. As feature evolves, page sizes get mixed, we'd almost need that
>> flexibility. So, imo, either we just don't do this for now, or add num pages
>> parameter to be passed down.
>>
> 
> What you do mean by "page sizes get mixed"?
> A helper to deposit num pages already exists: its
> hv_call_deposit_pages().

My point, you are removing number of pages, and we may want to keep
that so one can quickly play around and change them.

-                       ret = hv_call_deposit_pages(NUMA_NO_NODE,
-                                                   pt_id, 1);
+                       ret = hv_deposit_memory(pt_id, status);

For example, in hv_call_initialize_partition() we may realize after
some analysis that depositing 2 pages or 4 pages is much better.

> Thanks,
> Stanislav
> 
>> Thanks,
>> -Mukesh
>>
>>
>>
>>>    bool hv_result_oom(u64 status)
>>>    {
>>>    	switch (hv_result(status)) {
>>> @@ -155,7 +172,8 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
>>>    			}
>>>    			break;
>>>    		}
>>> -		ret = hv_call_deposit_pages(node, hv_current_partition_id, 1);
>>> +		ret = hv_deposit_memory_node(node, hv_current_partition_id,
>>> +					     status);
>>>    	} while (!ret);
>>>    	return ret;
>>> @@ -197,7 +215,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
>>>    			}
>>>    			break;
>>>    		}
>>> -		ret = hv_call_deposit_pages(node, partition_id, 1);
>>> +		ret = hv_deposit_memory_node(node, partition_id, status);
>>>    	} while (!ret);
>>> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
>>> index 58c5cbf2e567..06f2bac8039d 100644
>>> --- a/drivers/hv/mshv_root_hv_call.c
>>> +++ b/drivers/hv/mshv_root_hv_call.c
>>> @@ -123,8 +123,7 @@ int hv_call_create_partition(u64 flags,
>>>    			break;
>>>    		}
>>>    		local_irq_restore(irq_flags);
>>> -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
>>> -					    hv_current_partition_id, 1);
>>> +		ret = hv_deposit_memory(hv_current_partition_id, status);
>>>    	} while (!ret);
>>>    	return ret;
>>> @@ -151,7 +150,7 @@ int hv_call_initialize_partition(u64 partition_id)
>>>    			ret = hv_result_to_errno(status);
>>>    			break;
>>>    		}
>>> -		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
>>> +		ret = hv_deposit_memory(partition_id, status);
>>>    	} while (!ret);
>>>    	return ret;
>>> @@ -465,8 +464,7 @@ int hv_call_get_vp_state(u32 vp_index, u64 partition_id,
>>>    		}
>>>    		local_irq_restore(flags);
>>> -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
>>> -					    partition_id, 1);
>>> +		ret = hv_deposit_memory(partition_id, status);
>>>    	} while (!ret);
>>>    	return ret;
>>> @@ -525,8 +523,7 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
>>>    		}
>>>    		local_irq_restore(flags);
>>> -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
>>> -					    partition_id, 1);
>>> +		ret = hv_deposit_memory(partition_id, status);
>>>    	} while (!ret);
>>>    	return ret;
>>> @@ -573,7 +570,7 @@ static int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>>>    		local_irq_restore(flags);
>>> -		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
>>> +		ret = hv_deposit_memory(partition_id, status);
>>>    	} while (!ret);
>>>    	return ret;
>>> @@ -722,8 +719,7 @@ hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
>>>    			ret = hv_result_to_errno(status);
>>>    			break;
>>>    		}
>>> -		ret = hv_call_deposit_pages(NUMA_NO_NODE, port_partition_id, 1);
>>> -
>>> +		ret = hv_deposit_memory(port_partition_id, status);
>>>    	} while (!ret);
>>>    	return ret;
>>> @@ -776,8 +772,7 @@ hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
>>>    			ret = hv_result_to_errno(status);
>>>    			break;
>>>    		}
>>> -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
>>> -					    connection_partition_id, 1);
>>> +		ret = hv_deposit_memory(connection_partition_id, status);
>>>    	} while (!ret);
>>>    	return ret;
>>> @@ -848,8 +843,7 @@ static int hv_call_map_stats_page2(enum hv_stats_object_type type,
>>>    			break;
>>>    		}
>>> -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
>>> -					    hv_current_partition_id, 1);
>>> +		ret = hv_deposit_memory(hv_current_partition_id, status);
>>>    	} while (!ret);
>>>    	return ret;
>>> @@ -885,8 +879,7 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
>>>    			return ret;
>>>    		}
>>> -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
>>> -					    hv_current_partition_id, 1);
>>> +		ret = hv_deposit_memory(hv_current_partition_id, status);
>>>    		if (ret)
>>>    			return ret;
>>>    	} while (!ret);
>>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>>> index f4697497f83e..5fc572e31cd7 100644
>>> --- a/drivers/hv/mshv_root_main.c
>>> +++ b/drivers/hv/mshv_root_main.c
>>> @@ -264,8 +264,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
>>>    		if (!hv_result_oom(status))
>>>    			ret = hv_result_to_errno(status);
>>>    		else
>>> -			ret = hv_call_deposit_pages(NUMA_NO_NODE,
>>> -						    pt_id, 1);
>>> +			ret = hv_deposit_memory(pt_id, status);
>>>    	} while (!ret);
>>>    	args.status = hv_result(status);
>>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>>> index b73352a7fc9e..c8e8976839f8 100644
>>> --- a/include/asm-generic/mshyperv.h
>>> +++ b/include/asm-generic/mshyperv.h
>>> @@ -344,6 +344,7 @@ static inline bool hv_parent_partition(void)
>>>    }
>>>    bool hv_result_oom(u64 status);
>>> +int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
>>>    int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>>>    int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>>>    int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
>>> @@ -353,6 +354,10 @@ static inline bool hv_root_partition(void) { return false; }
>>>    static inline bool hv_l1vh_partition(void) { return false; }
>>>    static inline bool hv_parent_partition(void) { return false; }
>>>    static inline bool hv_result_oom(u64 status) { return false; }
>>> +static inline int hv_deposit_memory_node(int node, u64 partition_id, u64 status)
>>> +{
>>> +	return -EOPNOTSUPP;
>>> +}
>>>    static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>>>    {
>>>    	return -EOPNOTSUPP;
>>> @@ -367,6 +372,11 @@ static inline int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u3
>>>    }
>>>    #endif /* CONFIG_MSHV_ROOT */
>>> +static inline int hv_deposit_memory(u64 partition_id, u64 status)
>>> +{
>>> +	return hv_deposit_memory_node(NUMA_NO_NODE, partition_id, status);
>>> +}
>>> +
>>>    #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>>>    u8 __init get_vtl(void);
>>>    #else
>>>
>>>


