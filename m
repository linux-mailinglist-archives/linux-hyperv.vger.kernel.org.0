Return-Path: <linux-hyperv+bounces-8494-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBtbAQ7kc2mjzQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8494-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 22:11:42 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7D37AD57
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 22:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0791730157F1
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 21:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B41829993D;
	Fri, 23 Jan 2026 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AAmMAhRw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE5E2EDD7E;
	Fri, 23 Jan 2026 21:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769202670; cv=none; b=ZvRwrN4IZHKBbtxX2UbAoeqU7LRW8zx6IKzpP/kJZoEId0oRINs1j12OkmtG8rqYoOx6wc4DOsQos/maer1/gHqQlwAvTQEP0HLPdiy9QXln/XkCglADcJhJKY7xS1eHTUyckovUuy8QpL0KV8xWuruOVa9xAZhq7YFk/eSvZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769202670; c=relaxed/simple;
	bh=Ah0HTGPFOAHAsT3PmPy1BghC57MUghFexACaHL5RHXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRAKCcUKKLcUAKzlyvNOjkHf2iVaSurjsLKVXbl1VinhBcCGdulu/ItJheU43ed7RO/zWa22Dylq3n5QGZuneSl+kgU4RDGPDmfbczf2CFANssuaDHAyhms+XFYF+n356Jnu8hk/cWEH1r95RO95Mxu+r8Yy5lQbg/1dN0eaHOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AAmMAhRw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.216.129] (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0D44820B7167;
	Fri, 23 Jan 2026 13:11:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D44820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769202667;
	bh=hgoyTCSPRbxUztTzn4rdatkWnsopi6t4GHg1emnmUjk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AAmMAhRwKtiCCovleDMiGtW/NfnwFOdhzzY72DG+QBJGd7P5pOwccY+Xz0RC31r3y
	 m0gpuNzkJABCvCB6/bGoimfiCpEdZ/e8EnancZ1tw2dcoHnUUMAHGF4wcSljFDkbJF
	 crCz63H6DHrFsCj5HtQEZMq4u9YN4hRae55LG360=
Message-ID: <467e1b51-e335-4280-befa-adc2cf283ab5@linux.microsoft.com>
Date: Fri, 23 Jan 2026 13:11:06 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] mshv: Add debugfs to view hypervisor statistics
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "longli@microsoft.com" <longli@microsoft.com>,
 "prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "paekkaladevi@linux.microsoft.com" <paekkaladevi@linux.microsoft.com>,
 Jinank Jain <jinankjain@microsoft.com>
References: <20260121214623.76374-1-nunodasneves@linux.microsoft.com>
 <20260121214623.76374-8-nunodasneves@linux.microsoft.com>
 <SN6PR02MB415765A8221B8F6270ACEF1DD494A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415765A8221B8F6270ACEF1DD494A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8494-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,vger.kernel.org,linux.microsoft.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nunodasneves@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB7D37AD57
X-Rspamd-Action: no action

On 1/23/2026 9:09 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, January 21, 2026 1:46 PM
>>
>> Introduce a debugfs interface to expose root and child partition stats
>> when running with mshv_root.
>>
>> Create a debugfs directory "mshv" containing 'stats' files organized by
>> type and id. A stats file contains a number of counters depending on
>> its type. e.g. an excerpt from a VP stats file:
>>
>> TotalRunTime                  : 1997602722
>> HypervisorRunTime             : 649671371
>> RemoteNodeRunTime             : 0
>> NormalizedRunTime             : 1997602721
>> IdealCpu                      : 0
>> HypercallsCount               : 1708169
>> HypercallsTime                : 111914774
>> PageInvalidationsCount        : 0
>> PageInvalidationsTime         : 0
>>
>> On a root partition with some active child partitions, the entire
>> directory structure may look like:
>>
>> mshv/
>>   stats             # hypervisor stats
>>   lp/               # logical processors
>>     0/              # LP id
>>       stats         # LP 0 stats
>>     1/
>>     2/
>>     3/
>>   partition/        # partition stats
>>     1/              # root partition id
>>       stats         # root partition stats
>>       vp/           # root virtual processors
>>         0/          # root VP id
>>           stats     # root VP 0 stats
>>         1/
>>         2/
>>         3/
>>     42/             # child partition id
>>       stats         # child partition stats
>>       vp/           # child VPs
>>         0/          # child VP id
>>           stats     # child VP 0 stats
>>         1/
>>     43/
>>     55/
>>
>> On L1VH, some stats are not present as it does not own the hardware
>> like the root partition does:
>> - The hypervisor and lp stats are not present
>> - L1VH's partition directory is named "self" because it can't get its
>>   own id
>> - Some of L1VH's partition and VP stats fields are not populated, because
>>   it can't map its own HV_STATS_AREA_PARENT page.
>>
>> Co-developed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>> Co-developed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
>> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
>> Co-developed-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> Co-developed-by: Purna Pavan Chandra Aekkaladevi
>> <paekkaladevi@linux.microsoft.com>
>> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>> Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
>> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>> ---
>>  drivers/hv/Makefile         |   1 +
>>  drivers/hv/hv_counters.c    |   1 +
>>  drivers/hv/hv_synic.c       | 177 +++++++++
> 
> This new file hv_synic.c seems to be spurious.  It looks like you unintentionally
> picked up this new file from the build tree where you were creating the patches
> for this series.
> 

