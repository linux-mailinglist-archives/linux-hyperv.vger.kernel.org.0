Return-Path: <linux-hyperv+bounces-2403-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09716905832
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jun 2024 18:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2334D1C20805
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jun 2024 16:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A29A17F367;
	Wed, 12 Jun 2024 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UPY3t7u/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C27E182AF;
	Wed, 12 Jun 2024 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208617; cv=none; b=p9TC2Cj7OewuM6UEivGrwTlIhqbqpNYHZFrwq9EQypC1CD4CAe3xKrheeTahPgxysjx+SJUNVxKIagb/OnKp4gZQaSp8vUc/PNC46dgT3TM0NQTMl9YNlCJDHjlA+Nd+iCJFEe7YfihMU4lGY4j2Q1w4bZx1X2vEoTt2o5sZ+Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208617; c=relaxed/simple;
	bh=9FjkK63X7UnIqqjlNMXnOdUdp7IseXQXhp451DJFoqA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tqy2b9ZbEpwFqQY1AIZvDkvZS5YEZUM7C1jpYhvpEdM40s+WnHXA3aFRUGoGKrgOJ6YN+kC3PRAGTs9dzQVd8/x5PYnvrTjkdNcR6ASEGX1ui73RjiuJJAzR2rKfptFrePWP0jz4fslqvJVyjMgLXx/+22oMO8is76vmJhbeflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UPY3t7u/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.49.54] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 656DB20B7001;
	Wed, 12 Jun 2024 09:10:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 656DB20B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718208609;
	bh=RwjazV5sA8GVLo5REZFAAJWRTt27/+09ggocg8Gt8+s=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=UPY3t7u/dFyqZbYJ9STAjRbF7OXVYcuyHIkrTcJJHpuLzxBaCJiqI4frJ6YnI/Bt6
	 btkUf/VfpLp68lnAzl9evVqiEgFDquWxWtYbaNo2VKYhRTJcxXY0zlH4G8je6dKw94
	 Kdzvnhm9NDvObXjQVuewOWqOUswTiAhwt7reZXxM=
Message-ID: <cabdb509-83a2-4de7-8e10-4eea7e4c96f2@linux.microsoft.com>
Date: Wed, 12 Jun 2024 09:10:09 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com
Subject: Re: [PATCH 1/1] Documentation: hyperv: Add overview of Confidential
 Computing VM support
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-coco@lists.linux.dev
References: <20240610202810.193452-1-mhklinux@outlook.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20240610202810.193452-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thank you for adding much needed documentation throughout the tree!

On 6/10/2024 1:28 PM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Add documentation topic for Confidential Computing (CoCo) VM support
> in Linux guests on Hyper-V.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  Documentation/virt/hyperv/coco.rst  | 258 ++++++++++++++++++++++++++++
>  Documentation/virt/hyperv/index.rst |   1 +
>  2 files changed, 259 insertions(+)
>  create mode 100644 Documentation/virt/hyperv/coco.rst
> 
> diff --git a/Documentation/virt/hyperv/coco.rst b/Documentation/virt/hyperv/coco.rst
> new file mode 100644
> index 000000000000..ffd6ba7a1d64
> --- /dev/null
> +++ b/Documentation/virt/hyperv/coco.rst
> @@ -0,0 +1,258 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Confidential Computing VMs
> +==========================
> +Hyper-V can create and run Linux guests that are Confidential Computing
> +(CoCo) VMs. Such VMs cooperate with the physical processor to better protect
> +the confidentiality and integrity of data in the VM's memory, even in the
> +face of a hypervisor/VMM that has been compromised and may behave maliciously.
> +CoCo VMs on Hyper-V share the generic CoCo VM threat model and security
> +objectives described in Documentation/security/snp-tdx-threat-model.rst. Note
> +that Hyper-V specific code in Linux refers to CoCo VMs as "isolated VMs" or
> +"isolation VMs".

Thanks for incorporating the link to the threat model!

