Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E873F32DDFC
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Mar 2021 00:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhCDXtU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Mar 2021 18:49:20 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45398 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhCDXtS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Mar 2021 18:49:18 -0500
Received: from [10.0.0.178] (c-67-168-106-253.hsd1.wa.comcast.net [67.168.106.253])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2437A20B83EA;
        Thu,  4 Mar 2021 15:49:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2437A20B83EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614901758;
        bh=zpMZL+3uS5Gzr3e47TpLt7Rep9VZwhcyHbt15NTqjKc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hE5bLJ68b8OlrIPu5luShejlRB51fbU4lyxUyhTp13JqrFUC4yaEjcP4RBN2j6ThU
         RkcJqK2A1Vx4XXkX2DF8EES2VZ2X3DIeHakGNGDr3AaqxdglGbNrnsNFIeBqkwxmkb
         vaxjyrbSW1E9f+fRVpRQgEQPrQKKMzWaAMKPpfoc=
Subject: Re: [RFC PATCH 06/18] virt/mshv: create, initialize, finalize, delete
 partition hypercalls
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-7-git-send-email-nunodasneves@linux.microsoft.com>
 <MWHPR21MB1593518130E3E0532894C516D78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
Message-ID: <e6cc796d-f9ee-5203-95a9-05906f95d3f8@linux.microsoft.com>
Date:   Thu, 4 Mar 2021 15:49:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB1593518130E3E0532894C516D78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2/8/2021 11:42 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, November 20, 2020 4:30 PM
>>
>> Add hypercalls for fully setting up and mostly tearing down a guest
>> partition.
>> The teardown operation will generate an error as the deposited
>> memory has not been withdrawn.
>> This is fixed in the next patch.
>>
>> Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  include/asm-generic/hyperv-tlfs.h      |  52 +++++++-
>>  include/uapi/asm-generic/hyperv-tlfs.h |   1 +
>>  include/uapi/linux/mshv.h              |   1 +
>>  virt/mshv/mshv_main.c                  | 169 ++++++++++++++++++++++++-
>>  4 files changed, 220 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
>> index 2ff580780ce4..ab6ae6c164f5 100644
>> --- a/include/asm-generic/hyperv-tlfs.h
>> +++ b/include/asm-generic/hyperv-tlfs.h
>> @@ -142,6 +142,10 @@ struct ms_hyperv_tsc_page {
>>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
>>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>>  #define HVCALL_SEND_IPI_EX			0x0015
>> +#define HVCALL_CREATE_PARTITION			0x0040
>> +#define HVCALL_INITIALIZE_PARTITION		0x0041
>> +#define HVCALL_FINALIZE_PARTITION		0x0042
>> +#define HVCALL_DELETE_PARTITION			0x0043
>>  #define HVCALL_GET_PARTITION_ID			0x0046
>>  #define HVCALL_DEPOSIT_MEMORY			0x0048
>>  #define HVCALL_CREATE_VP			0x004e
>> @@ -451,7 +455,7 @@ struct hv_get_partition_id {
>>  struct hv_deposit_memory {
>>  	u64 partition_id;
>>  	u64 gpa_page_list[];
>> -} __packed;
>> +};
> 
> Why remove __packed?
> 

I change it to match the hyperv structures exactly.
I will re-add __packed here and explicitly lay out all the
structures as you have suggested.

>>
>>  struct hv_proximity_domain_flags {
>>  	u32 proximity_preferred : 1;
>> @@ -767,4 +771,50 @@ struct hv_input_unmap_device_interrupt {
>>  #define HV_SOURCE_SHADOW_NONE               0x0
>>  #define HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE   0x1
>>
>> +#define HV_MAKE_COMPATIBILITY_VERSION(major_, minor_)                          \
>> +	((u32)((major_) << 8 | (minor_)))
>> +
>> +enum hv_compatibility_version {
>> +	HV_COMPATIBILITY_19_H1 = HV_MAKE_COMPATIBILITY_VERSION(0X6, 0X5),
>> +	HV_COMPATIBILITY_MANGANESE = HV_MAKE_COMPATIBILITY_VERSION(0X6, 0X7),
> 
> Avoid use of "Manganese", which is an internal code name.  I'd suggest calling it
> 20_H1 instead, which at least has some broader meaning.
> 
>> +	HV_COMPATIBILITY_PRERELEASE = HV_MAKE_COMPATIBILITY_VERSION(0XFE, 0X0),
>> +	HV_COMPATIBILITY_EXPERIMENT = HV_MAKE_COMPATIBILITY_VERSION(0XFF, 0X0),
>> +};
>> +
>> +union hv_partition_isolation_properties {
>> +	u64 as_uint64;
>> +	struct {
>> +		u64 isolation_type: 5;
>> +		u64 rsvd_z: 7;
>> +		u64 shared_gpa_boundary_page_number: 52;
>> +	};
>> +};
> 
> Add __packed.
> 

Will do.

>> +
>> +/* Non-userspace-visible partition creation flags */
>> +#define HV_PARTITION_CREATION_FLAG_EXO_PARTITION                    BIT(8)
>> +
>> +struct hv_create_partition_in {
>> +	u64 flags;
>> +	union hv_proximity_domain_info proximity_domain_info;
>> +	enum hv_compatibility_version compatibility_version;
> 
> An "enum" is a 32 bit value in gcc and I would presume that
> Hyper-V is expecting a 64 bit value.  In general, using an enum in a data
> structure with exact layout requirements is problematic because the "C"
> language doesn't specify how big an enum is.  In such cases, it's better
> to use an integer field with an explicit size (like u64) and #defines for
> the possible values.
> 

Will do.

>> +	struct hv_partition_creation_properties partition_creation_properties;
>> +	union hv_partition_isolation_properties isolation_properties;
>> +};
>> +
>> +struct hv_create_partition_out {
>> +	u64 partition_id;
>> +};
>> +
>> +struct hv_initialize_partition {
>> +	u64 partition_id;
>> +};
>> +
>> +struct hv_finalize_partition {
>> +	u64 partition_id;
>> +};
>> +
>> +struct hv_delete_partition {
>> +	u64 partition_id;
>> +};
> 
> All of the above should have __packed for consistency with the other
> Hyper-V data structures.
> 

Will do.

>> +
>>  #endif
>> diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-generic/hyperv-
>> tlfs.h
>> index 140cc0b4f98f..7a858226a9c5 100644
>> --- a/include/uapi/asm-generic/hyperv-tlfs.h
>> +++ b/include/uapi/asm-generic/hyperv-tlfs.h
>> @@ -6,6 +6,7 @@
>>  #define BIT(X)	(1ULL << (X))
>>  #endif
>>
>> +/* Userspace-visible partition creation flags */
> 
> Could this comment be included in the earlier patch with the #defines so
> that you avoid the trivial change here?
> 

Yep, will do.

>>  #define HV_PARTITION_CREATION_FLAG_SMT_ENABLED_GUEST                BIT(0)
>>  #define HV_PARTITION_CREATION_FLAG_GPA_LARGE_PAGES_DISABLED         BIT(3)
>>  #define HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED          BIT(4)
>> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
>> index 3788f8bc5caa..4f8da9a6fde2 100644
>> --- a/include/uapi/linux/mshv.h
>> +++ b/include/uapi/linux/mshv.h
>> @@ -9,6 +9,7 @@
>>
>>  #include <linux/types.h>
>>  #include <asm/hyperv-tlfs.h>
>> +#include <asm-generic/hyperv-tlfs.h>
> 
> Similarly, consider adding this #include in the earlier patch so that
> this trivial change isn't needed here.
> 

Will do.

>>
>>  #define MSHV_VERSION	0x0
>>
>> diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
>> index 4dcbe4907430..c4130a6508e5 100644
>> --- a/virt/mshv/mshv_main.c
>> +++ b/virt/mshv/mshv_main.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/file.h>
>>  #include <linux/anon_inodes.h>
>>  #include <linux/mshv.h>
>> +#include <asm/mshyperv.h>
>>
>>  MODULE_AUTHOR("Microsoft");
>>  MODULE_LICENSE("GPL");
>> @@ -31,7 +32,6 @@ static struct mshv mshv = {};
>>  static void mshv_partition_put(struct mshv_partition *partition);
>>  static int mshv_partition_release(struct inode *inode, struct file *filp);
>>  static long mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
>> -
> 
> Spurious whitespace change?
> 

Yes - removed it.

>>  static int mshv_dev_open(struct inode *inode, struct file *filp);
>>  static int mshv_dev_release(struct inode *inode, struct file *filp);
>>  static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
>> @@ -57,6 +57,143 @@ static struct miscdevice mshv_dev = {
>>  	.mode = 600,
>>  };
>>
>> +#define HV_INIT_PARTITION_DEPOSIT_PAGES 208
> 
> A comment about how this value is determined would be useful.
> I'm assuming it was determined empirically.
> 

Correct - I'll add a comment.

>> +
>> +static int
>> +hv_call_create_partition(
>> +		u64 flags,
>> +		struct hv_partition_creation_properties creation_properties,
>> +		u64 *partition_id)
>> +{
>> +	struct hv_create_partition_in *input;
>> +	struct hv_create_partition_out *output;
>> +	int status;
>> +	int ret;
>> +	unsigned long irq_flags;
>> +	int i;
>> +
>> +	do {
>> +		local_irq_save(irq_flags);
>> +		input = (struct hv_create_partition_in *)(*this_cpu_ptr(
>> +			hyperv_pcpu_input_arg));
>> +		output = (struct hv_create_partition_out *)(*this_cpu_ptr(
>> +			hyperv_pcpu_output_arg));
>> +
>> +		input->flags = flags;
>> +		input->proximity_domain_info.as_uint64 = 0;
>> +		input->compatibility_version = HV_COMPATIBILITY_MANGANESE;
>> +		for (i = 0; i < HV_PARTITION_PROCESSOR_FEATURE_BANKS; ++i)
>> +			input->partition_creation_properties
>> +				.disabled_processor_features.as_uint64[i] = 0;
>> +		input->partition_creation_properties
>> +			.disabled_processor_xsave_features.as_uint64 = 0;
>> +		input->isolation_properties.as_uint64 = 0;
>> +
>> +		status = hv_do_hypercall(HVCALL_CREATE_PARTITION,
>> +					 input, output);
> 
> hv_do_hypercall returns a u64, which should then be masked with
> HV_HYPERCALL_RESULT_MASK before checking the result.
> 

Yes, I'll fix this everywhere.

>> +		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
>> +			if (status == HV_STATUS_SUCCESS)
>> +				*partition_id = output->partition_id;
>> +			else
>> +				pr_err("%s: %s\n",
>> +				       __func__, hv_status_to_string(status));
>> +			local_irq_restore(irq_flags);
>> +			ret = -hv_status_to_errno(status);
>> +			break;
>> +		}
>> +		local_irq_restore(irq_flags);
>> +		ret = hv_call_deposit_pages(NUMA_NO_NODE,
>> +					    hv_current_partition_id, 1);
>> +	} while (!ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int
>> +hv_call_initialize_partition(u64 partition_id)
>> +{
>> +	struct hv_initialize_partition *input;
>> +	int status;
>> +	int ret;
>> +	unsigned long flags;
>> +
>> +	ret = hv_call_deposit_pages(
>> +				NUMA_NO_NODE,
>> +				partition_id,
>> +				HV_INIT_PARTITION_DEPOSIT_PAGES);
>> +	if (ret)
>> +		return ret;
>> +
>> +	do {
>> +		local_irq_save(flags);
>> +		input = (struct hv_initialize_partition *)(*this_cpu_ptr(
>> +			hyperv_pcpu_input_arg));
>> +		input->partition_id = partition_id;
>> +
>> +		status = hv_do_hypercall(
>> +				HVCALL_INITIALIZE_PARTITION,
>> +				input, NULL);
> 
> FWIW, since the input is a single 64 bit value, and there's no output,
> this could use hv_do_fast_hypercall8() instead, and avoid
> needing to use the input arg page and the irq save/restore.  Would have
> to check that the particular hypercall supports the "fast" version.
> 

Good idea! I tested it and confirmed it works.

>> +		local_irq_restore(flags);
>> +
>> +		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
> 
> Same comment about status being u64 and masking.
> 

Will do.

>> +			if (status != HV_STATUS_SUCCESS)
>> +				pr_err("%s: %s\n",
>> +				       __func__, hv_status_to_string(status));
>> +			ret = -hv_status_to_errno(status);
>> +			break;
>> +		}
>> +		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
>> +	} while (!ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int
>> +hv_call_finalize_partition(u64 partition_id)
>> +{
>> +	struct hv_finalize_partition *input;
>> +	int status;
>> +	unsigned long flags;
>> +
>> +	local_irq_save(flags);
>> +	input = (struct hv_finalize_partition *)(*this_cpu_ptr(
>> +		hyperv_pcpu_input_arg));
>> +
>> +	input->partition_id = partition_id;
>> +	status = hv_do_hypercall(
>> +			HVCALL_FINALIZE_PARTITION,
>> +			input, NULL);
>> +	local_irq_restore(flags);
> 
> 
> Same comment about hv_do_fast_hypercall8() and about status
> being a u64 and masking.
> 

Will do.

>> +
>> +	if (status != HV_STATUS_SUCCESS)
>> +		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
>> +
>> +	return -hv_status_to_errno(status);
>> +}
>> +
>> +static int
>> +hv_call_delete_partition(u64 partition_id)
>> +{
>> +	struct hv_delete_partition *input;
>> +	int status;
>> +	unsigned long flags;
>> +
>> +	local_irq_save(flags);
>> +	input = (struct hv_delete_partition *)(*this_cpu_ptr(
>> +		hyperv_pcpu_input_arg));
>> +
>> +	input->partition_id = partition_id;
>> +	status = hv_do_hypercall(
>> +			HVCALL_DELETE_PARTITION,
>> +			input, NULL);
>> +	local_irq_restore(flags);
> 
> Same comments about hv_do_fast_hypercall8(), and
> the status and masking.
> 

Will do.

>> +
>> +	if (status != HV_STATUS_SUCCESS)
>> +		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
>> +
>> +	return -hv_status_to_errno(status);
>> +}
>> +
>>  static long
>>  mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>>  {
>> @@ -86,6 +223,17 @@ destroy_partition(struct mshv_partition *partition)
>>
>>  	spin_unlock_irqrestore(&mshv.partitions.lock, flags);
>>
>> +	/*
>> +	 * There are no remaining references to the partition or vps,
>> +	 * so the remaining cleanup can be lockless
>> +	 */
>> +
>> +	/* Deallocates and unmaps everything including vcpus, GPA mappings etc */
>> +	hv_call_finalize_partition(partition->id);
>> +	/* TODO: Withdraw and free all pages we deposited */
>> +
>> +	hv_call_delete_partition(partition->id);
>> +
>>  	kfree(partition);
>>  }
>>
>> @@ -146,6 +294,9 @@ mshv_ioctl_create_partition(void __user *user_arg)
>>  	if (copy_from_user(&args, user_arg, sizeof(args)))
>>  		return -EFAULT;
>>
>> +	/* Only support EXO partitions */
>> +	args.flags |= HV_PARTITION_CREATION_FLAG_EXO_PARTITION;
>> +
>>  	partition = kzalloc(sizeof(*partition), GFP_KERNEL);
>>  	if (!partition)
>>  		return -ENOMEM;
>> @@ -156,11 +307,21 @@ mshv_ioctl_create_partition(void __user *user_arg)
>>  		goto free_partition;
>>  	}
>>
>> +	ret = hv_call_create_partition(args.flags,
>> +				       args.partition_creation_properties,
>> +				       &partition->id);
>> +	if (ret)
>> +		goto put_fd;
>> +
>> +	ret = hv_call_initialize_partition(partition->id);
>> +	if (ret)
>> +		goto delete_partition;
>> +
>>  	file = anon_inode_getfile("mshv_partition", &mshv_partition_fops,
>>  				  partition, O_RDWR);
>>  	if (IS_ERR(file)) {
>>  		ret = PTR_ERR(file);
>> -		goto put_fd;
>> +		goto finalize_partition;
>>  	}
>>  	refcount_set(&partition->ref_count, 1);
>>
>> @@ -174,6 +335,10 @@ mshv_ioctl_create_partition(void __user *user_arg)
>>
>>  release_file:
>>  	file->f_op->release(file->f_inode, file);
>> +finalize_partition:
>> +	hv_call_finalize_partition(partition->id);
>> +delete_partition:
>> +	hv_call_delete_partition(partition->id);
>>  put_fd:
>>  	put_unused_fd(fd);
>>  free_partition:
>> --
>> 2.25.1
