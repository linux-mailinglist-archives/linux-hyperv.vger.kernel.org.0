Return-Path: <linux-hyperv+bounces-3178-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2E59AB9B9
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Oct 2024 00:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC074284702
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Oct 2024 22:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7FD1CDFC6;
	Tue, 22 Oct 2024 22:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="src16h4f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AEE1CDFBF;
	Tue, 22 Oct 2024 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637892; cv=none; b=O90BZpDKkKheLmniRZz+iN/rp1ArzFWuih7Vf/pCG2xJ30q23MvtGBJ6SqFiW/eLt5lk9XBLgp7LLuh8Ghr3tJ7rpFP9OHhf1Wa+QuCkm48kjZkVS8cp+zWn5a8pSa5fleh9O2JLEQzigusNdbeKBIq+d28QwL1pcg6Bt8xYOY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637892; c=relaxed/simple;
	bh=AOaeQ/JIrGG6hVU/F59SW5zbpMK6YqCThcfIwLGdMu4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OGpZykFtqDiSSBoBxtDGtlgkWqsNvXrvxeGtwKX+2gplmaKIlCkzRKr3C4fgArTBICUOjlcClpTkqlOpfRIUEAnFYNqayBFXf9nwSqzjD+MGAfPAJtHfdPf7XUE46RftOfSs2YNZ08szpyUu7UM582pROpWLSYJIimBiuEpI1wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=src16h4f; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.66.184] (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2A8FD21112EF;
	Tue, 22 Oct 2024 15:58:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A8FD21112EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729637890;
	bh=2QQm/IH+Y8dbs5DxBwqLr/A9c7L7ikg8eZ/If3zOwmI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=src16h4fKcPufvHf+a4/l9zZ598jjOFJ+msduFTYVgo4IXECIVmFkRq1J6yOBqitr
	 hPkTw/IEMSIeAARlAq2FdLc1xCrvW61+Cuz/aGfzkFzDNamus0jqijwp6NycfalL8z
	 0ltBw+9TKmhBgiDbUJBGih/Gna5t8d3/QDnJMYYQ=
Message-ID: <112aed61-2c4d-450e-9a44-cba33e2a017f@linux.microsoft.com>
Date: Tue, 22 Oct 2024 15:58:10 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Naman Jain <namjain@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH 1/2] jiffies: Define secs_to_jiffies()
To: lkp@intel.com, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Linux-HyperV <linux-hyperv@vger.kernel.org>
References: <20241022185353.2080021-1-eahariha@linux.microsoft.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20241022185353.2080021-1-eahariha@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/2024 11:53 AM, Easwar Hariharan wrote:
> There are ~500 usages of msecs_to_jiffies() that either use a multiplier
> value of 1000 or equivalently MSEC_PER_SEC. Define secs_to_jiffies() to
> allow such code to be less clunky.
> 
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  include/linux/jiffies.h   | 2 ++
>  net/bluetooth/hci_event.c | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
> index 1220f0fbe5bf..50dba516fd2f 100644
> --- a/include/linux/jiffies.h
> +++ b/include/linux/jiffies.h
> @@ -526,6 +526,8 @@ static __always_inline unsigned long msecs_to_jiffies(const unsigned int m)
>  	}
>  }
>  
> +#define secs_to_jiffies(_secs) msecs_to_jiffies((_secs) * MSEC_PER_SEC)
> +
>  extern unsigned long __usecs_to_jiffies(const unsigned int u);
>  #if !(USEC_PER_SEC % HZ)
>  static inline unsigned long _usecs_to_jiffies(const unsigned int u)
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 0bbad90ddd6f..7b35c58bbbeb 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -42,8 +42,6 @@
>  #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
>  		 "\x00\x00\x00\x00\x00\x00\x00\x00"
>  
> -#define secs_to_jiffies(_secs) msecs_to_jiffies((_secs) * 1000)
> -
>  /* Handle HCI Event packets */
>  
>  static void *hci_ev_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,

Sorry, I should have combined distribution lists for the two patches, so
everyone received both patches. Combining the lists with this email.

Here's the lore link for the series:
https://lore.kernel.org/all/20241022185353.2080021-1-eahariha@linux.microsoft.com/

Thanks,
Easwar

