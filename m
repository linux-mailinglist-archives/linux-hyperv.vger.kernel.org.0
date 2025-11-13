Return-Path: <linux-hyperv+bounces-7559-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E06C5A11E
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 22:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1518E4E58D1
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 21:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19270322A2A;
	Thu, 13 Nov 2025 21:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHhA/Nza"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5E03218BA;
	Thu, 13 Nov 2025 21:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763068412; cv=none; b=iUfW14LTv1fu+2rdlEJzikUgpZ+cMHB2RZTwSTgEq4FhuXsjYRlibaPXW3tLu2hH7qzzLmm7GKEiLDc0bfE3I5qADngN8aOiZz1Z2fC+hQvyU2LfE6OY0tkZHV43oHX5gpt5gS1WJ/zsFIxQS6RNRhJ4UaWHSiPzSii302fIa04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763068412; c=relaxed/simple;
	bh=6qTE3g2fwOo645y+YIaWR69QEm3wvsTuwqbFcwqHJjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NP54OhnNtJpzZt2Xm5LwpzF8fbD4rWe8X1vxl8ROmnd75zNsdglyYBRa8mAHrsje7+JSO6EMrju0PXCd/5a+2iuNUZFXx+Fy3NcNAtvUhK6wTiYwumcc6S1vB1UaC0+4Nr1VvKbkTKZQ1xX27EaBFhjH/3sVw2GbUOZpudNE0sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHhA/Nza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0367C4CEFB;
	Thu, 13 Nov 2025 21:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763068411;
	bh=6qTE3g2fwOo645y+YIaWR69QEm3wvsTuwqbFcwqHJjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dHhA/NzaeFOtom8pvGyqQoo1+9R9C0RM5gJZB7QLMgmflek/G562iJ63pUN9cMn+E
	 NLiaPEGtDEsututTzk6UJS0gCcl5J/wpaUiP1zYYD5Ykb12ZJxJiPzCu5K9Ay/VWF9
	 HwoRxibfcV9gwufYukf/E8Sj7ZQFl+F+mVG3sjwAKg/jjTVqnxGUx1OhmI4eTt5hER
	 60Yly3Fx36/qHnuvsqLE3QvWUVC2+2tnSjbBRO32b5cB/5OVm9Eos7z75eShnqtW58
	 PxOpG81wIlCACB/T2FycEJR2i9rnLM9odmGPxvsoFIXmXsIDvMmvUmH5Bb5ByYwR6u
	 cC6R+CzwSz54g==
Date: Thu, 13 Nov 2025 21:13:29 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Heiko Carstens <hca@linux.ibm.com>, Uros Bizjak <ubizjak@gmail.com>,
	Sean Christopherson <seanjc@google.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH v12 0/3] Drivers: hv: Introduce new driver - mshv_vtl
Message-ID: <20251113211329.GA1188343@liuwe-devbox-debian-v2.local>
References: <20251113044149.3710877-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113044149.3710877-1-namjain@linux.microsoft.com>

On Thu, Nov 13, 2025 at 04:41:46AM +0000, Naman Jain wrote:
[...]
> Naman Jain (3):
>   static_call: allow using STATIC_CALL_TRAMP_STR() from assembly
>   Drivers: hv: Export some symbols for mshv_vtl
>   Drivers: hv: Introduce mshv_vtl driver
> 

Thank you Peter, Paolo and Michael for the valuable input to make the
code better. And thank you Naman for your patience and perseverance to
get this done properly.

I intend to merge this into hyperv-next in the following days unless I
hear new objections.

Wei

>  arch/x86/hyperv/Makefile                |   10 +-
>  arch/x86/hyperv/hv_vtl.c                |   29 +
>  arch/x86/hyperv/mshv-asm-offsets.c      |   37 +
>  arch/x86/hyperv/mshv_vtl_asm.S          |  113 ++
>  arch/x86/include/asm/mshyperv.h         |   34 +
>  drivers/hv/Kconfig                      |   27 +-
>  drivers/hv/Makefile                     |    7 +-
>  drivers/hv/hv.c                         |    3 +
>  drivers/hv/hyperv_vmbus.h               |    1 +
>  drivers/hv/mshv_vtl.h                   |   25 +
>  drivers/hv/mshv_vtl_main.c              | 1392 +++++++++++++++++++++++
>  drivers/hv/vmbus_drv.c                  |    4 +-
>  include/hyperv/hvgdk_mini.h             |  106 ++
>  include/linux/compiler_types.h          |    8 +-
>  include/linux/static_call_types.h       |    4 +
>  include/uapi/linux/mshv.h               |   80 ++
>  tools/include/linux/static_call_types.h |    4 +
>  17 files changed, 1876 insertions(+), 8 deletions(-)
>  create mode 100644 arch/x86/hyperv/mshv-asm-offsets.c
>  create mode 100644 arch/x86/hyperv/mshv_vtl_asm.S
>  create mode 100644 drivers/hv/mshv_vtl.h
>  create mode 100644 drivers/hv/mshv_vtl_main.c
> 
> 
> base-commit: ab40c92c74c6b0c611c89516794502b3a3173966
> -- 
> 2.43.0
> 
> 

