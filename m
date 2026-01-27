Return-Path: <linux-hyperv+bounces-8549-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGovGjoEeWk3ugEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8549-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 19:30:18 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C75990E4
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 19:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AFF4303DAD6
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 18:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768D4327202;
	Tue, 27 Jan 2026 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MDXYAekg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5A8279907;
	Tue, 27 Jan 2026 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538615; cv=none; b=Xbi8sUDgZnaK3T5yN/EGCjRJr91LskPEMH18vOKEIlpQu+GAujfW6yriHui0dEW6sq7MBYBsK6ratpyJk6Jcsv1Ar51g6If+D57pJj1exHH18obOhwlJG5boEMdNkNbR/RzMMi57MMGLuzfRrAP5gRfQJ7H8VsyLQxFEB4VKsMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538615; c=relaxed/simple;
	bh=U2XEATTfURjO9oXNZuXDArrkDH5LGMyJ4nsR7zMiL2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrXgyI7O8dYwzny0rg3TPIm3rgXmgcv9JoetChLybwiz61kLimuReQ6f2OcpfVEG2B/F/O6j5u/PlM1p3g2gMm9lTVHZ8B+ObzWiUP9M23nuEnF3Ldz260t6YmQw+93DiZPG2eh5RRh8FcyGrU1qH+K+B55vQ+ol0Z+nSSIIMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MDXYAekg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id DB3F120B7165;
	Tue, 27 Jan 2026 10:30:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB3F120B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769538613;
	bh=V1hcMz64KRI1tog8IVLnBXS5bBgoOqJ333Bj0FzlyiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MDXYAekgsp+pOiBxsswZ6h0TomqwWlbWmu92MYqeZakQZQaHQfTeOeuyn2y37mDQy
	 ABdLHtAsFM6nGalzruPNczVnvzQ0wSyNofzIx4cBC1YKhIlv/kl55/tKZAJW51vamF
	 uMkOOUlkqVRGYMdPMMFvHQTAtmcfZ27J6MwBZ21U=
