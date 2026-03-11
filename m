Return-Path: <linux-hyperv+bounces-9319-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLUfANNtsWlVvAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9319-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 14:27:47 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0B9264825
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 14:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 220763059FDD
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA777257825;
	Wed, 11 Mar 2026 13:21:30 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4AB253F05
	for <linux-hyperv@vger.kernel.org>; Wed, 11 Mar 2026 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235290; cv=none; b=q0VaNV/XIzEAogM11S0L3MAeFKAvlkDbpXdj9jzEz/qUcKJ2Kz31rrOLNlKvBW4zpdtCw6cU/LLuvWWNd8AWnCX0UdEsKkvCI3hTGVgTBw8jImC2XrEPcij3Gqwedc3f3whTEVsgiVt+gI1Q5DrhhrIdKCV9bkXZ4rtisIc+zW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235290; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSuxohqFmyndYrpYnsikk6UmR6FCfz7MzK/CPBRi+iA/c7pUqGxVyDZuP4sOp40pIhkGBoSgFKxVhn833KStkZ6hs1qZbZYONJE2QfA9jAnDNtQ1BA3ZBkkdL2Ro1PCG1MZVt+SVqSZfq3UujaHDHtJ/eX/4X3uvmhwfuPCta5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56b18f05f49so2422642e0c.1
        for <linux-hyperv@vger.kernel.org>; Wed, 11 Mar 2026 06:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235288; x=1773840088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=jE4W4cZEnxV9tb37V/b3WDgP0fqJvsG2IgFPm94FNYz7MYKtyCV8l/dg8/KZebx/je
         5Y192ZmKffN0Rmgc5c2xZBYZugY0WAvJmwLp8krv9oikILzbyHvw3RmaOS6XPLC4G+m2
         3G6dxl7bN1xc3yawTHWMjhkPYWKbs++X+yubSnm0IlVpP8ah+D+xE3OXSQhJZNp4ABw5
         xFOD46RQ4hBkqnCCLwGu8UXn57eAE9MVX1/72Vo2QAKg3xmJeTtqZH4MGEbxKGLgEIvp
         Z1LBgO+8KysWNSEOGPFRwtQBCPKGoYYtgzjOWZ7alhXHFY48A9EnbI6cQKQknT4n8W4D
         jyTA==
X-Forwarded-Encrypted: i=1; AJvYcCVNBeoFphJ2JHgQrAGCYSSjWPMHfP0U6T11Z6BABmdg5FZitgakvds0kX8cR6fVGLuh6CqYdwCr+TWrzls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDcuW2F3G5ORgvs9OHAs3BnT3KQof85rsg8jp0a3jVS3ULZmZM
	9GxgjUhxThQJ8IA8lBZU6Oe9mvPlZgZ/lDRKHzCrE1CgtLtfnleoihvVbFjQDZejm7Y=
X-Gm-Gg: ATEYQzyxjQ6MkZh+V7WOz8ysZak/4iTovv0ztq8t2TwAA9wwym5afrlDIJrSu7nHR1H
	95COPwfRs38ch1EFZokpppwJYaH2JblnLxIVs1WoPVHJJ2tHaUf7aYD42AVFoEc4wBhaWRkb+td
	1BTZGwKEVFBp5dV+V4z10+fBmAAbTQbyskdy+z3DzaSdqDMwOCd0RCsWMI7ItLsWRBhqDEVswh7
	i8tr+mO7chJ4EE6Tp5kvBirsaZsV/8sdaV8/UwDOC9jZAufwSOczHgHK26v7e+uActRRauKamqx
	hO8c7j8r5BzS0VtsGrzpKq/FVPY/AEp/QQaYExUw1FETkNDkzVYATbJJ5r8aFvyQN+pdAwVomYB
	u8PglxP7bMc9ce+r81oSPGlwHhpvi9SOiAcjbiQBBkW+oiOiWDmHQCRQ3lScjBpwj+VbaJbPxyN
	o2yX5mZPF6TslLCngsVVq5zM887ABVr/RuR50aM2jyMqGIGCyr39ElgOvFiXRGOhI/YBRraDU=
X-Received: by 2002:a05:6122:54e:b0:56a:f09a:f1f2 with SMTP id 71dfb90a1353d-56b47446ee2mr997083e0c.4.1773235288587;
        Wed, 11 Mar 2026 06:21:28 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b46311eddsm924012e0c.3.2026.03.11.06.21.28
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:21:28 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5fff774800cso3499092137.0
        for <linux-hyperv@vger.kernel.org>; Wed, 11 Mar 2026 06:21:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3F1AtXLXtXPJyP6zRYyC63hQFvJOWBPrarw/IB3KUhZcqIJ9mCT4yzWwSl5X1O+hyleT9mEcJ4eHV8lI=@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4F0B9264825
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9319-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_GT_50(0.00)[57];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,sourceforge.jp:email,fu-berlin.de:email,avm.de:email,glider.be:email,linux-m68k.org:email,libc.org:email]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

