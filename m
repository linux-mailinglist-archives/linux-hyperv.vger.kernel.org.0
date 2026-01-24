Return-Path: <linux-hyperv+bounces-8503-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lK+GNBMUdGk32AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8503-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 01:36:35 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 139CB7BB22
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 01:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57D6A3011F3D
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 00:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B88A1917FB;
	Sat, 24 Jan 2026 00:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZoxJ8N07"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410B9823DD;
	Sat, 24 Jan 2026 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769214991; cv=none; b=T/l/QNQFAnsxX5yO85/TKdXNikMY7rY/Jcg5JxxKhnWMckCeDTKHPHfUhrffgdntawCv1VogsnoZz9YykCoQ12fJxVOWBhHb8fDcztPKEyN/KKnHa1x94SBpx3znmFitOxUiQLIUl47UefDn5pePXxFk6HkJQShF5rQoW05OHkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769214991; c=relaxed/simple;
	bh=4+JcBjsJ3jpNa79nmBtW6xWHGRy+D9IpO6UQvRDNZL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WI3FbZ2BYHY8tOtCq+K0YRa2x/xCoY4J3qzp7Mf3Nf1ayvkDJJbLMl3EhhtLldu3vX+Q1EkWtUKwy30cY9CcZHZBd2SoqRHPU3y/U8s2vAaQUlzyuxFVBcqDx5lJ3ldWFdgqPGpMzIu5s+2yHrzH1Vo7vdYK2M2czjHb2WrjWG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZoxJ8N07; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.32.59] (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id B602120B7167;
	Fri, 23 Jan 2026 16:36:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B602120B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769214989;
	bh=HF5ySjziVuJCs18G6mejhJJ5cTlOU0ca7WYm9uSxPe0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZoxJ8N07WkrIxSZAzIIae4bQSiNO7HPLD4KvNa35tBPT8NdKWZCZ7cXemYe4oebBo
	 YvmpizsnddjeAz767kYSeb6kjB6NVl9oVl7CpmwHKkwcrNh5K3udRmzC/keMmfDxId
	 lnT/vCjzi5p6CdQFjHto94Me8w0OmN2LRaNMWb7Y=
Message-ID: <eb50b355-06f9-c93f-3600-56af4a53f4c0@linux.microsoft.com>
Date: Fri, 23 Jan 2026 16:36:28 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v0 05/15] mshv: Declarations and definitions for VFIO-MSHV
 bridge device
Content-Language: en-US
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, catalin.marinas@arm.com,
 will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de, mhklinux@outlook.com,
 romank@linux.microsoft.com
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-6-mrathor@linux.microsoft.com>
 <eeb79431-47e6-4334-b97a-4dd64474e539@linux.microsoft.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <eeb79431-47e6-4334-b97a-4dd64474e539@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8503-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,outlook.com,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 139CB7BB22
X-Rspamd-Action: no action

