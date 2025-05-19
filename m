Return-Path: <linux-hyperv+bounces-5558-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C9AABC711
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 May 2025 20:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36921B60002
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 May 2025 18:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AF0283FD1;
	Mon, 19 May 2025 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="A+W/Xmr2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7591EDA3C;
	Mon, 19 May 2025 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747678924; cv=none; b=VxHzAeX2s6TnqFtm6VGAifCcAILK//24551VZDlHrjVatKp733fpBM42gNWpvH9tLhYlVkpVESOsWWARireb83IR/3AlATDbv9rsOkHT9AXrJenjVVJb/ysMoScP677Zk3ynKp3NZ/EGw480EH2XLCJKSsFgnVzvoQd7POCjacM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747678924; c=relaxed/simple;
	bh=8VuaBNnAvh7pPtfCGF4GFjHx7YfYm1kOeJSEBnjKm3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSsIP3wsmcZEIn1iqmvuygqhB43jgcP4fvoQWf7G1kI8I0L8qaOxdhlv71OFWbcAApxJfolWRs4WpbbWdnQqciVPu66st9pcIH6pfc2SKi12+3QlY9RDfyHeQ097yypECovBVDtU/MBi//X6Bp0XFaZaORS1luB65i1Wy112tRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=A+W/Xmr2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id DBA4D206786D; Mon, 19 May 2025 11:22:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DBA4D206786D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747678922;
	bh=p0bB/j78zCPghO8iWsrXfnBJ5zLGOc64idMJk0+m+rM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A+W/Xmr2RYZmwzzos1aJi+OYwJUyCtumEk1wCEZtFjrsrgEeQrA9Zs+r3gZPDFdQv
	 3Cev8pZ2AZtoSxH48+tFIK+u85uBPs+jrdSJ4PgvElI73uzthdUJL38uhxXmU4ITal
	 GrUoHFGXfcERRwQhktNWFqlBd+5HuNLtLKnFfu2k=
Date: Mon, 19 May 2025 11:22:02 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Drivers: hv: Introduce new driver - mshv_vtl
Message-ID: <20250519182202.GA15054@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250519045642.50609-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519045642.50609-1-namjain@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, May 19, 2025 at 10:26:40AM +0530, Naman Jain wrote:
> Introduce a new mshv_vtl driver to provide an interface for Virtual
> Machine Monitor like OpenVMM and its use as OpenHCL paravisor to
> control VTL0 (Virtual trust Level).
> Expose devices and support IOCTLs for features like VTL creation,
> VTL0 memory management, context switch, making hypercalls,
> mapping VTL0 address space to VTL2 userspace, getting new VMBus
> messages and channel events in VTL2 etc.
> 
> OpenVMM : https://openvmm.dev/guide/
> 
> Changes since v2:
> https://lore.kernel.org/all/20250512140432.2387503-1-namjain@linux.microsoft.com/
> * Removed CONFIG_OF dependency (addressed Saurabh's comments
> * Fixed typo in "allow_map_intialized" variable name
> 
> Changes since v1:
> https://lore.kernel.org/all/20250506084937.624680-1-namjain@linux.microsoft.com/
> Addressed Saurabh's comments:
> * Split the patch in 2 to keep export symbols separate
> * Make MSHV_VTL module tristate and fixed compilation warning that would come when HYPERV is
>   compiled as a module.
> * Remove the use of ref_count
> * Split functionality of mshv_vtl_ioctl_get_set_regs to different functions
>   mshv_vtl_ioctl_(get|set)_regs as it actually make things simpler
> * Fixed use of copy_from_user in atomic context in mshv_vtl_hvcall_call.
>   Added ToDo comment for info.
> * Added extra code to free memory for vtl in error scenarios in mshv_ioctl_create_vtl()
> 
> Addressed Alok's comments regarding:
> * Additional conditional checks
> * corrected typo in HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB case
> * empty lines before return statement
> * Added/edited comments, variable names, structure field names as suggested to improve
>   documentation - no functional change here.
> 
> Naman Jain (2):
>   Drivers: hv: Export some symbols for mshv_vtl
>   Drivers: hv: Introduce mshv_vtl driver
> 
>  drivers/hv/Kconfig          |   20 +
>  drivers/hv/Makefile         |    7 +-
>  drivers/hv/hv.c             |    2 +
>  drivers/hv/hyperv_vmbus.h   |    1 +
>  drivers/hv/mshv_vtl.h       |   52 +
>  drivers/hv/mshv_vtl_main.c  | 1783 +++++++++++++++++++++++++++++++++++
>  drivers/hv/vmbus_drv.c      |    3 +-
>  include/hyperv/hvgdk_mini.h |   81 ++
>  include/hyperv/hvhdk.h      |    1 +
>  include/uapi/linux/mshv.h   |   82 ++
>  10 files changed, 2030 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/hv/mshv_vtl.h
>  create mode 100644 drivers/hv/mshv_vtl_main.c
> 
> 
> base-commit: 8566fc3b96539e3235909d6bdda198e1282beaed
> -- 
> 2.34.1
> 

For both the patches,
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>


