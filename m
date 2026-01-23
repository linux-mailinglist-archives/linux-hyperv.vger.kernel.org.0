Return-Path: <linux-hyperv+bounces-8486-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNdRIiq9c2kmyQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8486-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 19:25:46 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F362D79957
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 19:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 896273017271
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 18:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8735D27B348;
	Fri, 23 Jan 2026 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rj9O+27x"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C21023A99F;
	Fri, 23 Jan 2026 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192739; cv=none; b=B++4FWl+SIYS6BuQe2Hi0Rl96SA5SHghXLgMJJDFaSDGSd0Qw/xorFE/4ur1qz2YsSf0DV2YcdfNkmy7Y42n8LinmbVELCH9rauJ1ltXcGBu+OIDoXoRrua0SrbIEHGM2wfGwpV9W/R6bf1hqv/G7invnVZE+z5WzbfUFjvQq3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192739; c=relaxed/simple;
	bh=AA7yFhYVp9ci2vmPpw6v2etFfGkZiud/rpKUTH3n02M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNMi27ZCb/PMFPKJAcV8g95zIw81D1y8pLu6wQ0ZKRTQOYosS1SFQZ6wefu2cp4Hp5Fq+9qp1snyUUpPhmKrLOnG0jnoX8c+vmxPgbd5czUH8L3bwzt+++RV6Vce4eEKdsOuNYbuSF/abR1dOS3pP966ahWNPubL2c8CQtssUEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rj9O+27x; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.200.94] (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1046020B716A;
	Fri, 23 Jan 2026 10:25:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1046020B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769192737;
	bh=c5e6KHQNxi0zfVxaoY8XkYNiy4vKr9eRDqbXHFKlre4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rj9O+27xqHx44G8G+ZgJSTJd8WaNlkr14SPuNQ3jcmYOILcXTHDjQbS+fXzPZRo30
	 hYrXEXE8WoPwmCzsIMoB+eNwFEuShQJrSebppRXY4JFTpEeKY9sUVqUBgUuprSq4jM
	 iUaQ0NcK6Yx0HC9oQBssLw3jxfHX7Bw+KEzb4KlU=
Message-ID: <eeb79431-47e6-4334-b97a-4dd64474e539@linux.microsoft.com>
Date: Fri, 23 Jan 2026 10:25:36 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 05/15] mshv: Declarations and definitions for VFIO-MSHV
 bridge device
To: Mukesh R <mrathor@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, catalin.marinas@arm.com,
 will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de, mhklinux@outlook.com,
 romank@linux.microsoft.com
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-6-mrathor@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20260120064230.3602565-6-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8486-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,outlook.com,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nunodasneves@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: F362D79957
X-Rspamd-Action: no action

On 1/19/2026 10:42 PM, Mukesh R wrote:
> From: Mukesh Rathor <mrathor@linux.microsoft.com>
> 
> Add data structs needed by the subsequent patch that introduces a new
> module to implement VFIO-MSHV pseudo device.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h    | 23 +++++++++++++++++++++++
>  include/uapi/linux/mshv.h | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index c3753b009fd8..42e1da1d545b 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -220,6 +220,29 @@ struct port_table_info {
>  	};
>  };
>  
> +struct mshv_device {
> +	const struct mshv_device_ops *device_ops;
> +	struct mshv_partition *device_pt;
> +	void *device_private;
> +	struct hlist_node device_ptnode;
> +};
> +
> +struct mshv_device_ops {
> +	const char *device_name;
> +	long (*device_create)(struct mshv_device *dev, u32 type);
> +	void (*device_release)(struct mshv_device *dev);
> +	long (*device_set_attr)(struct mshv_device *dev,
> +				struct mshv_device_attr *attr);
> +	long (*device_has_attr)(struct mshv_device *dev,
> +				struct mshv_device_attr *attr);
> +};
> +
> +extern struct mshv_device_ops mshv_vfio_device_ops;
> +int mshv_vfio_ops_init(void);
> +void mshv_vfio_ops_exit(void);
> +long mshv_partition_ioctl_create_device(struct mshv_partition *partition,
> +					void __user *user_args);
> +
>  int mshv_update_routing_table(struct mshv_partition *partition,
>  			      const struct mshv_user_irq_entry *entries,
>  			      unsigned int numents);
> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index dee3ece28ce5..b7b10f9e2896 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h
> @@ -252,6 +252,7 @@ struct mshv_root_hvcall {
>  #define MSHV_GET_GPAP_ACCESS_BITMAP	_IOWR(MSHV_IOCTL, 0x06, struct mshv_gpap_access_bitmap)
>  /* Generic hypercall */
>  #define MSHV_ROOT_HVCALL		_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcall)
> +#define MSHV_CREATE_DEVICE		_IOWR(MSHV_IOCTL, 0x08, struct mshv_create_device)
>  

With this commit, the IOCTL number is exposed to userspace but it doesn't work.
Ideally the IOCTL number should be added in the commit where it becomes usable.

>  /*
>   ********************************
> @@ -402,4 +403,34 @@ struct mshv_sint_mask {
>  /* hv_hvcall device */
>  #define MSHV_HVCALL_SETUP        _IOW(MSHV_IOCTL, 0x1E, struct mshv_vtl_hvcall_setup)
>  #define MSHV_HVCALL              _IOWR(MSHV_IOCTL, 0x1F, struct mshv_vtl_hvcall)
> +
> +/* device passhthru */
> +#define MSHV_CREATE_DEVICE_TEST		1
> +
> +enum {
> +	MSHV_DEV_TYPE_VFIO,
> +	MSHV_DEV_TYPE_MAX,
> +};
> +
> +struct mshv_create_device {
> +	__u32	type;	     /* in: MSHV_DEV_TYPE_xxx */
> +	__u32	fd;	     /* out: device handle */
> +	__u32	flags;	     /* in: MSHV_CREATE_DEVICE_xxx */
> +};
> +
> +#define MSHV_DEV_VFIO_FILE      1
> +#define MSHV_DEV_VFIO_FILE_ADD	1
> +#define MSHV_DEV_VFIO_FILE_DEL	2
> +
> +struct mshv_device_attr {
> +	__u32	flags;		/* no flags currently defined */
> +	__u32	group;		/* device-defined */
> +	__u64	attr;		/* group-defined */
> +	__u64	addr;		/* userspace address of attr data */
> +};
> +
> +/* Device fds created with MSHV_CREATE_DEVICE */
> +#define MSHV_SET_DEVICE_ATTR	_IOW(MSHV_IOCTL, 0x00, struct mshv_device_attr)
> +#define MSHV_HAS_DEVICE_ATTR	_IOW(MSHV_IOCTL, 0x01, struct mshv_device_attr)
> +
>  #endif


