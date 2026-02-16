Return-Path: <linux-hyperv+bounces-8860-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGRCIKzvkmkQ0QEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8860-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Feb 2026 11:21:32 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B351424AC
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Feb 2026 11:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF749300D9C2
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Feb 2026 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6CC2FF66A;
	Mon, 16 Feb 2026 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYhbhwdq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4856F2FF662;
	Mon, 16 Feb 2026 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771237289; cv=none; b=emtUdY6/d+Y5VnDz1dRbTufyu6oe1h4lLLrnjLJQSYGU+aROPnlBjlLWY0TbB13ftIDoZLINfScMHId1Y/eQZ0kqW6L8PSAEbstBZ4LQesKvFFJQVoAEpSCBRbhdlYGn/mUzB/BJrHtAh8h7vHR51V+CdB8DMHvybugn01Mf4G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771237289; c=relaxed/simple;
	bh=AqcJYYhoZiLH9/qC47tS0hwSwiE+8F8U0vB5G6d3sjY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L7fGPYS3GPsJ9qADBDnRs+OW/VCbl4yL7+3XVpzzGeI5tOP+eUxdhCkXvvyRFpNfrv5K1CKfeSFXwWyQSXeralqjx+DhKOFpAHtXL0NML31sVK8RleDdnHG7pw4x7BWQaooVskE4kLY03DxN1tddTLfEhVVaRs9OBfWbNAu1RAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYhbhwdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C9AC116C6;
	Mon, 16 Feb 2026 10:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771237289;
	bh=AqcJYYhoZiLH9/qC47tS0hwSwiE+8F8U0vB5G6d3sjY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gYhbhwdqokbqxomREfRkfsl2Ee4QXmAzybiLDmHqS9NXXIwmqDLTA91zdbhIXBSQM
	 AwIBx/6/Rn2FJ+/9RR27xr9aEBGU6IJQAoHG8yfztqmuHtGGwxUbzoHz4mIUKVX8Jz
	 PbRDCeBbb0HzsIoGrBvyGM2qDfDDggxP18AfkYgnQhzQKujpiA88pdA5y7mRdLLnC9
	 SwHrmwiipBB4+q+FCDO3IIPoZF8VreIEWn/2jdYjAJQzq+IlZfTWiGrcJJH3Gfgt1B
	 NUs2rhcXCB/9CYW6ImEmQqjDJv6fCcgSbu4HGMzkNfLAkz7y0vjfWkbiJsgzKYUjA3
	 E77It8IjtF6gw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Tianyu Lan <ltykernel@gmail.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>
Cc: Tianyu Lan <tiala@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hch@infradead.org" <hch@infradead.org>,
	"vdso@hexbites.dev" <vdso@hexbites.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [RFC PATCH V2] x86/VMBus: Confidential VMBus for dynamic DMA
 buffer transition
In-Reply-To: <cc4dc4a6-2d74-49c1-bbb0-cfa44802a66b@arm.com>
References: <20260210162107.2270823-1-ltykernel@gmail.com>
 <SN6PR02MB41577FB84EC73E48ABAC7D18D463A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <cc4dc4a6-2d74-49c1-bbb0-cfa44802a66b@arm.com>
Date: Mon, 16 Feb 2026 15:51:24 +0530
Message-ID: <yq5a5x7xq997.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[arm.com,outlook.com,gmail.com,microsoft.com,kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8860-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aneesh.kumar@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,openvmm.dev:url]
X-Rspamd-Queue-Id: E2B351424AC
X-Rspamd-Action: no action

Robin Murphy <robin.murphy@arm.com> writes:

