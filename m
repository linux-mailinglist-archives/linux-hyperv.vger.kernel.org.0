Return-Path: <linux-hyperv+bounces-8736-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHwoLVbbhGkV6AMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8736-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:03:02 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95217F647F
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A72E4302EEBC
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 18:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CEF30149F;
	Thu,  5 Feb 2026 18:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="X99y4vwl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8592F3C3A;
	Thu,  5 Feb 2026 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770314533; cv=pass; b=KHUti6WoVOG7Y0iSnjKDxuKW9/0OpF+G74t04v+rxFtk28LMcms63MgOn3RJBWXeqXe/fNA/7ciUENI6dnnT31ouHVpoxevFqqfu7ZB423lm3Nv6hoY9a0AsM/a5pNAT6N0q/5k51jwyOa2U37copE0G39pPF7MFXd+Bt6f4f3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770314533; c=relaxed/simple;
	bh=xY8xXzz5pBg0ITbdyziQQu2Jojup6JepLTAvcGKldxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4XYwRER1W2nKJDLr7qJni6ElEC0AILclxxtx0ZrY+wQ/A0ICDvdPdifRp4QE5rcHTyarZfSucMPtw0n40Le4P6ZPCFjiKpx9FYuIG1iJi1cYuFJsDqd0be9lbR5nqo7BJnO+g3CtZeKoRq55KfQgC9tZb19roFND9xGYHi0vZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=X99y4vwl; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1770314525; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fqZAjwnk6txCScazB1Jr2oB0F0e3N64Mu1oWMBBl9QijRlwvoIC4iIb95CM8Do92TbPRrAzChNK7iq1XuJOLu2ZTtQcQsa1yHD27KdEs8wRw7Rj/oW1ib1maEDERfuPM+eL4/D2ZYgoPMWNfumIrZ2oIW38bbFUl/y9tMOX/07s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770314525; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=927/vcha9AccB0gjkN10r1h62qO1r5LsG7fjzW3VW7I=; 
	b=IQJpOmDsBWQygbctOBVOptL9Q3hggS5dhecOpZovdEqQ2AFrrZTRQm6VnSekwdUTCbtWxd3kPalOIocnZ7X3zYoLJnjPYw9D47mJcTJqBAHq2w+W1r+gTlhuHeNqZEhO4XlvggpNNDIr1/wldHy4B+khmguRn+hTLhgD2Evd/Oc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770314525;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=927/vcha9AccB0gjkN10r1h62qO1r5LsG7fjzW3VW7I=;
	b=X99y4vwlGm0E5gcoYTccAW18DaLJLaxmxUIt/Vp5z0POMHY7UvBE/v1mX8dix6o9
	2OsgOts7LUOHbHTAMfn635F04XCvzOA0wHgN5EXtQs8HYTqBND/oJcyLkZvB9a3YC6r
	r8Mccp/khHNIwVIUFSDQrarLifEoxwAloMR0YGzE=
Received: by mx.zohomail.com with SMTPS id 1770314523079327.7215834155538;
	Thu, 5 Feb 2026 10:02:03 -0800 (PST)
