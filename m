Return-Path: <linux-hyperv+bounces-92-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F70B7A15A9
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 07:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998511C2121B
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 05:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FDA3FDF;
	Fri, 15 Sep 2023 05:47:18 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F7D3C05
	for <linux-hyperv@vger.kernel.org>; Fri, 15 Sep 2023 05:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE0BC433B7;
	Fri, 15 Sep 2023 05:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694756837;
	bh=RyPR2NkOFcffhMr5xddvC27sEYDMrJaqGqZTUScQkPA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PcvjwDYx9G5f5Q1qxmIfIx5D0ne1wz4esF+c5nMP3hE41d6nNonhJxXX4/PUPMnzt
	 6IFVF+L5cUwGSpdXGC9UnPrlhotCcgfse/rpTnTcuP+ptih8GLpBYauZqloFgw4mKm
	 1BJ4h9wpYsZDVo/JkDqFS86S8QepQGmMcduIrPgKI9p+ayQKVK5++KZEbJZg+++hRi
	 APvnDLOLgHFa9QzULX+SIhe2v+5k6OYtaDDMPz3MGCP43ZqWapGyedZSR/31ZKtcxY
	 zc2AZBJQYwAAfcCSy28d4Vinr1VmiJGRwpjQCASK4NeItrige3SaZGkefwxAZMm0JB
	 fOjUjO2NE9U5Q==
Date: Fri, 15 Sep 2023 14:47:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Xin Li <xin3.li@intel.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, luto@kernel.org, pbonzini@redhat.com,
 seanjc@google.com, peterz@infradead.org, jgross@suse.com,
 ravi.v.shankar@intel.com, mhiramat@kernel.org, andrew.cooper3@citrix.com,
 jiangshanlai@gmail.com
Subject: Re: [PATCH v10 02/38] x86/opcode: Add the WRMSRNS instruction to
 the x86 opcode map
Message-Id: <20230915144710.7c2b94e93db16fd217acaf9f@kernel.org>
In-Reply-To: <20230914044805.301390-3-xin3.li@intel.com>
References: <20230914044805.301390-1-xin3.li@intel.com>
	<20230914044805.301390-3-xin3.li@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Sep 2023 21:47:29 -0700
Xin Li <xin3.li@intel.com> wrote:

> Add the opcode used by WRMSRNS, which is the non-serializing version of
> WRMSR and may replace it to improve performance, to the x86 opcode map.
> 
> Tested-by: Shan Kang <shan.kang@intel.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  arch/x86/lib/x86-opcode-map.txt       | 2 +-
>  tools/arch/x86/lib/x86-opcode-map.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
> index 5168ee0360b2..1efe1d9bf5ce 100644
> --- a/arch/x86/lib/x86-opcode-map.txt
> +++ b/arch/x86/lib/x86-opcode-map.txt
> @@ -1051,7 +1051,7 @@ GrpTable: Grp6
>  EndTable
>  
>  GrpTable: Grp7
> -0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B)
> +0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (110),(11B)
>  1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B)
>  2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
>  3: LIDT Ms
> diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
> index 5168ee0360b2..1efe1d9bf5ce 100644
> --- a/tools/arch/x86/lib/x86-opcode-map.txt
> +++ b/tools/arch/x86/lib/x86-opcode-map.txt
> @@ -1051,7 +1051,7 @@ GrpTable: Grp6
>  EndTable
>  
>  GrpTable: Grp7
> -0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B)
> +0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (110),(11B)
>  1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B)
>  2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
>  3: LIDT Ms
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

