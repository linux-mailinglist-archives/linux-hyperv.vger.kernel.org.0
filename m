Return-Path: <linux-hyperv+bounces-2457-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4D891108B
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Jun 2024 20:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C5E1F23B99
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Jun 2024 18:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6991C1B47B0;
	Thu, 20 Jun 2024 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R3h6pwN5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F09E1BA085
	for <linux-hyperv@vger.kernel.org>; Thu, 20 Jun 2024 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906815; cv=none; b=D9vDmzO+ftvaugT2dCWow4X3es1tO9cUQlz22VHsDmdSyypMlwGEWcPNl43JJESszAJAh9NOcj7LuUAgNqvsmmb4NgwKMPqA9JlWw9ztLkpF9NgCDCYOSR8CTzWLw3pZVqcKuDelk2T8lDn+HFxzOPA1a6BJj0tHSyuIb4WG7cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906815; c=relaxed/simple;
	bh=29OxgEL3l6wtk/wr9HSlAcydEGnms+qvS9bonjZCeq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqC850dEz9YMejd0fpHzCe0S/weGf2YYog6UZI22CEAVGeQ+6CtZhZvN7zm8VWqrG4FltSG09RQ89DFHTnI0+4Plyohb6KH5k3vQJ691YvVKUNosNZpR+Zffmi6fpWv0Fzh31VpH7aBZLI6MNItomqmzLJJlQIVOrVcTv1lsJIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R3h6pwN5; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52c82101407so1933844e87.3
        for <linux-hyperv@vger.kernel.org>; Thu, 20 Jun 2024 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718906811; x=1719511611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fuatl8An2r1cXJScFESolD1f90VPFvdc9a3mKIi/oro=;
        b=R3h6pwN54/jOqRV9VhGXS4vodx0Bxx+4xmZyCSEYil1qIp6llokybTIRzNLxJADEpb
         mevpdCMZuuyQjL7iJkFpS6QqcdVWEEHI5HutdTu/b/lFdUWlPLTKOQaUhfH/L+gCsIUH
         73YPMdqd4LKIgghlbL3/SFrHMWaUtJpYmbNA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906811; x=1719511611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuatl8An2r1cXJScFESolD1f90VPFvdc9a3mKIi/oro=;
        b=H3lS9Eht9FsIhdh8Gg2qOwRvjbuJWi6Owu7ckLw1SFm6EUMgQxA45hse1KszLRHrR1
         RLGfLZveDdcMvH6U4jFAFkGceFJSjPEftHJirwy6ZoYBk7in5uHMg3u3xOnAFma/+4oS
         6GUrUXfyn7DB3aDjS75pG85speQlawaNWaGzVyfuF6lZlm7fwEwEqcXmskPlrjJqNGL9
         cd1Cmc9hUQLTUwIQsRhPRTbSclrOEpHvgJvOjFYt8ZqEUysXmRxMt9bSQ7wu/ojZb2hs
         cGQ/dxtPTV+FdaKNJWQ4qaeog3Oi8cxpaaTczxZ+tikRlt635EtDP9N4ZdTTZsXFJ5FK
         ntkg==
X-Forwarded-Encrypted: i=1; AJvYcCUMSi3y6CBjbwSYxlCOKIYcX8yXXFa1Cxpp3gGER9CVRd/Gu8B7rqOeR7apmy8JoE4HDLuIstHQOYw8yxjJtWjMSllPIPpDLRATHCW/
X-Gm-Message-State: AOJu0YwbehbC+lldmoEdgD/aBev6bJkHsMDq1EPV6w6IG/PuWV/U4+lG
	o9YeX2AyaAaQGgp/TT+EocUxlNn9FyBQpCMNuLBsUyX3Uw8sOYUrmtIDHmxRaqU9mJnm8Lj2Nus
	WCqlVcIpM
X-Google-Smtp-Source: AGHT+IEV96FlwawLqOkmdDYe5KJ6CL7c0klOcF1F2t2SK/qvTIe/USInHplHRrg7T5j1melGtMG4Og==
X-Received: by 2002:a19:5f0a:0:b0:52b:c08d:2da4 with SMTP id 2adb3069b0e04-52ccaa33c19mr4143955e87.25.1718906811307;
        Thu, 20 Jun 2024 11:06:51 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f638d97fdsm704333666b.145.2024.06.20.11.06.50
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 11:06:51 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4230366ad7bso13937795e9.1
        for <linux-hyperv@vger.kernel.org>; Thu, 20 Jun 2024 11:06:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVip269EcFm2BzJ+Z6q5NxHnbphJXej0/7vgCFj+mZJFZ7q//0eymSuW28uXgbcjZDbP0cpLHEGVYT54+H705nDRxqF7rEoav6gl/Y/
X-Received: by 2002:a50:96cf:0:b0:57c:5874:4f5c with SMTP id
 4fb4d7f45d1cf-57d07ea857fmr5124279a12.32.1718906455555; Thu, 20 Jun 2024
 11:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620175703.605111-1-yury.norov@gmail.com>
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Jun 2024 11:00:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUTXC452qbypG3jW6XCZGfc8d-iehSavxn5JkQ=sv0zA@mail.gmail.com>
Message-ID: <CAHk-=wiUTXC452qbypG3jW6XCZGfc8d-iehSavxn5JkQ=sv0zA@mail.gmail.com>
Subject: Re: [PATCH v4 00/40] lib/find: add atomic find_bit() primitives
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	"H. Peter Anvin" <hpa@zytor.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Andersson <andersson@kernel.org>, Borislav Petkov <bp@alien8.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Disseldorp <ddiss@suse.de>, 
	Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gregory Greenman <gregory.greenman@intel.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, 
	Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, 
	Jiri Pirko <jiri@resnulli.us>, Jiri Slaby <jirislaby@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Karsten Graul <kgraul@linux.ibm.com>, Karsten Keil <isdn@linux-pingi.de>, 
	Kees Cook <keescook@chromium.org>, Leon Romanovsky <leon@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Martin Habets <habetsm.xilinx@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, 
	Nicholas Piggin <npiggin@gmail.com>, Oliver Neukum <oneukum@suse.com>, Paolo Abeni <pabeni@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ping-Ke Shih <pkshih@realtek.com>, Rich Felker <dalias@libc.org>, Rob Herring <robh@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	GR-QLogic-Storage-Upstream@marvell.com, alsa-devel@alsa-project.org, 
	ath10k@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-media@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-net-drivers@amd.com, 
	linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	mpi3mr-linuxdrv.pdl@broadcom.com, netdev@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, 
	Alexey Klimov <alexey.klimov@linaro.org>, Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 10:57, Yury Norov <yury.norov@gmail.com> wrote:
>
>
> The typical lock-protected bit allocation may look like this:

If it looks like this, then nobody cares. Clearly the user in question
never actually cared about performance, and you SHOULD NOT then say
"let's optimize this that nobody cares about":.

Yury, I spend an inordinate amount of time just double-checking your
patches. I ended up having to basically undo one of them just days
ago.

New rule: before you send some optimization, you need to have NUMBERS.

Some kind of "look, this code is visible in profiles, so we actually care".

Because without numbers, I'm just not going to pull anything from you.
These insane inlines for things that don't matter need to stop.

And if they *DO* matter, you need to show that they matter.

               Linus

