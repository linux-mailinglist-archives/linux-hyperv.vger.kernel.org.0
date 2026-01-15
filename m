Return-Path: <linux-hyperv+bounces-8324-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B11D279D9
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 19:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E8F330C0EBF
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 18:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9959B3B8D5F;
	Thu, 15 Jan 2026 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKsjnU4I"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546E92D7D30;
	Thu, 15 Jan 2026 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501364; cv=none; b=ISpJaJd+9MTdYgIUI7EAlpAJALA5f2Pt1cHEVt80+yRodpyQ7TM8cAYSl1K3kA1tDyjEkV0DV2Lk+vqpm3lC7Wno64K+D603X9bSB1eHqxo6wme05uCXIaawjLNKeFR+Xo2o6zftBEG2cTPYA9+Wbeb1I7oBjK0FyO6g5wHvc/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501364; c=relaxed/simple;
	bh=ucFIsL4YAazWafq1W6Q6AasZZLKFU0m+iUOFnn5n1gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcI03rcX9XKSDdimTCo74KnHhe9i6iPbwsa5TBg43+bY4jP22ZYWjUeZv6FzzfWkvDG4g1nEoVwN/ITZehkEDZAupf/Dlw8ec7XlNhP30nAKUzlwBZuMKz7JZsBQcW4WkepUlYuJOaMST4ZaH9tQbHb1XIdJMdltb/KHfrSIlio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKsjnU4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB0BC116D0;
	Thu, 15 Jan 2026 18:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768501364;
	bh=ucFIsL4YAazWafq1W6Q6AasZZLKFU0m+iUOFnn5n1gM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKsjnU4IVNiQBJzqXtqIzQ3NSlPUEs3eKQBUDQQd5cmOgschp+Dn7ljy9NZibOQ5b
	 XEVGnNQwYF+AD7cQSAy0kcGs38PBa/KiJlKMo+3Anpm6/k9Rj8Js5Oizcn7JTWhw77
	 N1g6h0GzWvq38xfvUfwrtn+6G7CdiU/Cw3TB17yfujBwvnKlk+y7gUw2o/ZVriurja
	 ZpcHRLPEXaTRTR1X8dJpUzL/nNLpjkJ2keInPHLEw2532MFxJ6Yh0bb+/eMwdQeS5u
	 Zwg6t3ZX+Ktj3jNAHBQxY7I/N33IM8zU7GAvftHc5lnIexgU0uqnKNMnF5hf3owhDJ
	 nIBL4pyHa/HvA==
Date: Thu, 15 Jan 2026 18:22:42 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Hans de Goede <hansg@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] hyper-v: Mark inner union in hv_kvp_exchg_msg_value
 as packed
Message-ID: <20260115182242.GA3690299@liuwe-devbox-debian-v2.local>
References: <20260115-kbuild-alignment-vbox-v1-0-076aed1623ff@linutronix.de>
 <20260115-kbuild-alignment-vbox-v1-1-076aed1623ff@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260115-kbuild-alignment-vbox-v1-1-076aed1623ff@linutronix.de>

On Thu, Jan 15, 2026 at 08:35:44AM +0100, Thomas Weiﬂschuh wrote:
> The unpacked union within a packed struct generates alignment warnings
> on clang for 32-bit ARM:
> 
> ./usr/include/linux/hyperv.h:361:2: error: field  within 'struct hv_kvp_exchg_msg_value'
>   is less aligned than 'union hv_kvp_exchg_msg_value::(anonymous at ./usr/include/linux/hyperv.h:361:2)'
>   and is usually due to 'struct hv_kvp_exchg_msg_value' being packed,
>   which can lead to unaligned accesses [-Werror,-Wunaligned-access]
>      361 |         union {
>          |         ^
> 
> With the recent changes to compile-test the UAPI headers in more cases,
> this warning in combination with CONFIG_WERROR breaks the build.
> 
> Fix the warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512140314.DzDxpIVn-lkp@intel.com/
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/linux-kbuild/20260110-uapi-test-disable-headers-arm-clang-unaligned-access-v1-1-b7b0fa541daa@kernel.org/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/linux-kbuild/29b2e736-d462-45b7-a0a9-85f8d8a3de56@app.fastmail.com/
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Acked-by: Wei Liu (Microsoft) <wei.liu@kernel.org>

> ---
>  include/uapi/linux/hyperv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/hyperv.h b/include/uapi/linux/hyperv.h
> index aaa502a7bff4..1749b35ab2c2 100644
> --- a/include/uapi/linux/hyperv.h
> +++ b/include/uapi/linux/hyperv.h
> @@ -362,7 +362,7 @@ struct hv_kvp_exchg_msg_value {
>  		__u8 value[HV_KVP_EXCHANGE_MAX_VALUE_SIZE];
>  		__u32 value_u32;
>  		__u64 value_u64;
> -	};
> +	} __attribute__((packed));
>  } __attribute__((packed));
>  
>  struct hv_kvp_msg_enumerate {
> 
> -- 
> 2.52.0
> 
> 