Date: Tue, 27 Jan 2026 10:30:10 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mshv: Introduce hv_deposit_memory helper functions
Message-ID: <aXkEMnDy8UFwJitP@skinsburskii.localdomain>
References: <176913164914.89165.5792608454600292463.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176913212322.89165.12915292926444353627.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <23f52e20-f156-a2aa-ff04-00dc55238c51@linux.microsoft.com>
 <aXacAQP3gjZ1gSLs@skinsburskii.localdomain>
 <df21ce10-3cd5-9d78-a3ce-84c4b1ff9275@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df21ce10-3cd5-9d78-a3ce-84c4b1ff9275@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8549-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii.localdomain:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: B8C75990E4
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 06:06:23PM -0800, Mukesh R wrote:
> On 1/25/26 14:41, Stanislav Kinsburskii wrote:
> > On Fri, Jan 23, 2026 at 04:33:39PM -0800, Mukesh R wrote:
> > > On 1/22/26 17:35, Stanislav Kinsburskii wrote:
> > > > Introduce hv_deposit_memory_node() and hv_deposit_memory() helper
> > > > functions to handle memory deposition with proper error handling.
> > > > 
> > > > The new hv_deposit_memory_node() function takes the hypervisor status
> > > > as a parameter and validates it before depositing pages. It checks for
> > > > HV_STATUS_INSUFFICIENT_MEMORY specifically and returns an error for
> > > > unexpected status codes.
> > > > 
> > > > This is a precursor patch to new out-of-memory error codes support.
> > > > No functional changes intended.
> > > > 
> > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > > ---
> > > >    drivers/hv/hv_proc.c           |   22 ++++++++++++++++++++--
> > > >    drivers/hv/mshv_root_hv_call.c |   25 +++++++++----------------
> > > >    drivers/hv/mshv_root_main.c    |    3 +--
> > > >    include/asm-generic/mshyperv.h |   10 ++++++++++
> > > >    4 files changed, 40 insertions(+), 20 deletions(-)
> > > > 
> > > > diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> > > > index 80c66d1c74d5..c0c2bfc80d77 100644
> > > > --- a/drivers/hv/hv_proc.c
> > > > +++ b/drivers/hv/hv_proc.c
> > > > @@ -110,6 +110,23 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> > > >    }
> > > >    EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
> > > > +int hv_deposit_memory_node(int node, u64 partition_id,
> > > > +			   u64 hv_status)
> > > > +{
> > > > +	u32 num_pages;
> > > > +
> > > > +	switch (hv_result(hv_status)) {
> > > > +	case HV_STATUS_INSUFFICIENT_MEMORY:
> > > > +		num_pages = 1;
> > > > +		break;
> > > > +	default:
> > > > +		hv_status_err(hv_status, "Unexpected!\n");
> > > > +		return -ENOMEM;
> > > > +	}
> > > > +	return hv_call_deposit_pages(node, partition_id, num_pages);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
> > > > +
> > > 
> > > Different hypercalls may want to deposit different number of pages in one
> > > shot. As feature evolves, page sizes get mixed, we'd almost need that
> > > flexibility. So, imo, either we just don't do this for now, or add num pages
> > > parameter to be passed down.
> > > 
> > 
> > What you do mean by "page sizes get mixed"?
> > A helper to deposit num pages already exists: its
> > hv_call_deposit_pages().
> 
> My point, you are removing number of pages, and we may want to keep
> that so one can quickly play around and change them.
> 
> -                       ret = hv_call_deposit_pages(NUMA_NO_NODE,
> -                                                   pt_id, 1);
> +                       ret = hv_deposit_memory(pt_id, status);
> 
> For example, in hv_call_initialize_partition() we may realize after
> some analysis that depositing 2 pages or 4 pages is much better.
> 

We have been using this 1-page deposit logic from the beginning. To
change the number of pages, simply replace hv_deposit_memory with
hv_call_deposit_pages and specify the desired number of pages.

The proposed approach reduces code duplication and is less error-prone,
as there are multiple error codes to handle. Consolidating the logic
also makes the driver more robust.


Thanks,  Stanislav

> > Thanks,
> > Stanislav
> > 
> > > Thanks,
> > > -Mukesh
> > > 
> > > 
> > > 
> > > >    bool hv_result_oom(u64 status)
> > > >    {
> > > >    	switch (hv_result(status)) {
> > > > @@ -155,7 +172,8 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
> > > >    			}
> > > >    			break;
> > > >    		}
> > > > -		ret = hv_call_deposit_pages(node, hv_current_partition_id, 1);
> > > > +		ret = hv_deposit_memory_node(node, hv_current_partition_id,
> > > > +					     status);
> > > >    	} while (!ret);
> > > >    	return ret;
> > > > @@ -197,7 +215,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
> > > >    			}
> > > >    			break;
> > > >    		}
> > > > -		ret = hv_call_deposit_pages(node, partition_id, 1);
> > > > +		ret = hv_deposit_memory_node(node, partition_id, status);
> > > >    	} while (!ret);
> > > > diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> > > > index 58c5cbf2e567..06f2bac8039d 100644
> > > > --- a/drivers/hv/mshv_root_hv_call.c
> > > > +++ b/drivers/hv/mshv_root_hv_call.c
> > > > @@ -123,8 +123,7 @@ int hv_call_create_partition(u64 flags,
> > > >    			break;
> > > >    		}
> > > >    		local_irq_restore(irq_flags);
> > > > -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> > > > -					    hv_current_partition_id, 1);
> > > > +		ret = hv_deposit_memory(hv_current_partition_id, status);
> > > >    	} while (!ret);
> > > >    	return ret;
> > > > @@ -151,7 +150,7 @@ int hv_call_initialize_partition(u64 partition_id)
> > > >    			ret = hv_result_to_errno(status);
> > > >    			break;
> > > >    		}
> > > > -		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
> > > > +		ret = hv_deposit_memory(partition_id, status);
> > > >    	} while (!ret);
> > > >    	return ret;
> > > > @@ -465,8 +464,7 @@ int hv_call_get_vp_state(u32 vp_index, u64 partition_id,
> > > >    		}
> > > >    		local_irq_restore(flags);
> > > > -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> > > > -					    partition_id, 1);
> > > > +		ret = hv_deposit_memory(partition_id, status);
> > > >    	} while (!ret);
> > > >    	return ret;
> > > > @@ -525,8 +523,7 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
> > > >    		}
> > > >    		local_irq_restore(flags);
> > > > -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> > > > -					    partition_id, 1);
> > > > +		ret = hv_deposit_memory(partition_id, status);
> > > >    	} while (!ret);
> > > >    	return ret;
> > > > @@ -573,7 +570,7 @@ static int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> > > >    		local_irq_restore(flags);
> > > > -		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
> > > > +		ret = hv_deposit_memory(partition_id, status);
> > > >    	} while (!ret);
> > > >    	return ret;
> > > > @@ -722,8 +719,7 @@ hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
> > > >    			ret = hv_result_to_errno(status);
> > > >    			break;
> > > >    		}
> > > > -		ret = hv_call_deposit_pages(NUMA_NO_NODE, port_partition_id, 1);
> > > > -
> > > > +		ret = hv_deposit_memory(port_partition_id, status);
> > > >    	} while (!ret);
> > > >    	return ret;
> > > > @@ -776,8 +772,7 @@ hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
> > > >    			ret = hv_result_to_errno(status);
> > > >    			break;
> > > >    		}
> > > > -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> > > > -					    connection_partition_id, 1);
> > > > +		ret = hv_deposit_memory(connection_partition_id, status);
> > > >    	} while (!ret);
> > > >    	return ret;
> > > > @@ -848,8 +843,7 @@ static int hv_call_map_stats_page2(enum hv_stats_object_type type,
> > > >    			break;
> > > >    		}
> > > > -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> > > > -					    hv_current_partition_id, 1);
> > > > +		ret = hv_deposit_memory(hv_current_partition_id, status);
> > > >    	} while (!ret);
> > > >    	return ret;
> > > > @@ -885,8 +879,7 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
> > > >    			return ret;
> > > >    		}
> > > > -		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> > > > -					    hv_current_partition_id, 1);
> > > > +		ret = hv_deposit_memory(hv_current_partition_id, status);
> > > >    		if (ret)
> > > >    			return ret;
> > > >    	} while (!ret);
> > > > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > > > index f4697497f83e..5fc572e31cd7 100644
> > > > --- a/drivers/hv/mshv_root_main.c
> > > > +++ b/drivers/hv/mshv_root_main.c
> > > > @@ -264,8 +264,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
> > > >    		if (!hv_result_oom(status))
> > > >    			ret = hv_result_to_errno(status);
> > > >    		else
> > > > -			ret = hv_call_deposit_pages(NUMA_NO_NODE,
> > > > -						    pt_id, 1);
> > > > +			ret = hv_deposit_memory(pt_id, status);
> > > >    	} while (!ret);
> > > >    	args.status = hv_result(status);
> > > > diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> > > > index b73352a7fc9e..c8e8976839f8 100644
> > > > --- a/include/asm-generic/mshyperv.h
> > > > +++ b/include/asm-generic/mshyperv.h
> > > > @@ -344,6 +344,7 @@ static inline bool hv_parent_partition(void)
> > > >    }
> > > >    bool hv_result_oom(u64 status);
> > > > +int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
> > > >    int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> > > >    int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
> > > >    int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
> > > > @@ -353,6 +354,10 @@ static inline bool hv_root_partition(void) { return false; }
> > > >    static inline bool hv_l1vh_partition(void) { return false; }
> > > >    static inline bool hv_parent_partition(void) { return false; }
> > > >    static inline bool hv_result_oom(u64 status) { return false; }
> > > > +static inline int hv_deposit_memory_node(int node, u64 partition_id, u64 status)
> > > > +{
> > > > +	return -EOPNOTSUPP;
> > > > +}
> > > >    static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> > > >    {
> > > >    	return -EOPNOTSUPP;
> > > > @@ -367,6 +372,11 @@ static inline int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u3
> > > >    }
> > > >    #endif /* CONFIG_MSHV_ROOT */
> > > > +static inline int hv_deposit_memory(u64 partition_id, u64 status)
> > > > +{
> > > > +	return hv_deposit_memory_node(NUMA_NO_NODE, partition_id, status);
> > > > +}
> > > > +
> > > >    #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
> > > >    u8 __init get_vtl(void);
> > > >    #else
> > > > 
> > > > 

