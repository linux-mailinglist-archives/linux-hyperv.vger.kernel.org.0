Return-Path: <linux-hyperv+bounces-10833-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCa2EfFzBGprIQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10833-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 14:52:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE1D53359F
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 14:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEF3C307E66A
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 12:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2977F40F8ED;
	Wed, 13 May 2026 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDpIoc5Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05626360EF1;
	Wed, 13 May 2026 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676087; cv=none; b=J0Rcc4K06yFNNrBag8Awy8wbORhMcCqVMf0xLpbqo51798SDYa4PlyDcwG4P8/eksccDy+8jLkdJhVUDmWcKEMt+fXJY9Bz7qd7aOwLcaiOLchofzKORfJeNPJivEjMlteLXOBF6iqNY7FYBGBKQcMfB2XyQmvyiWuOZLh0B/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676087; c=relaxed/simple;
	bh=vH2mzStKt1hov8XZrortvHdz5QEOqNQPNbfe69Mz8Qc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VUcIpVdnke2Xi8i/5GMfagsWTArvud7AOOlKR2UXODKCBACmJQW4iWJSiw+he1Wt0ec4qgNpeA/Pcck7IPDREpGdMxttW2RWAmvcLD1N9pyJKYVFB72qCh0BI3OTfrfTfFbW4XhTncT0otm2f3vtQDlXSx3NubFJqcDFZnIbKwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDpIoc5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2EAC2BCB7;
	Wed, 13 May 2026 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778676086;
	bh=vH2mzStKt1hov8XZrortvHdz5QEOqNQPNbfe69Mz8Qc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nDpIoc5ZJndZCLVpCp9mrnweAmEcFduOkP1OZjT2RZqYI7Jbg23BdgQVTvK60/M13
	 rUVQnq7sFo5KJKc1FBxqtf2mxdTX9twS7I6cFdK1d+PS1hoyzd8qD+r0IsitpfeL9y
	 LmxgNk8s/Q+JgM/JcwIMkcIlXWe3HFlH4F7FYRWEMylt2vIjol7RILntoSC4rpt9QN
	 ZVmTB2r87FUPf3IxvwWvYXhTUcsmqJf83Ua4jrMgEgc4raHTBeH5FQRo33P5luW5fw
	 f2mzOT+aLds34n4zIIRgaBgeaNZM8fIUSmJHtslpzGtAP2FZQfeUa60i85Fq/MXZAX
	 QHgT1ulTSVcKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 09/11] x86/hyperv: Implement Hyper-V virtual IOMMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260512020259.1678627-10-mrathor@linux.microsoft.com>
References: <20260512020259.1678627-10-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 12:41:25 +0000
Message-Id: <20260513124126.7D2EAC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 9FE1D53359F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10833-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [Critical] `hv_iommu_unmap_pages` makes a rep hypercall but ignores the c=
ompletion count, leaving pages permanently mapped.
- [Critical] Integer truncation in `hv_iommu_unmap_pages` causes incomplete=
 hardware unmapping.
- [Critical] Global `unique_id` data race leads to IOMMU domain collisions =
and cross-VM DMA sharing.
- [High] The `sscanf` return value check in `hv_iommu_probe_device` breaks =
the loop on success instead of failure.
- [High] Partial unmaps corrupt the interval tree state, desynchronizing ha=
rdware and software.
- [High] Unsafe interval tree iteration leads to skipped nodes during remov=
al.
- [High] Memory leak of interval tree nodes on domain free.
- [High] Ignoring `gfp` flags causes premature OOM and risks sleeping in at=
omic context.
- [Medium] Missing NULL check on `mapped` pointer in fast path.
- [Low] The `__setup` handlers violate the API by returning 0.
--

commit 4a3c258bcace1805e7afe537c6eb3e451a6fd030
Author: Mukesh R <mrathor@linux.microsoft.com>

x86/hyperv: Implement Hyper-V virtual IOMMU

Add a new file to implement management of device domains, mapping and
unmapping of IOMMU memory, and other iommu_ops to fit within the VFIO
framework for PCI passthru on Hyper-V running Linux as baremetal root
or L1VH root.

