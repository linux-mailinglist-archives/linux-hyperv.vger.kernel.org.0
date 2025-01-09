Return-Path: <linux-hyperv+bounces-3652-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E384A08284
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 22:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FC83A6F27
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 21:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6A1204F7A;
	Thu,  9 Jan 2025 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVyXVzSE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA90204C35;
	Thu,  9 Jan 2025 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459813; cv=none; b=E6uTdVdWZ1++14qmJ0RJUu5yBEtZAj/KUrtGRu14BsAG+68lpJhI0rbQyKIKt+gq2WNH4exi94+EtWOkgFhI0Pn5F0EvZt527WV06pyOj7YrGZayGe/6uppUTbnRHpL/rJuKFEE4czzPFWyK97dritWFfskvKvCeg26CgYuNMIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459813; c=relaxed/simple;
	bh=hISaJecocJn7hn/OYarXOgunClSMmRuVwd131XnvG1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Za6bEOv/23w8/Tksf2JeMB91xKL4U4YQmTjWjDeUkRLpCeTNVhXUOhLIMSrB2eB2zPPN/7ac7M6n1q72c//gbYzmA0J/70MpzOkFksEIgEenMb2KS+porJgD33kUj7bafokrIa6/d/JvEs8iMvpG31o2LC0x347CIn/yvqKB9CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVyXVzSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1192C4CED2;
	Thu,  9 Jan 2025 21:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736459813;
	bh=hISaJecocJn7hn/OYarXOgunClSMmRuVwd131XnvG1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVyXVzSEJ9MYLTGCypYYAgXp/c+i+hnw+QrMwK2M3UWjVDze2atkL4u54RY+TakkF
	 il4MQM/av7DVhYci1gNpVLyvwrGdEmUZPp02SRnIlKMJrENfegTJMiInBv58qjHANs
	 xwtW4+SX1GyexpmTVsMavh0c55DnJvCDxS0m1GqFLfYdyKHm+yTm2K7SbeEgyvWHbT
	 JL8V20aqLQufIXe7VZPHg7OH6UlGOSMk/YGbtZ1uRD6hvaasleAhIhRfKTmJCd3eO+
	 Sh/Z/N4Cx0VqshIpCjJMXgO3BH+3KZDS7N6vbg67iXaJU41FdwQvDLSI3UN6+B5cl0
	 UaygglaoqxQiw==
Date: Thu, 9 Jan 2025 21:56:51 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, hpa@zytor.com, kys@microsoft.com,
	bp@alien8.de, dave.hansen@linux.intel.com, decui@microsoft.com,
	eahariha@linux.microsoft.com, haiyangz@microsoft.com,
	mingo@redhat.com, mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com, tglx@linutronix.de,
	tiala@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v6 0/5] hyperv: Fixes for get_vtl(),
 hv_vtl_apicid_to_vp_id()
Message-ID: <Z4BGI-yoptUPbF3v@liuwe-devbox-debian-v2>
References: <20250108222138.1623703-1-romank@linux.microsoft.com>
 <Z4Au-chfvfXCt-zq@liuwe-devbox-debian-v2>
 <dead87fe-c765-4bcc-a097-fc247ee1adf2@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dead87fe-c765-4bcc-a097-fc247ee1adf2@linux.microsoft.com>

On Thu, Jan 09, 2025 at 01:40:34PM -0800, Roman Kisel wrote:
> 
> 
> On 1/9/2025 12:18 PM, Wei Liu wrote:
> > On Wed, Jan 08, 2025 at 02:21:33PM -0800, Roman Kisel wrote:
> > [...]
> > > Roman Kisel (5):
> > >    hyperv: Define struct hv_output_get_vp_registers
> > >    hyperv: Fix pointer type in get_vtl(void)
> > >    hyperv: Enable the hypercall output page for the VTL mode
> > >    hyperv: Do not overlap the hvcall IO areas in get_vtl()
> > >    hyperv: Do not overlap the hvcall IO areas in hv_vtl_apicid_to_vp_id()
> > 
> > The patches have been pushed to hyperv-next. Roman and Nuno, please
> > check the tree for correctness.
> 
> This
> 
> ```c
> union hv_arm64_pending_synthetic_exception_event {
> 	u64 as_uint64[2];
> 	struct {
> 		u8 event_pending : 1;
> 		u8 event_type : 3;
> 		u8 reserved : 4;
> 		u8 rsvd[3];
> 		u64 context;
> 	} __packed;
> };
> ```
> 
> needs to have the `u32 exception_type;` field:
> 
> ```c
> union hv_arm64_pending_synthetic_exception_event {
> 	u64 as_uint64[2];
> 	struct {
> 		u8 event_pending : 1;
> 		u8 event_type : 3;
> 		u8 reserved : 4;
> 		u8 rsvd[3];
> 		u32 exception_type;
> 		u64 context;
> 	} __packed;
> };
> ```
> as otherwise the struct won't cover the array.
> Testing the VMs currently with the latest hyperv-next.

Fixed. I c&p'ed the code then deleted the right version of the struct.
Thanks for checking.

Wei.

