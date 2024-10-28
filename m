Return-Path: <linux-hyperv+bounces-3202-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43D89B3A60
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2024 20:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C91B218F9
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2024 19:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFDF18F2DF;
	Mon, 28 Oct 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J47FdrG1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8081C155A52;
	Mon, 28 Oct 2024 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730143539; cv=none; b=p9D0hkl54640stvUmwRKi0w4I8t6HZ+t0s+iLLDB0fEcorPyk/MIvzxh1pqMruJMq9gXcutpRUc5yU1+w2oh1BdVg3wdgu1P9fsyTDsvhVCiwqrXAI2U8+myjVHd5YH80zvXmnYkMQujFq7n6p0s0jKqsCLDPhFA35JGWWn7t9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730143539; c=relaxed/simple;
	bh=C7V4jnM///u5m7Dt/3VK+yG1FD4ImKYx2jbvgvZuoBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8oRelb4cAirDimPijo6hD+KBPshbi13vcAqnIcBFpBr1dEY+HVegGBwOB831UxL5s0gpzcInlCmiFP9zMFPPhrg6JiDlTsTSJp5eq3m8XToeKIhoAgALW5BH+Zc3lASi8DdVi9NGm9mVvPPxw8JPQJ1zWz7iGrnecGtNcQ7ExM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J47FdrG1; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb49510250so45670841fa.0;
        Mon, 28 Oct 2024 12:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730143536; x=1730748336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkQAJayFU9AcTexWWwk6v3avyn7IpkTY2pfgXXCLGk0=;
        b=J47FdrG1v2i3qIWTOEbVl81Jmp1mhPqbL5itVE3MQDsUwyxPBdDn5eC4vmZsyyVWCu
         KYqJUbkR3QpeDxZoT+ZZkrwb8Snb83W7bpUd2rHp2CdQQAQTGyR7f6h4TrwskAmUoK1z
         96rCXa5GFIP32IUsayumu2j19uOhlM9vL/ZZV0p6wIdWUYQ/sfwwIKRj96U5YL4QPz8w
         pht3T4hKm61I+RVmTCDDdUC5cl91MR9bSRVeBbRKyi6tk8P0dDN69xk06XDGm/ziHKGR
         r2YQZVfc8f5rsXC+FlcwDKFa7SwZ9f9nJFDOb2lJ2WzK1C8JNqPwbUq6qBM5UZay6End
         gQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730143536; x=1730748336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkQAJayFU9AcTexWWwk6v3avyn7IpkTY2pfgXXCLGk0=;
        b=THV+V0bpX0oWsCsyfnTZEcjHS7rHkVSsDEiJYludy/1Hi6ZHd5dSS7hSqDUqixV6kg
         HM7vznuttQG1YgDr8SvuUFa3jJZJpt46Gv3GYI6trSbajNVdux1nye5sBNqF2M8bcf5+
         ML3OfuaLbFGQxfYg4S2UTv8aiw5SIoAg9gJUgIjxgMkT5MLOpVIgygK6uybW1RLY7d1H
         o0yZU2kA5aOPrphk0U2CqyOPLjB26//0L1wGWUdvfzuSVl/PZDSBxBjNpCSelPVoa8qF
         rxH0C7zOGyiBq3LT2u2RpVuFlyuRSBBPG2vlvjIxcApujoLOIHoJHE/tFguEH7k8YtGB
         ev9w==