Date: Thu, 5 Feb 2026 23:31:55 +0530
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mshv: Introduce hv_deposit_memory helper functions
Message-ID: <qhcijv5kwmjvripayqmuh5xnh32v62fput43ff7u3m6kci7ai6@zfhdi3ay26vu>
References: <177005499596.120041.5908089206606113719.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177005514346.120041.5702271891856790910.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177005514346.120041.5702271891856790910.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[anirudhrb.com];
	TAGGED_FROM(0.00)[bounces-8736-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:email,anirudhrb.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95217F647F
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 05:59:03PM +0000, Stanislav Kinsburskii wrote:
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
>  drivers/hv/hv_proc.c           |   22 ++++++++++++++++++++--
>  drivers/hv/mshv_root_hv_call.c |   25 +++++++++----------------
>  drivers/hv/mshv_root_main.c    |    3 +--
>  include/asm-generic/mshyperv.h |   10 ++++++++++
>  4 files changed, 40 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index e53204b9e05d..ffa25cd6e4e9 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -110,6 +110,23 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>  }
>  EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
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
>  bool hv_result_needs_memory(u64 status)
>  {
>  	switch (hv_result(status)) {
> @@ -155,7 +172,8 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
>  			}
>  			break;
>  		}
> -		ret = hv_call_deposit_pages(node, hv_current_partition_id, 1);
> +		ret = hv_deposit_memory_node(node, hv_current_partition_id,
> +					     status);
>  	} while (!ret);
>  
>  	return ret;
> @@ -197,7 +215,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
>  			}
>  			break;
>  		}
> -		ret = hv_call_deposit_pages(node, partition_id, 1);
> +		ret = hv_deposit_memory_node(node, partition_id, status);
>  
>  	} while (!ret);
>  
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index 89afeeda21dd..174431cb5e0e 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -123,8 +123,7 @@ int hv_call_create_partition(u64 flags,
>  			break;
>  		}
>  		local_irq_restore(irq_flags);
> -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> -					    hv_current_partition_id, 1);
> +		ret = hv_deposit_memory(hv_current_partition_id, status);
>  	} while (!ret);
>  
>  	return ret;
> @@ -151,7 +150,7 @@ int hv_call_initialize_partition(u64 partition_id)
>  			ret = hv_result_to_errno(status);
>  			break;
>  		}
> -		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
> +		ret = hv_deposit_memory(partition_id, status);
>  	} while (!ret);
>  
>  	return ret;
> @@ -465,8 +464,7 @@ int hv_call_get_vp_state(u32 vp_index, u64 partition_id,
>  		}
>  		local_irq_restore(flags);
>  
> -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> -					    partition_id, 1);
> +		ret = hv_deposit_memory(partition_id, status);
>  	} while (!ret);
>  
>  	return ret;
> @@ -525,8 +523,7 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
>  		}
>  		local_irq_restore(flags);
>  
> -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> -					    partition_id, 1);
> +		ret = hv_deposit_memory(partition_id, status);
>  	} while (!ret);
>  
>  	return ret;
> @@ -573,7 +570,7 @@ static int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>  
>  		local_irq_restore(flags);
>  
> -		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
> +		ret = hv_deposit_memory(partition_id, status);
>  	} while (!ret);
>  
>  	return ret;
> @@ -722,8 +719,7 @@ hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
>  			ret = hv_result_to_errno(status);
>  			break;
>  		}
> -		ret = hv_call_deposit_pages(NUMA_NO_NODE, port_partition_id, 1);
> -
> +		ret = hv_deposit_memory(port_partition_id, status);
>  	} while (!ret);
>  
>  	return ret;
> @@ -776,8 +772,7 @@ hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
>  			ret = hv_result_to_errno(status);
>  			break;
>  		}
> -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> -					    connection_partition_id, 1);
> +		ret = hv_deposit_memory(connection_partition_id, status);
>  	} while (!ret);
>  
>  	return ret;
> @@ -848,8 +843,7 @@ static int hv_call_map_stats_page2(enum hv_stats_object_type type,
>  			break;
>  		}
>  
> -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> -					    hv_current_partition_id, 1);
> +		ret = hv_deposit_memory(hv_current_partition_id, status);
>  	} while (!ret);
>  
>  	return ret;
> @@ -885,8 +879,7 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
>  			return ret;
>  		}
>  
> -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> -					    hv_current_partition_id, 1);
> +		ret = hv_deposit_memory(hv_current_partition_id, status);
>  		if (ret)
>  			return ret;
>  	} while (!ret);
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index ee30bfa6bb2e..dce255c94f9e 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -264,8 +264,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
>  		if (!hv_result_needs_memory(status))
>  			ret = hv_result_to_errno(status);
>  		else
> -			ret = hv_call_deposit_pages(NUMA_NO_NODE,
> -						    pt_id, 1);
> +			ret = hv_deposit_memory(pt_id, status);
>  	} while (!ret);
>  
>  	args.status = hv_result(status);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 452426d5b2ab..d37b68238c97 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -344,6 +344,7 @@ static inline bool hv_parent_partition(void)
>  }
>  
>  bool hv_result_needs_memory(u64 status);
> +int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
> @@ -353,6 +354,10 @@ static inline bool hv_root_partition(void) { return false; }
>  static inline bool hv_l1vh_partition(void) { return false; }
>  static inline bool hv_parent_partition(void) { return false; }
>  static inline bool hv_result_needs_memory(u64 status) { return false; }
> +static inline int hv_deposit_memory_node(int node, u64 partition_id, u64 status)
> +{
> +	return -EOPNOTSUPP;
> +}
>  static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>  {
>  	return -EOPNOTSUPP;
> @@ -367,6 +372,11 @@ static inline int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u3
>  }
>  #endif /* CONFIG_MSHV_ROOT */
>  
> +static inline int hv_deposit_memory(u64 partition_id, u64 status)
> +{
> +	return hv_deposit_memory_node(NUMA_NO_NODE, partition_id, status);
> +}
> +
>  #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>  u8 __init get_vtl(void);
>  #else
> 
> 

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


