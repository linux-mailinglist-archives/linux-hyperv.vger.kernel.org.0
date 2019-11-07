Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6678DF2F33
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2019 14:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbfKGN05 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Nov 2019 08:26:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388525AbfKGN04 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Nov 2019 08:26:56 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB91081F05
        for <linux-hyperv@vger.kernel.org>; Thu,  7 Nov 2019 13:26:56 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id f14so772490wmc.0
        for <linux-hyperv@vger.kernel.org>; Thu, 07 Nov 2019 05:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=sY5GQZQRR37FgRTpgS+peb+lk0hBcwjkBJyRvYYH6Hw=;
        b=kfR7iNjRmccwhtUTcKIKXtPuAdrU6kZ+p8Scy+KNvnWeex2hHh07GbgRGZo8f0WOKY
         hsXiku1o/yNRiThU6K5UPcHogXr+X707knWf5wN3Ew8tFu3cz7G9jI+ykaE4es3XyfM7
         qhlpllPlYHIMcqKAFiRVjN91H8oKUDzC7OBlIgm8ln61bX9EGLfEFWNaSRfRXiphI2Un
         SR7Hul5XziOa5ltCP+3YeaO+PUIAWLCMEyC2/Bw59UVNpXhVg1ByNCPenJktOuh9Fa5+
         zZrUZ3JvwKia+gh96SQwfXo8iFnvN813rQQZO73D1vZbEiHYxx3DtTwZeWriVuQSb7Ld
         mA1A==
X-Gm-Message-State: APjAAAVng8y2M5K8EDM+G1H2dGUkm+iYdEO/zINyADhSeCShyj0IKvb3
        /O+hUyYV3TYYOeymjB4XIkXrSsFUUSikR4s9DzKy3ZTr3bVcjH3RD/gw0YfXN4rzZyPSLlp8618
        j+3PCX1GiyaE7vApa4wXVwFZU
X-Received: by 2002:a1c:3b08:: with SMTP id i8mr2855693wma.56.1573133215354;
        Thu, 07 Nov 2019 05:26:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqxTxNfiovI0w9kYuknzKXffvwCptiTG92icmrRUIsqrAdos08hnvVnr3eQTmeYuQjClpj2+4A==
X-Received: by 2002:a1c:3b08:: with SMTP id i8mr2855658wma.56.1573133215051;
        Thu, 07 Nov 2019 05:26:55 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w13sm2269778wrm.8.2019.11.07.05.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 05:26:54 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3] x86/hyper-v: micro-optimize send_ipi_one case
In-Reply-To: <20191027151938.7296-1-vkuznets@redhat.com>
References: <20191027151938.7296-1-vkuznets@redhat.com>
Date:   Thu, 07 Nov 2019 14:26:53 +0100
Message-ID: <877e4bbyw2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> When sending an IPI to a single CPU there is no need to deal with cpumasks.
> With 2 CPU guest on WS2019 I'm seeing a minor (like 3%, 8043 -> 7761 CPU
> cycles) improvement with smp_call_function_single() loop benchmark. The
> optimization, however, is tiny and straitforward. Also, send_ipi_one() is
> important for PV spinlock kick.
>
> I was also wondering if it would make sense to switch to using regular
> APIC IPI send for CPU > 64 case but no, it is twice as expesive (12650 CPU
> cycles for __send_ipi_mask_ex() call, 26000 for orig_apic.send_IPI(cpu,
> vector)).
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes since v2:
>  - Check VP number instead of CPU number against >= 64 [Michael]
>  - Check for VP_INVAL

Hi Sasha,

do you have plans to pick this up for hyperv-next or should we ask x86
folks to?

Thanks!

-- 
Vitaly
