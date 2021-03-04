Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090C832D992
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Mar 2021 19:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhCDSpj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Mar 2021 13:45:39 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35904 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhCDSpU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Mar 2021 13:45:20 -0500
Received: from [10.0.0.178] (c-67-168-106-253.hsd1.wa.comcast.net [67.168.106.253])
        by linux.microsoft.com (Postfix) with ESMTPSA id C457D20B83EA;
        Thu,  4 Mar 2021 10:44:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C457D20B83EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614883480;
        bh=bMYdGdlT9rjckz9lt8hiSrSMtcxEoJuBhRamoWn6pOg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TDiStr375hCfXexh72rfmMlUy70v37eJEHsH+kCtJeCrxH+BWskqE5b050B8dk15Z
         kXoHPXA+QY9nv7Iqvn0dvkI4p8dJSKFnO8QMUZ+2dAhFCelFDVCG3RRiNXQrDK8nko
         XpuKEnxByMGiUgCvWEidhUGeI0fram5fDM+tjtrc=
Subject: Re: [RFC PATCH 05/18] virt/mshv: create partition ioctl
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-hyperv@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, ligrassi@microsoft.com, kys@microsoft.com
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-6-git-send-email-nunodasneves@linux.microsoft.com>
 <87v9b1mlfn.fsf@vitty.brq.redhat.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
