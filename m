Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF3655F9C
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jun 2019 05:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfFZDhR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Jun 2019 23:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfFZDhM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Jun 2019 23:37:12 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 620C521738
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Jun 2019 03:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520231;
        bh=JmzGPKsmUvSdNsSmIymUCFxAhA+cTqqTboCcY+e/GPI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mpIGug1BN7TkavcEanSgy9S5TtgTAZM159v3f/R0RGk2ktaFcZBiwXCLs/azsmbLf
         uUPFAtrSsYkESs/Ex05eq88JFcXbg2ESx8nqbaF8XaupoKVIi7fl+KcUqLwW38K/ma
         gTC6bPVOCj3EOyALXyVKo6/zCvdWEcp4HhF6RByI=
Received: by mail-wr1-f49.google.com with SMTP id r16so863661wrl.11
        for <linux-hyperv@vger.kernel.org>; Tue, 25 Jun 2019 20:37:11 -0700 (PDT)
X-Gm-Message-State: APjAAAVY5ZK6m28SEA2wgcGNi1xviT8VMs39N83XzflOTJjeF81GVCNt
        M8Pb4k3HS/4CklbHffDn5yjUWLHDAR02lO1v+VGW7w==
X-Google-Smtp-Source: APXvYqwElpql8oD8RU81s8JM59UICeBjuSUCnq2AkPAPHmk5YrgJh6ZyasGJxpLlUDzaC8WV+AQ53SYq53YWmoIFgSg=
X-Received: by 2002:adf:f28a:: with SMTP id k10mr1277832wro.343.1561520229959;
 Tue, 25 Jun 2019 20:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190613064813.8102-1-namit@vmware.com> <20190613064813.8102-5-namit@vmware.com>
In-Reply-To: <20190613064813.8102-5-namit@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 25 Jun 2019 20:36:59 -0700
X-Gmail-Original-Message-ID: <CALCETrXyJ8y7PSqf+RmGKjM4VSLXmNEGi6K=Jzw4jmckRQECTg@mail.gmail.com>
Message-ID: <CALCETrXyJ8y7PSqf+RmGKjM4VSLXmNEGi6K=Jzw4jmckRQECTg@mail.gmail.com>
Subject: Re: [PATCH 4/9] x86/mm/tlb: Flush remote and local TLBs concurrently
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-hyperv@vger.kernel.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        kvm list <kvm@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 12, 2019 at 11:49 PM Nadav Amit <namit@vmware.com> wrote:
>
> To improve TLB shootdown performance, flush the remote and local TLBs
> concurrently. Introduce flush_tlb_multi() that does so. The current
> flush_tlb_others() interface is kept, since paravirtual interfaces need
> to be adapted first before it can be removed. This is left for future
> work. In such PV environments, TLB flushes are not performed, at this
> time, concurrently.

Would it be straightforward to have a default PV flush_tlb_multi()
that uses flush_tlb_others() under the hood?
