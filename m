Return-Path: <linux-hyperv+bounces-8502-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gErVJGkTdGkh2AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8502-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 01:33:45 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E80817BAF9
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 01:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE6793012CB5
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 00:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843DC82866;
	Sat, 24 Jan 2026 00:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PUwCdsEO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCF11465B4;
	Sat, 24 Jan 2026 00:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769214822; cv=none; b=rvirtEGcGZiVD9CLEQzbsQV1ny2NMdYRw23AQWj6endaKqJvm5b1tyJvYO4O3kZ5lQ9lgqjWb6s9ReXyHk1cvTnBrckHJskmROSBcXnEoZbUxtWRShyyUGt49YiXZlBrwgt/khHro5P3IgmRafbkhdzabfBXSEKudaGqLC5Zt/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769214822; c=relaxed/simple;
	bh=z3R/wrVswnEc8Mlveaey10BAwEXrs2TA+HmUpqdeZLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3VANay93JmLEAYvCzyvyxC7DaL7oX/QU1TuokXzq8guH265vd7v1s6/1V27m1LnCEZcZ5cuPMumx4h3R7pL2cFSYo4WdxWATP33ZLXVzl1LL4wzBzkho2HcM7CTEgKoZLDAtmruUJE6DJS7fegcY/8PRWO6OeVlgo1QvL0glc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PUwCdsEO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.32.59] (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id F1CE220B7167;
	Fri, 23 Jan 2026 16:33:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F1CE220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769214820;
	bh=vKFWkJ02MLdZUVqi+QmWlPkkQ4G/0snfvi/vXEHon6c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PUwCdsEOVKcvn/ngMLjkJFVAgYZyQtkk61egP9gVJwYcaeRGEcfRfF7QpNGinzQDa
	 mAXtUBJCBSM7DylcBvP+seI2Yg+lezjOk/TejAwWKXOAUVDgGSVCIsxpvET795DYJ0
	 sYVDpOnYAD9tIpXrgcXcyn5f3v01D+AgWAp2I7jU=
Message-ID: <23f52e20-f156-a2aa-ff04-00dc55238c51@linux.microsoft.com>
Date: Fri, 23 Jan 2026 16:33:39 -0800
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
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <176913164914.89165.5792608454600292463.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176913212322.89165.12915292926444353627.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <176913212322.89165.12915292926444353627.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8502-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E80817BAF9
X-Rspamd-Action: no action

On 1/22/26 17:35, Stanislav Kinsburskii wrote:
> Introduce hv_deposit_memory_node() and hv_deposit_memory() helper
> functions to handle memory deposition with proper error handling.
> 
> The new hv_deposit_memory_node() function takes the hypervisor status
> as a parameter and validates it before depositing pages. It checks for
> HV_STATUS_INSUFFICIENT_MEMORY specifically and returns an error for
> unexpected status codes.
> 
> This is a precursor patch to new out-of-memory error codes support.
> No functional changes intended.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>   drivers/hv/hv_proc.c           |   22 ++++++++++++++++++++--
>   drivers/hv/mshv_root_hv_call.c |   25 +++++++++----------------
>   drivers/hv/mshv_root_main.c    |    3 +--
>   include/asm-generic/mshyperv.h |   10 ++++++++++
>   4 files changed, 40 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 80c66d1c74d5..c0c2bfc80d77 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -110,6 +110,23 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>   }
>   EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
>   
> +int hv_deposit_memory_node(int node, u64 partition_id,
> +			   u64 hv_status)
> +{
> +	u32 num_pages;
> +
> +	switch (hv_result(hv_status)) {
> +	case HV_STATUS_INSUFFICIENT_MEMORY:
> +		num_pages = 1;
> +		break;
> +	default:
> +		hv_status_err(hv_status, "Unexpected!\n");
> +		return -ENOMEM;
> +	}
> +	return hv_call_deposit_pages(node, partition_id, num_pages);
> +}
> +EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
> +

Different hypercalls may want to deposit different number of pages in one
shot. As feature evolves, page sizes get mixed, we'd almost need that
flexibility. So, imo, either we just don't do this for now, or add num pages
parameter to be passed down.

Thanks,
-Mukesh