Message-ID: <63ff92ed-5fb8-df3c-cd42-d636cf8972c5@linux.microsoft.com>
Date:   Thu, 4 Mar 2021 10:44:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <87v9b1mlfn.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2/9/2021 5:15 AM, Vitaly Kuznetsov wrote:
> Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:
> 
>> Add MSHV_CREATE_PARTITION, which creates an fd to track a new partition.
>> Partition is not yet created in the hypervisor itself.
>> Introduce header files for userspace-facing hyperv structures.
>>
>> Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  Documentation/virt/mshv/api.rst         |  12 ++
>>  arch/x86/include/asm/hyperv-tlfs.h      |   1 +
>>  arch/x86/include/uapi/asm/hyperv-tlfs.h | 124 ++++++++++++++++
>>  include/asm-generic/hyperv-tlfs.h       |   1 +
>>  include/linux/mshv.h                    |  16 +++
>>  include/uapi/asm-generic/hyperv-tlfs.h  |  14 ++
>>  include/uapi/linux/mshv.h               |   7 +
>>  virt/mshv/mshv_main.c                   | 179 +++++++++++++++++++++---
>>  8 files changed, 338 insertions(+), 16 deletions(-)
>>  create mode 100644 arch/x86/include/uapi/asm/hyperv-tlfs.h
>>  create mode 100644 include/uapi/asm-generic/hyperv-tlfs.h
>>
>> diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
>> index 82e32de48d03..ce651a1738e0 100644
>> --- a/Documentation/virt/mshv/api.rst
>> +++ b/Documentation/virt/mshv/api.rst
>> @@ -39,6 +39,9 @@ root partition can use mshv APIs to create guest partitions.
>>  
>>  The module is named mshv and can be configured with CONFIG_HYPERV_ROOT_API.
>>  
>> +The uapi header files you need are linux/mshv.h, asm/hyperv-tlfs.h, and
>> +asm-generic/hyperv-tlfs.h.
>> +
>>  Mshv is file descriptor-based, following a similar pattern to KVM.
>>  
>>  To get a handle to the mshv driver, use open("/dev/mshv").
>> @@ -60,3 +63,12 @@ if one of them matches.
>>  This /dev/mshv file descriptor will remain 'locked' to that version as long as
>>  it is open - this ioctl can only be called once per open.
>>  
>> +3.2 MSHV_CREATE_PARTITION
>> +-------------------------
>> +:Type: /dev/mshv ioctl
>> +:Parameters: struct mshv_create_partition
>> +:Returns: partition file descriptor, or -1 on failure
>> +
>> +This ioctl creates a guest partition, returning a file descriptor to use as a
>> +handle for partition ioctls.
>> +
>> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
>> index 592c75e51e0f..4cd44ae9bffb 100644
>> --- a/arch/x86/include/asm/hyperv-tlfs.h
>> +++ b/arch/x86/include/asm/hyperv-tlfs.h
>> @@ -11,6 +11,7 @@
>>  
>>  #include <linux/types.h>
>>  #include <asm/page.h>
>> +#include <uapi/asm/hyperv-tlfs.h>
>>  /*
>>   * The below CPUID leaves are present if VersionAndFeatures.HypervisorPresent
>>   * is set by CPUID(HvCpuIdFunctionVersionAndFeatures).
>> diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h b/arch/x86/include/uapi/asm/hyperv-tlfs.h
>> new file mode 100644
>> index 000000000000..72150c25ffe6
>> --- /dev/null
>> +++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
>> @@ -0,0 +1,124 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +#ifndef _UAPI_ASM_X86_HYPERV_TLFS_USER_H
>> +#define _UAPI_ASM_X86_HYPERV_TLFS_USER_H
>> +
>> +#include <linux/types.h>
>> +
>> +#define HV_PARTITION_PROCESSOR_FEATURE_BANKS 2
>> +
>> +union hv_partition_processor_features {
>> +	struct {
>> +		__u64 sse3_support:1;
>> +		__u64 lahf_sahf_support:1;
>> +		__u64 ssse3_support:1;
>> +		__u64 sse4_1_support:1;
>> +		__u64 sse4_2_support:1;
>> +		__u64 sse4a_support:1;
>> +		__u64 xop_support:1;
>> +		__u64 pop_cnt_support:1;
>> +		__u64 cmpxchg16b_support:1;
>> +		__u64 altmovcr8_support:1;
>> +		__u64 lzcnt_support:1;
>> +		__u64 mis_align_sse_support:1;
>> +		__u64 mmx_ext_support:1;
>> +		__u64 amd3dnow_support:1;
>> +		__u64 extended_amd3dnow_support:1;
>> +		__u64 page_1gb_support:1;
>> +		__u64 aes_support:1;
>> +		__u64 pclmulqdq_support:1;
>> +		__u64 pcid_support:1;
>> +		__u64 fma4_support:1;
>> +		__u64 f16c_support:1;
>> +		__u64 rd_rand_support:1;
>> +		__u64 rd_wr_fs_gs_support:1;
>> +		__u64 smep_support:1;
>> +		__u64 enhanced_fast_string_support:1;
>> +		__u64 bmi1_support:1;
>> +		__u64 bmi2_support:1;
>> +		__u64 hle_support_deprecated:1;
>> +		__u64 rtm_support_deprecated:1;
>> +		__u64 movbe_support:1;
>> +		__u64 npiep1_support:1;
>> +		__u64 dep_x87_fpu_save_support:1;
>> +		__u64 rd_seed_support:1;
>> +		__u64 adx_support:1;
>> +		__u64 intel_prefetch_support:1;
>> +		__u64 smap_support:1;
>> +		__u64 hle_support:1;
>> +		__u64 rtm_support:1;
>> +		__u64 rdtscp_support:1;
>> +		__u64 clflushopt_support:1;
>> +		__u64 clwb_support:1;
>> +		__u64 sha_support:1;
>> +		__u64 x87_pointers_saved_support:1;
>> +		__u64 invpcid_support:1;
>> +		__u64 ibrs_support:1;
>> +		__u64 stibp_support:1;
>> +		__u64 ibpb_support: 1;
>> +		__u64 unrestricted_guest_support:1;
>> +		__u64 mdd_support:1;
>> +		__u64 fast_short_rep_mov_support:1;
>> +		__u64 l1dcache_flush_support:1;
>> +		__u64 rdcl_no_support:1;
>> +		__u64 ibrs_all_support:1;
>> +		__u64 skip_l1df_support:1;
>> +		__u64 ssb_no_support:1;
>> +		__u64 rsb_a_no_support:1;
>> +		__u64 virt_spec_ctrl_support:1;
>> +		__u64 rd_pid_support:1;
>> +		__u64 umip_support:1;
>> +		__u64 mbs_no_support:1;
>> +		__u64 mb_clear_support:1;
>> +		__u64 taa_no_support:1;
>> +		__u64 tsx_ctrl_support:1;
>> +		/*
>> +		 * N.B. The final processor feature bit in bank 0 is reserved to
>> +		 * simplify potential downlevel backports.
>> +		 */
>> +		__u64 reserved_bank0:1;
>> +
>> +		/* N.B. Begin bank 1 processor features. */
>> +		__u64 acount_mcount_support:1;
>> +		__u64 tsc_invariant_support:1;
>> +		__u64 cl_zero_support:1;
>> +		__u64 rdpru_support:1;
>> +		__u64 la57_support:1;
>> +		__u64 mbec_support:1;
>> +		__u64 nested_virt_support:1;
>> +		__u64 psfd_support:1;
>> +		__u64 cet_ss_support:1;
>> +		__u64 cet_ibt_support:1;
>> +		__u64 vmx_exception_inject_support:1;
>> +		__u64 enqcmd_support:1;
>> +		__u64 umwait_tpause_support:1;
>> +		__u64 movdiri_support:1;
>> +		__u64 movdir64b_support:1;
>> +		__u64 cldemote_support:1;
>> +		__u64 serialize_support:1;
>> +		__u64 tsc_deadline_tmr_support:1;
>> +		__u64 tsc_adjust_support:1;
>> +		__u64 fzlrep_movsb:1;
>> +		__u64 fsrep_stosb:1;
>> +		__u64 fsrep_cmpsb:1;
>> +		__u64 reserved_bank1:42;
>> +	};
>> +	__u64 as_uint64[HV_PARTITION_PROCESSOR_FEATURE_BANKS];
>> +};
>> +
>> +union hv_partition_processor_xsave_features {
>> +	struct {
>> +		__u64 xsave_support : 1;
>> +		__u64 xsaveopt_support : 1;
>> +		__u64 avx_support : 1;
>> +		__u64 reserved1 : 61;
>> +	};
>> +	__u64 as_uint64;
>> +};
>> +
>> +struct hv_partition_creation_properties {
>> +	union hv_partition_processor_features disabled_processor_features;
>> +	union hv_partition_processor_xsave_features
>> +		disabled_processor_xsave_features;
>> +};
>> +
>> +#endif
>> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
>> index 05b9dc9896ab..2ff580780ce4 100644
>> --- a/include/asm-generic/hyperv-tlfs.h
>> +++ b/include/asm-generic/hyperv-tlfs.h
>> @@ -12,6 +12,7 @@
>>  #include <linux/types.h>
>>  #include <linux/bits.h>
>>  #include <linux/time64.h>
>> +#include <uapi/asm-generic/hyperv-tlfs.h>
>>  
>>  /*
>>   * While not explicitly listed in the TLFS, Hyper-V always runs with a page size
>> diff --git a/include/linux/mshv.h b/include/linux/mshv.h
>> index a0982fe2c0b8..fc4f35089b2c 100644
>> --- a/include/linux/mshv.h
>> +++ b/include/linux/mshv.h
>> @@ -6,6 +6,22 @@
>>   * Microsoft Hypervisor root partition driver for /dev/mshv
>>   */
>>  
>> +#include <linux/spinlock.h>
>>  #include <uapi/linux/mshv.h>
>>  
>> +#define MSHV_MAX_PARTITIONS		128
>> +
>> +struct mshv_partition {
>> +	u64 id;
>> +	refcount_t ref_count;
>> +};
>> +
>> +struct mshv {
>> +	struct {
>> +		spinlock_t lock;
>> +		u64 count;
>> +		struct mshv_partition *array[MSHV_MAX_PARTITIONS];
>> +	} partitions;
>> +};
>> +
>>  #endif
>> diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-generic/hyperv-tlfs.h
>> new file mode 100644
>> index 000000000000..140cc0b4f98f
>> --- /dev/null
>> +++ b/include/uapi/asm-generic/hyperv-tlfs.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +#ifndef _UAPI_ASM_GENERIC_HYPERV_TLFS_USER_H
>> +#define _UAPI_ASM_GENERIC_HYPERV_TLFS_USER_H
>> +
>> +#ifndef BIT
>> +#define BIT(X)	(1ULL << (X))
>> +#endif
>> +
>> +#define HV_PARTITION_CREATION_FLAG_SMT_ENABLED_GUEST                BIT(0)
>> +#define HV_PARTITION_CREATION_FLAG_GPA_LARGE_PAGES_DISABLED         BIT(3)
>> +#define HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED          BIT(4)
>> +#define HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED                    BIT(13)
>> +
>> +#endif
>> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
>> index dd30fc2f0a80..3788f8bc5caa 100644
>> --- a/include/uapi/linux/mshv.h
>> +++ b/include/uapi/linux/mshv.h
>> @@ -8,12 +8,19 @@
>>   */
>>  
>>  #include <linux/types.h>
>> +#include <asm/hyperv-tlfs.h>
>>  
>>  #define MSHV_VERSION	0x0
>>  
>> +struct mshv_create_partition {
>> +	__u64 flags;
>> +	struct hv_partition_creation_properties partition_creation_properties;
>> +};
>> +
>>  #define MSHV_IOCTL 0xB8
>>  
>>  /* mshv device */
>>  #define MSHV_REQUEST_VERSION	_IOW(MSHV_IOCTL, 0x00, __u32)
>> +#define MSHV_CREATE_PARTITION	_IOW(MSHV_IOCTL, 0x01, struct mshv_create_partition)
>>  
>>  #endif
>> diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
>> index 62f631f85301..4dcbe4907430 100644
>> --- a/virt/mshv/mshv_main.c
>> +++ b/virt/mshv/mshv_main.c
>> @@ -12,6 +12,8 @@
>>  #include <linux/fs.h>
>>  #include <linux/miscdevice.h>
>>  #include <linux/slab.h>
>> +#include <linux/file.h>
>> +#include <linux/anon_inodes.h>
>>  #include <linux/mshv.h>
>>  
>>  MODULE_AUTHOR("Microsoft");
>> @@ -24,6 +26,161 @@ static u32 supported_versions[] = {
>>  	MSHV_CURRENT_VERSION,
>>  };
>>  
>> +static struct mshv mshv = {};
>> +
>> +static void mshv_partition_put(struct mshv_partition *partition);
>> +static int mshv_partition_release(struct inode *inode, struct file *filp);
>> +static long mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
>> +
>> +static int mshv_dev_open(struct inode *inode, struct file *filp);
>> +static int mshv_dev_release(struct inode *inode, struct file *filp);
>> +static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
>> +
>> +static const struct file_operations mshv_partition_fops = {
>> +	.release = mshv_partition_release,
>> +	.unlocked_ioctl = mshv_partition_ioctl,
>> +	.llseek = noop_llseek,
>> +};
>> +
>> +static const struct file_operations mshv_dev_fops = {
>> +	.owner = THIS_MODULE,
>> +	.open = mshv_dev_open,
>> +	.release = mshv_dev_release,
>> +	.unlocked_ioctl = mshv_dev_ioctl,
>> +	.llseek = noop_llseek,
>> +};
>> +
>> +static struct miscdevice mshv_dev = {
>> +	.minor = MISC_DYNAMIC_MINOR,
>> +	.name = "mshv",
>> +	.fops = &mshv_dev_fops,
>> +	.mode = 600,
>> +};
>> +
>> +static long
>> +mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>> +{
>> +	return -ENOTTY;
>> +}
>> +
>> +static void
>> +destroy_partition(struct mshv_partition *partition)
>> +{
>> +	unsigned long flags;
>> +	int i;
>> +
>> +	/* Remove from list of partitions */
>> +	spin_lock_irqsave(&mshv.partitions.lock, flags);
>> +
>> +	for (i = 0; i < MSHV_MAX_PARTITIONS; ++i) {
>> +		if (mshv.partitions.array[i] == partition)
>> +			break;
>> +	}
>> +
>> +	if (i == MSHV_MAX_PARTITIONS) {
>> +		pr_err("%s: failed to locate partition in array\n", __func__);
>> +	} else {
>> +		mshv.partitions.count--;
>> +		mshv.partitions.array[i] = NULL;
>> +	}
>> +
>> +	spin_unlock_irqrestore(&mshv.partitions.lock, flags);
>> +
>> +	kfree(partition);
>> +}
>> +
>> +static void
>> +mshv_partition_put(struct mshv_partition *partition)
>> +{
>> +	if (refcount_dec_and_test(&partition->ref_count))
>> +		destroy_partition(partition);
>> +}
>> +
>> +static int
>> +mshv_partition_release(struct inode *inode, struct file *filp)
>> +{
>> +	struct mshv_partition *partition = filp->private_data;
>> +
>> +	mshv_partition_put(partition);
>> +
>> +	return 0;
>> +}
>> +
>> +static int
>> +add_partition(struct mshv_partition *partition)
>> +{
>> +	unsigned long flags;
>> +	int i, ret = 0;
>> +
>> +	spin_lock_irqsave(&mshv.partitions.lock, flags);
>> +
>> +	if (mshv.partitions.count >= MSHV_MAX_PARTITIONS) {
>> +		pr_err("%s: too many partitions\n", __func__);
>> +		ret = -ENOSPC;
>> +		goto out_unlock;
>> +	}
>> +
>> +	for (i = 0; i < MSHV_MAX_PARTITIONS; ++i) {
>> +		if (!mshv.partitions.array[i])
>> +			break;
>> +	}
>> +
>> +	mshv.partitions.count++;
>> +	mshv.partitions.array[i] = partition;
>> +
>> +out_unlock:
>> +	spin_unlock_irqrestore(&mshv.partitions.lock, flags);
>> +
>> +	return ret;
>> +}
>> +
>> +static long
>> +mshv_ioctl_create_partition(void __user *user_arg)
>> +{
>> +	struct mshv_create_partition args;
>> +	struct mshv_partition *partition;
>> +	struct file *file;
>> +	int fd;
>> +	long ret;
>> +
>> +	if (copy_from_user(&args, user_arg, sizeof(args)))
>> +		return -EFAULT;
>> +
>> +	partition = kzalloc(sizeof(*partition), GFP_KERNEL);
>> +	if (!partition)
>> +		return -ENOMEM;
>> +
>> +	fd = get_unused_fd_flags(O_CLOEXEC);
>> +	if (fd < 0) {
>> +		ret = fd;
>> +		goto free_partition;
>> +	}
>> +
>> +	file = anon_inode_getfile("mshv_partition", &mshv_partition_fops,
>> +				  partition, O_RDWR);
>> +	if (IS_ERR(file)) {
>> +		ret = PTR_ERR(file);
>> +		goto put_fd;
>> +	}
>> +	refcount_set(&partition->ref_count, 1);
>> +
>> +	ret = add_partition(partition);
>> +	if (ret)
>> +		goto release_file;
>> +
>> +	fd_install(fd, file);
>> +
>> +	return fd;
>> +
>> +release_file:
>> +	file->f_op->release(file->f_inode, file);
>> +put_fd:
>> +	put_unused_fd(fd);
>> +free_partition:
>> +	kfree(partition);
>> +	return ret;
>> +}
>> +
>>  static long
>>  mshv_ioctl_request_version(u32 *version, void __user *user_arg)
>>  {
>> @@ -59,7 +216,10 @@ mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>>  	if (*version == MSHV_INVALID_VERSION)
>>  		return -EBADFD;
>>  
>> -	/* TODO other ioctls */
>> +	switch (ioctl) {
>> +	case MSHV_CREATE_PARTITION:
>> +		return mshv_ioctl_create_partition((void __user *)arg);
>> +	}
>>  
>>  	return -ENOTTY;
>>  }
>> @@ -82,21 +242,6 @@ mshv_dev_release(struct inode *inode, struct file *filp)
>>  	return 0;
>>  }
>>  
>> -static const struct file_operations mshv_dev_fops = {
>> -	.owner = THIS_MODULE,
>> -	.open = mshv_dev_open,
>> -	.release = mshv_dev_release,
>> -	.unlocked_ioctl = mshv_dev_ioctl,
>> -	.llseek = noop_llseek,
>> -};
>> -
>> -static struct miscdevice mshv_dev = {
>> -	.minor = MISC_DYNAMIC_MINOR,
>> -	.name = "mshv",
>> -	.fops = &mshv_dev_fops,
>> -	.mode = 600,
>> -};
>> -
> 
> This looks like an unneeded code churn as these structs just got added a
> few patches ago. It would probably be possible to put it to the right
> place from the very beginning so you don't need to move it in this
> patch.
> 

Agreed

>>  static int
>>  __init mshv_init(void)
>>  {
>> @@ -106,6 +251,8 @@ __init mshv_init(void)
>>  	if (r)
>>  		pr_err("%s: misc device register failed\n", __func__);
>>  
>> +	spin_lock_init(&mshv.partitions.lock);
>> +
>>  	return r;
>>  }
> 