On 1/23/26 10:25, Nuno Das Neves wrote:
> On 1/19/2026 10:42 PM, Mukesh R wrote:
>> From: Mukesh Rathor <mrathor@linux.microsoft.com>
>>
>> Add data structs needed by the subsequent patch that introduces a new
>> module to implement VFIO-MSHV pseudo device.
>>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> ---
>>   drivers/hv/mshv_root.h    | 23 +++++++++++++++++++++++
>>   include/uapi/linux/mshv.h | 31 +++++++++++++++++++++++++++++++
>>   2 files changed, 54 insertions(+)
>>
>> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
>> index c3753b009fd8..42e1da1d545b 100644
>> --- a/drivers/hv/mshv_root.h
>> +++ b/drivers/hv/mshv_root.h
>> @@ -220,6 +220,29 @@ struct port_table_info {
>>   	};
>>   };
>>   
>> +struct mshv_device {
>> +	const struct mshv_device_ops *device_ops;
>> +	struct mshv_partition *device_pt;
>> +	void *device_private;
>> +	struct hlist_node device_ptnode;
>> +};
>> +
>> +struct mshv_device_ops {
>> +	const char *device_name;
>> +	long (*device_create)(struct mshv_device *dev, u32 type);
>> +	void (*device_release)(struct mshv_device *dev);
>> +	long (*device_set_attr)(struct mshv_device *dev,
>> +				struct mshv_device_attr *attr);
>> +	long (*device_has_attr)(struct mshv_device *dev,
>> +				struct mshv_device_attr *attr);
>> +};
>> +
>> +extern struct mshv_device_ops mshv_vfio_device_ops;
>> +int mshv_vfio_ops_init(void);
>> +void mshv_vfio_ops_exit(void);
>> +long mshv_partition_ioctl_create_device(struct mshv_partition *partition,
>> +					void __user *user_args);
>> +
>>   int mshv_update_routing_table(struct mshv_partition *partition,
>>   			      const struct mshv_user_irq_entry *entries,
>>   			      unsigned int numents);
>> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
>> index dee3ece28ce5..b7b10f9e2896 100644
>> --- a/include/uapi/linux/mshv.h
>> +++ b/include/uapi/linux/mshv.h
>> @@ -252,6 +252,7 @@ struct mshv_root_hvcall {
>>   #define MSHV_GET_GPAP_ACCESS_BITMAP	_IOWR(MSHV_IOCTL, 0x06, struct mshv_gpap_access_bitmap)
>>   /* Generic hypercall */
>>   #define MSHV_ROOT_HVCALL		_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcall)
>> +#define MSHV_CREATE_DEVICE		_IOWR(MSHV_IOCTL, 0x08, struct mshv_create_device)
>>   
> 
> With this commit, the IOCTL number is exposed to userspace but it doesn't work.
> Ideally the IOCTL number should be added in the commit where it becomes usable.
> 


Correct, I switched it because the next patch won't compile without it as
it needs the declarations here. It could be combined into one big patch,
but I think normally one would not expect full functionality until the
release is certified to be that feature compliant anyways. Hope that
makes sense.

Thanks,
-Mukesh




>>   /*
>>    ********************************
>> @@ -402,4 +403,34 @@ struct mshv_sint_mask {
>>   /* hv_hvcall device */
>>   #define MSHV_HVCALL_SETUP        _IOW(MSHV_IOCTL, 0x1E, struct mshv_vtl_hvcall_setup)
>>   #define MSHV_HVCALL              _IOWR(MSHV_IOCTL, 0x1F, struct mshv_vtl_hvcall)
>> +
>> +/* device passhthru */
>> +#define MSHV_CREATE_DEVICE_TEST		1
>> +
>> +enum {
>> +	MSHV_DEV_TYPE_VFIO,
>> +	MSHV_DEV_TYPE_MAX,
>> +};
>> +
>> +struct mshv_create_device {
>> +	__u32	type;	     /* in: MSHV_DEV_TYPE_xxx */
>> +	__u32	fd;	     /* out: device handle */
>> +	__u32	flags;	     /* in: MSHV_CREATE_DEVICE_xxx */
>> +};
>> +
>> +#define MSHV_DEV_VFIO_FILE      1
>> +#define MSHV_DEV_VFIO_FILE_ADD	1
>> +#define MSHV_DEV_VFIO_FILE_DEL	2
>> +
>> +struct mshv_device_attr {
>> +	__u32	flags;		/* no flags currently defined */
>> +	__u32	group;		/* device-defined */
>> +	__u64	attr;		/* group-defined */
>> +	__u64	addr;		/* userspace address of attr data */
>> +};
>> +
>> +/* Device fds created with MSHV_CREATE_DEVICE */
>> +#define MSHV_SET_DEVICE_ATTR	_IOW(MSHV_IOCTL, 0x00, struct mshv_device_attr)
>> +#define MSHV_HAS_DEVICE_ATTR	_IOW(MSHV_IOCTL, 0x01, struct mshv_device_attr)
>> +
>>   #endif


