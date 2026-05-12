Return-Path: <linux-hyperv+bounces-10801-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBxPJx0CA2pczgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10801-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 12:34:05 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A656F51EA88
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 12:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2AC9302CFCD
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 10:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2270732E696;
	Tue, 12 May 2026 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GqBzrPrA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F13395ADE;
	Tue, 12 May 2026 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581620; cv=none; b=LNPOGU+PuSRitjCp2SAlD9+T6sUgv4ZPJ+35Y7DHUlSrhurVVnv+iexZu1vCv0928NaLVfsjaeEW9gZ83PvswOudzesOH8U6mOQWjCFgwpOL4cy9mvgrpwr14rwzbluudqDqtAdWnLkyo+aOnTvzjsLvBCCSSZObn5SR7LdrjXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581620; c=relaxed/simple;
	bh=fpCfDhlI+6Y1Y4HK/f0puB8Zw3bUPFUedBGlK81FWnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H68HJ944ADowuvLAX2PvfOj8pDNdIpOHdRoGxbYqVW96Nxg4TpXDW379DYSo6sElMWgYHdrCHiksZf22m59znw+rckEfv6aVWIfd3l2GklRJNIUY7AecR4t+VVQqDhHChV273YXHW1Fl+GDEFCPqnj3obEswO/MVcmMPakMi5ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GqBzrPrA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id A11C120B7166; Tue, 12 May 2026 03:26:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A11C120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778581616;
	bh=YMpG9/qTFc7d8S8pCm2AKjUdxYbHAlU955g+3UalODA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GqBzrPrAFHUtANfe7YisZ8Q9TtyKX8KJ8zL+At03sOPAkh/0QY2+xM1z5ooDfYkFM
	 5/IZrS5jxRfjl4cxQYZmEQ4f1pf+k2p0NzUcwdgx4jtUxje/1C8h3hMg1EDb86x0mo
	 8Y5qUY6lTzkogDUK5/DqYJj+qhqevNkoARvIZq8Y=
Date: Tue, 12 May 2026 03:26:56 -0700
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V3 04/11] mshv: Declarations and definitions for
 VFIO-MSHV bridge device
Message-ID: <agMAcF4E1kmflQ4/@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
 <20260512020259.1678627-5-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512020259.1678627-5-mrathor@linux.microsoft.com>
X-Rspamd-Queue-Id: A656F51EA88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10801-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zytor.com,arm.com,kernel.org,outlook.com,microsoft.com,linux.microsoft.com,vger.kernel.org,lists.linux.dev,redhat.com,alien8.de,linux.intel.com,8bytes.org,google.com,arndb.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schakrabarti@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 07:02:52PM -0700, Mukesh R wrote:
> Add data structs needed by the subsequent patch that introduces a new
> module to implement VFIO-MSHV pseudo device.
> 
Reviewed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h    | 19 +++++++++++++++++++
>  include/uapi/linux/mshv.h | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index a85c24dcc701..b9880d0bdc4d 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -227,6 +227,25 @@ struct port_table_info {
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
> +	long (*device_create)(struct mshv_device *dev);
> +	void (*device_release)(struct mshv_device *dev);
> +	long (*device_set_attr)(struct mshv_device *dev,
> +				struct mshv_device_attr *attr);
> +	long (*device_has_attr)(struct mshv_device *dev,
> +				struct mshv_device_attr *attr);
> +};
> +
> +extern struct mshv_device_ops mshv_vfio_device_ops;
> +
>  int mshv_update_routing_table(struct mshv_partition *partition,
>  			      const struct mshv_user_irq_entry *entries,
>  			      unsigned int numents);
> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index 32ff92b6342b..be6fe3ee8707 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h
> @@ -404,4 +404,34 @@ struct mshv_sint_mask {
>  /* hv_hvcall device */
>  #define MSHV_HVCALL_SETUP        _IOW(MSHV_IOCTL, 0x1E, struct mshv_vtl_hvcall_setup)
>  #define MSHV_HVCALL              _IOWR(MSHV_IOCTL, 0x1F, struct mshv_vtl_hvcall)
> +
> +/* Device passhthru */
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
> -- 
> 2.51.2.vfs.0.1
> 

