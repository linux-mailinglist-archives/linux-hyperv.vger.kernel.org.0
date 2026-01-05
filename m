Return-Path: <linux-hyperv+bounces-8152-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 760CACF4E0C
	for <lists+linux-hyperv@lfdr.de>; Mon, 05 Jan 2026 18:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42118301B11B
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jan 2026 17:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09BC23C516;
	Mon,  5 Jan 2026 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EwRG3JtY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE97C86348;
	Mon,  5 Jan 2026 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767632497; cv=none; b=aDaxeatJUbwM8rS81Stij7fMcVHu9THLKU8nNkgWTXndnDsx1fqTdm6YYFfTnY6DaQRPzceJb829DSm4Y5S4oEzF70Yd+L9njw66xirqinL2Tfs5on31T8v0mfLvcOjv0BSI9rwRrQJXDlIMlz2nZ3r1NDfOPiymC39Z8uaepzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767632497; c=relaxed/simple;
	bh=ScrrYzlxaEZ3Vway80Sj1W+wz4Svg2zuQoBuJwQOb50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=in4eyRg7bAmxQzFdu3Kz6jo1FXpwhs18bAxAxXe6ghidKcYbeniNwzvFdq1skPPwY5w51SoINsppRRXB2p9VBhfbNYFNDoclvUibg91KX4fRZdte/pjA85p+DeCBcLGcw+uzuUvesiCTdkZAVkTzbunSEnH6yXEvT013kut6sgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EwRG3JtY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id E16C7211CFB4;
	Mon,  5 Jan 2026 09:01:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E16C7211CFB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767632495;
	bh=TCiepJ8eE1rHHE2s0LWxXKUhhos+DkRv2lY5wnGrORk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EwRG3JtYHkLI9DWcsdE/yJN/78hnhimkfXs5cI7y5rRpYMHSFbziP/Q+si8GtsHB8
	 GykDd+CKigQSvi09koTDbYCbVEsyWg7si0Di7TX5IvTpZLOAQD1laPEMwyNe1bJnei
	 eT3yqolWELNN+bBg1rLbUC9kzaCZ+Aw5JEguxr98=
Date: Mon, 5 Jan 2026 09:01:32 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hyperv: add definitions for arm64 gpa intercepts
Message-ID: <aVvubEEqnIxkvib2@skinsburskii.localdomain>
References: <20260105122837.1083896-1-anirudh@anirudhrb.com>
 <20260105122837.1083896-2-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105122837.1083896-2-anirudh@anirudhrb.com>

On Mon, Jan 05, 2026 at 12:28:36PM +0000, Anirudh Rayabharam wrote:
> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 
> Add definitions required for handling GPA intercepts on arm64.
> 
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

> ---
>  include/hyperv/hvhdk.h | 47 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index 469186df7826..08965970c17d 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -800,6 +800,53 @@ struct hv_x64_memory_intercept_message {
>  	u8 instruction_bytes[16];
>  } __packed;
>  
> +#if IS_ENABLED(CONFIG_ARM64)
> +union hv_arm64_vp_execution_state {
> +	u16 as_uint16;
> +	struct {
> +		u16 cpl:2; /* Exception Level (EL) */
> +		u16 debug_active:1;
> +		u16 interruption_pending:1;
> +		u16 vtl:4;
> +		u16 virtualization_fault_active:1;
> +		u16 reserved:7;
> +	} __packed;
> +};
> +
> +struct hv_arm64_intercept_message_header {
> +	u32 vp_index;
> +	u8 instruction_length;
> +	u8 intercept_access_type;
> +	union hv_arm64_vp_execution_state execution_state;
> +	u64 pc;
> +	u64 cpsr;
> +} __packed;
> +
> +union hv_arm64_memory_access_info {
> +	u8 as_uint8;
> +	struct {
> +		u8 gva_valid:1;
> +		u8 gva_gpa_valid:1;
> +		u8 hypercall_output_pending:1;
> +		u8 reserved:5;
> +	} __packed;
> +};
> +
> +struct hv_arm64_memory_intercept_message {
> +	struct hv_arm64_intercept_message_header header;
> +	u32 cache_type; /* enum hv_cache_type */
> +	u8 instruction_byte_count;
> +	union hv_arm64_memory_access_info memory_access_info;
> +	u16 reserved1;
> +	u8 instruction_bytes[4];
> +	u32 reserved2;
> +	u64 guest_virtual_address;
> +	u64 guest_physical_address;
> +	u64 syndrome;
> +} __packed;
> +
> +#endif /* CONFIG_ARM64 */
> +
>  /*
>   * Dispatch state for the VP communicated by the hypervisor to the
>   * VP-dispatching thread in the root on return from HVCALL_DISPATCH_VP.
> -- 
> 2.34.1
> 

