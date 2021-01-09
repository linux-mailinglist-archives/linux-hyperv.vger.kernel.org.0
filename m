Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB862F01C1
	for <lists+linux-hyperv@lfdr.de>; Sat,  9 Jan 2021 17:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbhAIQi4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 9 Jan 2021 11:38:56 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:34301 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbhAIQi4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 9 Jan 2021 11:38:56 -0500
Received: by mail-wm1-f44.google.com with SMTP id g25so8500766wmh.1;
        Sat, 09 Jan 2021 08:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aDVJo3+shPWu5nWTcCZgnv+cqtkL4Ekc8Vl/UftVUGw=;
        b=Q0MYGr2KyQFN9KQHC8rb/WxjCGfFZ38fpg/bZo3IN7ENzVpR9L+eRz6EUX/uZNoDPd
         rXGZ5GD1/8wcbGGXkhNe46wYcwy1FCi1jMW1G4jRJpWAdFdfmSRe9DX7hx9Jo4IWrkEx
         iRZ0kdBeG0jKjpPSxBV233RuoR2SRHKmKCIPuabPdu04Hltr+pez7E0br4apK1IFDHlM
         vdLZZx+xz8h9WvKTOD4Old4BL1kSKycFNIh8L7nEGm213zkhypGWQASiAWpPIrrBwFYT
         o5Gdg4sef5Gi8Ua9vm10+jC6oWQIqlxsqyWVo+RBQTLxe1tA/fJ1ZcT/+Ti7Y1Y+fmwj
         CqYA==
X-Gm-Message-State: AOAM5304PcwJ7wgcmz/jp/Z8/1Y8mH7xWu9TuzmiBOCdKsOdjDZPlQn7
        qL6/semf/n2001kcnhqQ+YbZ8UCWOAY=
X-Google-Smtp-Source: ABdhPJwZtF/sNBO7dwSbjcDkCeWqtQG+qKdu/AGuKIcG2RiZ+/UKota2JkUvrtQBfBMhrftVEno0oQ==
X-Received: by 2002:a05:600c:2116:: with SMTP id u22mr7763249wml.174.1610210294134;
        Sat, 09 Jan 2021 08:38:14 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b12sm22732903wmj.2.2021.01.09.08.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 08:38:13 -0800 (PST)
Date:   Sat, 9 Jan 2021 16:38:11 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Joerg Roedel <jroedel@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH v4 16/17] x86/ioapic: export a few functions and data
 structures via io_apic.h
Message-ID: <20210109163811.o7fdhjzjg6m4hawo@liuwe-devbox-debian-v2>
References: <20210106203350.14568-1-wei.liu@kernel.org>
 <20210106203350.14568-17-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106203350.14568-17-wei.liu@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 06, 2021 at 08:33:49PM +0000, Wei Liu wrote:
> We are about to implement an irqchip for IO-APIC when Linux runs as root
> on Microsoft Hypervisor. At the same time we would like to reuse
> existing code as much as possible.
> 
> Move mp_chip_data to io_apic.h and make a few helper functions
> non-static.
> 
> No functional change.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>

This patch can be dropped. I've figured out a much cleaner way to handle
IO-APIC due to recent changes.

Wei.
