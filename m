Return-Path: <linux-hyperv+bounces-8684-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGATGDl+gmnAVQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8684-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 00:01:13 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F37ADDF7ED
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 00:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 291D83023021
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Feb 2026 23:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DD72BD5BD;
	Tue,  3 Feb 2026 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SZjlYE7N"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259912DB783;
	Tue,  3 Feb 2026 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159669; cv=none; b=SbwpyiRJfcodcH9EZ5r2A7M5RTPFzMg9YUXVkO1DlTP+uKaE66WC0zd2Y/AFHAHW/F0L6Bc/cQgZE66ZNWfafnC/NwQzhF+mYO6ScK3ZjA2TXyF4vRvy/bbsE/9dEC/G7KMcxM1/NDW+daxnK2GHUsB3z6C/mcDvSkh8BwIrfiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159669; c=relaxed/simple;
	bh=ydYGxUjwRj3SrwOnADx/ReHcXO5yZILyS3iZh7dt/GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSNPmnNssTLoh+2oqr8oXZY6Oujw/WPLi8BlNorVGO7Y6D+++0URHcgi0lew6CHREQXlJ6VP4em6biXPjlivmY1mElwdBeLi5k2gc/o9b59sziJRfrOiV5QEJc0LHMP+krNXj5N5LGJ4SLiyRqWOYNUjOxT5UzYja4Jr+KVKjDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SZjlYE7N; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9D06620B7168;
	Tue,  3 Feb 2026 15:01:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9D06620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770159663;
	bh=zQEi/2mybaIg8UWWowH4lza41Lh2JjXWPvYXBhPFFS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SZjlYE7Nysu1DL+Az1SsL0jb0pMDkk4FAyfcRlm1ayujtHx8TJctggGyXogRQLoaR
	 lvK9S/jW1pG9zn0OVLqbnKqKHjjJebXR5/3y41hHbrbhbaveVCD4Qr5GzjKdPe8Oyj
	 v9RA+wa7tn9iMrGbQT8BDq+6+1bDP84pG2wZKnmU=
Message-ID: <7e401646-cc11-ee82-a045-8955201aa8cf@linux.microsoft.com>
Date: Tue, 3 Feb 2026 15:01:02 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 2/4] mshv: Introduce hv_deposit_memory helper functions
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <177005499596.120041.5908089206606113719.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177005514346.120041.5702271891856790910.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <177005514346.120041.5702271891856790910.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8684-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F37ADDF7ED
X-Rspamd-Action: no action

On 2/2/26 09:59, Stanislav Kinsburskii wrote:
> Introduce hv_deposit_memory_node() and hv_deposit_memory() helper
> functions to handle memory deposition with proper error handling.

deposition is a legal thing :) ... i think you just mean deposit.

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
> index e53204b9e05d..ffa25cd6e4e9 100644
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
>   bool hv_result_needs_memory(u64 status)
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
> index 89afeeda21dd..174431cb5e0e 100644
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
> index ee30bfa6bb2e..dce255c94f9e 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -264,8 +264,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
>   		if (!hv_result_needs_memory(status))
>   			ret = hv_result_to_errno(status);
>   		else
> -			ret = hv_call_deposit_pages(NUMA_NO_NODE,
> -						    pt_id, 1);
> +			ret = hv_deposit_memory(pt_id, status);
>   	} while (!ret);
>   
>   	args.status = hv_result(status);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 452426d5b2ab..d37b68238c97 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -344,6 +344,7 @@ static inline bool hv_parent_partition(void)
>   }
>   
>   bool hv_result_needs_memory(u64 status);
> +int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
>   int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>   int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>   int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
> @@ -353,6 +354,10 @@ static inline bool hv_root_partition(void) { return false; }
>   static inline bool hv_l1vh_partition(void) { return false; }
>   static inline bool hv_parent_partition(void) { return false; }
>   static inline bool hv_result_needs_memory(u64 status) { return false; }
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


