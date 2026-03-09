Return-Path: <linux-hyperv+bounces-9196-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGqUAo0Lr2lzMQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9196-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 09 Mar 2026 19:03:57 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A88B223E270
	for <lists+linux-hyperv@lfdr.de>; Mon, 09 Mar 2026 19:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E69B303BF48
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Mar 2026 18:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C97B41C2F1;
	Mon,  9 Mar 2026 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQ32ADvb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D589E41C2E2;
	Mon,  9 Mar 2026 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079055; cv=none; b=YIOpOYJjbBlieke7qTNW/vAXD3v/2B5UOK5cJ9KhkCMRQRPyev01jHPyr9hNt+Ew00RrmU9Vx2TDvl4Rk8r6QSOuDqPwikoc9XdSCBklZOCBZwto4BYpIK8CkDo8D3bTJ8Vh8lv3ad211/VeXUFAgUgi/pDHs1gwCtuLmp3jzOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079055; c=relaxed/simple;
	bh=umRBIgezxy/dOmobJ4s+VmhAY+beHNIpBO1wRh2/qIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVY4lwcbrPyVHtrkryWJvkLa+JcXdF70OuWcDi848V4vcem2DtAvpUYqBXyJt0t+6BOmzleO+l23OLcx55XQBVuFc804Qq7yRfKbUiXPzdKhIFoPE2jEqmEvcK+dUlK122z/wZVWQiwNgQStvN+47AuZig5V9gxu1zsCCoLLdmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ32ADvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CFBC4CEF7;
	Mon,  9 Mar 2026 17:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773079055;
	bh=umRBIgezxy/dOmobJ4s+VmhAY+beHNIpBO1wRh2/qIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQ32ADvbfD8iXzwmmwiwU2Ui8jZLQQH+l6LYrom56+g7S04WbCyAnYohKGaSSUOmC
	 MSSR3B5KEwOtM1Yh/X71U+8lF3phb8uo5L182+r0/Ri1G0tp1uST/I+4TIA66IePu7
	 dd6iGq5iKJoz8sv36dOfoMLXpdUEjUlqOYBimR0bix5sHkNWoBtmyZrR3EWVKu6Lh5
	 17kKtJ1CXfPIWsJlzO/yZNVc9z+Phvj/TE3bWOqPEE8JnBx3PPChlKY+ppKSi2rSJO
	 YfaQJbHxeFttKUY3sVC00sHrNAdWJdA0IZBm8NGHF+hiXrOhUMEp6ajGu7Jci8T92o
	 9wymE9A806tYw==
Date: Mon, 9 Mar 2026 17:57:33 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>
Subject: Re: [PATCH v8 09/10] x86/hyperv/vtl: Mark the wakeup mailbox page as
 private
Message-ID: <20260309175733.GA3083831@liuwe-devbox-debian-v2.local>
References: <20260107-rneri-wakeup-mailbox-v8-0-2f5b6785f2f5@linux.intel.com>
 <20260107-rneri-wakeup-mailbox-v8-9-2f5b6785f2f5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107-rneri-wakeup-mailbox-v8-9-2f5b6785f2f5@linux.intel.com>
X-Rspamd-Queue-Id: A88B223E270
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9196-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,outlook.com,linux.microsoft.com,vger.kernel.org,intel.com,linux.intel.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Action: no action

Dexuan, are you happy with the patch? You can also delegate to Saurabh
if you think it's more appropriate. Thanks!

On Wed, Jan 07, 2026 at 01:44:45PM -0800, Ricardo Neri wrote:
> From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> 
> The current code maps MMIO devices as shared (decrypted) by default in a
> confidential computing VM.
> 
> In a TDX environment, secondary CPUs are booted using the Multiprocessor
> Wakeup Structure defined in the ACPI specification. The virtual firmware
> and the operating system function in the guest context, without
> intervention from the VMM. Map the physical memory of the mailbox as
> private. Use the is_private_mmio() callback.
> 
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes in v8:
>  - Included linux/acpi.h to add missing definitions that caused build
>    breaks (kernel test robot)
> 
> Changes in v7:
>  - Dropped check for !CONFIG_X86_MAILBOX_WAKEUP. The symbol is no longer
>    valid and now we have a stub for !CONFIG_ACPI.
>  - Dropped Reviewed-by tags from Dexuan and Michael as this patch
>    changed.
> 
> Changes in v6:
>  - Fixed a compile error with !CONFIG_X86_MAILBOX_WAKEUP.
>  - Added Reviewed-by tag from Dexuan. Thanks!
> 
> Changes in v5:
>  - None
> 
> Changes in v4:
>  - Updated to use the renamed function acpi_get_mp_wakeup_mailbox_paddr().
>  - Added Reviewed-by tag from Michael. Thanks!
> 
> Changes in v3:
>  - Use the new helper function get_mp_wakeup_mailbox_paddr().
>  - Edited the commit message for clarity.
> 
> Changes in v2:
>  - Added the helper function within_page() to improve readability
>  - Override the is_private_mmio() callback when detecting a TDX
>    environment. The address of the mailbox is checked in
>    hv_is_private_mmio_tdx().
> ---
>  arch/x86/hyperv/hv_vtl.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 752101544663..2af825f7a447 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -6,6 +6,9 @@
>   *   Saurabh Sengar <ssengar@microsoft.com>
>   */
>  
> +#include <linux/acpi.h>
> +
> +#include <asm/acpi.h>
>  #include <asm/apic.h>
>  #include <asm/boot.h>
>  #include <asm/desc.h>
> @@ -59,6 +62,18 @@ static void  __noreturn hv_vtl_restart(char __maybe_unused *cmd)
>  	hv_vtl_emergency_restart();
>  }
>  
> +static inline bool within_page(u64 addr, u64 start)
> +{
> +	return addr >= start && addr < (start + PAGE_SIZE);
> +}
> +
> +static bool hv_vtl_is_private_mmio_tdx(u64 addr)
> +{
> +	u64 mb_addr = acpi_get_mp_wakeup_mailbox_paddr();
> +
> +	return mb_addr && within_page(addr, mb_addr);
> +}
> +
>  void __init hv_vtl_init_platform(void)
>  {
>  	/*
> @@ -71,6 +86,8 @@ void __init hv_vtl_init_platform(void)
>  	/* There is no paravisor present if we are here. */
>  	if (hv_isolation_type_tdx()) {
>  		x86_init.resources.realmode_limit = SZ_4G;
> +		x86_platform.hyper.is_private_mmio = hv_vtl_is_private_mmio_tdx;
> +
>  	} else {
>  		x86_platform.realmode_reserve = x86_init_noop;
>  		x86_platform.realmode_init = x86_init_noop;
> 
> -- 
> 2.43.0
> 