Oh, that's embarrassing! Yes, it's a half-baked, unrelated work-in-progress...
Please ignore!

<snip>
>> diff --git a/drivers/hv/mshv_debugfs.c b/drivers/hv/mshv_debugfs.c
>> new file mode 100644
>> index 000000000000..72eb0ae44e4b
>> --- /dev/null
>> +++ b/drivers/hv/mshv_debugfs.c
>> @@ -0,0 +1,703 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2026, Microsoft Corporation.
>> + *
>> + * The /sys/kernel/debug/mshv directory contents.
>> + * Contains various statistics data, provided by the hypervisor.
>> + *
>> + * Authors: Microsoft Linux virtualization team
>> + */
>> +
>> +#include <linux/debugfs.h>
>> +#include <linux/stringify.h>
>> +#include <asm/mshyperv.h>
>> +#include <linux/slab.h>
>> +
>> +#include "mshv.h"
>> +#include "mshv_root.h"
>> +
>> +#include "hv_counters.c"
>> +
>> +#define U32_BUF_SZ 11
>> +#define U64_BUF_SZ 21
>> +#define NUM_STATS_AREAS (HV_STATS_AREA_PARENT + 1)
> 
> This is sort of weak in that it doesn't really guard against
> changes in the enum that defines HV_STATS_AREA_PARENT.
> It would work if it were defined as part of the enum, but then
> you are changing the code coming from the Windows world,
> which I know is a different problem.
> 
> The enum is part of the hypervisor ABI and hence isn't likely to
> change, but it still feels funny to define NUM_STATS_AREAS like
> this. I would suggest dropping this and just using
> HV_STATS_AREA_COUNT for the memory allocations even
> though doing so will allocate space for a stats area pointer
> that isn't used by this code. It's only a few bytes.
> 

That would work, but then I'd want to have a comment explaining
that the decision is intentional, otherwise I think it's just as
confusing to have unexplained wasted space.

Alternatively, the usage of SELF and PARENT (but not INTERNAL)
could be made explicit by a compile-time check, and a comment to
clarify:

/* Only support SELF and PARENT areas */
#define NUM_STATS_AREAS 2
static_assert(HV_STATS_AREA_SELF == 0 && HV_STATS_AREA_PARENT == 1,
	      "SELF and PARENT areas must be usable as indices into an array of size NUM_STATS_AREAS")