>   bool hv_result_oom(u64 status)
>   {
>   	switch (hv_result(status)) {
> @@ -155,7 +172,8 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
>   			}
>   			break;
>   		}
> -		ret = hv_call_deposit_pages(node, hv_current_partition_id, 1);
> +		ret = hv_deposit_memory_node(node, hv_current_partition_id,
> +					     status);
>   	} while (!ret);
>   
>   	return ret;
> @@ -197,7 +215,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
>   			}
>   			break;
>   		}
> -		ret = hv_call_deposit_pages(node, partition_id, 1);
> +		ret = hv_deposit_memory_node(node, partition_id, status);
>   
>   	} while (!ret);
>   
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index 58c5cbf2e567..06f2bac8039d 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -123,8 +123,7 @@ int hv_call_create_partition(u64 flags,
>   			break;
>   		}
>   		local_irq_restore(irq_flags);
> -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> -					    hv_current_partition_id, 1);
> +		ret = hv_deposit_memory(hv_current_partition_id, status);
>   	} while (!ret);
>   
>   	return ret;
> @@ -151,7 +150,7 @@ int hv_call_initialize_partition(u64 partition_id)
>   			ret = hv_result_to_errno(status);
>   			break;
>   		}
> -		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
> +		ret = hv_deposit_memory(partition_id, status);
>   	} while (!ret);
>   
>   	return ret;
> @@ -465,8 +464,7 @@ int hv_call_get_vp_state(u32 vp_index, u64 partition_id,
>   		}
>   		local_irq_restore(flags);
>   
> -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> -					    partition_id, 1);
> +		ret = hv_deposit_memory(partition_id, status);
>   	} while (!ret);
>   
>   	return ret;
> @@ -525,8 +523,7 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
>   		}
>   		local_irq_restore(flags);
>   
> -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> -					    partition_id, 1);
> +		ret = hv_deposit_memory(partition_id, status);
>   	} while (!ret);
>   
>   	return ret;
> @@ -573,7 +570,7 @@ static int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>   
>   		local_irq_restore(flags);
>   
> -		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
> +		ret = hv_deposit_memory(partition_id, status);
>   	} while (!ret);
>   
>   	return ret;
> @@ -722,8 +719,7 @@ hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
>   			ret = hv_result_to_errno(status);
>   			break;
>   		}
> -		ret = hv_call_deposit_pages(NUMA_NO_NODE, port_partition_id, 1);
> -
> +		ret = hv_deposit_memory(port_partition_id, status);
>   	} while (!ret);
>   
>   	return ret;
> @@ -776,8 +772,7 @@ hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
>   			ret = hv_result_to_errno(status);
>   			break;
>   		}
> -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> -					    connection_partition_id, 1);
> +		ret = hv_deposit_memory(connection_partition_id, status);
>   	} while (!ret);
>   
>   	return ret;
> @@ -848,8 +843,7 @@ static int hv_call_map_stats_page2(enum hv_stats_object_type type,
>   			break;
>   		}
>   
> -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> -					    hv_current_partition_id, 1);
> +		ret = hv_deposit_memory(hv_current_partition_id, status);
>   	} while (!ret);
>   
>   	return ret;
> @@ -885,8 +879,7 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
>   			return ret;
>   		}
>   
> -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> -					    hv_current_partition_id, 1);
> +		ret = hv_deposit_memory(hv_current_partition_id, status);
>   		if (ret)
>   			return ret;
>   	} while (!ret);
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index f4697497f83e..5fc572e31cd7 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -264,8 +264,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
>   		if (!hv_result_oom(status))
>   			ret = hv_result_to_errno(status);
>   		else
> -			ret = hv_call_deposit_pages(NUMA_NO_NODE,
> -						    pt_id, 1);
> +			ret = hv_deposit_memory(pt_id, status);
>   	} while (!ret);
>   
>   	args.status = hv_result(status);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index b73352a7fc9e..c8e8976839f8 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -344,6 +344,7 @@ static inline bool hv_parent_partition(void)
>   }
>   
>   bool hv_result_oom(u64 status);
> +int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
>   int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>   int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>   int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
> @@ -353,6 +354,10 @@ static inline bool hv_root_partition(void) { return false; }
>   static inline bool hv_l1vh_partition(void) { return false; }
>   static inline bool hv_parent_partition(void) { return false; }
>   static inline bool hv_result_oom(u64 status) { return false; }
> +static inline int hv_deposit_memory_node(int node, u64 partition_id, u64 status)
> +{
> +	return -EOPNOTSUPP;
> +}
>   static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>   {
>   	return -EOPNOTSUPP;
> @@ -367,6 +372,11 @@ static inline int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u3
>   }
>   #endif /* CONFIG_MSHV_ROOT */
>   
> +static inline int hv_deposit_memory(u64 partition_id, u64 status)
> +{
> +	return hv_deposit_memory_node(NUMA_NO_NODE, partition_id, status);
> +}
> +
>   #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>   u8 __init get_vtl(void);
>   #else
> 
> 