> +
> +A Linux CoCo VM on Hyper-V requires the cooperation and interaction of the
> +following:
> +
> +* Physical hardware with a processor that supports CoCo VMs
> +
> +* The hardware runs a version of Windows/Hyper-V with support for CoCo VMs
> +
> +* The VM runs a version of Linux that supports being a CoCo VM
> +
> +The physical hardware requirements are as follows:
> +
> +* AMD processor with SEV-SNP. Hyper-V does not run guest VMs with AMD SME,
> +  SEV, or SEV-ES encryption, and such encryption is not sufficient for a CoCo
> +  VM on Hyper-V.
> +
> +* Intel processor with TDX
> +
> +To create a CoCo VM, the "Isolated VM" attribute must be specified to Hyper-V
> +when the VM is created. A VM cannot be changed from a CoCo VM to a normal VM,
> +or vice versa, after it is created.
> +
> +Operational Modes
> +-----------------
> +Hyper-V CoCo VMs can run in two modes. The mode is selected when the VM is
> +created and cannot be changed during the life of the VM.
> +
> +* Fully-enlightened mode. In this mode, the guest operating system is
> +  enlightened to understand and manage all aspects of running as a CoCo VM.
> +
> +* Paravisor mode. In this mode, a paravisor layer between the guest and the
> +  host provides some operations needed to run as a CoCo VM. The guest operating
> +  system can have fewer CoCo enlightenments than is required in the
> +  fully-enlightened case.
> +
> +Conceptually, fully-enlightened mode and paravisor mode may be treated as
> +points on a spectrum spanning the degree of guest enlightenment needed to run
> +as a CoCo VM. Fully-enlightened mode is one end of the spectrum. A full
> +implementation of paravisor mode is the other end of the spectrum, where all
> +aspects of running as a CoCo VM are handled by the paravisor, and a normal
> +guest OS with no knowledge of memory encryption or other aspects of CoCo VMs
> +can run successfully. However, the Hyper-V implementation of paravisor mode
> +does not go this far, and is somewhere in the middle of the spectrum. Some
> +aspects of CoCo VMs are handled by the Hyper-V paravisor while the guest OS
> +must be enlightened for other aspects. Unfortunately, there is no
> +standardized enumeration of feature/functions that might be provided in the
> +paravisor, and there is no standardized mechanism for a guest OS to query the
> +paravisor for the feature/functions it provides. The understanding of what
> +the paravisor provides is hard-coded in the guest OS.
> +
> +Paravisor mode has similarities to the Coconut project, which aims to provide
> +a limited paravisor to provide services to the guest such as a virtual TPM.

Would it be useful to add an external link to the Coconut project here?
https://github.com/coconut-svsm/svsm

> +However, the Hyper-V paravisor generally handles more aspects of CoCo VMs
> +than is currently envisioned for Coconut, and so is further toward the "no
> +guest enlightenments required" end of the spectrum.
> +
> +In the CoCo VM threat model, the paravisor is in the guest security domain
> +and must be trusted by the guest OS. By implication, the hypervisor/VMM must
> +protect itself against a potentially malicious paravisor just like it
> +protects against a potentially malicious guest.

Tangential to this patch, can the guest provide its own paravisor since
it needs to be trusted and apparently the only way to find out if a
paravisor will be used is to rely on the (possibly) malicious
hypervisor/VMM to provide a synthetic MSR?

> +
> +The hardware architectural approach to fully-enlightened vs. paravisor mode
> +varies depending on the underlying processor.
> +
> +* With AMD SEV-SNP processors, in fully-enlightened mode the guest OS runs in
> +  VMPL 0 and has full control of the guest context. In paravisor mode, the
> +  guest OS runs in VMPL 2 and the paravisor runs in VMPL 0. The paravisor
> +  running in VMPL 0 has privileges that the guest OS in VMPL 2 does not have.
> +  Certain operations require the guest to invoke the paravisor. Furthermore, in
> +  paravisor mode the guest OS operates in "virtual Top Of Memory" (vTOM) mode
> +  as defined by the SEV-SNP architecture. This mode simplifies guest management
> +  of memory encryption when a paravisor is used.
> +
> +* With Intel TDX processor, in fully-enlightened mode the guest OS runs in an
> +  L1 VM. In paravisor mode, TD partitioning is used. The paravisor runs in the
> +  L1 VM, and the guest OS runs in a nested L2 VM.
> +
> +Hyper-V exposes a synthetic MSR to guests that describes the CoCo mode. This
> +MSR indicates if the underlying processor uses AMD SEV-SNP or Intel TDX, and
> +whether a paravisor is being used. It is straightforward to build a single
> +kernel image that can boot and run properly on either architecture, and in
> +either mode.
> +