X-Forwarded-Encrypted: i=1; AJvYcCU5ds4y85bJfWLsCEBoiHb+UWjOkdxEy/xj5fVPibieahorrnrlOmW/ELnheI/9tovuSH7wNhoxKPVRZf8m@vger.kernel.org, AJvYcCVgG8XviHPrAXolDL4hYBmSS1E/gUHms2LSPedo56EPFvl+ahsFOg7tU/TaEwveJp+Bi5U87/OJ8/SrmG5/10w=@vger.kernel.org, AJvYcCXIvmIanQmWQFmxDwiSt4o7pDmQzp3/RnPl9YO0zCdYIWzkyumZtzZwcikhHnRbopoHgAvwUzdrYHIMQXv2@vger.kernel.org
X-Gm-Message-State: AOJu0YzT2gha0i3CFB6hC1jlRyladPiUWp0VziMeArvepSI8yN6Rhzwk
	Kryz9eSfU/z41nXZImONG8nF92/EARNGOZl/9YwmhtBcoSZKYViqKKqzoRAU4ixtRjXTBn69+Sc
	PoimzOWcyK+PUiD7c0sTshCPBf5dOxwKH
X-Google-Smtp-Source: AGHT+IEbRBQz+aQnxjwPcgER2o0cmQl54BbDEvkwXLGVRUcu8aNdMAp2W46P/aczgqbSSUb/5YPaFdBUuD0aZ/SM5fA=
X-Received: by 2002:a2e:6112:0:b0:2fb:4b0d:909b with SMTP id
 38308e7fff4ca-2fcbdfc9d2emr36473061fa.26.1730143535209; Mon, 28 Oct 2024
 12:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028-open-coded-timeouts-v2-0-c7294bb845a1@linux.microsoft.com>
 <20241028-open-coded-timeouts-v2-1-c7294bb845a1@linux.microsoft.com>
In-Reply-To: <20241028-open-coded-timeouts-v2-1-c7294bb845a1@linux.microsoft.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 28 Oct 2024 15:25:21 -0400
Message-ID: <CABBYNZ+=W-PG5RqVVuoT=TVrcQ3qYaF79TfBP6nAzG1R4DaoAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] jiffies: Define secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Easwar,

On Mon, Oct 28, 2024 at 3:11=E2=80=AFPM Easwar Hariharan
<eahariha@linux.microsoft.com> wrote:
>
> secs_to_jiffies() is defined in hci_event.c and cannot be reused by
> other call sites. Hoist it into the core code to allow conversion of the
> ~1150 usages of msecs_to_jiffies() that either:
> - use a multiplier value of 1000 or equivalently MSEC_PER_SEC, or
> - have timeouts that are denominated in seconds (i.e. end in 000)
>
> This will also allow conversion of yet more sites that use (sec * HZ)
> directly, and improve their readability.
>
> TO: "K. Y. Srinivasan" <kys@microsoft.com>
> TO: Haiyang Zhang <haiyangz@microsoft.com>
> TO: Wei Liu <wei.liu@kernel.org>
> TO: Dexuan Cui <decui@microsoft.com>
> TO: linux-hyperv@vger.kernel.org
> TO: Anna-Maria Behnsen <anna-maria@linutronix.de>
> TO: Thomas Gleixner <tglx@linutronix.de>
> TO: Geert Uytterhoeven <geert@linux-m68k.org>
> TO: Marcel Holtmann <marcel@holtmann.org>
> TO: Johan Hedberg <johan.hedberg@gmail.com>
> TO: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> TO: linux-bluetooth@vger.kernel.org
> TO: linux-kernel@vger.kernel.org
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  include/linux/jiffies.h   | 2 ++
>  net/bluetooth/hci_event.c | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
> index 1220f0fbe5bf..e5256bb5f851 100644
> --- a/include/linux/jiffies.h
> +++ b/include/linux/jiffies.h
> @@ -526,6 +526,8 @@ static __always_inline unsigned long msecs_to_jiffies=
(const unsigned int m)
>         }
>  }
>
> +#define secs_to_jiffies(_secs) ((_secs) * HZ)
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
>                  "\x00\x00\x00\x00\x00\x00\x00\x00"
>
> -#define secs_to_jiffies(_secs) msecs_to_jiffies((_secs) * 1000)
> -
>  /* Handle HCI Event packets */
>
>  static void *hci_ev_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,
>
> --
> 2.34.1
>

Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

--=20
Luiz Augusto von Dentz