>> +
>> +static struct dentry *mshv_debugfs;
>> +static struct dentry *mshv_debugfs_partition;
>> +static struct dentry *mshv_debugfs_lp;
>> +static struct dentry **parent_vp_stats;
>> +static struct dentry *parent_partition_stats;
>> +
>> +static u64 mshv_lps_count;
>> +static struct hv_stats_page **mshv_lps_stats;
>> +
>> +static int lp_stats_show(struct seq_file *m, void *v)
>> +{
>> +	const struct hv_stats_page *stats = m->private;
>> +	struct hv_counter_entry *entry = hv_lp_counters;
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(hv_lp_counters); i++, entry++)
>> +		seq_printf(m, "%-29s: %llu\n", entry->name,
>> +			   stats->data[entry->idx]);
>> +
>> +	return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(lp_stats);
>> +
>> +static void mshv_lp_stats_unmap(u32 lp_index)
>> +{
>> +	union hv_stats_object_identity identity = {
>> +		.lp.lp_index = lp_index,
>> +		.lp.stats_area_type = HV_STATS_AREA_SELF,
>> +	};
>> +	int err;
>> +
>> +	err = hv_unmap_stats_page(HV_STATS_OBJECT_LOGICAL_PROCESSOR,
>> +				  mshv_lps_stats[lp_index], &identity);
>> +	if (err)
>> +		pr_err("%s: failed to unmap logical processor %u stats, err: %d\n",
>> +		       __func__, lp_index, err);
> 
> Perhaps set mshv_lps_stats[lp_index] to NULL?  I don't think it's actually
> required, but similar code later in this file sets some pointers to NULL
> just as good hygiene.
> 

Good idea, I'll do that.

>> +}
>> +
<snip>
>> +
>> +static int __init mshv_debugfs_lp_create(struct dentry *parent)
>> +{
>> +	struct dentry *lp_dir;
>> +	int err, lp_index;
>> +
>> +	mshv_lps_stats = kcalloc(mshv_lps_count,
>> +				 sizeof(*mshv_lps_stats),
>> +				 GFP_KERNEL_ACCOUNT);
>> +
>> +	if (!mshv_lps_stats)
>> +		return -ENOMEM;
>> +
>> +	lp_dir = debugfs_create_dir("lp", parent);
>> +	if (IS_ERR(lp_dir)) {
>> +		err = PTR_ERR(lp_dir);
>> +		goto free_lp_stats;
>> +	}
>> +
>> +	for (lp_index = 0; lp_index < mshv_lps_count; lp_index++) {
>> +		err = lp_debugfs_create(lp_index, lp_dir);
>> +		if (err)
>> +			goto remove_debugfs_lps;
>> +	}
>> +
>> +	mshv_debugfs_lp = lp_dir;
>> +
>> +	return 0;
>> +
>> +remove_debugfs_lps:
>> +	for (lp_index -= 1; lp_index >= 0; lp_index--)
>> +		mshv_lp_stats_unmap(lp_index);
>> +	debugfs_remove_recursive(lp_dir);
>> +free_lp_stats:
>> +	kfree(mshv_lps_stats);
> 
> Set mshv_lps_stats to NULL?
> 

Agreed, thanks.

>> +
>> +	return err;
>> +}
>> +
<snip>
>> +
>> +static void mshv_debugfs_parent_partition_remove(void)
>> +{
>> +	int idx;
>> +
>> +	for_each_online_cpu(idx)
>> +		parent_vp_debugfs_remove(idx,
> 
> The first parameter here ("idx") should be translated through the
> hv_vp_index[] array like is done in mshv_debugfs_parent_partition_create().
> 

Ok, thanks

>> +					 parent_vp_stats[idx]);
>> +
>> +	partition_debugfs_remove(hv_current_partition_id,
>> +				 parent_partition_stats);
>> +	kfree(parent_vp_stats);
>> +	parent_vp_stats = NULL;
>> +	parent_partition_stats = NULL;
>> +
> 
> Extra blank line.
> 

Ack

>> +}
>> +
>> +static int __init parent_vp_debugfs_create(u32 vp_index,
>> +					   struct dentry **vp_stats_ptr,
>> +					   struct dentry *parent)
>> +{
>> +	struct hv_stats_page **pstats;
>> +	int err;
>> +
>> +	pstats = kcalloc(2, sizeof(struct hv_stats_page *), GFP_KERNEL_ACCOUNT);
> 
> Another case of using "2" that should be changed.
>

Ack

>> +	if (!pstats)
>> +		return -ENOMEM;
>> +
>> +	err = mshv_vp_stats_map(hv_current_partition_id, vp_index, pstats);
>> +	if (err)
>> +		goto cleanup;
>> +
>> +	err = vp_debugfs_create(hv_current_partition_id, vp_index, pstats,
>> +				vp_stats_ptr, parent);
>> +	if (err)
>> +		goto unmap_vp_stats;
>> +
>> +	return 0;
>> +
>> +unmap_vp_stats:
>> +	mshv_vp_stats_unmap(hv_current_partition_id, vp_index, pstats);
>> +cleanup:
>> +	kfree(pstats);
>> +	return err;
>> +}
>> +
>> +static int __init mshv_debugfs_parent_partition_create(void)
>> +{
>> +	struct dentry *vp_dir;
>> +	int err, idx, i;
>> +
>> +	mshv_debugfs_partition = debugfs_create_dir("partition",
>> +						     mshv_debugfs);
>> +	if (IS_ERR(mshv_debugfs_partition))
>> +		return PTR_ERR(mshv_debugfs_partition);
>> +
>> +	err = partition_debugfs_create(hv_current_partition_id,
>> +				       &vp_dir,
>> +				       &parent_partition_stats,
>> +				       mshv_debugfs_partition);
>> +	if (err)
>> +		goto remove_debugfs_partition;
>> +
>> +	parent_vp_stats = kcalloc(num_possible_cpus(),
> 
> num_possible_cpus() should not be used to allocate an array that is
> then indexed by the Linux CPU number. Use nr_cpu_ids instead when
> allocating the array. See commit 16b18fdf6bc7 for the full explanation.
> As explained in that commit message, using num_possible_cpus()
> doesn't break things now, but it might in the future.
> 
Thanks, will do

>> +				  sizeof(*parent_vp_stats),
>> +				  GFP_KERNEL);
>> +	if (!parent_vp_stats) {
>> +		err = -ENOMEM;
>> +		goto remove_debugfs_partition;
>> +	}
>> +
>> +	for_each_online_cpu(idx) {
>> +		err = parent_vp_debugfs_create(hv_vp_index[idx],
>> +					       &parent_vp_stats[idx],
>> +					       vp_dir);
>> +		if (err)
>> +			goto remove_debugfs_partition_vp;
>> +	}
>> +
>> +	return 0;
>> +
>> +remove_debugfs_partition_vp:
>> +	for_each_online_cpu(i) {
>> +		if (i >= idx)
>> +			break;
>> +		parent_vp_debugfs_remove(i, parent_vp_stats[i]);
>> +	}
>> +	partition_debugfs_remove(hv_current_partition_id,
>> +				 parent_partition_stats);
>> +
>> +	kfree(parent_vp_stats);
>> +	parent_vp_stats = NULL;
>> +	parent_partition_stats = NULL;
>> +
>> +remove_debugfs_partition:
>> +	debugfs_remove_recursive(mshv_debugfs_partition);
>> +	mshv_debugfs_partition = NULL;
>> +	return err;
>> +}
>> +
>> +static int hv_stats_show(struct seq_file *m, void *v)
>> +{
>> +	const struct hv_stats_page *stats = m->private;
>> +	struct hv_counter_entry *entry = hv_hypervisor_counters;
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(hv_hypervisor_counters); i++, entry++)
>> +		seq_printf(m, "%-25s: %llu\n", entry->name,
>> +			   stats->data[entry->idx]);
>> +
>> +	return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(hv_stats);
>> +
>> +static void mshv_hv_stats_unmap(void)
>> +{
>> +	union hv_stats_object_identity identity = {
>> +		.hv.stats_area_type = HV_STATS_AREA_SELF,
>> +	};
>> +	int err;
>> +
>> +	err = hv_unmap_stats_page(HV_STATS_OBJECT_HYPERVISOR, NULL, &identity);
>> +	if (err)
>> +		pr_err("%s: failed to unmap hypervisor stats: %d\n",
>> +		       __func__, err);
>> +}
>> +
>> +static void * __init mshv_hv_stats_map(void)
>> +{
>> +	union hv_stats_object_identity identity = {
>> +		.hv.stats_area_type = HV_STATS_AREA_SELF,
>> +	};
>> +	struct hv_stats_page *stats;
>> +	int err;
>> +
>> +	err = hv_map_stats_page(HV_STATS_OBJECT_HYPERVISOR, &identity, &stats);
>> +	if (err) {
>> +		pr_err("%s: failed to map hypervisor stats: %d\n",
>> +		       __func__, err);
>> +		return ERR_PTR(err);
>> +	}
>> +	return stats;
>> +}
>> +
>> +static int __init mshv_debugfs_hv_stats_create(struct dentry *parent)
>> +{
>> +	struct dentry *dentry;
>> +	u64 *stats;
>> +	int err;
>> +
>> +	stats = mshv_hv_stats_map();
>> +	if (IS_ERR(stats))
>> +		return PTR_ERR(stats);
>> +
>> +	dentry = debugfs_create_file("stats", 0400, parent,
>> +				     stats, &hv_stats_fops);
>> +	if (IS_ERR(dentry)) {
>> +		err = PTR_ERR(dentry);
>> +		pr_err("%s: failed to create hypervisor stats dentry: %d\n",
>> +		       __func__, err);
>> +		goto unmap_hv_stats;
>> +	}
>> +
>> +	mshv_lps_count = num_present_cpus();
> 
> This method of setting mshv_lps_count, and the iteration through the lp_index
> in mshv_debugfs_lp_create() and mshv_debugfs_lp_remove(), seems risky. The
> lp_index gets passed to the hypervisor, so it must be the hypervisor's concept
> of the lp_index. Is that always guaranteed to be the same as Linux's numbering
> of the present CPUs? There may be edge cases where it is not. For example, what
> if Linux in the root partition were booted with the "nosmt" kernel boot option,
> such that Linux ignores all the 2nd hyper-threads in a core? Could that create
> a numbering mismatch?
> 

Ah, this was using the hypervisor stats page before; HvLogicalProcessors. But
I removed the enum, so I thought this would be a reasonable way to get the number
of LPs, but I think I'm mistaken.

For context, there is a fix to how LP and VP numbers are assigned in
hv_smp_prepare_cpus(), but it's part of a future patchset. That fix ensures the
LP indices are dense. The code looks like:

	/* create dense LPs from 0-N for all apicids */
        i = next_smallest_apicid(apicids, 0);
        for (lpidx = 1; i != INT_MAX; lpidx++) {
                node = __apicid_to_node[i];
                if (node == NUMA_NO_NODE)
                        node = 0;

                /* params: node num, lp index, apic id */
                ret = hv_call_add_logical_proc(node, lpidx, i);
                BUG_ON(ret);

                i = next_smallest_apicid(apicids, i);
        }

	/* create a VP for each present CPU */
        lpidx = 1;         /* skip BSP cpu 0 */
        for_each_present_cpu(i) {
                if (i == 0)
                        continue;

                /* params: node num, domid, vp index, lp index */
                ret = hv_call_create_vp(numa_cpu_node(i),
                                        hv_current_partition_id, lpidx, lpidx);
                BUG_ON(ret);
                lpidx++;
        }

For what it's worth, with that fix^ I tested with "nosmt" and things worked as I
would expect: All LPs were displayed in debugfs, but every second LP was not in
use by Linux, as evidenced by e.g. the number of timer interrupts not going up:
LpTimerInterrupts            : 1

Also, only every second VP was created (0, 2, 4, 6...) since the others aren't
in the present mask at boot.

> Note that for vp_index, we have the hv_vp_index[] array for translating from
> Linux's concept of a CPU number to Hyper-V's concept of vp_index. For
> example, mshv_debugfs_parent_partition_create() correctly goes through
> this translation. And presumably when the VMM code does the
> MSHV_CREATE_VP ioctl, it is passing in a hypervisor vp_index.
> 
> Everything may work fine "as is" for the moment, but the lp functions here
> are still conflating the hypervisor's LP numbering with Linux's CPU numbering,
> and that seems like a recipe for trouble somewhere down the road. I'm
> not sure how the hypervisor interprets the "lp_index" part of the identity
> argument passed to a hypercall, so I'm not sure what the fix is.
> 

The simplest thing for now might be to bring back that enum value
HvLogicalProcessors just for this one usage. I'll admit I'm not familiar with
all the nuances here so there are still probably edge cases here.

>> +
>> +	return 0;
>> +
>> +unmap_hv_stats:
>> +	mshv_hv_stats_unmap();
>> +	return err;
>> +}
>> +
<snip>