> On 2026-02-11 6:00 pm, Michael Kelley wrote:
>> From: Tianyu Lan <ltykernel@gmail.com> Sent: Tuesday, February 10, 2026 =
8:21 AM
>>>
>>> Hyper-V provides Confidential VMBus to communicate between
>>> device model and device guest driver via encrypted/private
>>> memory in Confidential VM. The device model is in OpenHCL
>>> (https://openvmm.dev/guide/user_guide/openhcl.html) that
>>> plays the paravisor rule.
>>>
>>> For a VMBUS device, there are two communication methods to
>>=20
>> s/VMBUS/VMBus/
>>=20
>>> talk with Host/Hypervisor. 1) VMBus Ring buffer 2) dynamic
>>> DMA transition.
>>=20
>> I'm not sure what "dynamic DMA transition" is. Maybe just
>> "DMA transfers"?  Also, do the same substitution further
>> down in this commit message.
>>=20
>>> The Confidential VMBus Ring buffer has been
>>> upstreamed by Roman Kisel(commit 6802d8af).
>>=20
>> It's customary to use 12 character commit IDs, which would be
>> 6802d8af47d1 in this case.
>>=20
>>>
>>> The dynamic DMA transition of VMBus device normally goes
>>> through DMA core and it uses SWIOTLB as bounce buffer in
>>> CVM
>>=20
>> "CVM" is Microsoft-speak. The Linux terminology is "a CoCo VM".
>>=20
>>> to communicate with Host/Hypervisor. The Confidential
>>> VMBus device may use private/encrypted memory to do DMA
>>> and so the device swiotlb(bounce buffer) isn't necessary.
>>=20
>> The phrase "isn't necessary" does not capture the real issue
>> here. Saying "isn't necessary" makes it sound like this patch is
>> just avoids unnecessary work, so that it is a performance
>> improvement. But that's not the case.
>>=20
>> The real issue is that swiotlb memory is decrypted. So bouncing
>> through the swiotlb exposes to the host what is supposed to be
>> confidential data passed on the Confidential VMBus. Disabling
>> the swiotlb bouncing in this case is a hard requirement to preserve
>> confidentially.
>
> Yeah, this really isn't a Hyper-V problem. Indeed as things stand,=20
> "swiotlb=3Dforce" could potentially break confidentiality for any=20
> environment trying to invent a notion of private DMA, and perhaps we=20
> could throw a big warning about that, but really the answer there is=20
> "Don't run your confidential workload with 'swiotlb=3Dforce'. Why would=20
> you even do that? Debug your drivers in a regular VM or bare-metal with=20
> full debug visibility like a normal person..."
>
> The fact is we do not have a proper notion of trusted/private DMA yet,=20
> and this is not the way to add it. The current assumption is very much=20
> that all DMA is untrusted in the CoCo sense, because initially it was=20
> only virtual devices emulated by a hypervisor, thus had to be bounced=20
> through shared memory anyway. AMD SEV with a stage 1 IOMMU in the guest=20
> can allow an assigned physical device to access a suitably-aligned=20
> encrypted buffer directly, but that's still effectively just putting the=
=20
> buffer into a temporarily shared state for that device, it merely skips=20
> sharing it with the rest of the system. !force_dma_unencrypted() doesn't=
=20
> mean "we trust this device's DMA", it just means "we don't have to use=20
> explicitly-decrypted pages to accommodate untrusted/shared DMA here",=20
> plus it also serves double-duty for host encryption which doesn't share=20
> the same trust model anyway.
>
> I assumed this would follow the TDISP stuff, but if Hyper-V has an=20
> alternative device-trusting mechanism already then there's no need to=20
> wait. We want some common device property (likely consolidating the=20
> current PCI external-facing port notion of trustedness plus whatever=20
> TDISP wants), with which we can then make proper decisions in all the=20
> right DMA API paths - and if it can end up replacing the horrible=20
> force_dma_unencrypted() as well then all the better! I'd totally=20
> forgotten about the previous discussion that Michael referred to (which=20
> I had to track down[1]), but it looks like all the main points were=20
> already covered there and we were approaching a consensus, so really I=20
> guess someone just needs to give it a go.
>

With my device-assignment=E2=80=93related changes, I have made the following
update. It may be a slightly stronger requirement to enforce that=20
trusted device cannot use SWIOTLB, but it simplifies the overall design.
I also have a prototype, that added two default swiotlb, ie,

static struct io_tlb_mem io_tlb_default_mem;
static struct io_tlb_mem io_tlb_default_shared_mem;

Looking at that change, I would suggest we avoid doing this unless we
are certain that there is a requirement for a trusted device to use
SWIOTLB bouncing.

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index b27de03f2466..07ef149bd9fc 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -292,6 +292,9 @@ bool swiotlb_free(struct device *dev, struct page *page=
, size_t size);
=20
 static inline bool is_swiotlb_for_alloc(struct device *dev)
 {
+       if (device_cc_accepted(dev))
+               return false;
+
        return dev->dma_io_tlb_mem->for_alloc;
 }
 #else
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 34fe14b987f0..a89a7ac07499 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -159,6 +159,14 @@ static struct page *__dma_direct_alloc_pages(struct de=
vice *dev, size_t size,
  */
 static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
 {
+       /*
+        * Atomic pools are marked decrypted and are used if we require req=
uire
+        * updation of pfn mem encryption attributes or for DMA non-coherent
+        * device allocation. Both is not true for trusted device.
+        */
+       if (device_cc_accepted(dev))
+               return false;
+
        return !gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);
 }
=20
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index a862712f4dc6..6d9f0c869c6f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1643,6 +1643,9 @@ bool is_swiotlb_active(struct device *dev)
 {
        struct io_tlb_mem *mem =3D dev->dma_io_tlb_mem;
=20
+       if (device_cc_accepted(dev))
+               return false;
+
        return mem && mem->nslabs;
 }