> diff --git a/drivers/iommu/hyperv-iommu-root.c b/drivers/iommu/hyperv-iom=
mu-root.c
> new file mode 100644
> index 0000000000000..a2e0f6cc78e66
> --- /dev/null
> +++ b/drivers/iommu/hyperv-iommu-root.c

[ ... ]

> +static char *pci_devs_to_skip;
> +static int __init hv_iommu_setup_skip(char *str)
> +{
> +	pci_devs_to_skip =3D str;
> +
> +	return 0;
> +}

Should this return 1 instead of 0? Returning 0 causes the kernel to print an
unknown command line parameters warning and passes the parameters to the in=
it
process.

> +/* hv_iommu_skip=3D(SSSS:BB:DD.F)(SSSS:BB:DD.F) */
> +__setup("hv_iommu_skip=3D", hv_iommu_setup_skip);
> +
> +bool hv_no_attdev;	 /* disable direct device attach for passthru */
> +EXPORT_SYMBOL_GPL(hv_no_attdev);
> +static int __init setup_hv_no_attdev(char *str)
> +{
> +	hv_no_attdev =3D true;
> +	return 0;
> +}

Should this also return 1 instead of 0 to indicate the parameter was handle=
d?

[ ... ]

> +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *=
dev)
> +{
> +	struct hv_domain *hvdom;
> +	int rc;

[ ... ]

> +	/* Called under iommu group mutex, so single threaded */
> +	if (++unique_id =3D=3D HV_DEVICE_DOMAIN_ID_S2_NULL)   /* ie, UINTMAX */
> +		goto out_err;

Can this increment of unique_id race if called concurrently?

iommu_domain_alloc() can be called by subsystems without holding global or
group locks. If multiple allocations race, it could assign identical domid_=
num
values to different domains, which might place them in the same S2 domain.

[ ... ]

> +static void hv_iommu_domain_free(struct iommu_domain *immdom)
> +{
> +	struct hv_domain *hvdom =3D to_hv_domain(immdom);
> +	unsigned long flags;
> +	u64 status;
> +	struct hv_input_delete_device_domain *input;
> +
> +	if (hv_special_domain(hvdom))
> +		return;
> +
> +	if (!hv_dom_owner_is_vmm(hvdom) || hv_no_attdev) {

[ ... ]

> +	}
> +
> +	kfree(hvdom);
> +}

Does this code leak the interval tree nodes?

It looks like the remaining struct hv_iommu_mapping nodes in
hvdom->mappings_tree are not freed before kfree(hvdom).

[ ... ]

> +static int hv_iommu_add_tree_mapping(struct hv_domain *hvdom,
> +				     unsigned long iova, phys_addr_t paddr,
> +				     size_t size, u32 flags)
> +{
> +	unsigned long irqflags;
> +	struct hv_iommu_mapping *mapping;
> +
> +	mapping =3D kzalloc(sizeof(*mapping), GFP_ATOMIC);

Should this use the gfp flag passed into hv_iommu_map_pages() instead of
GFP_ATOMIC? It might avoid failing prematurely under memory pressure when t=
he
caller can sleep.

[ ... ]

> +static size_t hv_iommu_del_tree_mappings(struct hv_domain *hvdom,
> +					unsigned long iova, size_t size)
> +{
> +	unsigned long flags;
> +	size_t unmapped =3D 0;
> +	unsigned long last =3D iova + size - 1;
> +	struct hv_iommu_mapping *mapping =3D NULL;
> +	struct interval_tree_node *node, *next;
> +
> +	spin_lock_irqsave(&hvdom->mappings_lock, flags);
> +	next =3D interval_tree_iter_first(&hvdom->mappings_tree, iova, last);
> +	while (next) {
> +		node =3D next;
> +		mapping =3D container_of(node, struct hv_iommu_mapping, iova);
> +		next =3D interval_tree_iter_next(node, iova, last);
> +
> +		/* Trying to split a mapping? Not supported for now. */
> +		if (mapping->iova.start < iova)
> +			break;

Does breaking out early here leave stale mappings in the tree?

If the target region is unmapped in hardware, the tracking node would remai=
n,
causing stale lookups. Also, if unmapping the head of a mapping, is the
entire node deleted even though the tail is still mapped?

> +
> +		unmapped +=3D mapping->iova.last - mapping->iova.start + 1;
> +
> +		interval_tree_remove(node, &hvdom->mappings_tree);

Can erasing the node corrupt the iteration?

Since interval_tree_remove() rebalances the tree and alters parent pointers,
calling interval_tree_iter_next(next) on the next loop iteration might skip
overlapping nodes.

[ ... ]

> +static int hv_iommu_map_pages(struct iommu_domain *immdom, ulong iova,
> +			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
> +			      int prot, gfp_t gfp, size_t *mapped)
> +{
> +	u32 map_flags;
> +	int ret;
> +	u64 status;
> +	unsigned long npages, done =3D 0;
> +	struct hv_domain *hvdom =3D to_hv_domain(immdom);
> +	size_t size =3D pgsize * pgcount;
> +
> +	map_flags =3D HV_MAP_GPA_READABLE;	/* required */
> +	map_flags |=3D prot & IOMMU_WRITE ? HV_MAP_GPA_WRITABLE : 0;
> +
> +	ret =3D hv_iommu_add_tree_mapping(hvdom, iova, paddr, size, map_flags);
> +	if (ret)
> +		return ret;
> +
> +	if (hvdom->attached_dom) {
> +		*mapped =3D size;
> +		return 0;
> +	}

Is it possible for mapped to be NULL here?

The fast path assigns to *mapped without validating the pointer, while later
in the function there are defensive checks like if (mapped).

[ ... ]

> +		if (hv_result(status) =3D=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			ret =3D hv_call_deposit_pages(NUMA_NO_NODE,
> +						    hv_current_partition_id,
> +						    256);

Could this trigger a sleeping in atomic context bug?

hv_call_deposit_pages() typically performs sleepable allocations, but the
caller of hv_iommu_map_pages() might have provided a non-sleeping gfp flag
which was not forwarded.

[ ... ]

> +static size_t hv_iommu_unmap_pages(struct iommu_domain *immdom, ulong io=
va,
> +				   size_t pgsize, size_t pgcount,
> +				   struct iommu_iotlb_gather *gather)
> +{
> +	unsigned long flags, npages;
> +	struct hv_input_unmap_device_gpa_pages *input;
> +	u64 status;
> +	struct hv_domain *hvdom =3D to_hv_domain(immdom);
> +	size_t unmapped, size =3D pgsize * pgcount;

[ ... ]

> +	npages =3D size >> HV_HYP_PAGE_SHIFT;
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	input->device_domain.partition_id =3D HV_PARTITION_ID_SELF;
> +	input->device_domain.domain_id.type =3D HV_DEVICE_DOMAIN_TYPE_S2;
> +	input->device_domain.domain_id.id =3D hvdom->domid_num;
> +	input->target_device_va_base =3D iova;
> +
> +	status =3D hv_do_rep_hypercall(HVCALL_UNMAP_DEVICE_GPA_PAGES, npages,
> +				     0, input, NULL);

Can npages be truncated here?

The hypercall parameter rep_count in hv_do_rep_hypercall() expects a u16.
If npages is >=3D 65536, it would be silently truncated, causing incomplete
unmapping in the hardware.

Does this also need a loop to handle partial completions?

hv_do_rep_hypercall() might only partially complete. Since the completion c=
ount
from hv_repcomp(status) is ignored, remaining pages could be left fully
mapped in the hardware.

[ ... ]

> +static struct iommu_device *hv_iommu_probe_device(struct device *dev)
> +{
> +	if (!dev_is_pci(dev))
> +		return ERR_PTR(-ENODEV);
> +
> +	if (pci_devs_to_skip && *pci_devs_to_skip) {
> +		int rc, pos =3D 0;
> +		int parsed;
> +		int segment, bus, slot, func;
> +		struct pci_dev *pdev =3D to_pci_dev(dev);
> +
> +		do {
> +			parsed =3D 0;
> +
> +			rc =3D sscanf(pci_devs_to_skip + pos, " (%x:%x:%x.%x) %n",
> +				    &segment, &bus, &slot, &func, &parsed);
> +			if (rc)
> +				break;

Should this check for failure instead of success?

sscanf() returns the number of successfully matched items. If it succeeds, =
rc
will be 4, causing the loop to break prematurely without checking the parsed
values against the device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512020259.1678=
627-1-mrathor@linux.microsoft.com?part=3D9

